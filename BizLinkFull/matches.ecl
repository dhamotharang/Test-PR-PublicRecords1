// Begin code to perform the matching itself
IMPORT SALT28,ut,std;
EXPORT matches(DATASET(layout_BizHead) ih,UNSIGNED MatchThreshold = 38) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED2 c,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.proxid1 := le.proxid;
  SELF.proxid2 := ri.proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  INTEGER2 company_url_score := MAP( le.company_url_isnull OR ri.company_url_isnull => 0,
                        le.company_url = ri.company_url  => le.company_url_weight100,
                        SALT28.MatchBagOfWords(le.company_url,ri.company_url,0,0));
  INTEGER2 contact_email_score := MAP( le.contact_email_isnull OR ri.contact_email_isnull => 0,
                        le.contact_email = ri.contact_email  => le.contact_email_weight100,
                        SALT28.Fn_Fail_Scale(le.contact_email_weight100,s.contact_email_switch));
  INTEGER2 source_record_id_score := MAP( le.source_record_id_isnull OR ri.source_record_id_isnull => 0,
                        le.source_record_id = ri.source_record_id  => le.source_record_id_weight100,
                        SALT28.Fn_Fail_Scale(le.source_record_id_weight100,s.source_record_id_switch));
  INTEGER2 contact_ssn_score := MAP( le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT28.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch));
  INTEGER2 company_name_score := MAP( le.company_name_isnull OR ri.company_name_isnull => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT28.Fn_Fail_Scale(le.company_name_weight100,s.company_name_switch));
  INTEGER2 company_name_prefix_score := MAP( le.company_name_prefix_isnull OR ri.company_name_prefix_isnull => 0,
                        le.company_name_prefix = ri.company_name_prefix  => le.company_name_prefix_weight100,
                        SALT28.Fn_Fail_Scale(le.company_name_prefix_weight100,s.company_name_prefix_switch));
  INTEGER2 company_fein_score := MAP( le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT28.WithinEditN(le.company_fein,ri.company_fein,1) => SALT28.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt),
                        SALT28.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  INTEGER2 cnp_name_score := MAP( le.cnp_name_isnull OR ri.cnp_name_isnull => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT28.MatchBagOfWords(le.cnp_name,ri.cnp_name,98323,1));
  INTEGER2 company_phone_7_score := MAP( le.company_phone_7_isnull OR ri.company_phone_7_isnull => 0,
                        le.company_phone_7 = ri.company_phone_7  => le.company_phone_7_weight100,
                        SALT28.Fn_Fail_Scale(le.company_phone_7_weight100,s.company_phone_7_switch));
  INTEGER2 CONTACTNAME_score_pre := MAP( (le.CONTACTNAME_isnull OR le.fname_isnull AND le.mname_isnull AND le.lname_isnull) OR (ri.CONTACTNAME_isnull OR ri.fname_isnull AND ri.mname_isnull AND ri.lname_isnull) => 0,
                        0 // SCALE(NEVER) has been used - so the combination does not score
                        );
  INTEGER2 STREETADDRESS_score_pre := MAP( (le.STREETADDRESS_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) OR (ri.STREETADDRESS_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) => 0,
                        0 // SCALE(NEVER) has been used - so the combination does not score
                        );
  INTEGER2 prim_name_score := MAP( le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT28.WithinEditN(le.prim_name,ri.prim_name,1) => SALT28.fn_fuzzy_specificity(le.prim_name_weight100,le.prim_name_cnt, le.prim_name_e1_cnt,ri.prim_name_weight100,ri.prim_name_cnt,ri.prim_name_e1_cnt),
                        SALT28.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  INTEGER2 zip_score := MAP( le.zip_isnull OR ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT28.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  INTEGER2 cnp_number_score := MAP( le.cnp_number_isnull OR ri.cnp_number_isnull => 0,
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT28.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 prim_range_score_temp := MAP( le.prim_range_isnull OR ri.prim_range_isnull => 0,
                        STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT28.WithinEditN(le.prim_range,ri.prim_range,1) => SALT28.fn_fuzzy_specificity(le.prim_range_weight100,le.prim_range_cnt, le.prim_range_e1_cnt,ri.prim_range_weight100,ri.prim_range_cnt,ri.prim_range_e1_cnt),
                        SALT28.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  INTEGER2 sec_range_score := MAP( le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT28.WithinEditN(le.sec_range,ri.sec_range,1) => SALT28.fn_fuzzy_specificity(le.sec_range_weight100,le.sec_range_cnt, le.sec_range_e1_cnt,ri.sec_range_weight100,ri.sec_range_cnt,ri.sec_range_e1_cnt),
                        SALT28.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
  INTEGER2 city_score := MAP( le.city_isnull OR ri.city_isnull => 0,
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.city = ri.city  => le.city_weight100,
                        SALT28.WithinEditN(le.city,ri.city,2) and metaphonelib.dmetaphone1(le.city) = metaphonelib.dmetaphone1(ri.city) => SALT28.fn_fuzzy_specificity(le.city_weight100,le.city_cnt, le.city_e2p_cnt,ri.city_weight100,ri.city_cnt,ri.city_e2p_cnt),
                        SALT28.WithinEditN(le.city,ri.city,2) => SALT28.fn_fuzzy_specificity(le.city_weight100,le.city_cnt, le.city_e2_cnt,ri.city_weight100,ri.city_cnt,ri.city_e2_cnt),
                        metaphonelib.dmetaphone1(le.city) = metaphonelib.dmetaphone1(ri.city) => SALT28.fn_fuzzy_specificity(le.city_weight100,le.city_cnt, le.city_p_cnt,ri.city_weight100,ri.city_cnt,ri.city_p_cnt),
                        SALT28.Fn_Fail_Scale(le.city_weight100,s.city_switch));
  INTEGER2 city_clean_score := MAP( le.city_clean_isnull OR ri.city_clean_isnull => 0,
                        le.city_clean = ri.city_clean  => le.city_clean_weight100,
                        SALT28.Fn_Fail_Scale(le.city_clean_weight100,s.city_clean_switch));
  INTEGER2 company_sic_code1_score := MAP( le.company_sic_code1_isnull OR ri.company_sic_code1_isnull => 0,
                        le.company_sic_code1 = ri.company_sic_code1  => le.company_sic_code1_weight100,
                        SALT28.Fn_Fail_Scale(le.company_sic_code1_weight100,s.company_sic_code1_switch));
  INTEGER2 lname_score := MAP( le.lname_isnull OR ri.lname_isnull => 0,
                        CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.lname = ri.lname OR SALT28.fn_hyphen_match(le.lname,ri.lname,1)<=2  => MIN(le.lname_weight100,ri.lname_weight100),
                        SALT28.WithinEditN(le.lname,ri.lname,2) => SALT28.fn_fuzzy_specificity(le.lname_weight100,le.lname_cnt, le.lname_e2_cnt,ri.lname_weight100,ri.lname_cnt,ri.lname_e2_cnt),
                        LENGTH(TRIM(le.lname))>0 and le.lname = ri.lname[1..LENGTH(TRIM(le.lname))] => le.lname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.lname))>0 and ri.lname = le.lname[1..LENGTH(TRIM(ri.lname))] => ri.lname_weight100, // An initial match - take initial specificity
                        SALT28.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  INTEGER2 company_phone_3_score := MAP( le.company_phone_3_isnull OR ri.company_phone_3_isnull => 0,
                        le.company_phone_3 = ri.company_phone_3  => le.company_phone_3_weight100,
                        SALT28.Fn_Fail_Scale(le.company_phone_3_weight100,s.company_phone_3_switch));
  INTEGER2 company_phone_3_ex_score := MAP( le.company_phone_3_ex_isnull OR ri.company_phone_3_ex_isnull => 0,
                        le.company_phone_3_ex = ri.company_phone_3_ex  => le.company_phone_3_ex_weight100,
                        SALT28.Fn_Fail_Scale(le.company_phone_3_ex_weight100,s.company_phone_3_ex_switch));
  INTEGER2 mname_score := MAP( le.mname_isnull OR ri.mname_isnull => 0,
                        CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT28.WithinEditN(le.mname,ri.mname,2) => SALT28.fn_fuzzy_specificity(le.mname_weight100,le.mname_cnt, le.mname_e2_cnt,ri.mname_weight100,ri.mname_cnt,ri.mname_e2_cnt),
                        LENGTH(TRIM(le.mname))>0 and le.mname = ri.mname[1..LENGTH(TRIM(le.mname))] => le.mname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.mname))>0 and ri.mname = le.mname[1..LENGTH(TRIM(ri.mname))] => ri.mname_weight100, // An initial match - take initial specificity
                        SALT28.Fn_Fail_Scale(le.mname_weight100,s.mname_switch));
  INTEGER2 fname_score_temp := MAP( le.fname_isnull OR ri.fname_isnull => 0,
                        CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT28.WithinEditN(le.fname,ri.fname,1) => SALT28.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_e1_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_e1_cnt),
                        LENGTH(TRIM(le.fname))>0 and le.fname = ri.fname[1..LENGTH(TRIM(le.fname))] => le.fname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.fname))>0 and ri.fname = le.fname[1..LENGTH(TRIM(ri.fname))] => ri.fname_weight100, // An initial match - take initial specificity
                        SALT28.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  INTEGER2 fname_preferred_score := MAP( le.fname_preferred_isnull OR ri.fname_preferred_isnull => 0,
                        le.fname_preferred = ri.fname_preferred  => le.fname_preferred_weight100,
                        SALT28.Fn_Fail_Scale(le.fname_preferred_weight100,s.fname_preferred_switch));
  INTEGER2 name_suffix_score := MAP( le.name_suffix_isnull OR ri.name_suffix_isnull => 0,
                        le.name_suffix = ri.name_suffix  => le.name_suffix_weight100,
                        le.name_suffix_NormSuffix = ri.name_suffix_NormSuffix => SALT28.fn_fuzzy_specificity(le.name_suffix_weight100,le.name_suffix_cnt, le.name_suffix_NormSuffix_cnt,ri.name_suffix_weight100,ri.name_suffix_cnt,ri.name_suffix_NormSuffix_cnt),
                        SALT28.Fn_Fail_Scale(le.name_suffix_weight100,s.name_suffix_switch));
  INTEGER2 cnp_lowv_score := MAP( le.cnp_lowv_isnull OR ri.cnp_lowv_isnull => 0,
                        le.cnp_lowv = ri.cnp_lowv  => le.cnp_lowv_weight100,
                        SALT28.Fn_Fail_Scale(le.cnp_lowv_weight100,s.cnp_lowv_switch));
  INTEGER2 st_score := MAP( le.st_isnull OR ri.st_isnull => 0,
                        le.st = ri.st  => le.st_weight100,
                        SALT28.Fn_Fail_Scale(le.st_weight100,s.st_switch));
  INTEGER2 source_score := MAP( le.source_isnull OR ri.source_isnull => 0,
                        le.source = ri.source  => le.source_weight100,
                        SALT28.Fn_Fail_Scale(le.source_weight100,s.source_switch));
  INTEGER2 cnp_btype_score := MAP( le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT28.Fn_Fail_Scale(le.cnp_btype_weight100,s.cnp_btype_switch));
  INTEGER2 isContact_score := MAP( le.isContact_isnull OR ri.isContact_isnull => 0,
                        le.isContact = ri.isContact  => le.isContact_weight100,
                        SALT28.Fn_Fail_Scale(le.isContact_weight100,s.isContact_switch));
  INTEGER2 title_score := MAP( le.title_isnull OR ri.title_isnull => 0,
                        le.title = ri.title  => le.title_weight100,
                        SALT28.Fn_Fail_Scale(le.title_weight100,s.title_switch));
  INTEGER2 rcid_score := MAP( le.rcid_isnull OR ri.rcid_isnull => 0,
                        le.rcid = ri.rcid  => le.rcid_weight100,
                        SALT28.Fn_Fail_Scale(le.rcid_weight100,s.rcid_switch));
  INTEGER2 rcid2_score := MAP( le.rcid2_isnull OR ri.rcid2_isnull => 0,
                        le.rcid2 = ri.rcid2  => le.rcid2_weight100,
                        SALT28.Fn_Fail_Scale(le.rcid2_weight100,s.rcid2_switch));
  INTEGER2 empid_score := MAP( le.empid_isnull OR ri.empid_isnull => 0,
                        le.empid = ri.empid  => le.empid_weight100,
                        SALT28.Fn_Fail_Scale(le.empid_weight100,s.empid_switch));
  INTEGER2 powid_score := MAP( le.powid_isnull OR ri.powid_isnull => 0,
                        le.powid = ri.powid  => le.powid_weight100,
                        SALT28.Fn_Fail_Scale(le.powid_weight100,s.powid_switch));
  INTEGER2 sele_flag_score := MAP( le.sele_flag_isnull OR ri.sele_flag_isnull => 0,
                        le.sele_flag = ri.sele_flag  => le.sele_flag_weight100,
                        SALT28.Fn_Fail_Scale(le.sele_flag_weight100,s.sele_flag_switch));
  INTEGER2 org_flag_score := MAP( le.org_flag_isnull OR ri.org_flag_isnull => 0,
                        le.org_flag = ri.org_flag  => le.org_flag_weight100,
                        SALT28.Fn_Fail_Scale(le.org_flag_weight100,s.org_flag_switch));
  INTEGER2 ult_flag_score := MAP( le.ult_flag_isnull OR ri.ult_flag_isnull => 0,
                        le.ult_flag = ri.ult_flag  => le.ult_flag_weight100,
                        SALT28.Fn_Fail_Scale(le.ult_flag_weight100,s.ult_flag_switch));
  INTEGER2 prim_range_score := IF ( prim_range_score_temp >= 0, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 fname_score := fname_score_temp*0.20; 
// Compute the score for the concept CONTACTNAME
  INTEGER2 CONTACTNAME_score_ext := MAX(CONTACTNAME_score_pre,0) + fname_score + mname_score + lname_score;// Score in surrounding context
  INTEGER2 CONTACTNAME_score_res := MAX(0,CONTACTNAME_score_pre); // At least nothing
  INTEGER2 CONTACTNAME_score := CONTACTNAME_score_res;
// Compute the score for the concept STREETADDRESS
  INTEGER2 STREETADDRESS_score_ext := MAX(STREETADDRESS_score_pre,0) + prim_range_score + prim_name_score + sec_range_score;// Score in surrounding context
  INTEGER2 STREETADDRESS_score_res := MAX(0,STREETADDRESS_score_pre); // At least nothing
  INTEGER2 STREETADDRESS_score := STREETADDRESS_score_res;
  SELF.Conf_Prop := (0
    +MAX(le.company_fein_prop,ri.company_fein_prop)*company_fein_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (company_url_score + contact_email_score + source_record_id_score + contact_ssn_score + company_name_score + company_name_prefix_score + company_fein_score + cnp_name_score + company_phone_7_score + MAX(CONTACTNAME_score,fname_score + mname_score + lname_score) + MAX(STREETADDRESS_score,prim_range_score + prim_name_score + sec_range_score) + zip_score + cnp_number_score + city_score + city_clean_score + company_sic_code1_score + company_phone_3_score + company_phone_3_ex_score + fname_preferred_score + name_suffix_score + cnp_lowv_score + st_score + source_score + cnp_btype_score + isContact_score + title_score + rcid_score + rcid2_score + empid_score + powid_score + sele_flag_score + org_flag_score + ult_flag_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
SHARED RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':company_url',
  n = 1 => ':contact_email',
  n = 2 => ':source_record_id',
  n = 3 => ':contact_ssn',
  n = 4 => ':company_name:*',
  n = 25 => ':company_name_prefix:*',
  n = 45 => ':company_fein:*',
  n = 64 => ':cnp_name:*',
  n = 82 => ':company_phone_7:*',
  n = 98 => ':prim_name:zip',
  n = 99 => ':prim_name:cnp_number',
  n = 100 => ':prim_name:prim_range',
  n = 101 => ':prim_name:sec_range',
  n = 102 => ':prim_name:city:*',
  n = 113 => ':prim_name:city_clean:*',
  n = 123 => ':prim_name:company_sic_code1:*',
  n = 132 => ':prim_name:lname:*',
  n = 140 => ':prim_name:company_phone_3:*',
  n = 146 => ':prim_name:company_phone_3_ex:*',
  n = 151 => ':prim_name:mname:*',
  n = 155 => ':prim_name:fname:*',
  n = 158 => ':prim_name:fname_preferred:*',
  n = 160 => ':prim_name:name_suffix:cnp_lowv',
  n = 161 => ':zip:cnp_number',
  n = 162 => ':zip:prim_range',
  n = 163 => ':zip:sec_range',
  n = 164 => ':zip:city:*',
  n = 175 => ':zip:city_clean:*',
  n = 185 => ':zip:company_sic_code1:*',
  n = 194 => ':zip:lname:*',
  n = 202 => ':zip:company_phone_3:*',
  n = 208 => ':zip:company_phone_3_ex:*',
  n = 213 => ':zip:mname:*',
  n = 217 => ':zip:fname:*',
  n = 220 => ':zip:fname_preferred:*',
  n = 222 => ':zip:name_suffix:cnp_lowv',
  n = 223 => ':cnp_number:prim_range',
  n = 224 => ':cnp_number:sec_range:*',
  n = 236 => ':cnp_number:city:*',
  n = 247 => ':cnp_number:city_clean:*',
  n = 257 => ':cnp_number:company_sic_code1:*',
  n = 265 => ':cnp_number:lname:*',
  n = 272 => ':cnp_number:company_phone_3:*',
  n = 278 => ':cnp_number:company_phone_3_ex:*',
  n = 283 => ':cnp_number:mname:*',
  n = 287 => ':cnp_number:fname:*',
  n = 290 => ':cnp_number:fname_preferred:*',
  n = 292 => ':cnp_number:name_suffix:cnp_lowv',
  n = 293 => ':prim_range:sec_range:*',
  n = 305 => ':prim_range:city:*',
  n = 316 => ':prim_range:city_clean:*',
  n = 326 => ':prim_range:company_sic_code1:*',
  n = 334 => ':prim_range:lname:*',
  n = 341 => ':prim_range:company_phone_3:*',
  n = 347 => ':prim_range:company_phone_3_ex:*',
  n = 352 => ':prim_range:mname:*',
  n = 356 => ':prim_range:fname:*',
  n = 359 => ':prim_range:fname_preferred:*',
  n = 361 => ':prim_range:name_suffix:cnp_lowv',
  n = 362 => ':sec_range:city:*',
  n = 372 => ':sec_range:city_clean:*',
  n = 381 => ':sec_range:company_sic_code1:*',
  n = 389 => ':sec_range:lname:*',
  n = 396 => ':sec_range:company_phone_3:*',
  n = 402 => ':sec_range:company_phone_3_ex:*',
  n = 407 => ':sec_range:mname:*',
  n = 411 => ':sec_range:fname:fname_preferred',
  n = 412 => ':sec_range:fname:name_suffix',
  n = 413 => ':sec_range:fname:cnp_lowv:st',
  n = 414 => ':sec_range:fname_preferred:name_suffix',
  n = 415 => ':sec_range:fname_preferred:cnp_lowv:st',
  n = 416 => ':sec_range:name_suffix:cnp_lowv:st',
  n = 417 => ':city:city_clean:*',
  n = 426 => ':city:company_sic_code1:*',
  n = 434 => ':city:lname:*',
  n = 441 => ':city:company_phone_3:company_phone_3_ex',
  n = 442 => ':city:company_phone_3:mname',
  n = 443 => ':city:company_phone_3:fname',
  n = 444 => ':city:company_phone_3:fname_preferred',
  n = 445 => ':city:company_phone_3:name_suffix',
  n = 446 => ':city:company_phone_3:cnp_lowv:st',
  n = 447 => ':city:company_phone_3_ex:mname',
  n = 448 => ':city:company_phone_3_ex:fname',
  n = 449 => ':city:company_phone_3_ex:fname_preferred',
  n = 450 => ':city:company_phone_3_ex:name_suffix',
  n = 451 => ':city:company_phone_3_ex:cnp_lowv:st',
  n = 452 => ':city:mname:fname',
  n = 453 => ':city:mname:fname_preferred',
  n = 454 => ':city:mname:name_suffix',
  n = 455 => ':city:mname:cnp_lowv:st',
  n = 456 => ':city:fname:fname_preferred',
  n = 457 => ':city:fname:name_suffix',
  n = 458 => ':city:fname:cnp_lowv:st',
  n = 459 => ':city:fname_preferred:name_suffix',
  n = 460 => ':city:fname_preferred:cnp_lowv:st',
  n = 461 => ':city:name_suffix:cnp_lowv:st',
  n = 462 => ':city_clean:company_sic_code1:*',
  n = 470 => ':city_clean:lname:*',
  n = 477 => ':city_clean:company_phone_3:company_phone_3_ex',
  n = 478 => ':city_clean:company_phone_3:mname',
  n = 479 => ':city_clean:company_phone_3:fname',
  n = 480 => ':city_clean:company_phone_3:fname_preferred',
  n = 481 => ':city_clean:company_phone_3:name_suffix',
  n = 482 => ':city_clean:company_phone_3:cnp_lowv:st',
  n = 483 => ':city_clean:company_phone_3_ex:mname',
  n = 484 => ':city_clean:company_phone_3_ex:fname',
  n = 485 => ':city_clean:company_phone_3_ex:fname_preferred',
  n = 486 => ':city_clean:company_phone_3_ex:name_suffix',
  n = 487 => ':city_clean:company_phone_3_ex:cnp_lowv:st',
  n = 488 => ':city_clean:mname:fname',
  n = 489 => ':city_clean:mname:fname_preferred',
  n = 490 => ':city_clean:mname:name_suffix',
  n = 491 => ':city_clean:mname:cnp_lowv:st',
  n = 492 => ':city_clean:fname:fname_preferred',
  n = 493 => ':city_clean:fname:name_suffix',
  n = 494 => ':city_clean:fname:cnp_lowv:st',
  n = 495 => ':city_clean:fname_preferred:name_suffix',
  n = 496 => ':city_clean:fname_preferred:cnp_lowv:st',
  n = 497 => ':city_clean:name_suffix:cnp_lowv:st',
  n = 498 => ':company_sic_code1:lname:company_phone_3',
  n = 499 => ':company_sic_code1:lname:company_phone_3_ex',
  n = 500 => ':company_sic_code1:lname:mname',
  n = 501 => ':company_sic_code1:lname:fname',
  n = 502 => ':company_sic_code1:lname:fname_preferred',
  n = 503 => ':company_sic_code1:lname:name_suffix',
  n = 504 => ':company_sic_code1:lname:cnp_lowv:st',
  n = 505 => ':company_sic_code1:company_phone_3:company_phone_3_ex',
  n = 506 => ':company_sic_code1:company_phone_3:mname',
  n = 507 => ':company_sic_code1:company_phone_3:fname',
  n = 508 => ':company_sic_code1:company_phone_3:fname_preferred',
  n = 509 => ':company_sic_code1:company_phone_3:name_suffix',
  n = 510 => ':company_sic_code1:company_phone_3:cnp_lowv:st',
  n = 511 => ':company_sic_code1:company_phone_3_ex:mname',
  n = 512 => ':company_sic_code1:company_phone_3_ex:fname',
  n = 513 => ':company_sic_code1:company_phone_3_ex:fname_preferred',
  n = 514 => ':company_sic_code1:company_phone_3_ex:name_suffix',
  n = 515 => ':company_sic_code1:company_phone_3_ex:cnp_lowv:st',
  n = 516 => ':company_sic_code1:mname:fname',
  n = 517 => ':company_sic_code1:mname:fname_preferred',
  n = 518 => ':company_sic_code1:mname:name_suffix',
  n = 519 => ':company_sic_code1:mname:cnp_lowv:st',
  n = 520 => ':company_sic_code1:fname:fname_preferred',
  n = 521 => ':company_sic_code1:fname:name_suffix',
  n = 522 => ':company_sic_code1:fname_preferred:name_suffix',
  n = 523 => ':lname:company_phone_3:company_phone_3_ex',
  n = 524 => ':lname:company_phone_3:mname',
  n = 525 => ':lname:company_phone_3:fname',
  n = 526 => ':lname:company_phone_3:fname_preferred',
  n = 527 => ':lname:company_phone_3:name_suffix',
  n = 528 => ':lname:company_phone_3:cnp_lowv:st',
  n = 529 => ':lname:company_phone_3_ex:mname',
  n = 530 => ':lname:company_phone_3_ex:fname',
  n = 531 => ':lname:company_phone_3_ex:fname_preferred',
  n = 532 => ':lname:company_phone_3_ex:name_suffix',
  n = 533 => ':lname:company_phone_3_ex:cnp_lowv:st',
  n = 534 => ':lname:mname:fname',
  n = 535 => ':lname:mname:fname_preferred',
  n = 536 => ':lname:mname:name_suffix',
  n = 537 => ':lname:mname:cnp_lowv:st',
  n = 538 => ':lname:fname:fname_preferred',
  n = 539 => ':lname:fname:name_suffix',
  n = 540 => ':lname:fname_preferred:name_suffix',
  n = 541 => ':company_phone_3:company_phone_3_ex:mname',
  n = 542 => ':company_phone_3:company_phone_3_ex:fname',
  n = 543 => ':company_phone_3:company_phone_3_ex:fname_preferred',
  n = 544 => ':company_phone_3:company_phone_3_ex:name_suffix',
  n = 545 => ':company_phone_3:mname:fname',
  n = 546 => ':company_phone_3:mname:fname_preferred',
  n = 547 => ':company_phone_3:mname:name_suffix',
  n = 548 => ':company_phone_3:fname:fname_preferred:*',
  n = 551 => ':company_phone_3:fname:name_suffix:*',
  n = 553 => ':company_phone_3:fname_preferred:name_suffix:*',
  n = 555 => ':company_phone_3_ex:mname:fname',
  n = 556 => ':company_phone_3_ex:mname:fname_preferred',
  n = 557 => ':company_phone_3_ex:mname:name_suffix',
  n = 558 => ':company_phone_3_ex:fname:fname_preferred:*',
  n = 561 => ':company_phone_3_ex:fname:name_suffix:*',
  n = 563 => ':company_phone_3_ex:fname_preferred:name_suffix:*',
  n = 565 => ':mname:fname:fname_preferred:*',
  n = 568 => ':mname:fname:name_suffix:*',
  n = 570 => ':mname:fname_preferred:name_suffix:*',
  n = 572 => ':fname:fname_preferred:name_suffix:*','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 574 join conditions of which 392 have been optimized into preceding conditions
//Fixed fields ->:company_url(27)
dn0 := h(~company_url_isnull);
dn0_deduped := dn0(company_url_weight100>=2600); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_url = RIGHT.company_url  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,0),HINT(Parallel_Match),ATMOST(LEFT.company_url = RIGHT.company_url,10000),HASH);
//Fixed fields ->:contact_email(27)
dn1 := h(~contact_email_isnull);
dn1_deduped := dn1(contact_email_weight100>=2600); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.contact_email = RIGHT.contact_email  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,1),HINT(Parallel_Match),ATMOST(LEFT.contact_email = RIGHT.contact_email,10000),HASH);
//Fixed fields ->:source_record_id(26)
dn2 := h(~source_record_id_isnull);
dn2_deduped := dn2(source_record_id_weight100>=2600); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.source_record_id = RIGHT.source_record_id  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,2),HINT(Parallel_Match),ATMOST(LEFT.source_record_id = RIGHT.source_record_id,10000),HASH);
//Fixed fields ->:contact_ssn(26)
dn3 := h(~contact_ssn_isnull);
dn3_deduped := dn3(contact_ssn_weight100>=2600); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.contact_ssn = RIGHT.contact_ssn  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,3),HINT(Parallel_Match),ATMOST(LEFT.contact_ssn = RIGHT.contact_ssn,10000),HASH);
//First 1 fields shared with following 20 joins - optimization performed
//Fixed fields ->:company_name(25):company_name_prefix(25) also :company_name(25):company_fein(25) also :company_name(25):cnp_name(24) also :company_name(25):company_phone_7(23) also :company_name(25):prim_name(14) also :company_name(25):zip(14) also :company_name(25):cnp_number(13) also :company_name(25):prim_range(13) also :company_name(25):sec_range(12) also :company_name(25):city(11) also :company_name(25):city_clean(11) also :company_name(25):company_sic_code1(10) also :company_name(25):lname(10) also :company_name(25):company_phone_3(9) also :company_name(25):company_phone_3_ex(9) also :company_name(25):mname(9) also :company_name(25):fname(8) also :company_name(25):fname_preferred(8) also :company_name(25):name_suffix(8) also :company_name(25):cnp_lowv(5) also :company_name(25):st(5)
dn4 := h(~company_name_isnull);
dn4_deduped := dn4(company_name_weight100>=2200); // Use specificity to flag high-dup counts
mj4 := JOIN( dn4_deduped, dn4_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_name = RIGHT.company_name  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_name_prefix = RIGHT.company_name_prefix AND ~LEFT.company_name_prefix_isnull
    OR    LEFT.company_fein = RIGHT.company_fein AND ~LEFT.company_fein_isnull
    OR    LEFT.cnp_name = RIGHT.cnp_name AND ~LEFT.cnp_name_isnull
    OR    LEFT.company_phone_7 = RIGHT.company_phone_7 AND ~LEFT.company_phone_7_isnull
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
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,4),HINT(Parallel_Match),ATMOST(LEFT.company_name = RIGHT.company_name,10000),HASH);
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT28.mac_select_best_matches(mjs0_t,rcid1,rcid2,o0);
mjs0 := o0 : PERSIST('~temp::BizLinkFull::proxid::mj0');
//First 1 fields shared with following 19 joins - optimization performed
//Fixed fields ->:company_name_prefix(25):company_fein(25) also :company_name_prefix(25):cnp_name(24) also :company_name_prefix(25):company_phone_7(23) also :company_name_prefix(25):prim_name(14) also :company_name_prefix(25):zip(14) also :company_name_prefix(25):cnp_number(13) also :company_name_prefix(25):prim_range(13) also :company_name_prefix(25):sec_range(12) also :company_name_prefix(25):city(11) also :company_name_prefix(25):city_clean(11) also :company_name_prefix(25):company_sic_code1(10) also :company_name_prefix(25):lname(10) also :company_name_prefix(25):company_phone_3(9) also :company_name_prefix(25):company_phone_3_ex(9) also :company_name_prefix(25):mname(9) also :company_name_prefix(25):fname(8) also :company_name_prefix(25):fname_preferred(8) also :company_name_prefix(25):name_suffix(8) also :company_name_prefix(25):cnp_lowv(5) also :company_name_prefix(25):st(5)
dn25 := h(~company_name_prefix_isnull);
dn25_deduped := dn25(company_name_prefix_weight100>=2200); // Use specificity to flag high-dup counts
mj25 := JOIN( dn25_deduped, dn25_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_name_prefix = RIGHT.company_name_prefix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_fein = RIGHT.company_fein AND ~LEFT.company_fein_isnull
    OR    LEFT.cnp_name = RIGHT.cnp_name AND ~LEFT.cnp_name_isnull
    OR    LEFT.company_phone_7 = RIGHT.company_phone_7 AND ~LEFT.company_phone_7_isnull
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
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,25),HINT(Parallel_Match),ATMOST(LEFT.company_name_prefix = RIGHT.company_name_prefix,10000),HASH);
mjs1_t := mj25;
SALT28.mac_select_best_matches(mjs1_t,rcid1,rcid2,o1);
mjs1 := o1 : PERSIST('~temp::BizLinkFull::proxid::mj1');
//First 1 fields shared with following 18 joins - optimization performed
//Fixed fields ->:company_fein(25):cnp_name(24) also :company_fein(25):company_phone_7(23) also :company_fein(25):prim_name(14) also :company_fein(25):zip(14) also :company_fein(25):cnp_number(13) also :company_fein(25):prim_range(13) also :company_fein(25):sec_range(12) also :company_fein(25):city(11) also :company_fein(25):city_clean(11) also :company_fein(25):company_sic_code1(10) also :company_fein(25):lname(10) also :company_fein(25):company_phone_3(9) also :company_fein(25):company_phone_3_ex(9) also :company_fein(25):mname(9) also :company_fein(25):fname(8) also :company_fein(25):fname_preferred(8) also :company_fein(25):name_suffix(8) also :company_fein(25):cnp_lowv(5) also :company_fein(25):st(5)
dn45 := h(~company_fein_isnull);
dn45_deduped := dn45(company_fein_weight100>=2200); // Use specificity to flag high-dup counts
mj45 := JOIN( dn45_deduped, dn45_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_fein = RIGHT.company_fein  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.cnp_name = RIGHT.cnp_name AND ~LEFT.cnp_name_isnull
    OR    LEFT.company_phone_7 = RIGHT.company_phone_7 AND ~LEFT.company_phone_7_isnull
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
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,45),HINT(Parallel_Match),ATMOST(LEFT.company_fein = RIGHT.company_fein,10000),HASH);
mjs2_t := mj45;
SALT28.mac_select_best_matches(mjs2_t,rcid1,rcid2,o2);
mjs2 := o2 : PERSIST('~temp::BizLinkFull::proxid::mj2');
//First 1 fields shared with following 17 joins - optimization performed
//Fixed fields ->:cnp_name(24):company_phone_7(23) also :cnp_name(24):prim_name(14) also :cnp_name(24):zip(14) also :cnp_name(24):cnp_number(13) also :cnp_name(24):prim_range(13) also :cnp_name(24):sec_range(12) also :cnp_name(24):city(11) also :cnp_name(24):city_clean(11) also :cnp_name(24):company_sic_code1(10) also :cnp_name(24):lname(10) also :cnp_name(24):company_phone_3(9) also :cnp_name(24):company_phone_3_ex(9) also :cnp_name(24):mname(9) also :cnp_name(24):fname(8) also :cnp_name(24):fname_preferred(8) also :cnp_name(24):name_suffix(8) also :cnp_name(24):cnp_lowv(5) also :cnp_name(24):st(5)
dn64 := h(~cnp_name_isnull);
dn64_deduped := dn64(cnp_name_weight100>=2200); // Use specificity to flag high-dup counts
mj64 := JOIN( dn64_deduped, dn64_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.cnp_name = RIGHT.cnp_name  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_phone_7 = RIGHT.company_phone_7 AND ~LEFT.company_phone_7_isnull
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
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,64),HINT(Parallel_Match),ATMOST(LEFT.cnp_name = RIGHT.cnp_name,10000),HASH);
mjs3_t := mj64;
SALT28.mac_select_best_matches(mjs3_t,rcid1,rcid2,o3);
mjs3 := o3 : PERSIST('~temp::BizLinkFull::proxid::mj3');
//First 1 fields shared with following 15 joins - optimization performed
//Fixed fields ->:company_phone_7(23):prim_name(14) also :company_phone_7(23):zip(14) also :company_phone_7(23):cnp_number(13) also :company_phone_7(23):prim_range(13) also :company_phone_7(23):sec_range(12) also :company_phone_7(23):city(11) also :company_phone_7(23):city_clean(11) also :company_phone_7(23):company_sic_code1(10) also :company_phone_7(23):lname(10) also :company_phone_7(23):company_phone_3(9) also :company_phone_7(23):company_phone_3_ex(9) also :company_phone_7(23):mname(9) also :company_phone_7(23):fname(8) also :company_phone_7(23):fname_preferred(8) also :company_phone_7(23):name_suffix(8) also :company_phone_7(23):cnp_lowv(5)
dn82 := h(~company_phone_7_isnull);
dn82_deduped := dn82(company_phone_7_weight100>=2200); // Use specificity to flag high-dup counts
mj82 := JOIN( dn82_deduped, dn82_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_7 = RIGHT.company_phone_7  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.prim_name = RIGHT.prim_name AND ~LEFT.prim_name_isnull
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
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,82),HINT(Parallel_Match),ATMOST(LEFT.company_phone_7 = RIGHT.company_phone_7,10000),HASH);
mjs4_t := mj82;
SALT28.mac_select_best_matches(mjs4_t,rcid1,rcid2,o4);
mjs4 := o4 : PERSIST('~temp::BizLinkFull::proxid::mj4');
//Fixed fields ->:prim_name(14):zip(14)
dn98 := h(~prim_name_isnull AND ~zip_isnull);
dn98_deduped := dn98(prim_name_weight100 + zip_weight100>=2600); // Use specificity to flag high-dup counts
mj98 := JOIN( dn98_deduped, dn98_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.zip = RIGHT.zip  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,98),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.zip = RIGHT.zip,10000),HASH);
//Fixed fields ->:prim_name(14):cnp_number(13)
dn99 := h(~prim_name_isnull AND ~cnp_number_isnull);
dn99_deduped := dn99(prim_name_weight100 + cnp_number_weight100>=2600); // Use specificity to flag high-dup counts
mj99 := JOIN( dn99_deduped, dn99_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.cnp_number = RIGHT.cnp_number  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,99),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.cnp_number = RIGHT.cnp_number,10000),HASH);
//Fixed fields ->:prim_name(14):prim_range(13)
dn100 := h(~prim_name_isnull AND ~prim_range_isnull);
dn100_deduped := dn100(prim_name_weight100 + prim_range_weight100>=2600); // Use specificity to flag high-dup counts
mj100 := JOIN( dn100_deduped, dn100_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range,match_join(LEFT,RIGHT,100),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range,10000),HASH);
//Fixed fields ->:prim_name(14):sec_range(12)
dn101 := h(~prim_name_isnull AND ~sec_range_isnull);
dn101_deduped := dn101(prim_name_weight100 + sec_range_weight100>=2600); // Use specificity to flag high-dup counts
mj101 := JOIN( dn101_deduped, dn101_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.sec_range = RIGHT.sec_range  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,101),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
//First 2 fields shared with following 10 joins - optimization performed
//Fixed fields ->:prim_name(14):city(11):city_clean(11) also :prim_name(14):city(11):company_sic_code1(10) also :prim_name(14):city(11):lname(10) also :prim_name(14):city(11):company_phone_3(9) also :prim_name(14):city(11):company_phone_3_ex(9) also :prim_name(14):city(11):mname(9) also :prim_name(14):city(11):fname(8) also :prim_name(14):city(11):fname_preferred(8) also :prim_name(14):city(11):name_suffix(8) also :prim_name(14):city(11):cnp_lowv(5) also :prim_name(14):city(11):st(5)
dn102 := h(~prim_name_isnull AND ~city_isnull);
dn102_deduped := dn102(prim_name_weight100 + city_weight100>=2200); // Use specificity to flag high-dup counts
mj102 := JOIN( dn102_deduped, dn102_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,102),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st,10000),HASH);
mjs5_t := mj98+mj99+mj100+mj101+mj102;
SALT28.mac_select_best_matches(mjs5_t,rcid1,rcid2,o5);
mjs5 := o5 : PERSIST('~temp::BizLinkFull::proxid::mj5');
//First 2 fields shared with following 9 joins - optimization performed
//Fixed fields ->:prim_name(14):city_clean(11):company_sic_code1(10) also :prim_name(14):city_clean(11):lname(10) also :prim_name(14):city_clean(11):company_phone_3(9) also :prim_name(14):city_clean(11):company_phone_3_ex(9) also :prim_name(14):city_clean(11):mname(9) also :prim_name(14):city_clean(11):fname(8) also :prim_name(14):city_clean(11):fname_preferred(8) also :prim_name(14):city_clean(11):name_suffix(8) also :prim_name(14):city_clean(11):cnp_lowv(5) also :prim_name(14):city_clean(11):st(5)
dn113 := h(~prim_name_isnull AND ~city_clean_isnull);
dn113_deduped := dn113(prim_name_weight100 + city_clean_weight100>=2200); // Use specificity to flag high-dup counts
mj113 := JOIN( dn113_deduped, dn113_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.city_clean = RIGHT.city_clean  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,113),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.city_clean = RIGHT.city_clean,10000),HASH);
mjs6_t := mj113;
SALT28.mac_select_best_matches(mjs6_t,rcid1,rcid2,o6);
mjs6 := o6 : PERSIST('~temp::BizLinkFull::proxid::mj6');
//First 2 fields shared with following 8 joins - optimization performed
//Fixed fields ->:prim_name(14):company_sic_code1(10):lname(10) also :prim_name(14):company_sic_code1(10):company_phone_3(9) also :prim_name(14):company_sic_code1(10):company_phone_3_ex(9) also :prim_name(14):company_sic_code1(10):mname(9) also :prim_name(14):company_sic_code1(10):fname(8) also :prim_name(14):company_sic_code1(10):fname_preferred(8) also :prim_name(14):company_sic_code1(10):name_suffix(8) also :prim_name(14):company_sic_code1(10):cnp_lowv(5) also :prim_name(14):company_sic_code1(10):st(5)
dn123 := h(~prim_name_isnull AND ~company_sic_code1_isnull);
dn123_deduped := dn123(prim_name_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj123 := JOIN( dn123_deduped, dn123_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.company_sic_code1 = RIGHT.company_sic_code1  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,123),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs7_t := mj123;
SALT28.mac_select_best_matches(mjs7_t,rcid1,rcid2,o7);
mjs7 := o7 : PERSIST('~temp::BizLinkFull::proxid::mj7');
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:prim_name(14):lname(10):company_phone_3(9) also :prim_name(14):lname(10):company_phone_3_ex(9) also :prim_name(14):lname(10):mname(9) also :prim_name(14):lname(10):fname(8) also :prim_name(14):lname(10):fname_preferred(8) also :prim_name(14):lname(10):name_suffix(8) also :prim_name(14):lname(10):cnp_lowv(5) also :prim_name(14):lname(10):st(5)
dn132 := h(~prim_name_isnull AND ~lname_isnull);
dn132_deduped := dn132(prim_name_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj132 := JOIN( dn132_deduped, dn132_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.lname = RIGHT.lname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,132),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs8_t := mj132;
SALT28.mac_select_best_matches(mjs8_t,rcid1,rcid2,o8);
mjs8 := o8 : PERSIST('~temp::BizLinkFull::proxid::mj8');
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:prim_name(14):company_phone_3(9):company_phone_3_ex(9) also :prim_name(14):company_phone_3(9):mname(9) also :prim_name(14):company_phone_3(9):fname(8) also :prim_name(14):company_phone_3(9):fname_preferred(8) also :prim_name(14):company_phone_3(9):name_suffix(8) also :prim_name(14):company_phone_3(9):cnp_lowv(5)
dn140 := h(~prim_name_isnull AND ~company_phone_3_isnull);
dn140_deduped := dn140(prim_name_weight100 + company_phone_3_weight100>=2200); // Use specificity to flag high-dup counts
mj140 := JOIN( dn140_deduped, dn140_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.company_phone_3 = RIGHT.company_phone_3  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,140),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.company_phone_3 = RIGHT.company_phone_3,10000),HASH);
mjs9_t := mj140;
SALT28.mac_select_best_matches(mjs9_t,rcid1,rcid2,o9);
mjs9 := o9 : PERSIST('~temp::BizLinkFull::proxid::mj9');
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:prim_name(14):company_phone_3_ex(9):mname(9) also :prim_name(14):company_phone_3_ex(9):fname(8) also :prim_name(14):company_phone_3_ex(9):fname_preferred(8) also :prim_name(14):company_phone_3_ex(9):name_suffix(8) also :prim_name(14):company_phone_3_ex(9):cnp_lowv(5)
dn146 := h(~prim_name_isnull AND ~company_phone_3_ex_isnull);
dn146_deduped := dn146(prim_name_weight100 + company_phone_3_ex_weight100>=2200); // Use specificity to flag high-dup counts
mj146 := JOIN( dn146_deduped, dn146_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,146),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
mjs10_t := mj146;
SALT28.mac_select_best_matches(mjs10_t,rcid1,rcid2,o10);
mjs10 := o10 : PERSIST('~temp::BizLinkFull::proxid::mj10');
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:prim_name(14):mname(9):fname(8) also :prim_name(14):mname(9):fname_preferred(8) also :prim_name(14):mname(9):name_suffix(8) also :prim_name(14):mname(9):cnp_lowv(5)
dn151 := h(~prim_name_isnull AND ~mname_isnull);
dn151_deduped := dn151(prim_name_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj151 := JOIN( dn151_deduped, dn151_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.mname = RIGHT.mname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,151),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.mname = RIGHT.mname,10000),HASH);
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:prim_name(14):fname(8):fname_preferred(8) also :prim_name(14):fname(8):name_suffix(8) also :prim_name(14):fname(8):cnp_lowv(5)
dn155 := h(~prim_name_isnull AND ~fname_isnull);
dn155_deduped := dn155(prim_name_weight100 + fname_weight100>=2200); // Use specificity to flag high-dup counts
mj155 := JOIN( dn155_deduped, dn155_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,155),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs11_t := mj151+mj155;
SALT28.mac_select_best_matches(mjs11_t,rcid1,rcid2,o11);
mjs11 := o11 : PERSIST('~temp::BizLinkFull::proxid::mj11');
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:prim_name(14):fname_preferred(8):name_suffix(8) also :prim_name(14):fname_preferred(8):cnp_lowv(5)
dn158 := h(~prim_name_isnull AND ~fname_preferred_isnull);
dn158_deduped := dn158(prim_name_weight100 + fname_preferred_weight100>=2200); // Use specificity to flag high-dup counts
mj158 := JOIN( dn158_deduped, dn158_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,158),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:prim_name(14):name_suffix(8):cnp_lowv(5)
dn160 := h(~prim_name_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull);
dn160_deduped := dn160(prim_name_weight100 + name_suffix_weight100 + cnp_lowv_weight100>=2600); // Use specificity to flag high-dup counts
mj160 := JOIN( dn160_deduped, dn160_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.cnp_lowv = RIGHT.cnp_lowv  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,160),HINT(Parallel_Match),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
//Fixed fields ->:zip(14):cnp_number(13)
dn161 := h(~zip_isnull AND ~cnp_number_isnull);
dn161_deduped := dn161(zip_weight100 + cnp_number_weight100>=2600); // Use specificity to flag high-dup counts
mj161 := JOIN( dn161_deduped, dn161_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.cnp_number = RIGHT.cnp_number  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,161),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.cnp_number = RIGHT.cnp_number,10000),HASH);
//Fixed fields ->:zip(14):prim_range(13)
dn162 := h(~zip_isnull AND ~prim_range_isnull);
dn162_deduped := dn162(zip_weight100 + prim_range_weight100>=2600); // Use specificity to flag high-dup counts
mj162 := JOIN( dn162_deduped, dn162_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.prim_range = RIGHT.prim_range,match_join(LEFT,RIGHT,162),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.prim_range = RIGHT.prim_range,10000),HASH);
mjs12_t := mj158+mj160+mj161+mj162;
SALT28.mac_select_best_matches(mjs12_t,rcid1,rcid2,o12);
mjs12 := o12 : PERSIST('~temp::BizLinkFull::proxid::mj12');
//Fixed fields ->:zip(14):sec_range(12)
dn163 := h(~zip_isnull AND ~sec_range_isnull);
dn163_deduped := dn163(zip_weight100 + sec_range_weight100>=2600); // Use specificity to flag high-dup counts
mj163 := JOIN( dn163_deduped, dn163_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.sec_range = RIGHT.sec_range  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,163),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
//First 2 fields shared with following 10 joins - optimization performed
//Fixed fields ->:zip(14):city(11):city_clean(11) also :zip(14):city(11):company_sic_code1(10) also :zip(14):city(11):lname(10) also :zip(14):city(11):company_phone_3(9) also :zip(14):city(11):company_phone_3_ex(9) also :zip(14):city(11):mname(9) also :zip(14):city(11):fname(8) also :zip(14):city(11):fname_preferred(8) also :zip(14):city(11):name_suffix(8) also :zip(14):city(11):cnp_lowv(5) also :zip(14):city(11):st(5)
dn164 := h(~zip_isnull AND ~city_isnull);
dn164_deduped := dn164(zip_weight100 + city_weight100>=2200); // Use specificity to flag high-dup counts
mj164 := JOIN( dn164_deduped, dn164_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,164),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st,10000),HASH);
mjs13_t := mj163+mj164;
SALT28.mac_select_best_matches(mjs13_t,rcid1,rcid2,o13);
mjs13 := o13 : PERSIST('~temp::BizLinkFull::proxid::mj13');
//First 2 fields shared with following 9 joins - optimization performed
//Fixed fields ->:zip(14):city_clean(11):company_sic_code1(10) also :zip(14):city_clean(11):lname(10) also :zip(14):city_clean(11):company_phone_3(9) also :zip(14):city_clean(11):company_phone_3_ex(9) also :zip(14):city_clean(11):mname(9) also :zip(14):city_clean(11):fname(8) also :zip(14):city_clean(11):fname_preferred(8) also :zip(14):city_clean(11):name_suffix(8) also :zip(14):city_clean(11):cnp_lowv(5) also :zip(14):city_clean(11):st(5)
dn175 := h(~zip_isnull AND ~city_clean_isnull);
dn175_deduped := dn175(zip_weight100 + city_clean_weight100>=2200); // Use specificity to flag high-dup counts
mj175 := JOIN( dn175_deduped, dn175_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.city_clean = RIGHT.city_clean  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,175),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.city_clean = RIGHT.city_clean,10000),HASH);
mjs14_t := mj175;
SALT28.mac_select_best_matches(mjs14_t,rcid1,rcid2,o14);
mjs14 := o14 : PERSIST('~temp::BizLinkFull::proxid::mj14');
//First 2 fields shared with following 8 joins - optimization performed
//Fixed fields ->:zip(14):company_sic_code1(10):lname(10) also :zip(14):company_sic_code1(10):company_phone_3(9) also :zip(14):company_sic_code1(10):company_phone_3_ex(9) also :zip(14):company_sic_code1(10):mname(9) also :zip(14):company_sic_code1(10):fname(8) also :zip(14):company_sic_code1(10):fname_preferred(8) also :zip(14):company_sic_code1(10):name_suffix(8) also :zip(14):company_sic_code1(10):cnp_lowv(5) also :zip(14):company_sic_code1(10):st(5)
dn185 := h(~zip_isnull AND ~company_sic_code1_isnull);
dn185_deduped := dn185(zip_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj185 := JOIN( dn185_deduped, dn185_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.company_sic_code1 = RIGHT.company_sic_code1  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,185),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs15_t := mj185;
SALT28.mac_select_best_matches(mjs15_t,rcid1,rcid2,o15);
mjs15 := o15 : PERSIST('~temp::BizLinkFull::proxid::mj15');
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:zip(14):lname(10):company_phone_3(9) also :zip(14):lname(10):company_phone_3_ex(9) also :zip(14):lname(10):mname(9) also :zip(14):lname(10):fname(8) also :zip(14):lname(10):fname_preferred(8) also :zip(14):lname(10):name_suffix(8) also :zip(14):lname(10):cnp_lowv(5) also :zip(14):lname(10):st(5)
dn194 := h(~zip_isnull AND ~lname_isnull);
dn194_deduped := dn194(zip_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj194 := JOIN( dn194_deduped, dn194_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.lname = RIGHT.lname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,194),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs16_t := mj194;
SALT28.mac_select_best_matches(mjs16_t,rcid1,rcid2,o16);
mjs16 := o16 : PERSIST('~temp::BizLinkFull::proxid::mj16');
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:zip(14):company_phone_3(9):company_phone_3_ex(9) also :zip(14):company_phone_3(9):mname(9) also :zip(14):company_phone_3(9):fname(8) also :zip(14):company_phone_3(9):fname_preferred(8) also :zip(14):company_phone_3(9):name_suffix(8) also :zip(14):company_phone_3(9):cnp_lowv(5)
dn202 := h(~zip_isnull AND ~company_phone_3_isnull);
dn202_deduped := dn202(zip_weight100 + company_phone_3_weight100>=2200); // Use specificity to flag high-dup counts
mj202 := JOIN( dn202_deduped, dn202_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.company_phone_3 = RIGHT.company_phone_3  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,202),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.company_phone_3 = RIGHT.company_phone_3,10000),HASH);
mjs17_t := mj202;
SALT28.mac_select_best_matches(mjs17_t,rcid1,rcid2,o17);
mjs17 := o17 : PERSIST('~temp::BizLinkFull::proxid::mj17');
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:zip(14):company_phone_3_ex(9):mname(9) also :zip(14):company_phone_3_ex(9):fname(8) also :zip(14):company_phone_3_ex(9):fname_preferred(8) also :zip(14):company_phone_3_ex(9):name_suffix(8) also :zip(14):company_phone_3_ex(9):cnp_lowv(5)
dn208 := h(~zip_isnull AND ~company_phone_3_ex_isnull);
dn208_deduped := dn208(zip_weight100 + company_phone_3_ex_weight100>=2200); // Use specificity to flag high-dup counts
mj208 := JOIN( dn208_deduped, dn208_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,208),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
mjs18_t := mj208;
SALT28.mac_select_best_matches(mjs18_t,rcid1,rcid2,o18);
mjs18 := o18 : PERSIST('~temp::BizLinkFull::proxid::mj18');
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:zip(14):mname(9):fname(8) also :zip(14):mname(9):fname_preferred(8) also :zip(14):mname(9):name_suffix(8) also :zip(14):mname(9):cnp_lowv(5)
dn213 := h(~zip_isnull AND ~mname_isnull);
dn213_deduped := dn213(zip_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj213 := JOIN( dn213_deduped, dn213_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.mname = RIGHT.mname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,213),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.mname = RIGHT.mname,10000),HASH);
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:zip(14):fname(8):fname_preferred(8) also :zip(14):fname(8):name_suffix(8) also :zip(14):fname(8):cnp_lowv(5)
dn217 := h(~zip_isnull AND ~fname_isnull);
dn217_deduped := dn217(zip_weight100 + fname_weight100>=2200); // Use specificity to flag high-dup counts
mj217 := JOIN( dn217_deduped, dn217_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,217),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs19_t := mj213+mj217;
SALT28.mac_select_best_matches(mjs19_t,rcid1,rcid2,o19);
mjs19 := o19 : PERSIST('~temp::BizLinkFull::proxid::mj19');
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:zip(14):fname_preferred(8):name_suffix(8) also :zip(14):fname_preferred(8):cnp_lowv(5)
dn220 := h(~zip_isnull AND ~fname_preferred_isnull);
dn220_deduped := dn220(zip_weight100 + fname_preferred_weight100>=2200); // Use specificity to flag high-dup counts
mj220 := JOIN( dn220_deduped, dn220_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,220),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:zip(14):name_suffix(8):cnp_lowv(5)
dn222 := h(~zip_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull);
dn222_deduped := dn222(zip_weight100 + name_suffix_weight100 + cnp_lowv_weight100>=2600); // Use specificity to flag high-dup counts
mj222 := JOIN( dn222_deduped, dn222_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.cnp_lowv = RIGHT.cnp_lowv  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,222),HINT(Parallel_Match),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
//Fixed fields ->:cnp_number(13):prim_range(13)
dn223 := h(~cnp_number_isnull AND ~prim_range_isnull);
dn223_deduped := dn223(cnp_number_weight100 + prim_range_weight100>=2600); // Use specificity to flag high-dup counts
mj223 := JOIN( dn223_deduped, dn223_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range,match_join(LEFT,RIGHT,223),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range,10000),HASH);
//First 2 fields shared with following 11 joins - optimization performed
//Fixed fields ->:cnp_number(13):sec_range(12):city(11) also :cnp_number(13):sec_range(12):city_clean(11) also :cnp_number(13):sec_range(12):company_sic_code1(10) also :cnp_number(13):sec_range(12):lname(10) also :cnp_number(13):sec_range(12):company_phone_3(9) also :cnp_number(13):sec_range(12):company_phone_3_ex(9) also :cnp_number(13):sec_range(12):mname(9) also :cnp_number(13):sec_range(12):fname(8) also :cnp_number(13):sec_range(12):fname_preferred(8) also :cnp_number(13):sec_range(12):name_suffix(8) also :cnp_number(13):sec_range(12):cnp_lowv(5) also :cnp_number(13):sec_range(12):st(5)
dn224 := h(~cnp_number_isnull AND ~sec_range_isnull);
dn224_deduped := dn224(cnp_number_weight100 + sec_range_weight100>=2200); // Use specificity to flag high-dup counts
mj224 := JOIN( dn224_deduped, dn224_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.sec_range = RIGHT.sec_range  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND ~LEFT.city_isnull
    OR    LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,224),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
mjs20_t := mj220+mj222+mj223+mj224;
SALT28.mac_select_best_matches(mjs20_t,rcid1,rcid2,o20);
mjs20 := o20 : PERSIST('~temp::BizLinkFull::proxid::mj20');
//First 2 fields shared with following 10 joins - optimization performed
//Fixed fields ->:cnp_number(13):city(11):city_clean(11) also :cnp_number(13):city(11):company_sic_code1(10) also :cnp_number(13):city(11):lname(10) also :cnp_number(13):city(11):company_phone_3(9) also :cnp_number(13):city(11):company_phone_3_ex(9) also :cnp_number(13):city(11):mname(9) also :cnp_number(13):city(11):fname(8) also :cnp_number(13):city(11):fname_preferred(8) also :cnp_number(13):city(11):name_suffix(8) also :cnp_number(13):city(11):cnp_lowv(5) also :cnp_number(13):city(11):st(5)
dn236 := h(~cnp_number_isnull AND ~city_isnull);
dn236_deduped := dn236(cnp_number_weight100 + city_weight100>=2200); // Use specificity to flag high-dup counts
mj236 := JOIN( dn236_deduped, dn236_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,236),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st,10000),HASH);
mjs21_t := mj236;
SALT28.mac_select_best_matches(mjs21_t,rcid1,rcid2,o21);
mjs21 := o21 : PERSIST('~temp::BizLinkFull::proxid::mj21');
//First 2 fields shared with following 9 joins - optimization performed
//Fixed fields ->:cnp_number(13):city_clean(11):company_sic_code1(10) also :cnp_number(13):city_clean(11):lname(10) also :cnp_number(13):city_clean(11):company_phone_3(9) also :cnp_number(13):city_clean(11):company_phone_3_ex(9) also :cnp_number(13):city_clean(11):mname(9) also :cnp_number(13):city_clean(11):fname(8) also :cnp_number(13):city_clean(11):fname_preferred(8) also :cnp_number(13):city_clean(11):name_suffix(8) also :cnp_number(13):city_clean(11):cnp_lowv(5) also :cnp_number(13):city_clean(11):st(5)
dn247 := h(~cnp_number_isnull AND ~city_clean_isnull);
dn247_deduped := dn247(cnp_number_weight100 + city_clean_weight100>=2200); // Use specificity to flag high-dup counts
mj247 := JOIN( dn247_deduped, dn247_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.city_clean = RIGHT.city_clean  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,247),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.city_clean = RIGHT.city_clean,10000),HASH);
mjs22_t := mj247;
SALT28.mac_select_best_matches(mjs22_t,rcid1,rcid2,o22);
mjs22 := o22 : PERSIST('~temp::BizLinkFull::proxid::mj22');
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:cnp_number(13):company_sic_code1(10):lname(10) also :cnp_number(13):company_sic_code1(10):company_phone_3(9) also :cnp_number(13):company_sic_code1(10):company_phone_3_ex(9) also :cnp_number(13):company_sic_code1(10):mname(9) also :cnp_number(13):company_sic_code1(10):fname(8) also :cnp_number(13):company_sic_code1(10):fname_preferred(8) also :cnp_number(13):company_sic_code1(10):name_suffix(8) also :cnp_number(13):company_sic_code1(10):cnp_lowv(5)
dn257 := h(~cnp_number_isnull AND ~company_sic_code1_isnull);
dn257_deduped := dn257(cnp_number_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj257 := JOIN( dn257_deduped, dn257_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.company_sic_code1 = RIGHT.company_sic_code1  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,257),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs23_t := mj257;
SALT28.mac_select_best_matches(mjs23_t,rcid1,rcid2,o23);
mjs23 := o23 : PERSIST('~temp::BizLinkFull::proxid::mj23');
//First 2 fields shared with following 6 joins - optimization performed
//Fixed fields ->:cnp_number(13):lname(10):company_phone_3(9) also :cnp_number(13):lname(10):company_phone_3_ex(9) also :cnp_number(13):lname(10):mname(9) also :cnp_number(13):lname(10):fname(8) also :cnp_number(13):lname(10):fname_preferred(8) also :cnp_number(13):lname(10):name_suffix(8) also :cnp_number(13):lname(10):cnp_lowv(5)
dn265 := h(~cnp_number_isnull AND ~lname_isnull);
dn265_deduped := dn265(cnp_number_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj265 := JOIN( dn265_deduped, dn265_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.lname = RIGHT.lname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,265),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs24_t := mj265;
SALT28.mac_select_best_matches(mjs24_t,rcid1,rcid2,o24);
mjs24 := o24 : PERSIST('~temp::BizLinkFull::proxid::mj24');
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:cnp_number(13):company_phone_3(9):company_phone_3_ex(9) also :cnp_number(13):company_phone_3(9):mname(9) also :cnp_number(13):company_phone_3(9):fname(8) also :cnp_number(13):company_phone_3(9):fname_preferred(8) also :cnp_number(13):company_phone_3(9):name_suffix(8) also :cnp_number(13):company_phone_3(9):cnp_lowv(5)
dn272 := h(~cnp_number_isnull AND ~company_phone_3_isnull);
dn272_deduped := dn272(cnp_number_weight100 + company_phone_3_weight100>=2200); // Use specificity to flag high-dup counts
mj272 := JOIN( dn272_deduped, dn272_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.company_phone_3 = RIGHT.company_phone_3  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,272),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.company_phone_3 = RIGHT.company_phone_3,10000),HASH);
mjs25_t := mj272;
SALT28.mac_select_best_matches(mjs25_t,rcid1,rcid2,o25);
mjs25 := o25 : PERSIST('~temp::BizLinkFull::proxid::mj25');
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:cnp_number(13):company_phone_3_ex(9):mname(9) also :cnp_number(13):company_phone_3_ex(9):fname(8) also :cnp_number(13):company_phone_3_ex(9):fname_preferred(8) also :cnp_number(13):company_phone_3_ex(9):name_suffix(8) also :cnp_number(13):company_phone_3_ex(9):cnp_lowv(5)
dn278 := h(~cnp_number_isnull AND ~company_phone_3_ex_isnull);
dn278_deduped := dn278(cnp_number_weight100 + company_phone_3_ex_weight100>=2200); // Use specificity to flag high-dup counts
mj278 := JOIN( dn278_deduped, dn278_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,278),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
mjs26_t := mj278;
SALT28.mac_select_best_matches(mjs26_t,rcid1,rcid2,o26);
mjs26 := o26 : PERSIST('~temp::BizLinkFull::proxid::mj26');
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:cnp_number(13):mname(9):fname(8) also :cnp_number(13):mname(9):fname_preferred(8) also :cnp_number(13):mname(9):name_suffix(8) also :cnp_number(13):mname(9):cnp_lowv(5)
dn283 := h(~cnp_number_isnull AND ~mname_isnull);
dn283_deduped := dn283(cnp_number_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj283 := JOIN( dn283_deduped, dn283_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.mname = RIGHT.mname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,283),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.mname = RIGHT.mname,10000),HASH);
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:cnp_number(13):fname(8):fname_preferred(8) also :cnp_number(13):fname(8):name_suffix(8) also :cnp_number(13):fname(8):cnp_lowv(5)
dn287 := h(~cnp_number_isnull AND ~fname_isnull);
dn287_deduped := dn287(cnp_number_weight100 + fname_weight100>=2200); // Use specificity to flag high-dup counts
mj287 := JOIN( dn287_deduped, dn287_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,287),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs27_t := mj283+mj287;
SALT28.mac_select_best_matches(mjs27_t,rcid1,rcid2,o27);
mjs27 := o27 : PERSIST('~temp::BizLinkFull::proxid::mj27');
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:cnp_number(13):fname_preferred(8):name_suffix(8) also :cnp_number(13):fname_preferred(8):cnp_lowv(5)
dn290 := h(~cnp_number_isnull AND ~fname_preferred_isnull);
dn290_deduped := dn290(cnp_number_weight100 + fname_preferred_weight100>=2200); // Use specificity to flag high-dup counts
mj290 := JOIN( dn290_deduped, dn290_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,290),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:cnp_number(13):name_suffix(8):cnp_lowv(5)
dn292 := h(~cnp_number_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull);
dn292_deduped := dn292(cnp_number_weight100 + name_suffix_weight100 + cnp_lowv_weight100>=2600); // Use specificity to flag high-dup counts
mj292 := JOIN( dn292_deduped, dn292_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.cnp_lowv = RIGHT.cnp_lowv  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,292),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
//First 2 fields shared with following 11 joins - optimization performed
//Fixed fields ->:prim_range(13):sec_range(12):city(11) also :prim_range(13):sec_range(12):city_clean(11) also :prim_range(13):sec_range(12):company_sic_code1(10) also :prim_range(13):sec_range(12):lname(10) also :prim_range(13):sec_range(12):company_phone_3(9) also :prim_range(13):sec_range(12):company_phone_3_ex(9) also :prim_range(13):sec_range(12):mname(9) also :prim_range(13):sec_range(12):fname(8) also :prim_range(13):sec_range(12):fname_preferred(8) also :prim_range(13):sec_range(12):name_suffix(8) also :prim_range(13):sec_range(12):cnp_lowv(5) also :prim_range(13):sec_range(12):st(5)
dn293 := h(~prim_range_isnull AND ~sec_range_isnull);
dn293_deduped := dn293(prim_range_weight100 + sec_range_weight100>=2200); // Use specificity to flag high-dup counts
mj293 := JOIN( dn293_deduped, dn293_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.sec_range = RIGHT.sec_range
    AND (
          LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND ~LEFT.city_isnull
    OR    LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,293),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.sec_range = RIGHT.sec_range,10000),HASH);
mjs28_t := mj290+mj292+mj293;
SALT28.mac_select_best_matches(mjs28_t,rcid1,rcid2,o28);
mjs28 := o28 : PERSIST('~temp::BizLinkFull::proxid::mj28');
//First 2 fields shared with following 10 joins - optimization performed
//Fixed fields ->:prim_range(13):city(11):city_clean(11) also :prim_range(13):city(11):company_sic_code1(10) also :prim_range(13):city(11):lname(10) also :prim_range(13):city(11):company_phone_3(9) also :prim_range(13):city(11):company_phone_3_ex(9) also :prim_range(13):city(11):mname(9) also :prim_range(13):city(11):fname(8) also :prim_range(13):city(11):fname_preferred(8) also :prim_range(13):city(11):name_suffix(8) also :prim_range(13):city(11):cnp_lowv(5) also :prim_range(13):city(11):st(5)
dn305 := h(~prim_range_isnull AND ~city_isnull);
dn305_deduped := dn305(prim_range_weight100 + city_weight100>=2200); // Use specificity to flag high-dup counts
mj305 := JOIN( dn305_deduped, dn305_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
    AND (
          LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,305),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st,10000),HASH);
mjs29_t := mj305;
SALT28.mac_select_best_matches(mjs29_t,rcid1,rcid2,o29);
mjs29 := o29 : PERSIST('~temp::BizLinkFull::proxid::mj29');
//First 2 fields shared with following 9 joins - optimization performed
//Fixed fields ->:prim_range(13):city_clean(11):company_sic_code1(10) also :prim_range(13):city_clean(11):lname(10) also :prim_range(13):city_clean(11):company_phone_3(9) also :prim_range(13):city_clean(11):company_phone_3_ex(9) also :prim_range(13):city_clean(11):mname(9) also :prim_range(13):city_clean(11):fname(8) also :prim_range(13):city_clean(11):fname_preferred(8) also :prim_range(13):city_clean(11):name_suffix(8) also :prim_range(13):city_clean(11):cnp_lowv(5) also :prim_range(13):city_clean(11):st(5)
dn316 := h(~prim_range_isnull AND ~city_clean_isnull);
dn316_deduped := dn316(prim_range_weight100 + city_clean_weight100>=2200); // Use specificity to flag high-dup counts
mj316 := JOIN( dn316_deduped, dn316_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.city_clean = RIGHT.city_clean
    AND (
          LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,316),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.city_clean = RIGHT.city_clean,10000),HASH);
mjs30_t := mj316;
SALT28.mac_select_best_matches(mjs30_t,rcid1,rcid2,o30);
mjs30 := o30 : PERSIST('~temp::BizLinkFull::proxid::mj30');
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:prim_range(13):company_sic_code1(10):lname(10) also :prim_range(13):company_sic_code1(10):company_phone_3(9) also :prim_range(13):company_sic_code1(10):company_phone_3_ex(9) also :prim_range(13):company_sic_code1(10):mname(9) also :prim_range(13):company_sic_code1(10):fname(8) also :prim_range(13):company_sic_code1(10):fname_preferred(8) also :prim_range(13):company_sic_code1(10):name_suffix(8) also :prim_range(13):company_sic_code1(10):cnp_lowv(5)
dn326 := h(~prim_range_isnull AND ~company_sic_code1_isnull);
dn326_deduped := dn326(prim_range_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj326 := JOIN( dn326_deduped, dn326_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,326),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs31_t := mj326;
SALT28.mac_select_best_matches(mjs31_t,rcid1,rcid2,o31);
mjs31 := o31 : PERSIST('~temp::BizLinkFull::proxid::mj31');
//First 2 fields shared with following 6 joins - optimization performed
//Fixed fields ->:prim_range(13):lname(10):company_phone_3(9) also :prim_range(13):lname(10):company_phone_3_ex(9) also :prim_range(13):lname(10):mname(9) also :prim_range(13):lname(10):fname(8) also :prim_range(13):lname(10):fname_preferred(8) also :prim_range(13):lname(10):name_suffix(8) also :prim_range(13):lname(10):cnp_lowv(5)
dn334 := h(~prim_range_isnull AND ~lname_isnull);
dn334_deduped := dn334(prim_range_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj334 := JOIN( dn334_deduped, dn334_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.lname = RIGHT.lname
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,334),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs32_t := mj334;
SALT28.mac_select_best_matches(mjs32_t,rcid1,rcid2,o32);
mjs32 := o32 : PERSIST('~temp::BizLinkFull::proxid::mj32');
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:prim_range(13):company_phone_3(9):company_phone_3_ex(9) also :prim_range(13):company_phone_3(9):mname(9) also :prim_range(13):company_phone_3(9):fname(8) also :prim_range(13):company_phone_3(9):fname_preferred(8) also :prim_range(13):company_phone_3(9):name_suffix(8) also :prim_range(13):company_phone_3(9):cnp_lowv(5)
dn341 := h(~prim_range_isnull AND ~company_phone_3_isnull);
dn341_deduped := dn341(prim_range_weight100 + company_phone_3_weight100>=2200); // Use specificity to flag high-dup counts
mj341 := JOIN( dn341_deduped, dn341_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.company_phone_3 = RIGHT.company_phone_3
    AND (
          LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,341),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.company_phone_3 = RIGHT.company_phone_3,10000),HASH);
mjs33_t := mj341;
SALT28.mac_select_best_matches(mjs33_t,rcid1,rcid2,o33);
mjs33 := o33 : PERSIST('~temp::BizLinkFull::proxid::mj33');
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:prim_range(13):company_phone_3_ex(9):mname(9) also :prim_range(13):company_phone_3_ex(9):fname(8) also :prim_range(13):company_phone_3_ex(9):fname_preferred(8) also :prim_range(13):company_phone_3_ex(9):name_suffix(8) also :prim_range(13):company_phone_3_ex(9):cnp_lowv(5)
dn347 := h(~prim_range_isnull AND ~company_phone_3_ex_isnull);
dn347_deduped := dn347(prim_range_weight100 + company_phone_3_ex_weight100>=2200); // Use specificity to flag high-dup counts
mj347 := JOIN( dn347_deduped, dn347_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,347),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
mjs34_t := mj347;
SALT28.mac_select_best_matches(mjs34_t,rcid1,rcid2,o34);
mjs34 := o34 : PERSIST('~temp::BizLinkFull::proxid::mj34');
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:prim_range(13):mname(9):fname(8) also :prim_range(13):mname(9):fname_preferred(8) also :prim_range(13):mname(9):name_suffix(8) also :prim_range(13):mname(9):cnp_lowv(5)
dn352 := h(~prim_range_isnull AND ~mname_isnull);
dn352_deduped := dn352(prim_range_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj352 := JOIN( dn352_deduped, dn352_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.mname = RIGHT.mname
    AND (
          LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,352),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.mname = RIGHT.mname,10000),HASH);
//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:prim_range(13):fname(8):fname_preferred(8) also :prim_range(13):fname(8):name_suffix(8) also :prim_range(13):fname(8):cnp_lowv(5)
dn356 := h(~prim_range_isnull AND ~fname_isnull);
dn356_deduped := dn356(prim_range_weight100 + fname_weight100>=2200); // Use specificity to flag high-dup counts
mj356 := JOIN( dn356_deduped, dn356_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.fname = RIGHT.fname
    AND (
          LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,356),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs35_t := mj352+mj356;
SALT28.mac_select_best_matches(mjs35_t,rcid1,rcid2,o35);
mjs35 := o35 : PERSIST('~temp::BizLinkFull::proxid::mj35');
//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:prim_range(13):fname_preferred(8):name_suffix(8) also :prim_range(13):fname_preferred(8):cnp_lowv(5)
dn359 := h(~prim_range_isnull AND ~fname_preferred_isnull);
dn359_deduped := dn359(prim_range_weight100 + fname_preferred_weight100>=2200); // Use specificity to flag high-dup counts
mj359 := JOIN( dn359_deduped, dn359_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.fname_preferred = RIGHT.fname_preferred
    AND (
          LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,359),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:prim_range(13):name_suffix(8):cnp_lowv(5)
dn361 := h(~prim_range_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull);
dn361_deduped := dn361(prim_range_weight100 + name_suffix_weight100 + cnp_lowv_weight100>=2600); // Use specificity to flag high-dup counts
mj361 := JOIN( dn361_deduped, dn361_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.cnp_lowv = RIGHT.cnp_lowv,match_join(LEFT,RIGHT,361),HINT(Parallel_Match),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.cnp_lowv = RIGHT.cnp_lowv,10000),HASH);
//First 2 fields shared with following 9 joins - optimization performed
//Fixed fields ->:sec_range(12):city(11):city_clean(11) also :sec_range(12):city(11):company_sic_code1(10) also :sec_range(12):city(11):lname(10) also :sec_range(12):city(11):company_phone_3(9) also :sec_range(12):city(11):company_phone_3_ex(9) also :sec_range(12):city(11):mname(9) also :sec_range(12):city(11):fname(8) also :sec_range(12):city(11):fname_preferred(8) also :sec_range(12):city(11):name_suffix(8) also :sec_range(12):city(11):cnp_lowv(5)
dn362 := h(~sec_range_isnull AND ~city_isnull);
dn362_deduped := dn362(sec_range_weight100 + city_weight100>=2200); // Use specificity to flag high-dup counts
mj362 := JOIN( dn362_deduped, dn362_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.city_clean = RIGHT.city_clean AND ~LEFT.city_clean_isnull
    OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,362),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st,10000),HASH);
mjs36_t := mj359+mj361+mj362;
SALT28.mac_select_best_matches(mjs36_t,rcid1,rcid2,o36);
mjs36 := o36 : PERSIST('~temp::BizLinkFull::proxid::mj36');
//First 2 fields shared with following 8 joins - optimization performed
//Fixed fields ->:sec_range(12):city_clean(11):company_sic_code1(10) also :sec_range(12):city_clean(11):lname(10) also :sec_range(12):city_clean(11):company_phone_3(9) also :sec_range(12):city_clean(11):company_phone_3_ex(9) also :sec_range(12):city_clean(11):mname(9) also :sec_range(12):city_clean(11):fname(8) also :sec_range(12):city_clean(11):fname_preferred(8) also :sec_range(12):city_clean(11):name_suffix(8) also :sec_range(12):city_clean(11):cnp_lowv(5)
dn372 := h(~sec_range_isnull AND ~city_clean_isnull);
dn372_deduped := dn372(sec_range_weight100 + city_clean_weight100>=2200); // Use specificity to flag high-dup counts
mj372 := JOIN( dn372_deduped, dn372_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.city_clean = RIGHT.city_clean  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,372),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.city_clean = RIGHT.city_clean,10000),HASH);
mjs37_t := mj372;
SALT28.mac_select_best_matches(mjs37_t,rcid1,rcid2,o37);
mjs37 := o37 : PERSIST('~temp::BizLinkFull::proxid::mj37');
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:sec_range(12):company_sic_code1(10):lname(10) also :sec_range(12):company_sic_code1(10):company_phone_3(9) also :sec_range(12):company_sic_code1(10):company_phone_3_ex(9) also :sec_range(12):company_sic_code1(10):mname(9) also :sec_range(12):company_sic_code1(10):fname(8) also :sec_range(12):company_sic_code1(10):fname_preferred(8) also :sec_range(12):company_sic_code1(10):name_suffix(8) also :sec_range(12):company_sic_code1(10):cnp_lowv(5)
dn381 := h(~sec_range_isnull AND ~company_sic_code1_isnull);
dn381_deduped := dn381(sec_range_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj381 := JOIN( dn381_deduped, dn381_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.company_sic_code1 = RIGHT.company_sic_code1  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,381),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs38_t := mj381;
SALT28.mac_select_best_matches(mjs38_t,rcid1,rcid2,o38);
mjs38 := o38 : PERSIST('~temp::BizLinkFull::proxid::mj38');
//First 2 fields shared with following 6 joins - optimization performed
//Fixed fields ->:sec_range(12):lname(10):company_phone_3(9) also :sec_range(12):lname(10):company_phone_3_ex(9) also :sec_range(12):lname(10):mname(9) also :sec_range(12):lname(10):fname(8) also :sec_range(12):lname(10):fname_preferred(8) also :sec_range(12):lname(10):name_suffix(8) also :sec_range(12):lname(10):cnp_lowv(5)
dn389 := h(~sec_range_isnull AND ~lname_isnull);
dn389_deduped := dn389(sec_range_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj389 := JOIN( dn389_deduped, dn389_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.lname = RIGHT.lname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,389),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs39_t := mj389;
SALT28.mac_select_best_matches(mjs39_t,rcid1,rcid2,o39);
mjs39 := o39 : PERSIST('~temp::BizLinkFull::proxid::mj39');
//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:sec_range(12):company_phone_3(9):company_phone_3_ex(9) also :sec_range(12):company_phone_3(9):mname(9) also :sec_range(12):company_phone_3(9):fname(8) also :sec_range(12):company_phone_3(9):fname_preferred(8) also :sec_range(12):company_phone_3(9):name_suffix(8) also :sec_range(12):company_phone_3(9):cnp_lowv(5)
dn396 := h(~sec_range_isnull AND ~company_phone_3_isnull);
dn396_deduped := dn396(sec_range_weight100 + company_phone_3_weight100>=2200); // Use specificity to flag high-dup counts
mj396 := JOIN( dn396_deduped, dn396_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.company_phone_3 = RIGHT.company_phone_3  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,396),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.company_phone_3 = RIGHT.company_phone_3,10000),HASH);
mjs40_t := mj396;
SALT28.mac_select_best_matches(mjs40_t,rcid1,rcid2,o40);
mjs40 := o40 : PERSIST('~temp::BizLinkFull::proxid::mj40');
//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:sec_range(12):company_phone_3_ex(9):mname(9) also :sec_range(12):company_phone_3_ex(9):fname(8) also :sec_range(12):company_phone_3_ex(9):fname_preferred(8) also :sec_range(12):company_phone_3_ex(9):name_suffix(8) also :sec_range(12):company_phone_3_ex(9):cnp_lowv(5)
dn402 := h(~sec_range_isnull AND ~company_phone_3_ex_isnull);
dn402_deduped := dn402(sec_range_weight100 + company_phone_3_ex_weight100>=2200); // Use specificity to flag high-dup counts
mj402 := JOIN( dn402_deduped, dn402_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,402),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
mjs41_t := mj402;
SALT28.mac_select_best_matches(mjs41_t,rcid1,rcid2,o41);
mjs41 := o41 : PERSIST('~temp::BizLinkFull::proxid::mj41');
//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:sec_range(12):mname(9):fname(8) also :sec_range(12):mname(9):fname_preferred(8) also :sec_range(12):mname(9):name_suffix(8) also :sec_range(12):mname(9):cnp_lowv(5)
dn407 := h(~sec_range_isnull AND ~mname_isnull);
dn407_deduped := dn407(sec_range_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj407 := JOIN( dn407_deduped, dn407_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.mname = RIGHT.mname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,407),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.mname = RIGHT.mname,10000),HASH);
//Fixed fields ->:sec_range(12):fname(8):fname_preferred(8)
dn411 := h(~sec_range_isnull AND ~fname_isnull AND ~fname_preferred_isnull);
dn411_deduped := dn411(sec_range_weight100 + fname_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj411 := JOIN( dn411_deduped, dn411_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,411),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
mjs42_t := mj407+mj411;
SALT28.mac_select_best_matches(mjs42_t,rcid1,rcid2,o42);
mjs42 := o42 : PERSIST('~temp::BizLinkFull::proxid::mj42');
//Fixed fields ->:sec_range(12):fname(8):name_suffix(8)
dn412 := h(~sec_range_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn412_deduped := dn412(sec_range_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj412 := JOIN( dn412_deduped, dn412_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,412),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:sec_range(12):fname(8):cnp_lowv(5):st(5)
dn413 := h(~sec_range_isnull AND ~fname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn413_deduped := dn413(sec_range_weight100 + fname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj413 := JOIN( dn413_deduped, dn413_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.fname = RIGHT.fname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,413),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.fname = RIGHT.fname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:sec_range(12):fname_preferred(8):name_suffix(8)
dn414 := h(~sec_range_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn414_deduped := dn414(sec_range_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj414 := JOIN( dn414_deduped, dn414_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,414),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:sec_range(12):fname_preferred(8):cnp_lowv(5):st(5)
dn415 := h(~sec_range_isnull AND ~fname_preferred_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn415_deduped := dn415(sec_range_weight100 + fname_preferred_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj415 := JOIN( dn415_deduped, dn415_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,415),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:sec_range(12):name_suffix(8):cnp_lowv(5):st(5)
dn416 := h(~sec_range_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn416_deduped := dn416(sec_range_weight100 + name_suffix_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj416 := JOIN( dn416_deduped, dn416_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,416),HINT(Parallel_Match),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
mjs43_t := mj412+mj413+mj414+mj415+mj416;
SALT28.mac_select_best_matches(mjs43_t,rcid1,rcid2,o43);
mjs43 := o43 : PERSIST('~temp::BizLinkFull::proxid::mj43');
//First 2 fields shared with following 8 joins - optimization performed
//Fixed fields ->:city(11):city_clean(11):company_sic_code1(10) also :city(11):city_clean(11):lname(10) also :city(11):city_clean(11):company_phone_3(9) also :city(11):city_clean(11):company_phone_3_ex(9) also :city(11):city_clean(11):mname(9) also :city(11):city_clean(11):fname(8) also :city(11):city_clean(11):fname_preferred(8) also :city(11):city_clean(11):name_suffix(8) also :city(11):city_clean(11):cnp_lowv(5)
dn417 := h(~city_isnull AND ~city_clean_isnull);
dn417_deduped := dn417(city_weight100 + city_clean_weight100>=2200); // Use specificity to flag high-dup counts
mj417 := JOIN( dn417_deduped, dn417_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.city_clean = RIGHT.city_clean  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
    OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,417),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.city_clean = RIGHT.city_clean,10000),HASH);
mjs44_t := mj417;
SALT28.mac_select_best_matches(mjs44_t,rcid1,rcid2,o44);
mjs44 := o44 : PERSIST('~temp::BizLinkFull::proxid::mj44');
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:city(11):company_sic_code1(10):lname(10) also :city(11):company_sic_code1(10):company_phone_3(9) also :city(11):company_sic_code1(10):company_phone_3_ex(9) also :city(11):company_sic_code1(10):mname(9) also :city(11):company_sic_code1(10):fname(8) also :city(11):company_sic_code1(10):fname_preferred(8) also :city(11):company_sic_code1(10):name_suffix(8) also :city(11):company_sic_code1(10):cnp_lowv(5)
dn426 := h(~city_isnull AND ~company_sic_code1_isnull);
dn426_deduped := dn426(city_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj426 := JOIN( dn426_deduped, dn426_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_sic_code1 = RIGHT.company_sic_code1  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,426),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs45_t := mj426;
SALT28.mac_select_best_matches(mjs45_t,rcid1,rcid2,o45);
mjs45 := o45 : PERSIST('~temp::BizLinkFull::proxid::mj45');
//First 2 fields shared with following 6 joins - optimization performed
//Fixed fields ->:city(11):lname(10):company_phone_3(9) also :city(11):lname(10):company_phone_3_ex(9) also :city(11):lname(10):mname(9) also :city(11):lname(10):fname(8) also :city(11):lname(10):fname_preferred(8) also :city(11):lname(10):name_suffix(8) also :city(11):lname(10):cnp_lowv(5)
dn434 := h(~city_isnull AND ~lname_isnull);
dn434_deduped := dn434(city_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj434 := JOIN( dn434_deduped, dn434_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.lname = RIGHT.lname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,434),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs46_t := mj434;
SALT28.mac_select_best_matches(mjs46_t,rcid1,rcid2,o46);
mjs46 := o46 : PERSIST('~temp::BizLinkFull::proxid::mj46');
//Fixed fields ->:city(11):company_phone_3(9):company_phone_3_ex(9)
dn441 := h(~city_isnull AND ~company_phone_3_isnull AND ~company_phone_3_ex_isnull);
dn441_deduped := dn441(city_weight100 + company_phone_3_weight100 + company_phone_3_ex_weight100>=2600); // Use specificity to flag high-dup counts
mj441 := JOIN( dn441_deduped, dn441_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,441),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
//Fixed fields ->:city(11):company_phone_3(9):mname(9)
dn442 := h(~city_isnull AND ~company_phone_3_isnull AND ~mname_isnull);
dn442_deduped := dn442(city_weight100 + company_phone_3_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj442 := JOIN( dn442_deduped, dn442_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.mname = RIGHT.mname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,442),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.mname = RIGHT.mname,10000),HASH);
//Fixed fields ->:city(11):company_phone_3(9):fname(8)
dn443 := h(~city_isnull AND ~company_phone_3_isnull AND ~fname_isnull);
dn443_deduped := dn443(city_weight100 + company_phone_3_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj443 := JOIN( dn443_deduped, dn443_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,443),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:city(11):company_phone_3(9):fname_preferred(8)
dn444 := h(~city_isnull AND ~company_phone_3_isnull AND ~fname_preferred_isnull);
dn444_deduped := dn444(city_weight100 + company_phone_3_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj444 := JOIN( dn444_deduped, dn444_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,444),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:city(11):company_phone_3(9):name_suffix(8)
dn445 := h(~city_isnull AND ~company_phone_3_isnull AND ~name_suffix_isnull);
dn445_deduped := dn445(city_weight100 + company_phone_3_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj445 := JOIN( dn445_deduped, dn445_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,445),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs47_t := mj441+mj442+mj443+mj444+mj445;
SALT28.mac_select_best_matches(mjs47_t,rcid1,rcid2,o47);
mjs47 := o47 : PERSIST('~temp::BizLinkFull::proxid::mj47');
//Fixed fields ->:city(11):company_phone_3(9):cnp_lowv(5):st(5)
dn446 := h(~city_isnull AND ~company_phone_3_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn446_deduped := dn446(city_weight100 + company_phone_3_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj446 := JOIN( dn446_deduped, dn446_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,446),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:city(11):company_phone_3_ex(9):mname(9)
dn447 := h(~city_isnull AND ~company_phone_3_ex_isnull AND ~mname_isnull);
dn447_deduped := dn447(city_weight100 + company_phone_3_ex_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj447 := JOIN( dn447_deduped, dn447_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,447),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname,10000),HASH);
//Fixed fields ->:city(11):company_phone_3_ex(9):fname(8)
dn448 := h(~city_isnull AND ~company_phone_3_ex_isnull AND ~fname_isnull);
dn448_deduped := dn448(city_weight100 + company_phone_3_ex_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj448 := JOIN( dn448_deduped, dn448_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,448),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:city(11):company_phone_3_ex(9):fname_preferred(8)
dn449 := h(~city_isnull AND ~company_phone_3_ex_isnull AND ~fname_preferred_isnull);
dn449_deduped := dn449(city_weight100 + company_phone_3_ex_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj449 := JOIN( dn449_deduped, dn449_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,449),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:city(11):company_phone_3_ex(9):name_suffix(8)
dn450 := h(~city_isnull AND ~company_phone_3_ex_isnull AND ~name_suffix_isnull);
dn450_deduped := dn450(city_weight100 + company_phone_3_ex_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj450 := JOIN( dn450_deduped, dn450_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,450),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs48_t := mj446+mj447+mj448+mj449+mj450;
SALT28.mac_select_best_matches(mjs48_t,rcid1,rcid2,o48);
mjs48 := o48 : PERSIST('~temp::BizLinkFull::proxid::mj48');
//Fixed fields ->:city(11):company_phone_3_ex(9):cnp_lowv(5):st(5)
dn451 := h(~city_isnull AND ~company_phone_3_ex_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn451_deduped := dn451(city_weight100 + company_phone_3_ex_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj451 := JOIN( dn451_deduped, dn451_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,451),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:city(11):mname(9):fname(8)
dn452 := h(~city_isnull AND ~mname_isnull AND ~fname_isnull);
dn452_deduped := dn452(city_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj452 := JOIN( dn452_deduped, dn452_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,452),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:city(11):mname(9):fname_preferred(8)
dn453 := h(~city_isnull AND ~mname_isnull AND ~fname_preferred_isnull);
dn453_deduped := dn453(city_weight100 + mname_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj453 := JOIN( dn453_deduped, dn453_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.mname = RIGHT.mname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,453),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.mname = RIGHT.mname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:city(11):mname(9):name_suffix(8)
dn454 := h(~city_isnull AND ~mname_isnull AND ~name_suffix_isnull);
dn454_deduped := dn454(city_weight100 + mname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj454 := JOIN( dn454_deduped, dn454_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.mname = RIGHT.mname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,454),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.mname = RIGHT.mname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:city(11):mname(9):cnp_lowv(5):st(5)
dn455 := h(~city_isnull AND ~mname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn455_deduped := dn455(city_weight100 + mname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj455 := JOIN( dn455_deduped, dn455_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.mname = RIGHT.mname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,455),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.mname = RIGHT.mname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
mjs49_t := mj451+mj452+mj453+mj454+mj455;
SALT28.mac_select_best_matches(mjs49_t,rcid1,rcid2,o49);
mjs49 := o49 : PERSIST('~temp::BizLinkFull::proxid::mj49');
//Fixed fields ->:city(11):fname(8):fname_preferred(8)
dn456 := h(~city_isnull AND ~fname_isnull AND ~fname_preferred_isnull);
dn456_deduped := dn456(city_weight100 + fname_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj456 := JOIN( dn456_deduped, dn456_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,456),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:city(11):fname(8):name_suffix(8)
dn457 := h(~city_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn457_deduped := dn457(city_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj457 := JOIN( dn457_deduped, dn457_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,457),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:city(11):fname(8):cnp_lowv(5):st(5)
dn458 := h(~city_isnull AND ~fname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn458_deduped := dn458(city_weight100 + fname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj458 := JOIN( dn458_deduped, dn458_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.fname = RIGHT.fname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,458),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.fname = RIGHT.fname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:city(11):fname_preferred(8):name_suffix(8)
dn459 := h(~city_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn459_deduped := dn459(city_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj459 := JOIN( dn459_deduped, dn459_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,459),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:city(11):fname_preferred(8):cnp_lowv(5):st(5)
dn460 := h(~city_isnull AND ~fname_preferred_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn460_deduped := dn460(city_weight100 + fname_preferred_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj460 := JOIN( dn460_deduped, dn460_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,460),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
mjs50_t := mj456+mj457+mj458+mj459+mj460;
SALT28.mac_select_best_matches(mjs50_t,rcid1,rcid2,o50);
mjs50 := o50 : PERSIST('~temp::BizLinkFull::proxid::mj50');
//Fixed fields ->:city(11):name_suffix(8):cnp_lowv(5):st(5)
dn461 := h(~city_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn461_deduped := dn461(city_weight100 + name_suffix_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj461 := JOIN( dn461_deduped, dn461_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,461),HINT(Parallel_Match),ATMOST(LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//First 2 fields shared with following 7 joins - optimization performed
//Fixed fields ->:city_clean(11):company_sic_code1(10):lname(10) also :city_clean(11):company_sic_code1(10):company_phone_3(9) also :city_clean(11):company_sic_code1(10):company_phone_3_ex(9) also :city_clean(11):company_sic_code1(10):mname(9) also :city_clean(11):company_sic_code1(10):fname(8) also :city_clean(11):company_sic_code1(10):fname_preferred(8) also :city_clean(11):company_sic_code1(10):name_suffix(8) also :city_clean(11):company_sic_code1(10):cnp_lowv(5)
dn462 := h(~city_clean_isnull AND ~company_sic_code1_isnull);
dn462_deduped := dn462(city_clean_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj462 := JOIN( dn462_deduped, dn462_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.company_sic_code1 = RIGHT.company_sic_code1  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
    OR    LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,462),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,10000),HASH);
mjs51_t := mj461+mj462;
SALT28.mac_select_best_matches(mjs51_t,rcid1,rcid2,o51);
mjs51 := o51 : PERSIST('~temp::BizLinkFull::proxid::mj51');
//First 2 fields shared with following 6 joins - optimization performed
//Fixed fields ->:city_clean(11):lname(10):company_phone_3(9) also :city_clean(11):lname(10):company_phone_3_ex(9) also :city_clean(11):lname(10):mname(9) also :city_clean(11):lname(10):fname(8) also :city_clean(11):lname(10):fname_preferred(8) also :city_clean(11):lname(10):name_suffix(8) also :city_clean(11):lname(10):cnp_lowv(5)
dn470 := h(~city_clean_isnull AND ~lname_isnull);
dn470_deduped := dn470(city_clean_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj470 := JOIN( dn470_deduped, dn470_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.lname = RIGHT.lname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.company_phone_3 = RIGHT.company_phone_3 AND ~LEFT.company_phone_3_isnull
    OR    LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND ~LEFT.company_phone_3_ex_isnull
    OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
    OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
    OR    LEFT.fname_preferred = RIGHT.fname_preferred AND ~LEFT.fname_preferred_isnull
    OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
        ),match_join(LEFT,RIGHT,470),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.lname = RIGHT.lname,10000),HASH);
mjs52_t := mj470;
SALT28.mac_select_best_matches(mjs52_t,rcid1,rcid2,o52);
mjs52 := o52 : PERSIST('~temp::BizLinkFull::proxid::mj52');
//Fixed fields ->:city_clean(11):company_phone_3(9):company_phone_3_ex(9)
dn477 := h(~city_clean_isnull AND ~company_phone_3_isnull AND ~company_phone_3_ex_isnull);
dn477_deduped := dn477(city_clean_weight100 + company_phone_3_weight100 + company_phone_3_ex_weight100>=2600); // Use specificity to flag high-dup counts
mj477 := JOIN( dn477_deduped, dn477_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,477),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
//Fixed fields ->:city_clean(11):company_phone_3(9):mname(9)
dn478 := h(~city_clean_isnull AND ~company_phone_3_isnull AND ~mname_isnull);
dn478_deduped := dn478(city_clean_weight100 + company_phone_3_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj478 := JOIN( dn478_deduped, dn478_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.mname = RIGHT.mname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,478),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.mname = RIGHT.mname,10000),HASH);
//Fixed fields ->:city_clean(11):company_phone_3(9):fname(8)
dn479 := h(~city_clean_isnull AND ~company_phone_3_isnull AND ~fname_isnull);
dn479_deduped := dn479(city_clean_weight100 + company_phone_3_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj479 := JOIN( dn479_deduped, dn479_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,479),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:city_clean(11):company_phone_3(9):fname_preferred(8)
dn480 := h(~city_clean_isnull AND ~company_phone_3_isnull AND ~fname_preferred_isnull);
dn480_deduped := dn480(city_clean_weight100 + company_phone_3_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj480 := JOIN( dn480_deduped, dn480_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,480),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:city_clean(11):company_phone_3(9):name_suffix(8)
dn481 := h(~city_clean_isnull AND ~company_phone_3_isnull AND ~name_suffix_isnull);
dn481_deduped := dn481(city_clean_weight100 + company_phone_3_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj481 := JOIN( dn481_deduped, dn481_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,481),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs53_t := mj477+mj478+mj479+mj480+mj481;
SALT28.mac_select_best_matches(mjs53_t,rcid1,rcid2,o53);
mjs53 := o53 : PERSIST('~temp::BizLinkFull::proxid::mj53');
//Fixed fields ->:city_clean(11):company_phone_3(9):cnp_lowv(5):st(5)
dn482 := h(~city_clean_isnull AND ~company_phone_3_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn482_deduped := dn482(city_clean_weight100 + company_phone_3_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj482 := JOIN( dn482_deduped, dn482_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,482),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:city_clean(11):company_phone_3_ex(9):mname(9)
dn483 := h(~city_clean_isnull AND ~company_phone_3_ex_isnull AND ~mname_isnull);
dn483_deduped := dn483(city_clean_weight100 + company_phone_3_ex_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj483 := JOIN( dn483_deduped, dn483_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,483),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname,10000),HASH);
//Fixed fields ->:city_clean(11):company_phone_3_ex(9):fname(8)
dn484 := h(~city_clean_isnull AND ~company_phone_3_ex_isnull AND ~fname_isnull);
dn484_deduped := dn484(city_clean_weight100 + company_phone_3_ex_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj484 := JOIN( dn484_deduped, dn484_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,484),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:city_clean(11):company_phone_3_ex(9):fname_preferred(8)
dn485 := h(~city_clean_isnull AND ~company_phone_3_ex_isnull AND ~fname_preferred_isnull);
dn485_deduped := dn485(city_clean_weight100 + company_phone_3_ex_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj485 := JOIN( dn485_deduped, dn485_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,485),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:city_clean(11):company_phone_3_ex(9):name_suffix(8)
dn486 := h(~city_clean_isnull AND ~company_phone_3_ex_isnull AND ~name_suffix_isnull);
dn486_deduped := dn486(city_clean_weight100 + company_phone_3_ex_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj486 := JOIN( dn486_deduped, dn486_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,486),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs54_t := mj482+mj483+mj484+mj485+mj486;
SALT28.mac_select_best_matches(mjs54_t,rcid1,rcid2,o54);
mjs54 := o54 : PERSIST('~temp::BizLinkFull::proxid::mj54');
//Fixed fields ->:city_clean(11):company_phone_3_ex(9):cnp_lowv(5):st(5)
dn487 := h(~city_clean_isnull AND ~company_phone_3_ex_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn487_deduped := dn487(city_clean_weight100 + company_phone_3_ex_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj487 := JOIN( dn487_deduped, dn487_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,487),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:city_clean(11):mname(9):fname(8)
dn488 := h(~city_clean_isnull AND ~mname_isnull AND ~fname_isnull);
dn488_deduped := dn488(city_clean_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj488 := JOIN( dn488_deduped, dn488_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,488),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:city_clean(11):mname(9):fname_preferred(8)
dn489 := h(~city_clean_isnull AND ~mname_isnull AND ~fname_preferred_isnull);
dn489_deduped := dn489(city_clean_weight100 + mname_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj489 := JOIN( dn489_deduped, dn489_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.mname = RIGHT.mname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,489),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.mname = RIGHT.mname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:city_clean(11):mname(9):name_suffix(8)
dn490 := h(~city_clean_isnull AND ~mname_isnull AND ~name_suffix_isnull);
dn490_deduped := dn490(city_clean_weight100 + mname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj490 := JOIN( dn490_deduped, dn490_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.mname = RIGHT.mname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,490),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.mname = RIGHT.mname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:city_clean(11):mname(9):cnp_lowv(5):st(5)
dn491 := h(~city_clean_isnull AND ~mname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn491_deduped := dn491(city_clean_weight100 + mname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj491 := JOIN( dn491_deduped, dn491_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.mname = RIGHT.mname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,491),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.mname = RIGHT.mname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
mjs55_t := mj487+mj488+mj489+mj490+mj491;
SALT28.mac_select_best_matches(mjs55_t,rcid1,rcid2,o55);
mjs55 := o55 : PERSIST('~temp::BizLinkFull::proxid::mj55');
//Fixed fields ->:city_clean(11):fname(8):fname_preferred(8)
dn492 := h(~city_clean_isnull AND ~fname_isnull AND ~fname_preferred_isnull);
dn492_deduped := dn492(city_clean_weight100 + fname_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj492 := JOIN( dn492_deduped, dn492_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,492),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:city_clean(11):fname(8):name_suffix(8)
dn493 := h(~city_clean_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn493_deduped := dn493(city_clean_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj493 := JOIN( dn493_deduped, dn493_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,493),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:city_clean(11):fname(8):cnp_lowv(5):st(5)
dn494 := h(~city_clean_isnull AND ~fname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn494_deduped := dn494(city_clean_weight100 + fname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj494 := JOIN( dn494_deduped, dn494_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.fname = RIGHT.fname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,494),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.fname = RIGHT.fname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:city_clean(11):fname_preferred(8):name_suffix(8)
dn495 := h(~city_clean_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn495_deduped := dn495(city_clean_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj495 := JOIN( dn495_deduped, dn495_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,495),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:city_clean(11):fname_preferred(8):cnp_lowv(5):st(5)
dn496 := h(~city_clean_isnull AND ~fname_preferred_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn496_deduped := dn496(city_clean_weight100 + fname_preferred_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj496 := JOIN( dn496_deduped, dn496_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,496),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
mjs56_t := mj492+mj493+mj494+mj495+mj496;
SALT28.mac_select_best_matches(mjs56_t,rcid1,rcid2,o56);
mjs56 := o56 : PERSIST('~temp::BizLinkFull::proxid::mj56');
//Fixed fields ->:city_clean(11):name_suffix(8):cnp_lowv(5):st(5)
dn497 := h(~city_clean_isnull AND ~name_suffix_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn497_deduped := dn497(city_clean_weight100 + name_suffix_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj497 := JOIN( dn497_deduped, dn497_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.city_clean = RIGHT.city_clean AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,497),HINT(Parallel_Match),ATMOST(LEFT.city_clean = RIGHT.city_clean AND LEFT.name_suffix = RIGHT.name_suffix AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:company_sic_code1(10):lname(10):company_phone_3(9)
dn498 := h(~company_sic_code1_isnull AND ~lname_isnull AND ~company_phone_3_isnull);
dn498_deduped := dn498(company_sic_code1_weight100 + lname_weight100 + company_phone_3_weight100>=2600); // Use specificity to flag high-dup counts
mj498 := JOIN( dn498_deduped, dn498_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3 = RIGHT.company_phone_3  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,498),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3 = RIGHT.company_phone_3,10000),HASH);
//Fixed fields ->:company_sic_code1(10):lname(10):company_phone_3_ex(9)
dn499 := h(~company_sic_code1_isnull AND ~lname_isnull AND ~company_phone_3_ex_isnull);
dn499_deduped := dn499(company_sic_code1_weight100 + lname_weight100 + company_phone_3_ex_weight100>=2600); // Use specificity to flag high-dup counts
mj499 := JOIN( dn499_deduped, dn499_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,499),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
//Fixed fields ->:company_sic_code1(10):lname(10):mname(9)
dn500 := h(~company_sic_code1_isnull AND ~lname_isnull AND ~mname_isnull);
dn500_deduped := dn500(company_sic_code1_weight100 + lname_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj500 := JOIN( dn500_deduped, dn500_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,500),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname,10000),HASH);
//Fixed fields ->:company_sic_code1(10):lname(10):fname(8)
dn501 := h(~company_sic_code1_isnull AND ~lname_isnull AND ~fname_isnull);
dn501_deduped := dn501(company_sic_code1_weight100 + lname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj501 := JOIN( dn501_deduped, dn501_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,501),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs57_t := mj497+mj498+mj499+mj500+mj501;
SALT28.mac_select_best_matches(mjs57_t,rcid1,rcid2,o57);
mjs57 := o57 : PERSIST('~temp::BizLinkFull::proxid::mj57');
//Fixed fields ->:company_sic_code1(10):lname(10):fname_preferred(8)
dn502 := h(~company_sic_code1_isnull AND ~lname_isnull AND ~fname_preferred_isnull);
dn502_deduped := dn502(company_sic_code1_weight100 + lname_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj502 := JOIN( dn502_deduped, dn502_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,502),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:company_sic_code1(10):lname(10):name_suffix(8)
dn503 := h(~company_sic_code1_isnull AND ~lname_isnull AND ~name_suffix_isnull);
dn503_deduped := dn503(company_sic_code1_weight100 + lname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj503 := JOIN( dn503_deduped, dn503_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,503),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:company_sic_code1(10):lname(10):cnp_lowv(5):st(5)
dn504 := h(~company_sic_code1_isnull AND ~lname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn504_deduped := dn504(company_sic_code1_weight100 + lname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj504 := JOIN( dn504_deduped, dn504_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,504),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:company_sic_code1(10):company_phone_3(9):company_phone_3_ex(9)
dn505 := h(~company_sic_code1_isnull AND ~company_phone_3_isnull AND ~company_phone_3_ex_isnull);
dn505_deduped := dn505(company_sic_code1_weight100 + company_phone_3_weight100 + company_phone_3_ex_weight100>=2600); // Use specificity to flag high-dup counts
mj505 := JOIN( dn505_deduped, dn505_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,505),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
//Fixed fields ->:company_sic_code1(10):company_phone_3(9):mname(9)
dn506 := h(~company_sic_code1_isnull AND ~company_phone_3_isnull AND ~mname_isnull);
dn506_deduped := dn506(company_sic_code1_weight100 + company_phone_3_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj506 := JOIN( dn506_deduped, dn506_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.mname = RIGHT.mname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,506),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.mname = RIGHT.mname,10000),HASH);
mjs58_t := mj502+mj503+mj504+mj505+mj506;
SALT28.mac_select_best_matches(mjs58_t,rcid1,rcid2,o58);
mjs58 := o58 : PERSIST('~temp::BizLinkFull::proxid::mj58');
//Fixed fields ->:company_sic_code1(10):company_phone_3(9):fname(8)
dn507 := h(~company_sic_code1_isnull AND ~company_phone_3_isnull AND ~fname_isnull);
dn507_deduped := dn507(company_sic_code1_weight100 + company_phone_3_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj507 := JOIN( dn507_deduped, dn507_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,507),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:company_sic_code1(10):company_phone_3(9):fname_preferred(8)
dn508 := h(~company_sic_code1_isnull AND ~company_phone_3_isnull AND ~fname_preferred_isnull);
dn508_deduped := dn508(company_sic_code1_weight100 + company_phone_3_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj508 := JOIN( dn508_deduped, dn508_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,508),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:company_sic_code1(10):company_phone_3(9):name_suffix(8)
dn509 := h(~company_sic_code1_isnull AND ~company_phone_3_isnull AND ~name_suffix_isnull);
dn509_deduped := dn509(company_sic_code1_weight100 + company_phone_3_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj509 := JOIN( dn509_deduped, dn509_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,509),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:company_sic_code1(10):company_phone_3(9):cnp_lowv(5):st(5)
dn510 := h(~company_sic_code1_isnull AND ~company_phone_3_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn510_deduped := dn510(company_sic_code1_weight100 + company_phone_3_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj510 := JOIN( dn510_deduped, dn510_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,510),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:company_sic_code1(10):company_phone_3_ex(9):mname(9)
dn511 := h(~company_sic_code1_isnull AND ~company_phone_3_ex_isnull AND ~mname_isnull);
dn511_deduped := dn511(company_sic_code1_weight100 + company_phone_3_ex_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj511 := JOIN( dn511_deduped, dn511_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,511),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname,10000),HASH);
mjs59_t := mj507+mj508+mj509+mj510+mj511;
SALT28.mac_select_best_matches(mjs59_t,rcid1,rcid2,o59);
mjs59 := o59 : PERSIST('~temp::BizLinkFull::proxid::mj59');
//Fixed fields ->:company_sic_code1(10):company_phone_3_ex(9):fname(8)
dn512 := h(~company_sic_code1_isnull AND ~company_phone_3_ex_isnull AND ~fname_isnull);
dn512_deduped := dn512(company_sic_code1_weight100 + company_phone_3_ex_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj512 := JOIN( dn512_deduped, dn512_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,512),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:company_sic_code1(10):company_phone_3_ex(9):fname_preferred(8)
dn513 := h(~company_sic_code1_isnull AND ~company_phone_3_ex_isnull AND ~fname_preferred_isnull);
dn513_deduped := dn513(company_sic_code1_weight100 + company_phone_3_ex_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj513 := JOIN( dn513_deduped, dn513_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,513),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:company_sic_code1(10):company_phone_3_ex(9):name_suffix(8)
dn514 := h(~company_sic_code1_isnull AND ~company_phone_3_ex_isnull AND ~name_suffix_isnull);
dn514_deduped := dn514(company_sic_code1_weight100 + company_phone_3_ex_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj514 := JOIN( dn514_deduped, dn514_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,514),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:company_sic_code1(10):company_phone_3_ex(9):cnp_lowv(5):st(5)
dn515 := h(~company_sic_code1_isnull AND ~company_phone_3_ex_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn515_deduped := dn515(company_sic_code1_weight100 + company_phone_3_ex_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj515 := JOIN( dn515_deduped, dn515_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,515),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:company_sic_code1(10):mname(9):fname(8)
dn516 := h(~company_sic_code1_isnull AND ~mname_isnull AND ~fname_isnull);
dn516_deduped := dn516(company_sic_code1_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj516 := JOIN( dn516_deduped, dn516_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,516),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname,10000),HASH);
mjs60_t := mj512+mj513+mj514+mj515+mj516;
SALT28.mac_select_best_matches(mjs60_t,rcid1,rcid2,o60);
mjs60 := o60 : PERSIST('~temp::BizLinkFull::proxid::mj60');
//Fixed fields ->:company_sic_code1(10):mname(9):fname_preferred(8)
dn517 := h(~company_sic_code1_isnull AND ~mname_isnull AND ~fname_preferred_isnull);
dn517_deduped := dn517(company_sic_code1_weight100 + mname_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj517 := JOIN( dn517_deduped, dn517_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.mname = RIGHT.mname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,517),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.mname = RIGHT.mname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:company_sic_code1(10):mname(9):name_suffix(8)
dn518 := h(~company_sic_code1_isnull AND ~mname_isnull AND ~name_suffix_isnull);
dn518_deduped := dn518(company_sic_code1_weight100 + mname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj518 := JOIN( dn518_deduped, dn518_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.mname = RIGHT.mname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,518),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.mname = RIGHT.mname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:company_sic_code1(10):mname(9):cnp_lowv(5):st(5)
dn519 := h(~company_sic_code1_isnull AND ~mname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn519_deduped := dn519(company_sic_code1_weight100 + mname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj519 := JOIN( dn519_deduped, dn519_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.mname = RIGHT.mname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,519),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.mname = RIGHT.mname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:company_sic_code1(10):fname(8):fname_preferred(8)
dn520 := h(~company_sic_code1_isnull AND ~fname_isnull AND ~fname_preferred_isnull);
dn520_deduped := dn520(company_sic_code1_weight100 + fname_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj520 := JOIN( dn520_deduped, dn520_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,520),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:company_sic_code1(10):fname(8):name_suffix(8)
dn521 := h(~company_sic_code1_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn521_deduped := dn521(company_sic_code1_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj521 := JOIN( dn521_deduped, dn521_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,521),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs61_t := mj517+mj518+mj519+mj520+mj521;
SALT28.mac_select_best_matches(mjs61_t,rcid1,rcid2,o61);
mjs61 := o61 : PERSIST('~temp::BizLinkFull::proxid::mj61');
//Fixed fields ->:company_sic_code1(10):fname_preferred(8):name_suffix(8)
dn522 := h(~company_sic_code1_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn522_deduped := dn522(company_sic_code1_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj522 := JOIN( dn522_deduped, dn522_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,522),HINT(Parallel_Match),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:lname(10):company_phone_3(9):company_phone_3_ex(9)
dn523 := h(~lname_isnull AND ~company_phone_3_isnull AND ~company_phone_3_ex_isnull);
dn523_deduped := dn523(lname_weight100 + company_phone_3_weight100 + company_phone_3_ex_weight100>=2600); // Use specificity to flag high-dup counts
mj523 := JOIN( dn523_deduped, dn523_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,523),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex,10000),HASH);
//Fixed fields ->:lname(10):company_phone_3(9):mname(9)
dn524 := h(~lname_isnull AND ~company_phone_3_isnull AND ~mname_isnull);
dn524_deduped := dn524(lname_weight100 + company_phone_3_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj524 := JOIN( dn524_deduped, dn524_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.mname = RIGHT.mname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,524),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.mname = RIGHT.mname,10000),HASH);
//Fixed fields ->:lname(10):company_phone_3(9):fname(8)
dn525 := h(~lname_isnull AND ~company_phone_3_isnull AND ~fname_isnull);
dn525_deduped := dn525(lname_weight100 + company_phone_3_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj525 := JOIN( dn525_deduped, dn525_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,525),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:lname(10):company_phone_3(9):fname_preferred(8)
dn526 := h(~lname_isnull AND ~company_phone_3_isnull AND ~fname_preferred_isnull);
dn526_deduped := dn526(lname_weight100 + company_phone_3_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj526 := JOIN( dn526_deduped, dn526_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,526),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
mjs62_t := mj522+mj523+mj524+mj525+mj526;
SALT28.mac_select_best_matches(mjs62_t,rcid1,rcid2,o62);
mjs62 := o62 : PERSIST('~temp::BizLinkFull::proxid::mj62');
//Fixed fields ->:lname(10):company_phone_3(9):name_suffix(8)
dn527 := h(~lname_isnull AND ~company_phone_3_isnull AND ~name_suffix_isnull);
dn527_deduped := dn527(lname_weight100 + company_phone_3_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj527 := JOIN( dn527_deduped, dn527_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,527),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:lname(10):company_phone_3(9):cnp_lowv(5):st(5)
dn528 := h(~lname_isnull AND ~company_phone_3_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn528_deduped := dn528(lname_weight100 + company_phone_3_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj528 := JOIN( dn528_deduped, dn528_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,528),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:lname(10):company_phone_3_ex(9):mname(9)
dn529 := h(~lname_isnull AND ~company_phone_3_ex_isnull AND ~mname_isnull);
dn529_deduped := dn529(lname_weight100 + company_phone_3_ex_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj529 := JOIN( dn529_deduped, dn529_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,529),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname,10000),HASH);
//Fixed fields ->:lname(10):company_phone_3_ex(9):fname(8)
dn530 := h(~lname_isnull AND ~company_phone_3_ex_isnull AND ~fname_isnull);
dn530_deduped := dn530(lname_weight100 + company_phone_3_ex_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj530 := JOIN( dn530_deduped, dn530_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,530),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:lname(10):company_phone_3_ex(9):fname_preferred(8)
dn531 := h(~lname_isnull AND ~company_phone_3_ex_isnull AND ~fname_preferred_isnull);
dn531_deduped := dn531(lname_weight100 + company_phone_3_ex_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj531 := JOIN( dn531_deduped, dn531_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,531),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
mjs63_t := mj527+mj528+mj529+mj530+mj531;
SALT28.mac_select_best_matches(mjs63_t,rcid1,rcid2,o63);
mjs63 := o63 : PERSIST('~temp::BizLinkFull::proxid::mj63');
//Fixed fields ->:lname(10):company_phone_3_ex(9):name_suffix(8)
dn532 := h(~lname_isnull AND ~company_phone_3_ex_isnull AND ~name_suffix_isnull);
dn532_deduped := dn532(lname_weight100 + company_phone_3_ex_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj532 := JOIN( dn532_deduped, dn532_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,532),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:lname(10):company_phone_3_ex(9):cnp_lowv(5):st(5)
dn533 := h(~lname_isnull AND ~company_phone_3_ex_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn533_deduped := dn533(lname_weight100 + company_phone_3_ex_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj533 := JOIN( dn533_deduped, dn533_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,533),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:lname(10):mname(9):fname(8)
dn534 := h(~lname_isnull AND ~mname_isnull AND ~fname_isnull);
dn534_deduped := dn534(lname_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj534 := JOIN( dn534_deduped, dn534_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,534),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:lname(10):mname(9):fname_preferred(8)
dn535 := h(~lname_isnull AND ~mname_isnull AND ~fname_preferred_isnull);
dn535_deduped := dn535(lname_weight100 + mname_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj535 := JOIN( dn535_deduped, dn535_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,535),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:lname(10):mname(9):name_suffix(8)
dn536 := h(~lname_isnull AND ~mname_isnull AND ~name_suffix_isnull);
dn536_deduped := dn536(lname_weight100 + mname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj536 := JOIN( dn536_deduped, dn536_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,536),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs64_t := mj532+mj533+mj534+mj535+mj536;
SALT28.mac_select_best_matches(mjs64_t,rcid1,rcid2,o64);
mjs64 := o64 : PERSIST('~temp::BizLinkFull::proxid::mj64');
//Fixed fields ->:lname(10):mname(9):cnp_lowv(5):st(5)
dn537 := h(~lname_isnull AND ~mname_isnull AND ~cnp_lowv_isnull AND ~st_isnull);
dn537_deduped := dn537(lname_weight100 + mname_weight100 + cnp_lowv_weight100 + st_weight100>=2600); // Use specificity to flag high-dup counts
mj537 := JOIN( dn537_deduped, dn537_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,537),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname AND LEFT.cnp_lowv = RIGHT.cnp_lowv AND LEFT.st = RIGHT.st,10000),HASH);
//Fixed fields ->:lname(10):fname(8):fname_preferred(8)
dn538 := h(~lname_isnull AND ~fname_isnull AND ~fname_preferred_isnull);
dn538_deduped := dn538(lname_weight100 + fname_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj538 := JOIN( dn538_deduped, dn538_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,538),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:lname(10):fname(8):name_suffix(8)
dn539 := h(~lname_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn539_deduped := dn539(lname_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj539 := JOIN( dn539_deduped, dn539_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,539),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:lname(10):fname_preferred(8):name_suffix(8)
dn540 := h(~lname_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn540_deduped := dn540(lname_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj540 := JOIN( dn540_deduped, dn540_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,540),HINT(Parallel_Match),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:company_phone_3(9):company_phone_3_ex(9):mname(9)
dn541 := h(~company_phone_3_isnull AND ~company_phone_3_ex_isnull AND ~mname_isnull);
dn541_deduped := dn541(company_phone_3_weight100 + company_phone_3_ex_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj541 := JOIN( dn541_deduped, dn541_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,541),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname,10000),HASH);
mjs65_t := mj537+mj538+mj539+mj540+mj541;
SALT28.mac_select_best_matches(mjs65_t,rcid1,rcid2,o65);
mjs65 := o65 : PERSIST('~temp::BizLinkFull::proxid::mj65');
//Fixed fields ->:company_phone_3(9):company_phone_3_ex(9):fname(8)
dn542 := h(~company_phone_3_isnull AND ~company_phone_3_ex_isnull AND ~fname_isnull);
dn542_deduped := dn542(company_phone_3_weight100 + company_phone_3_ex_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj542 := JOIN( dn542_deduped, dn542_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,542),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:company_phone_3(9):company_phone_3_ex(9):fname_preferred(8)
dn543 := h(~company_phone_3_isnull AND ~company_phone_3_ex_isnull AND ~fname_preferred_isnull);
dn543_deduped := dn543(company_phone_3_weight100 + company_phone_3_ex_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj543 := JOIN( dn543_deduped, dn543_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,543),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:company_phone_3(9):company_phone_3_ex(9):name_suffix(8)
dn544 := h(~company_phone_3_isnull AND ~company_phone_3_ex_isnull AND ~name_suffix_isnull);
dn544_deduped := dn544(company_phone_3_weight100 + company_phone_3_ex_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj544 := JOIN( dn544_deduped, dn544_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,544),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:company_phone_3(9):mname(9):fname(8)
dn545 := h(~company_phone_3_isnull AND ~mname_isnull AND ~fname_isnull);
dn545_deduped := dn545(company_phone_3_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj545 := JOIN( dn545_deduped, dn545_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,545),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:company_phone_3(9):mname(9):fname_preferred(8)
dn546 := h(~company_phone_3_isnull AND ~mname_isnull AND ~fname_preferred_isnull);
dn546_deduped := dn546(company_phone_3_weight100 + mname_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj546 := JOIN( dn546_deduped, dn546_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.mname = RIGHT.mname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,546),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.mname = RIGHT.mname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
mjs66_t := mj542+mj543+mj544+mj545+mj546;
SALT28.mac_select_best_matches(mjs66_t,rcid1,rcid2,o66);
mjs66 := o66 : PERSIST('~temp::BizLinkFull::proxid::mj66');
//Fixed fields ->:company_phone_3(9):mname(9):name_suffix(8)
dn547 := h(~company_phone_3_isnull AND ~mname_isnull AND ~name_suffix_isnull);
dn547_deduped := dn547(company_phone_3_weight100 + mname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj547 := JOIN( dn547_deduped, dn547_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.mname = RIGHT.mname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,547),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.mname = RIGHT.mname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//First 3 fields shared with following 2 joins - optimization performed
//Fixed fields ->:company_phone_3(9):fname(8):fname_preferred(8):name_suffix(8) also :company_phone_3(9):fname(8):fname_preferred(8):cnp_lowv(5) also :company_phone_3(9):fname(8):fname_preferred(8):st(5)
dn548 := h(~company_phone_3_isnull AND ~fname_isnull AND ~fname_preferred_isnull);
dn548_deduped := dn548(company_phone_3_weight100 + fname_weight100 + fname_preferred_weight100>=2200); // Use specificity to flag high-dup counts
mj548 := JOIN( dn548_deduped, dn548_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,548),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:company_phone_3(9):fname(8):name_suffix(8):cnp_lowv(5) also :company_phone_3(9):fname(8):name_suffix(8):st(5)
dn551 := h(~company_phone_3_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn551_deduped := dn551(company_phone_3_weight100 + fname_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj551 := JOIN( dn551_deduped, dn551_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,551),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs67_t := mj547+mj548+mj551;
SALT28.mac_select_best_matches(mjs67_t,rcid1,rcid2,o67);
mjs67 := o67 : PERSIST('~temp::BizLinkFull::proxid::mj67');
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:company_phone_3(9):fname_preferred(8):name_suffix(8):cnp_lowv(5) also :company_phone_3(9):fname_preferred(8):name_suffix(8):st(5)
dn553 := h(~company_phone_3_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn553_deduped := dn553(company_phone_3_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj553 := JOIN( dn553_deduped, dn553_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,553),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3 = RIGHT.company_phone_3 AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//Fixed fields ->:company_phone_3_ex(9):mname(9):fname(8)
dn555 := h(~company_phone_3_ex_isnull AND ~mname_isnull AND ~fname_isnull);
dn555_deduped := dn555(company_phone_3_ex_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj555 := JOIN( dn555_deduped, dn555_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,555),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname,10000),HASH);
//Fixed fields ->:company_phone_3_ex(9):mname(9):fname_preferred(8)
dn556 := h(~company_phone_3_ex_isnull AND ~mname_isnull AND ~fname_preferred_isnull);
dn556_deduped := dn556(company_phone_3_ex_weight100 + mname_weight100 + fname_preferred_weight100>=2600); // Use specificity to flag high-dup counts
mj556 := JOIN( dn556_deduped, dn556_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,556),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//Fixed fields ->:company_phone_3_ex(9):mname(9):name_suffix(8)
dn557 := h(~company_phone_3_ex_isnull AND ~mname_isnull AND ~name_suffix_isnull);
dn557_deduped := dn557(company_phone_3_ex_weight100 + mname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj557 := JOIN( dn557_deduped, dn557_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1),match_join(LEFT,RIGHT,557),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.mname = RIGHT.mname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs68_t := mj553+mj555+mj556+mj557;
SALT28.mac_select_best_matches(mjs68_t,rcid1,rcid2,o68);
mjs68 := o68 : PERSIST('~temp::BizLinkFull::proxid::mj68');
//First 3 fields shared with following 2 joins - optimization performed
//Fixed fields ->:company_phone_3_ex(9):fname(8):fname_preferred(8):name_suffix(8) also :company_phone_3_ex(9):fname(8):fname_preferred(8):cnp_lowv(5) also :company_phone_3_ex(9):fname(8):fname_preferred(8):st(5)
dn558 := h(~company_phone_3_ex_isnull AND ~fname_isnull AND ~fname_preferred_isnull);
dn558_deduped := dn558(company_phone_3_ex_weight100 + fname_weight100 + fname_preferred_weight100>=2200); // Use specificity to flag high-dup counts
mj558 := JOIN( dn558_deduped, dn558_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,558),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:company_phone_3_ex(9):fname(8):name_suffix(8):cnp_lowv(5) also :company_phone_3_ex(9):fname(8):name_suffix(8):st(5)
dn561 := h(~company_phone_3_ex_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn561_deduped := dn561(company_phone_3_ex_weight100 + fname_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj561 := JOIN( dn561_deduped, dn561_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,561),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
mjs69_t := mj558+mj561;
SALT28.mac_select_best_matches(mjs69_t,rcid1,rcid2,o69);
mjs69 := o69 : PERSIST('~temp::BizLinkFull::proxid::mj69');
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:company_phone_3_ex(9):fname_preferred(8):name_suffix(8):cnp_lowv(5) also :company_phone_3_ex(9):fname_preferred(8):name_suffix(8):st(5)
dn563 := h(~company_phone_3_ex_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn563_deduped := dn563(company_phone_3_ex_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj563 := JOIN( dn563_deduped, dn563_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,563),HINT(Parallel_Match),ATMOST(LEFT.company_phone_3_ex = RIGHT.company_phone_3_ex AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//First 3 fields shared with following 2 joins - optimization performed
//Fixed fields ->:mname(9):fname(8):fname_preferred(8):name_suffix(8) also :mname(9):fname(8):fname_preferred(8):cnp_lowv(5) also :mname(9):fname(8):fname_preferred(8):st(5)
dn565 := h(~mname_isnull AND ~fname_isnull AND ~fname_preferred_isnull);
dn565_deduped := dn565(mname_weight100 + fname_weight100 + fname_preferred_weight100>=2200); // Use specificity to flag high-dup counts
mj565 := JOIN( dn565_deduped, dn565_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
    OR    LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,565),HINT(Parallel_Match),ATMOST(LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred,10000),HASH);
mjs70_t := mj563+mj565;
SALT28.mac_select_best_matches(mjs70_t,rcid1,rcid2,o70);
mjs70 := o70 : PERSIST('~temp::BizLinkFull::proxid::mj70');
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:mname(9):fname(8):name_suffix(8):cnp_lowv(5) also :mname(9):fname(8):name_suffix(8):st(5)
dn568 := h(~mname_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn568_deduped := dn568(mname_weight100 + fname_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj568 := JOIN( dn568_deduped, dn568_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,568),HINT(Parallel_Match),ATMOST(LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:mname(9):fname_preferred(8):name_suffix(8):cnp_lowv(5) also :mname(9):fname_preferred(8):name_suffix(8):st(5)
dn570 := h(~mname_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn570_deduped := dn570(mname_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj570 := JOIN( dn570_deduped, dn570_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.mname = RIGHT.mname AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,570),HINT(Parallel_Match),ATMOST(LEFT.mname = RIGHT.mname AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:fname(8):fname_preferred(8):name_suffix(8):cnp_lowv(5) also :fname(8):fname_preferred(8):name_suffix(8):st(5)
dn572 := h(~fname_isnull AND ~fname_preferred_isnull AND ~name_suffix_isnull);
dn572_deduped := dn572(fname_weight100 + fname_preferred_weight100 + name_suffix_weight100>=2200); // Use specificity to flag high-dup counts
mj572 := JOIN( dn572_deduped, dn572_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix  AND SALT28.WithinEditN(LEFT.prim_range,RIGHT.prim_range,1)
    AND (
          LEFT.cnp_lowv = RIGHT.cnp_lowv AND ~LEFT.cnp_lowv_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        ),match_join(LEFT,RIGHT,572),HINT(Parallel_Match),ATMOST(LEFT.fname = RIGHT.fname AND LEFT.fname_preferred = RIGHT.fname_preferred AND LEFT.name_suffix = RIGHT.name_suffix,10000),HASH);
last_mjs_t :=mj568+mj570+mj572;
SALT28.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
SHARED all_mjs :=  mjs0+ mjs1+ mjs2+ mjs3+ mjs4+ mjs5+ mjs6+ mjs7+ mjs8+ mjs9+ mjs10+ mjs11+ mjs12+ mjs13+ mjs14+ mjs15+ mjs16+ mjs17+ mjs18+ mjs19+ mjs20+ mjs21+ mjs22+ mjs23+ mjs24+ mjs25+ mjs26+ mjs27+ mjs28+ mjs29+ mjs30+ mjs31+ mjs32+ mjs33+ mjs34+ mjs35+ mjs36+ mjs37+ mjs38+ mjs39+ mjs40+ mjs41+ mjs42+ mjs43+ mjs44+ mjs45+ mjs46+ mjs47+ mjs48+ mjs49+ mjs50+ mjs51+ mjs52+ mjs53+ mjs54+ mjs55+ mjs56+ mjs57+ mjs58+ mjs59+ mjs60+ mjs61+ mjs62+ mjs63+ mjs64+ mjs65+ mjs66+ mjs67+ mjs68+ mjs69+ mjs70 +o;
export All_Matches := all_mjs : PERSIST('~temp::BizLinkFull_proxid_BizHead_all_m'); // To by used by rcid and proxid
SALT28.mac_avoid_transitives(All_Matches,proxid1,proxid2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : PERSIST('~temp::BizLinkFull_proxid_BizHead_mt');
SALT28.mac_get_BestPerRecord( All_Matches,rcid1,proxid1,rcid2,proxid2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::BizLinkFull_proxid_BizHead_mr');
//Now lets see if any slice-outs are needed
too_big := Specificities(ih).ClusterSizes(InCluster>1000); // proxid that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.proxid=RIGHT.proxid,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
in_matches := JOIN(h_ok,h_ok,LEFT.proxid=RIGHT.proxid AND (>STRING6<)LEFT.rcid<>(>STRING6<)RIGHT.rcid,match_join(LEFT,RIGHT,9999),LOCAL,HINT(Parallel_Match));
SALT28.mac_cluster_breadth(in_matches,rcid1,rcid2,proxid1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.proxid1=RIGHT.proxid,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('~temp::BizLinkFull_proxid_BizHead_clu');
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT28.UIDType rcid;  //Outcast
  SALT28.UIDType proxid;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT28.UIDType Pref_rcid; // Prefers this record
  SALT28.UIDType Pref_proxid; // Prefers this cluster
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
EXPORT BetterElsewhere := WillJoin2;
EXPORT ToSlice := DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(proxid)),proxid,-Pref_Margin,LOCAL),proxid,LOCAL); // 1024x better in new place
SALT28.MAC_Avoid_SliceOuts(PossibleMatches,proxid1,proxid2,proxid,Pref_proxid,ToSlice,m); // If proxid is slice target - don't use in match
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
ut.MAC_Patch_Id(ih,proxid,BasicMatch(ih).patch_file,proxid1,proxid2,ihbp); // Perform basic matches
SALT28.MAC_SliceOut_ByRID(ihbp,rcid,proxid,ToSlice,rcid,sliced); // Execute Sliceouts
ut.MAC_Patch_Id(sliced,proxid,Matches,proxid1,proxid2,o); // Join Clusters
  Patchseleid := SALT28.MAC_ParentId_Patch(o,seleid,proxid);  // Collapse any seleid now joined by proxid
  Patchorgid := SALT28.MAC_ParentId_Patch(Patchseleid,orgid,seleid);  // Collapse any orgid now joined by seleid
  Patchultid := SALT28.MAC_ParentId_Patch(Patchorgid,ultid,orgid);  // Collapse any ultid now joined by orgid
EXPORT Patched_Infile := Patchultid;
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,proxid,Matches,proxid1,proxid2,o1);
EXPORT Patched_Candidates := o1;
// Now compute a file to show which identifiers have changed from input to output
  id_shift_r := RECORD
    SALT28.UIDType rcid;
    SALT28.UIDType proxid_before;
    SALT28.UIDType proxid_after;
    SALT28.UIDType seleid_before;
    SALT28.UIDType seleid_after;
    SALT28.UIDType orgid_before;
    SALT28.UIDType orgid_after;
    SALT28.UIDType ultid_before;
    SALT28.UIDType ultid_after;
    UNSIGNED4 change_date;
  END;
  id_shift_r note_change(ih le,patched_infile ri) := TRANSFORM
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
EXPORT IdChanges := JOIN(ih,patched_infile,LEFT.rcid = RIGHT.rcid AND (LEFT.proxid<>RIGHT.proxid OR LEFT.seleid<>RIGHT.seleid OR LEFT.orgid<>RIGHT.orgid OR LEFT.ultid<>RIGHT.ultid),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := BizLinkFull.Fields.UIDConsistency(ih); // Export whole consistency module
EXPORT PostIDs := BizLinkFull.Fields.UIDConsistency(Patched_Infile); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[1].proxid_count - PostIDs.IdCounts[1].proxid_count - MatchesPerformed - COUNT(BasicMatch(ih).patch_file) + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile) - PostIDs.IdCounts[1].rcid_Count; // Should be zero
END;

