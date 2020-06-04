// Begin code to perform the matching itself
 
IMPORT SALT311,std;
EXPORT matches(DATASET(layout_DOT_Base) ih, UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED split_patch := LinkBlockers(ih).Patches;
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED {boolean perfect_name_address_match/*HACK add perfect name address field*/,match_candidates(ih).layout_matches} match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0,UNSIGNED cnp_name_support0 = 0) := TRANSFORM
  SELF.Rule := c;
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT311.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 cnp_number_score_temp := MAP(
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.cnp_number_weight100,ri.cnp_number_weight100),s.cnp_number_switch));
  INTEGER2 sbfe_id_score := MAP(
                        le.sbfe_id_isnull OR ri.sbfe_id_isnull => 0,
                        le.sbfe_id = ri.sbfe_id  => le.sbfe_id_weight100,
                        0 /* switchN/0 */);
  INTEGER2 company_charter_number_score := MAP(
                        le.company_charter_number_isnull OR ri.company_charter_number_isnull => 0,
                        le.company_inc_state_isnull OR ri.company_inc_state_isnull OR le.company_inc_state <> ri.company_inc_state  => 0, // Only valid if the context variable is equal
                        le.company_charter_number = ri.company_charter_number  => le.company_charter_number_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.company_charter_number_weight100,ri.company_charter_number_weight100),s.company_charter_number_switch));
  INTEGER2 hist_enterprise_number_score := MAP(
                        le.hist_enterprise_number_isnull OR ri.hist_enterprise_number_isnull => 0,
                        le.hist_enterprise_number = ri.hist_enterprise_number  => le.hist_enterprise_number_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.hist_enterprise_number_weight100,ri.hist_enterprise_number_weight100),s.hist_enterprise_number_switch));
  INTEGER2 ebr_file_number_score := MAP(
                        le.ebr_file_number_isnull OR ri.ebr_file_number_isnull => 0,
                        le.ebr_file_number = ri.ebr_file_number  => le.ebr_file_number_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.ebr_file_number_weight100,ri.ebr_file_number_weight100),s.ebr_file_number_switch));
  INTEGER2 active_enterprise_number_score_temp := MAP(
                        le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.active_enterprise_number_weight100,ri.active_enterprise_number_weight100),s.active_enterprise_number_switch));
  INTEGER2 hist_corp_key_score := MAP(
                        le.hist_corp_key_isnull OR ri.hist_corp_key_isnull => 0,
                        le.hist_corp_key = ri.hist_corp_key  => le.hist_corp_key_weight100,
                        0 /* switchN/0 */);
  INTEGER2 hist_duns_number_score := MAP(
                        le.hist_duns_number_isnull OR ri.hist_duns_number_isnull => 0,
                        le.hist_duns_number = ri.hist_duns_number  => le.hist_duns_number_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.hist_duns_number_weight100,ri.hist_duns_number_weight100),s.hist_duns_number_switch));
  INTEGER2 active_duns_number_score := MAP(
                        le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.active_duns_number_weight100,ri.active_duns_number_weight100),s.active_duns_number_switch));
  INTEGER2 company_phone_score := MAP(
                        le.company_phone_isnull OR ri.company_phone_isnull => 0,
                        le.company_phone = ri.company_phone  => le.company_phone_weight100,
                        0 /* switchN/0 */);
  INTEGER2 company_fein_score := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        Config.WithinEditN(le.company_fein,le.company_fein_len,ri.company_fein,ri.company_fein_len,1,0) =>  SALT311.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt),
                        SALT311.Fn_Fail_Scale(AVE(le.company_fein_weight100,ri.company_fein_weight100),s.company_fein_switch));
  INTEGER2 cnp_name_phonetic_score := MAP(
                        le.cnp_name_phonetic_isnull OR ri.cnp_name_phonetic_isnull => 0,
                        le.cnp_name_phonetic = ri.cnp_name_phonetic  => le.cnp_name_phonetic_weight100,
                        metaphonelib.dmetaphone1(le.cnp_name_phonetic) = metaphonelib.dmetaphone1(ri.cnp_name_phonetic) => SALT311.fn_fuzzy_specificity(le.cnp_name_phonetic_weight100,le.cnp_name_phonetic_cnt, le.cnp_name_phonetic_p_cnt,ri.cnp_name_phonetic_weight100,ri.cnp_name_phonetic_cnt,ri.cnp_name_phonetic_p_cnt),
                        SALT311.Fn_Fail_Scale(AVE(le.cnp_name_phonetic_weight100,ri.cnp_name_phonetic_weight100),s.cnp_name_phonetic_switch));
  INTEGER2 company_inc_state_score := MAP(
                        le.company_inc_state_isnull OR ri.company_inc_state_isnull => 0,
                        le.company_inc_state = ri.company_inc_state  => le.company_inc_state_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.company_inc_state_weight100,ri.company_inc_state_weight100),s.company_inc_state_switch));
  INTEGER2 cnp_btype_score := MAP(
                        le.cnp_btype_isnull OR ri.cnp_btype_isnull => 0,
                        le.cnp_btype = ri.cnp_btype  => le.cnp_btype_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.cnp_btype_weight100,ri.cnp_btype_weight100),s.cnp_btype_switch));
  INTEGER2 company_name_type_derived_score_temp := MAP(
                        le.company_name_type_derived_isnull OR ri.company_name_type_derived_isnull => 0,
                        le.company_name_type_derived = ri.company_name_type_derived  => le.company_name_type_derived_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.company_name_type_derived_weight100,ri.company_name_type_derived_weight100),s.company_name_type_derived_switch));
  REAL company_address_score_scale := ( le.company_address_weight100 + ri.company_address_weight100 ) / (le.company_addr1_weight100 + ri.company_addr1_weight100 + le.company_csz_weight100 + ri.company_csz_weight100); // Scaling factor for this concept
  INTEGER2 company_address_score_pre := MAP( (le.company_address_isnull OR (le.company_addr1_isnull OR le.prim_range_derived_isnull AND le.prim_name_derived_isnull AND le.sec_range_isnull) AND (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.company_address_isnull OR (ri.company_addr1_isnull OR ri.prim_range_derived_isnull AND ri.prim_name_derived_isnull AND ri.sec_range_isnull) AND (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.company_address_weight100 = 0 => 0,
                        le.company_address = ri.company_address  => le.company_address_weight100,
                        0);
  INTEGER2 cnp_number_score := IF ( le.cnp_number = ri.cnp_number /*HACKCompanyNumber*/ /* cnp_number_score_temp >= Config.cnp_number_Force * 100 */ , cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= Config.active_enterprise_number_Force * 100, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter
  REAL company_addr1_score_scale := ( le.company_addr1_weight100 + ri.company_addr1_weight100 ) / (le.prim_range_derived_weight100 + ri.prim_range_derived_weight100 + le.prim_name_derived_weight100 + ri.prim_name_derived_weight100 + le.sec_range_weight100 + ri.sec_range_weight100); // Scaling factor for this concept
  INTEGER2 company_addr1_score_pre := MAP( (le.company_addr1_isnull OR le.prim_range_derived_isnull AND le.prim_name_derived_isnull AND le.sec_range_isnull) OR (ri.company_addr1_isnull OR ri.prim_range_derived_isnull AND ri.prim_name_derived_isnull AND ri.sec_range_isnull) => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_addr1 = ri.company_addr1  => le.company_addr1_weight100,
                        0)*IF(company_address_score_scale=0,1,company_address_score_scale);
  REAL company_csz_score_scale := ( le.company_csz_weight100 + ri.company_csz_weight100 ) / (le.v_city_name_weight100 + ri.v_city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 company_csz_score_pre := MAP( (le.company_csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.company_csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.company_csz_weight100 = 0 => 0,
                        company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.company_csz = ri.company_csz  => le.company_csz_weight100,
                        0)*IF(company_address_score_scale=0,1,company_address_score_scale);
  INTEGER2 cnp_name_score_temp := MAP(
                        le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        SALT311.WordBagsEqual(le.cnp_name,ri.cnp_name) OR SALT311.HyphenMatch(le.cnp_name,ri.cnp_name,1)<=1  => MIN(le.cnp_name_weight100,ri.cnp_name_weight100),
                        SALT311.MatchBagOfWords(le.cnp_name,ri.cnp_name,46614,1));
  INTEGER2 prim_name_derived_score_temp := MAP(
                        le.prim_name_derived_isnull OR ri.prim_name_derived_isnull OR le.prim_name_derived_weight100 = 0 => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        SALT311.WordBagsEqual(le.prim_name_derived,ri.prim_name_derived) OR SALT311.HyphenMatch(le.prim_name_derived,ri.prim_name_derived,1)<=1  => MIN(le.prim_name_derived_weight100,ri.prim_name_derived_weight100),
                        SALT311.MatchBagOfWords(le.prim_name_derived,ri.prim_name_derived,32022,1))*IF(company_addr1_score_scale=0,1,company_addr1_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  INTEGER2 sec_range_score := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range OR SALT311.HyphenMatch(le.sec_range,ri.sec_range,1)<=1  => MIN(le.sec_range_weight100,ri.sec_range_weight100),
                        SALT311.Fn_Fail_Scale(AVE(le.sec_range_weight100,ri.sec_range_weight100),s.sec_range_switch))*IF(company_addr1_score_scale=0,1,company_addr1_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  INTEGER2 v_city_name_score := MAP(
                        le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st_isnull OR ri.st_isnull OR le.st <> ri.st  => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.v_city_name_weight100,ri.v_city_name_weight100),s.v_city_name_switch))*IF(company_csz_score_scale=0,1,company_csz_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  INTEGER2 company_name_type_derived_score := company_name_type_derived_score_temp*0.00; 
  INTEGER2 st_score_temp := MAP(
                        le.st_isnull OR ri.st_isnull OR le.st_weight100 = 0 => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.st_weight100,ri.st_weight100),s.st_switch))*IF(company_csz_score_scale=0,1,company_csz_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  INTEGER2 prim_range_derived_score_temp := MAP(
                        company_addr1_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range_derived = ri.prim_range_derived  => le.prim_range_derived_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.prim_range_derived_weight100,ri.prim_range_derived_weight100),s.prim_range_derived_switch))*IF(company_addr1_score_scale=0,1,company_addr1_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  INTEGER2 zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        company_csz_score_pre > 0 OR company_address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT311.Fn_Fail_Scale(AVE(le.zip_weight100,ri.zip_weight100),s.zip_switch))*IF(company_csz_score_scale=0,1,company_csz_score_scale)*IF(company_address_score_scale=0,1,company_address_score_scale);
  INTEGER2 support_cnp_name := cnp_name_support0; // Add support
  INTEGER2 cnp_name_score_supp := MIN(IF(support_cnp_name>0,MAX(cnp_name_score_temp,support_cnp_name*100),cnp_name_score_temp),s.cnp_name_MAXIMUM*100); // Add support
    import tools;
  cnp_name_bow_most_38    := SALT311.MatchBagOfWords(le.cnp_name,ri.cnp_name,38   ,1);  //threshold of 800
  string_similarity_ratio := tools.string_similarity_ratio(trim(le.cnp_name_phonetic),trim(ri.cnp_name_phonetic));
  not_both_legal_names    := ~(regexfind('legal',le.company_name_type_derived,nocase) and regexfind('legal',ri.company_name_type_derived,nocase) );

  INTEGER2 cnp_name_score := MAP ( 
        le.cnp_name          = ri.cnp_name 
    or (cnp_name_score_supp >= Config.cnp_name_Force * 100 and cnp_name_support0 = 0)
    or (cnp_name_score_supp >= Config.cnp_name_Force * 100 and cnp_name_support0 > 0)  
                                                                                                                                                                         => cnp_name_score_supp
    ,company_charter_number_score > Config.company_charter_number_Force*100  and not_both_legal_names                                                                => 0
    ,active_duns_number_score       > Config.active_duns_number_Force      *100  and not_both_legal_names                                                                => 0
    ,company_fein_score             > Config.company_fein_Force            *100  and not_both_legal_names  and (le.SALT_Partition = '' and ri.SALT_Partition = '')   => 0                    /*no partitioned sources allowed*/
    ,sbfe_id_score                  > Config.sbfe_id_Force                 *100  and not_both_legal_names  and (le.SALT_Partition = '' and ri.SALT_Partition = '')   => 0                    /*no partitioned sources allowed*/

    ,(cnp_name_bow_most_38           >= 800 or cnp_name_phonetic_score        >= 700) and string_similarity_ratio >= 0.70/* or string_similarity_ratio >= 0.80 */   => map(cnp_name_bow_most_38 > cnp_name_phonetic_score and cnp_name_bow_most_38 > 800 => cnp_name_bow_most_38  
                                                                                                                                                                           ,cnp_name_phonetic_score  >= 700                                                   => cnp_name_phonetic_score
                                                                                                                                                                           ,0
                                                                                                                                                                           )    // ,cnp_name_phonetic_score        >= 700 and string_similarity >= 0.70                                                                                            => 0                    //this is already counted as a regular field, so don't double count

    ,                                                                                                                                                                      SKIP 
  );/*HACKCompanyNameScore*/ // Enforce FORCE parameter
 // Enforce FORCE parameter
  INTEGER2 prim_name_derived_score := IF ( le.prim_name_derived = ri.prim_name_derived/*HACKPrimName*/ or prim_name_derived_score_temp >= Config.prim_name_derived_Force * 100 OR company_addr1_score_pre > 0 OR company_address_score_pre > 0, prim_name_derived_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 st_score := IF ( st_score_temp > Config.st_Force * 100 OR company_csz_score_pre > 0 OR company_address_score_pre > 0, st_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_range_derived_score := IF ( prim_range_derived_score_temp >= Config.prim_range_derived_Force * 100 OR company_addr1_score_pre > 0 OR company_address_score_pre > 0, prim_range_derived_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept company_addr1
  INTEGER2 company_addr1_score_ext := SALT311.ClipScore(MAX(company_addr1_score_pre,0) + prim_range_derived_score + prim_name_derived_score + sec_range_score + MAX(company_address_score_pre,0));// Score in surrounding context
  INTEGER2 company_addr1_score_res := MAX(0,company_addr1_score_pre); // At least nothing
  INTEGER2 company_addr1_score := company_addr1_score_res;
// Compute the score for the concept company_csz
  INTEGER2 company_csz_score_ext := SALT311.ClipScore(MAX(company_csz_score_pre,0) + v_city_name_score + st_score + zip_score + MAX(company_address_score_pre,0));// Score in surrounding context
  INTEGER2 company_csz_score_res := MAX(0,company_csz_score_pre); // At least nothing
  INTEGER2 company_csz_score := IF ( company_csz_score_ext > -200,company_csz_score_res,SKIP);
// Compute the score for the concept company_address
  INTEGER2 company_address_score_ext := SALT311.ClipScore(MAX(company_address_score_pre,0)+ company_addr1_score + prim_range_derived_score + prim_name_derived_score + sec_range_score+ company_csz_score + v_city_name_score + st_score + zip_score);// Score in surrounding context
  INTEGER2 company_address_score_res := MAX(0,company_address_score_pre); // At least nothing
  INTEGER2 company_address_score := IF ( company_address_score_ext > 0,company_address_score_res,SKIP);
  // Get propagation scores for individual propagated fields
  INTEGER2 cnp_number_score_prop := MAX(le.cnp_number_prop,ri.cnp_number_prop)*cnp_number_score; // Score if either field propogated
  INTEGER2 prim_range_derived_score_prop := MAX(le.prim_range_derived_prop,ri.prim_range_derived_prop)*prim_range_derived_score; // Score if either field propogated
  INTEGER2 hist_enterprise_number_score_prop := MAX(le.hist_enterprise_number_prop,ri.hist_enterprise_number_prop)*hist_enterprise_number_score; // Score if either field propogated
  INTEGER2 ebr_file_number_score_prop := MAX(le.ebr_file_number_prop,ri.ebr_file_number_prop)*ebr_file_number_score; // Score if either field propogated
  INTEGER2 active_enterprise_number_score_prop := MAX(le.active_enterprise_number_prop,ri.active_enterprise_number_prop)*active_enterprise_number_score; // Score if either field propogated
  INTEGER2 hist_corp_key_score_prop := MAX(le.hist_corp_key_prop,ri.hist_corp_key_prop)*hist_corp_key_score; // Score if either field propogated
  INTEGER2 hist_duns_number_score_prop := MAX(le.hist_duns_number_prop,ri.hist_duns_number_prop)*hist_duns_number_score; // Score if either field propogated
  INTEGER2 active_duns_number_score_prop := MAX(le.active_duns_number_prop,ri.active_duns_number_prop)*active_duns_number_score; // Score if either field propogated
  INTEGER2 company_phone_score_prop := MAX(le.company_phone_prop,ri.company_phone_prop)*company_phone_score; // Score if either field propogated
  INTEGER2 company_fein_score_prop := MAX(le.company_fein_prop,ri.company_fein_prop)*company_fein_score; // Score if either field propogated
  INTEGER2 company_addr1_score_prop := IF(le.company_addr1_prop+ri.company_addr1_prop>0,company_addr1_score*(0+IF(le.prim_range_derived_prop+ri.prim_range_derived_prop>0,s.prim_range_derived_specificity,0)+IF(le.sec_range_prop+ri.sec_range_prop>0,s.sec_range_specificity,0))/( s.prim_range_derived_specificity+ s.sec_range_specificity),0);
  INTEGER2 sec_range_score_prop := MAX(le.sec_range_prop,ri.sec_range_prop)*sec_range_score; // Score if either field propogated
  INTEGER2 company_name_type_derived_score_prop := MAX(le.company_name_type_derived_prop,ri.company_name_type_derived_prop)*company_name_type_derived_score; // Score if either field propogated
  INTEGER2 company_address_score_prop := IF(le.company_address_prop+ri.company_address_prop>0,company_address_score*(0+IF(le.company_addr1_prop+ri.company_addr1_prop>0,s.company_addr1_specificity,0))/( s.company_addr1_specificity),0);
  SELF.Conf_Prop := (0 + cnp_number_score_prop + prim_range_derived_score_prop + hist_enterprise_number_score_prop + ebr_file_number_score_prop + active_enterprise_number_score_prop + hist_corp_key_score_prop + hist_duns_number_score_prop + active_duns_number_score_prop + company_phone_score_prop + company_fein_score_prop + company_addr1_score_prop + sec_range_score_prop + company_name_type_derived_score_prop + company_address_score_prop) / 100; // Score based on propogated fields
  import ut;
iComp1 := (cnp_number_score + sbfe_id_score + company_charter_number_score + hist_enterprise_number_score + ebr_file_number_score + active_enterprise_number_score + hist_corp_key_score + hist_duns_number_score + active_duns_number_score + company_phone_score + company_fein_score /*+ cnp_name_phonetic_score*/ /*HACKcnp_name_phonetic_score*/ + cnp_name_score + company_inc_state_score + cnp_btype_score + company_name_type_derived_score + IF(company_address_score>0,MAX(company_address_score,IF(company_addr1_score>0,MAX(company_addr1_score,prim_range_derived_score + prim_name_derived_score + sec_range_score),prim_range_derived_score + prim_name_derived_score + sec_range_score) + IF(company_csz_score>0,MAX(company_csz_score,v_city_name_score + st_score + zip_score),v_city_name_score + st_score + zip_score)),IF(company_addr1_score>0,MAX(company_addr1_score,prim_range_derived_score + prim_name_derived_score + sec_range_score),prim_range_derived_score + prim_name_derived_score + sec_range_score) + IF(company_csz_score>0,MAX(company_csz_score,v_city_name_score + st_score + zip_score),v_city_name_score + st_score + zip_score))) / 100 + outside;
iComp  := map( iComp1            >= MatchThreshold                                   => iComp1 
              ,le.company_address = ri.company_address and le.cnp_name = ri.cnp_name and ut.nneq(le.active_duns_number,ri.active_duns_number)=> MatchThreshold
              ,le.cnp_name = ri.cnp_name and  le.prim_range_derived = ri.prim_range_derived and le.prim_name_derived = ri.prim_name_derived and ut.nneq(le.v_city_name,ri.v_city_name) and le.st = ri.st and le.zip = ri.zip and ut.nneq(le.active_duns_number,ri.active_duns_number)=> MatchThreshold
              ,                                                                         iComp1
          );/*HACKScoreAssignment*/
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-SELF.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
  self.perfect_name_address_match := if(le.company_address = ri.company_address and le.cnp_name = ri.cnp_name ,true ,false);/*HACK set perfect_name_address_match*/
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
     n = 0 => ':cnp_number:st:prim_range_derived'
  ,n = 101 => ':cnp_number:prim_range_derived:cnp_name:st:pname_digits'      /* HACKMatches01 */
  ,n = 102 => ':cnp_number:prim_range_derived:prim_name_derived:st:cnp_name[1..4]'     /* HACKMatches01 */
  ,n = 103 => ':prim_range_derived:prim_name_derived:st:sec_range'         /* HACKMatches01 */
  ,n = 104 => ':cnp_number:prim_range_derived:v_city_name:st:pname_digits:cnp_name_raw[1..4]'	/* HACKMatches01 */
  ,n = 105 => ':cnp_number:prim_range_derived:zip:st:pname_digits:cnp_name_raw[1..4]'        /* HACKMatches01 */
  ,n = 106 => ':cnp_number:cnp_name:company_address'   /* HACKMatches01 */
  ,'AttributeFile:'+(STRING)(n-10000)
  );

//Now execute each of the 1 join conditions of which 0 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:cnp_number(13):st(5):prim_range_derived(12)
 
dn0 := hfile(~st_isnull);
dn0_deduped := dn0(cnp_number_weight100 + st_weight100 + prim_range_derived_weight100>=500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.Proxid > RIGHT.Proxid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' )
    AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_name_derived = RIGHT.prim_name_derived/*HACKMatches02*/
    AND LEFT.st = RIGHT.st
    AND LEFT.prim_range_derived = RIGHT.prim_range_derived
    AND ( ~left.st_isnull AND ~right.st_isnull )
    AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull )
    AND (( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) OR ( ~left.company_charter_number_isnull AND ~right.company_charter_number_isnull ) OR ( ~left.active_duns_number_isnull AND ~right.active_duns_number_isnull ) OR ( ~left.company_fein_isnull AND ~right.company_fein_isnull ) OR ( ~left.cnp_name_phonetic_isnull AND ~right.cnp_name_phonetic_isnull ) OR ( ~left.sbfe_id_isnull AND ~right.sbfe_id_isnull ))
    AND ( ~left.prim_name_derived_isnull AND ~right.prim_name_derived_isnull ) AND ( ~left.company_address_isnull AND ~right.company_address_isnull )
    /*HACKMatches03*/ AND ~(( left.cnp_name = right.cnp_name ) AND ( left.company_address = right.company_address )),trans(LEFT,RIGHT,0),UNORDERED,
    ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_name_derived = RIGHT.prim_name_derived/*HACKMatches02*/
      AND LEFT.st = RIGHT.st
      AND LEFT.prim_range_derived = RIGHT.prim_range_derived,20000),HASH);
last_mjs_t :=_mj_extra(hfile,trans) + mj0;
SALT311.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
mjs0 := o : PERSIST('~temp::Proxid::BIPV2_ProxID::mj::0',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
RETURN  mjs0;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
 
//Now construct candidates based upon attribute & relationship files
 
AllAttrMatches := SORT(Mod_Attr_SrcRidVlid(ih).Match+MOD_Attr_UnderLinks(ih).Match/*HACKMatches04*/ /* +MOD_Attr_ActiveCorpKeys(ih).Match+Mod_Attr_RAAddresses(ih).Match+Mod_Attr_FilterPrimNames(ih).Match*/,Proxid1,Proxid2,Rule,-(Conf+Conf_Prop+support_cnp_name),LOCAL);
match_candidates(ih).Layout_Attribute_Matches CombineResults(match_candidates(ih).Layout_Attribute_Matches le,match_candidates(ih).Layout_Attribute_Matches ri) := TRANSFORM
  SELF.Conf := le.Conf+ri.Conf;
  SELF.support_cnp_name := le.support_cnp_name+ri.support_cnp_name;
  SELF.Source_Id := le.Source_ID + '|' + ri.Source_ID;
  SELF := le;
END;
EXPORT All_Attribute_Matches := ROLLUP(AllAttrMatches,LEFT.Proxid1=RIGHT.Proxid1 AND LEFT.Proxid2=RIGHT.Proxid2,CombineResults(LEFT,RIGHT),LOCAL) : PERSIST('~temp::Proxid::BIPV2_ProxID::attribute_matches',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
hd := DISTRIBUTE(h,HASH(Proxid));
j1 := JOIN(DISTRIBUTE(All_Attribute_Matches,HASH(Proxid2)),hd,LEFT.Proxid2=RIGHT.Proxid,LOCAL); // Stock one half of full data
match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
  SELF := le;
END;
attr_match := JOIN(DISTRIBUTE(j1,HASH(Proxid1)),hd,LEFT.Proxid1 = RIGHT.Proxid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' )
AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_name_derived = RIGHT.prim_name_derived/*HACKMatches02*/
AND LEFT.st = RIGHT.st
AND LEFT.prim_range_derived = RIGHT.prim_range_derived
AND ( ~left.st_isnull AND ~right.st_isnull )
AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull )
AND (( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) OR LEFT.support_cnp_name > 0 OR ( ~left.active_duns_number_isnull AND ~right.active_duns_number_isnull ) OR ( ~left.company_fein_isnull AND ~right.company_fein_isnull ))
AND ( ~left.prim_name_derived_isnull AND ~right.prim_name_derived_isnull ) AND (~left.company_address_isnull AND ~right.company_address_isnull )
,match_join( RIGHT,PROJECT(LEFT,strim(LEFT)),LEFT.Rule, LEFT.Conf,LEFT.support_cnp_name)
,ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_name_derived = RIGHT.prim_name_derived
      AND LEFT.st = RIGHT.st
      AND LEFT.prim_range_derived = RIGHT.prim_range_derived,1000)
      ,LOCAL); 
 // Will be distributed by DID1
all_mjs_not_perfect_match := project(all_mjs(perfect_name_address_match = false),match_candidates(ih).layout_matches);/*HACK split matches*/
all_mjs_perfect_match     := project(all_mjs(perfect_name_address_match = true ),match_candidates(ih).layout_matches);/*HACK split matches*/
with_attr := project(attr_match,match_candidates(ih).layout_matches) + all_mjs_not_perfect_match ;/*HACK split matches*/

all_matches1 := MOD_Attr_ActiveCorpKeys(ih).ForceFilter(ih,with_attr,Proxid1,Proxid2); // Restrict to those matches obeying force upon ActiveCorpKeys
all_matches2 := MOD_Attr_RAAddresses(ih).ForceFilter(ih,all_matches1 + all_mjs_perfect_match/*HACK add back perfect matches*/,Proxid1,Proxid2); // Restrict to those matches obeying force upon RAAddresses
all_matches3 := MOD_Attr_FilterPrimNames(ih).ForceFilter(ih,all_matches2,Proxid1,Proxid2); // Restrict to those matches obeying force upon FilterPrimNames
not_blocked := JOIN(all_matches3,LinkBlockers(ih).Block,left.Proxid1=right.Proxid1 and left.Proxid2=right.Proxid2,TRANSFORM(LEFT),LEFT ONLY, SMART); // Remove all blocked links
EXPORT All_Matches := not_blocked : PERSIST('~temp::Proxid::BIPV2_ProxID::all_m',EXPIRE(BIPV2_ProxID.Config.PersistExpire)); // To by used by rcid and Proxid
// SALT311.mac_avoid_transitives(All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,o); /*HACKMatches05 - disable default salt mac_avoid_transitives*/
import BIPV2_Tools;
 /*HACKMatches05, import module for new transitives macro*/
o := BIPV2_ProxID.mac_avoid_transitives_scalene(All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,MatchThreshold,10); // HACKMatches05 - Use new transitives macro, bucket size 5*/

EXPORT PossibleMatches := o : PERSIST('~temp::Proxid::BIPV2_ProxID::mt',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
EXPORT Matches := PossibleMatches(Conf>=MatchThreshold) : PERSIST('~temp::Proxid::BIPV2_ProxID::Matches::Matches',EXPIRE(BIPV2_ProxID.Config.PersistExpire));
 
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
export MatchSampleRecords := Debug(ih, s, MatchThreshold).AnnotateMatches(Full_Sample_Matches,All_Attribute_Matches);
 
//Now actually produce the new file
SHARED ih_init := Specificities(ih).ih_init;
SHARED ih_thin := TABLE(ih_init,{rcid,dotid,Proxid,lgid3,orgid,ultid});
  SALT311.MAC_Reassign_UID(ih_thin,split_patch,Proxid,rcid,ih0); // Perform splits
  SALT311.MAC_Split_Parents(ih0,split_patch,Proxid,lgid3,ih1); // Perform parent splits
  SALT311.MAC_Split_Parents(ih1,split_patch,Proxid,orgid,ih2); // Perform parent splits
  SALT311.MAC_Split_Parents(ih2,split_patch,Proxid,ultid,ih3); // Perform parent splits
  SALT311.utMAC_Patch_Id(ih3,Proxid,BasicMatch(ih).patch_file,Proxid1,Proxid2,ihbp); // Perform basic matches
  SALT311.MAC_Reassign_UID(ihbp,Cleave(ih).patch_file,Proxid,rcid,ihbp01/*HACKMatches07a*/); // Perform cleaves
  SALT311.utMAC_Patch_Id(ihbp01/*HACKMatches07b*/,Proxid,Matches,Proxid1,Proxid2,o); // Join Clusters
  Patchlgid3 := BIPV2_Tools.MAC_ParentId_Patch(o,lgid3,Proxid);  // Collapse any lgid3 now joined by Proxid/*HACKMatches06*/
  Patchorgid := BIPV2_Tools.MAC_ParentId_Patch(Patchlgid3,orgid,lgid3);  // Collapse any orgid now joined by lgid3/*HACKMatches06*/
  Patchultid := BIPV2_Tools.MAC_ParentId_Patch(Patchorgid,ultid,orgid);  // Collapse any ultid now joined by orgid/*HACKMatches06*/
  Patchdotid := BIPV2_Tools.MAC_ChildId_Patch(Patchultid,Proxid,dotid,rcid); // Explode any dotid that need to because of splits in Proxid/*HACKMatches06*/
SHARED Patched_Infile_thin := Patchdotid : INDEPENDENT;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
 
EXPORT Patched_Infile := pi1;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
SALT311.utMAC_Patch_Id(h,Proxid,Matches,Proxid1,Proxid2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
  MatchHistory.id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.rcid := le.rcid;
    SELF.Proxid_before := le.Proxid;
    SELF.Proxid_after := ri.Proxid;
    SELF.lgid3_before := le.lgid3;
    SELF.lgid3_after := ri.lgid3;
    SELF.orgid_before := le.orgid;
    SELF.orgid_after := ri.orgid;
    SELF.ultid_before := le.ultid;
    SELF.ultid_after := ri.ultid;
    SELF.change_date := (UNSIGNED6)(STD.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%Y%m%d%H%M%S'));
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.rcid = RIGHT.rcid AND (LEFT.Proxid<>RIGHT.Proxid OR LEFT.lgid3<>RIGHT.lgid3 OR LEFT.orgid<>RIGHT.orgid OR LEFT.ultid<>RIGHT.ultid),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT LinkBlocksPerformed := COUNT(LinkBlockers(ih).New); // Count dids created
EXPORT LinkBlocksRulesUsedVsTotal := (STRING)LinkBlockers(ih).RuleCountActive + '/' + (STRING)LinkBlockers(ih).RuleCountTotal;
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := BIPV2_ProxID.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := BIPV2_ProxID.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[3].cnt - PostIDs.IdCounts[3].cnt - MatchesPerformed - COUNT(BasicMatch(ih).patch_file)  + LinkBlocksPerformed + Cleave(ih).patch_count; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].Cnt; // Should be zero
END;
