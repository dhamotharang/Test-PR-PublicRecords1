IMPORT SALT37,std,tools,BIPV2_Build;
EXPORT _Annotate_Matches(
   pProxidPairs                                                                                               // -- has at least these two fields: {unsigned6 proxid1, unsigned6 proxid2}
  ,pih              = 'BIPV2_ProxID.In_DOT_Base'                                                              // -- Input file for Iteration
  ,pKeyCandidates   = 'BIPV2_ProxID.Keys(,\'built\').candidates'                                              // -- Match Candidates Key
  ,pKeySpecs        = 'BIPV2_ProxID.Keys(,\'built\').Specificities_Key'                                       // -- Specificities Key
  ,pKeyAttMatches   = 'BIPV2_ProxID.Keys(,\'built\').Attribute_Matches'                                       // -- Attribute Matches Key
  ,MatchThreshold   = 'BIPV2_ProxID.Config.MatchThreshold'                                                    // -- Threshold for Internal Linking
  ,pDedupField      = ''                                                                                      // -- if specified, it will take the best match per dedup field(highest score)
) := 
functionmacro

  #UNIQUENAME(DedupField)
  #IF(trim(#TEXT(pDedupField)) != '')
    #SET(DedupField ,#TEXT(pDedupField))
  #ELSE
    #SET(DedupField ,'')
  #END
  
  import ut,BIPV2_Build,tools,BIPV2_Tools;
  
  // -- get MC key and input file ready
  ih        := pih;
  lay_cand  := BIPV2_ProxID.match_candidates(ih).layout_candidates;
  ds_mc     := project(pKeyCandidates ,transform(lay_cand,self := left,self := []));
  key_spec        := pKeySpecs;
  s               := project(key_spec ,transform(BIPV2_ProxID.Layout_Specificities.R,self := left,self := []))[1];

  key_att         := pKeyAttMatches;
  ds_att          := project(key_att ,BIPV2_ProxID.Match_Candidates(ih).layout_attribute_matches);

  annotate_matches := BIPV2_ProxID.debug(ih,s,MatchThreshold).AnnotateMatchesFromData;
  layout_matches   := BIPV2_ProxID.match_candidates(ih).layout_matches;

  // -- dedup and prep to annotate those matches(Score them) using the Debug attribute
  ds_prep_matches1 := table(pProxidPairs  ,{proxid1,proxid2} ,proxid1,proxid2 ,merge);
  ds_prep_matches2 := project(ds_prep_matches1  ,transform(layout_matches ,self.proxid1 := left.proxid1,self.proxid2 := left.proxid2  ,self := []))   : persist('~persist::BIPV2_ProxID::_Annotate_Matches::ds_prep_matches2');

  cnt_prep_matches := count(ds_prep_matches2);

   // -- Prep match candidates for join, dedup a little to speed up join.  Don't care too much about dates, so remove them from dedup criteria
   ds_mc_table1       := project    (ds_mc             ,transform(recordof(left),self := left));
   ds_mc_table_dist   := distribute (ds_mc_table1      ,hash(proxid,SALT_Partition));
   ds_mc_table_sort   := sort       (ds_mc_table_dist  ,proxid,record,except rcid,dt_first_seen,dt_last_seen,local);
   ds_mc_table_dedup  := dedup      (ds_mc_table_sort  ,proxid,record,except rcid,dt_first_seen,dt_last_seen,local)
     : persist('~persist::BIPV2_ProxID::_Annotate_Matches::ds_mc_table_dedup');


  // -- Annotate the matches in 4 batches.
  ds_match_join := annotate_matches(ds_mc_table_dedup ,ds_prep_matches2 ,ds_att)   : persist('~persist::BIPV2_ProxID::_Annotate_Matches::ds_match_join1');
  
  // -- Add summary string of the fields that matched and mismatched
  lay_summary := RECORD
    integer        realconf             ;
    string         SummaryForceFailures ;
    integer        total_positive_score ;
    integer        total_negative_score ;
    SALT37.StrType Summary              ;
    ds_match_join;
  END;
  lay_summary tosummary(ds_match_join le) := TRANSFORM
    SELF := le;
    SELF.Summary              := IF(le.cnp_number_Score = 0,'','|'+IF(le.cnp_number_Score < 0,'-','')+'cnp_number')+IF(le.st_Score = 0,'','|'+IF(le.st_Score < 0,'-','')+'st')+IF(le.prim_range_derived_Score = 0,'','|'+IF(le.prim_range_derived_Score < 0,'-','')+'prim_range_derived')+IF(le.hist_duns_number_Score = 0,'','|'+IF(le.hist_duns_number_Score < 0,'-','')+'hist_duns_number')+IF(le.ebr_file_number_Score = 0,'','|'+IF(le.ebr_file_number_Score < 0,'-','')+'ebr_file_number')+IF(le.active_duns_number_Score = 0,'','|'+IF(le.active_duns_number_Score < 0,'-','')+'active_duns_number')+IF(le.hist_enterprise_number_Score = 0,'','|'+IF(le.hist_enterprise_number_Score < 0,'-','')+'hist_enterprise_number')+IF(le.hist_domestic_corp_key_Score = 0,'','|'+IF(le.hist_domestic_corp_key_Score < 0,'-','')+'hist_domestic_corp_key')+IF(le.foreign_corp_key_Score = 0,'','|'+IF(le.foreign_corp_key_Score < 0,'-','')+'foreign_corp_key')+IF(le.unk_corp_key_Score = 0,'','|'+IF(le.unk_corp_key_Score < 0,'-','')+'unk_corp_key')+IF(le.company_fein_Score = 0,'','|'+IF(le.company_fein_Score < 0,'-','')+'company_fein')+IF(le.company_phone_Score = 0,'','|'+IF(le.company_phone_Score < 0,'-','')+'company_phone')+IF(le.active_enterprise_number_Score = 0,'','|'+IF(le.active_enterprise_number_Score < 0,'-','')+'active_enterprise_number')+IF(le.active_domestic_corp_key_Score = 0,'','|'+IF(le.active_domestic_corp_key_Score < 0,'-','')+'active_domestic_corp_key')+IF(le.company_addr1_Score = 0,'','|'+IF(le.company_addr1_Score < 0,'-','')+'company_addr1')+IF(le.cnp_name_Score = 0,'','|'+IF(le.cnp_name_Score < 0,'-','')+'cnp_name')+IF(le.zip_Score = 0,'','|'+IF(le.zip_Score < 0,'-','')+'zip')+IF(le.company_csz_Score = 0,'','|'+IF(le.company_csz_Score < 0,'-','')+'company_csz')+IF(le.prim_name_derived_Score = 0,'','|'+IF(le.prim_name_derived_Score < 0,'-','')+'prim_name_derived')+IF(le.sec_range_Score = 0,'','|'+IF(le.sec_range_Score < 0,'-','')+'sec_range')+IF(le.v_city_name_Score = 0,'','|'+IF(le.v_city_name_Score < 0,'-','')+'v_city_name')+IF(le.cnp_btype_Score = 0,'','|'+IF(le.cnp_btype_Score < 0,'-','')+'cnp_btype')+IF(le.company_name_type_derived_Score = 0,'','|'+IF(le.company_name_type_derived_Score < 0,'-','')+'company_name_type_derived')+IF(le.company_address_Score = 0,'','|'+IF(le.company_address_Score < 0,'-','')+'company_address');
    SELF.Summary              := IF(le.cnp_number_Score = 0,'','|'+IF(le.cnp_number_Score < 0,'-','')+'cnp_number')+IF(le.st_Score = 0,'','|'+IF(le.st_Score < 0,'-','')+'st')+IF(le.prim_range_derived_Score = 0,'','|'+IF(le.prim_range_derived_Score < 0,'-','')+'prim_range_derived')+IF(le.sbfe_id_Score = 0,'','|'+IF(le.sbfe_id_Score < 0,'-','')+'sbfe_id')+IF(le.company_charter_number_Score = 0,'','|'+IF(le.company_charter_number_Score < 0,'-','')+'company_charter_number')+IF(le.hist_enterprise_number_Score = 0,'','|'+IF(le.hist_enterprise_number_Score < 0,'-','')+'hist_enterprise_number')+IF(le.ebr_file_number_Score = 0,'','|'+IF(le.ebr_file_number_Score < 0,'-','')+'ebr_file_number')+IF(le.active_enterprise_number_Score = 0,'','|'+IF(le.active_enterprise_number_Score < 0,'-','')+'active_enterprise_number')+IF(le.hist_corp_key_Score = 0,'','|'+IF(le.hist_corp_key_Score < 0,'-','')+'hist_corp_key')+IF(le.hist_duns_number_Score = 0,'','|'+IF(le.hist_duns_number_Score < 0,'-','')+'hist_duns_number')+IF(le.active_duns_number_Score = 0,'','|'+IF(le.active_duns_number_Score < 0,'-','')+'active_duns_number')+IF(le.company_phone_Score = 0,'','|'+IF(le.company_phone_Score < 0,'-','')+'company_phone')+IF(le.company_fein_Score = 0,'','|'+IF(le.company_fein_Score < 0,'-','')+'company_fein')+IF(le.company_addr1_Score = 0,'','|'+IF(le.company_addr1_Score < 0,'-','')+'company_addr1')+IF(le.zip_Score = 0,'','|'+IF(le.zip_Score < 0,'-','')+'zip')+IF(le.company_csz_Score = 0,'','|'+IF(le.company_csz_Score < 0,'-','')+'company_csz')+IF(le.cnp_name_phonetic_Score = 0,'','|'+IF(le.cnp_name_phonetic_Score < 0,'-','')+'cnp_name_phonetic')+IF(le.cnp_name_Score = 0,'','|'+IF(le.cnp_name_Score < 0,'-','')+'cnp_name')+IF(le.prim_name_derived_Score = 0,'','|'+IF(le.prim_name_derived_Score < 0,'-','')+'prim_name_derived')+IF(le.sec_range_Score = 0,'','|'+IF(le.sec_range_Score < 0,'-','')+'sec_range')+IF(le.v_city_name_Score = 0,'','|'+IF(le.v_city_name_Score < 0,'-','')+'v_city_name')+IF(le.company_inc_state_Score = 0,'','|'+IF(le.company_inc_state_Score < 0,'-','')+'company_inc_state')+IF(le.cnp_btype_Score = 0,'','|'+IF(le.cnp_btype_Score < 0,'-','')+'cnp_btype')+IF(le.company_name_type_derived_Score = 0,'','|'+IF(le.company_name_type_derived_Score < 0,'-','')+'company_name_type_derived')+IF(le.company_address_Score = 0,'','|'+IF(le.company_address_Score < 0,'-','')+'company_address');

    SELF.SummaryForceFailures := IF(le.cnp_number_Score > -9999,'','|'+IF(le.cnp_number_Score = -9999,'-','')+'cnp_number')+IF(le.st_Score > -9999,'','|'+IF(le.st_Score = -9999,'-','')+'st')+IF(le.prim_range_derived_Score > -9999,'','|'+IF(le.prim_range_derived_Score = -9999,'-','')+'prim_range_derived')+IF(le.hist_duns_number_Score > -9999,'','|'+IF(le.hist_duns_number_Score = -9999,'-','')+'hist_duns_number')+IF(le.ebr_file_number_Score > -9999,'','|'+IF(le.ebr_file_number_Score = -9999,'-','')+'ebr_file_number')+IF(le.active_duns_number_Score > -9999,'','|'+IF(le.active_duns_number_Score = -9999,'-','')+'active_duns_number')+IF(le.hist_enterprise_number_Score > -9999,'','|'+IF(le.hist_enterprise_number_Score = -9999,'-','')+'hist_enterprise_number')+IF(le.hist_domestic_corp_key_Score > -9999,'','|'+IF(le.hist_domestic_corp_key_Score = -9999,'-','')+'hist_domestic_corp_key')+IF(le.foreign_corp_key_Score > -9999,'','|'+IF(le.foreign_corp_key_Score = -9999,'-','')+'foreign_corp_key')+IF(le.unk_corp_key_Score > -9999,'','|'+IF(le.unk_corp_key_Score = -9999,'-','')+'unk_corp_key')+IF(le.company_fein_Score > -9999,'','|'+IF(le.company_fein_Score = -9999,'-','')+'company_fein')+IF(le.company_phone_Score > -9999,'','|'+IF(le.company_phone_Score = -9999,'-','')+'company_phone')+IF(le.active_enterprise_number_Score > -9999,'','|'+IF(le.active_enterprise_number_Score = -9999,'-','')+'active_enterprise_number')+IF(le.active_domestic_corp_key_Score > -9999,'','|'+IF(le.active_domestic_corp_key_Score = -9999,'-','')+'active_domestic_corp_key')+IF(le.company_addr1_Score > -9999,'','|'+IF(le.company_addr1_Score = -9999,'-','')+'company_addr1')+IF(le.cnp_name_Score > -9999,'','|'+IF(le.cnp_name_Score = -9999,'-','')+'cnp_name')+IF(le.zip_Score > -9999,'','|'+IF(le.zip_Score = -9999,'-','')+'zip')+IF(le.company_csz_Score > -9999,'','|'+IF(le.company_csz_Score = -9999,'-','')+'company_csz')+IF(le.prim_name_derived_Score > -9999,'','|'+IF(le.prim_name_derived_Score = -9999,'-','')+'prim_name_derived')+IF(le.sec_range_Score > -9999,'','|'+IF(le.sec_range_Score = -9999,'-','')+'sec_range')+IF(le.v_city_name_Score > -9999,'','|'+IF(le.v_city_name_Score = -9999,'-','')+'v_city_name')+IF(le.cnp_btype_Score > -9999,'','|'+IF(le.cnp_btype_Score = -9999,'-','')+'cnp_btype')+IF(le.company_name_type_derived_Score > -9999,'','|'+IF(le.company_name_type_derived_Score = -9999,'-','')+'company_name_type_derived')+IF(le.company_address_Score > -9999,'','|'+IF(le.company_address_Score = -9999,'-','')+'company_address');

    self.realconf := (le.salt_partition_score + le.cnp_number_score + le.hist_enterprise_number_score + le.ebr_file_number_score + le.active_enterprise_number_score + le.hist_domestic_corp_key_score + le.foreign_corp_key_score + le.unk_corp_key_score + le.active_domestic_corp_key_score + le.hist_duns_number_score + le.active_duns_number_score + le.company_phone_score + le.company_fein_score + le.sbfe_id_score + le.cnp_name_score + le.cnp_btype_score + le.company_name_type_derived_score + IF(le.company_address_score>0,MAX(le.company_address_score,IF(le.company_addr1_score>0,MAX(le.company_addr1_score,le.prim_range_derived_score + le.prim_name_derived_score + le.sec_range_score),le.prim_range_derived_score + le.prim_name_derived_score + le.sec_range_score) + IF(le.company_csz_score>0,MAX(le.company_csz_score,le.v_city_name_score + le.st_score + le.zip_score),le.v_city_name_score + le.st_score + le.zip_score)),IF(le.company_addr1_score>0,MAX(le.company_addr1_score,le.prim_range_derived_score + le.prim_name_derived_score + le.sec_range_score),le.prim_range_derived_score + le.prim_name_derived_score + le.sec_range_score) + IF(le.company_csz_score>0,MAX(le.company_csz_score,le.v_city_name_score + le.st_score + le.zip_score),le.v_city_name_score + le.st_score + le.zip_score))) / 100;

  
    SELF.total_positive_score := 
    (IF(le.cnp_number_Score                 > 0 ,le.cnp_number_Score                ,0)
    +IF(le.st_Score                         > 0 ,le.st_Score                        ,0)
    +IF(le.prim_range_derived_Score         > 0 ,le.prim_range_derived_Score        ,0) 
    +IF(le.hist_duns_number_Score           > 0 ,le.hist_duns_number_Score          ,0)
    +IF(le.ebr_file_number_Score            > 0 ,le.ebr_file_number_Score           ,0)
    +IF(le.active_duns_number_Score         > 0 ,le.active_duns_number_Score        ,0)
    +IF(le.hist_enterprise_number_Score     > 0 ,le.hist_enterprise_number_Score    ,0)
    +IF(le.hist_domestic_corp_key_Score     > 0 ,le.hist_domestic_corp_key_Score    ,0)
    +IF(le.foreign_corp_key_Score           > 0 ,le.foreign_corp_key_Score          ,0)
    +IF(le.unk_corp_key_Score               > 0 ,le.unk_corp_key_Score              ,0)
    +IF(le.company_fein_Score               > 0 ,le.company_fein_Score              ,0)
    +IF(le.company_phone_Score              > 0 ,le.company_phone_Score             ,0)
    +IF(le.active_enterprise_number_Score   > 0 ,le.active_enterprise_number_Score  ,0)
    +IF(le.active_domestic_corp_key_Score   > 0 ,le.active_domestic_corp_key_Score  ,0)
    +IF(le.company_addr1_Score              > 0 ,le.company_addr1_Score             ,0)
    +IF(le.cnp_name_Score                   > 0 ,le.cnp_name_Score                  ,0)
    +IF(le.zip_Score                        > 0 ,le.zip_Score                       ,0)
    +IF(le.company_csz_Score                > 0 ,le.company_csz_Score               ,0)
    +IF(le.prim_name_derived_Score          > 0 ,le.prim_name_derived_Score         ,0)
    +IF(le.sec_range_Score                  > 0 ,le.sec_range_Score                 ,0)
    +IF(le.v_city_name_Score                > 0 ,le.v_city_name_Score               ,0)
    +IF(le.cnp_btype_Score                  > 0 ,le.cnp_btype_Score                 ,0)
    +IF(le.company_name_type_derived_Score  > 0 ,le.company_name_type_derived_Score ,0)
    +IF(le.company_address_Score            > 0 ,le.company_address_Score           ,0)   
    ) / 100;

    SELF.total_negative_score := 
    (IF(le.cnp_number_Score                 < 0 ,le.cnp_number_Score                ,0)
    +IF(le.st_Score                         < 0 ,le.st_Score                        ,0)
    +IF(le.prim_range_derived_Score         < 0 ,le.prim_range_derived_Score        ,0) 
    +IF(le.hist_duns_number_Score           < 0 ,le.hist_duns_number_Score          ,0)
    +IF(le.ebr_file_number_Score            < 0 ,le.ebr_file_number_Score           ,0)
    +IF(le.active_duns_number_Score         < 0 ,le.active_duns_number_Score        ,0)
    +IF(le.hist_enterprise_number_Score     < 0 ,le.hist_enterprise_number_Score    ,0)
    +IF(le.hist_domestic_corp_key_Score     < 0 ,le.hist_domestic_corp_key_Score    ,0)
    +IF(le.foreign_corp_key_Score           < 0 ,le.foreign_corp_key_Score          ,0)
    +IF(le.unk_corp_key_Score               < 0 ,le.unk_corp_key_Score              ,0)
    +IF(le.company_fein_Score               < 0 ,le.company_fein_Score              ,0)
    +IF(le.company_phone_Score              < 0 ,le.company_phone_Score             ,0)
    +IF(le.active_enterprise_number_Score   < 0 ,le.active_enterprise_number_Score  ,0)
    +IF(le.active_domestic_corp_key_Score   < 0 ,le.active_domestic_corp_key_Score  ,0)
    +IF(le.company_addr1_Score              < 0 ,le.company_addr1_Score             ,0)
    +IF(le.cnp_name_Score                   < 0 ,le.cnp_name_Score                  ,0)
    +IF(le.zip_Score                        < 0 ,le.zip_Score                       ,0)
    +IF(le.company_csz_Score                < 0 ,le.company_csz_Score               ,0)
    +IF(le.prim_name_derived_Score          < 0 ,le.prim_name_derived_Score         ,0)
    +IF(le.sec_range_Score                  < 0 ,le.sec_range_Score                 ,0)
    +IF(le.v_city_name_Score                < 0 ,le.v_city_name_Score               ,0)
    +IF(le.cnp_btype_Score                  < 0 ,le.cnp_btype_Score                 ,0)
    +IF(le.company_name_type_derived_Score  < 0 ,le.company_name_type_derived_Score ,0)
    +IF(le.company_address_Score            < 0 ,le.company_address_Score           ,0)   
    ) / 100;
  END;
  
  ds_add_Summary := PROJECT(ds_match_join,tosummary(LEFT))    : PERSIST('~persist::BIPV2_ProxID::_Annotate_Matches::ds_add_Summary'   );

  ds_result_prep := join(pProxidPairs  ,ds_add_Summary ,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2  ,transform({recordof(left) or recordof(right)},self := left,self := right)  ,hash);

  #IF(trim(%'DedupField'%) != '')
    ds_result := dedup(sort(distribute(ds_result_prep  ,hash(%DedupField%)) ,%DedupField% ,-realconf  ,proxid1  ,local) ,%DedupField%  ,local);
  #ELSE
    ds_result := ds_result_prep;
  #END


  // -- Count the summaries
  ds_summary_table := SORT(TABLE(ds_result,{Summary,Cnt := COUNT(GROUP)  ,Cnt_Above_Threshold := SUM(GROUP,if(realconf >= MatchThreshold and trim(SummaryForceFailures) = '',1,0)) ,Cnt_Below_Threshold := SUM(GROUP,if(~(realconf >= MatchThreshold and trim(SummaryForceFailures) = '') ,1,0)) 
,Cnt_Above_Threshold_with_force_failuer := SUM(GROUP,if(realconf >= MatchThreshold and trim(SummaryForceFailures) != '',1,0))
    ,Cnt_low    := SUM(GROUP,IF(realconf between (MatchThreshold - 5) and (MatchThreshold - 1) ,1,0))  
    ,Cnt_medium := SUM(GROUP,IF(realconf between (MatchThreshold - 10) and (MatchThreshold - 6) ,1,0))  
    ,Cnt_far    := SUM(GROUP,IF(realconf < 10                          ,1,0))  
  },Summary,FEW),-Cnt);

  ds_forcefailures_table := table(ds_result(trim(SummaryForceFailures) != '') ,{SummaryForceFailures  ,unsigned cnt := count(group)}  ,SummaryForceFailures ,few);

// -----------------------
  ds_overall_table := TABLE(ds_result,{Cnt := COUNT(GROUP)  
    ,Cnt_Above_Threshold                        := SUM(GROUP,if(  realconf >= MatchThreshold                                          ,1,0)) 
    ,Cnt_Above_Threshold_with_no_force_failure  := SUM(GROUP,if(  realconf >= MatchThreshold and  trim(SummaryForceFailures)  = ''    ,1,0))
    ,Cnt_Above_Threshold_with_force_failure     := SUM(GROUP,if(  realconf >= MatchThreshold and  trim(SummaryForceFailures) != ''    ,1,0))


    ,Cnt_Below_Threshold                    := SUM(GROUP,if(  realconf < MatchThreshold                                           ,1,0)) 
    // ,Cnt_Below_Threshold                    := SUM(GROUP,if(~(realconf >= MatchThreshold and  trim(SummaryForceFailures)  = '')   ,1,0)) 

    ,Cnt_force_failures                     := SUM(GROUP,if(  realconf < MatchThreshold and trim(SummaryForceFailures) != ''    ,1,0))
    ,Cnt_borderline                         := SUM(GROUP,IF(realconf between (MatchThreshold - 5 ) and (MatchThreshold - 1) ,1,0))  
    ,Cnt_medium                             := SUM(GROUP,IF(realconf between (MatchThreshold - 10) and (MatchThreshold - 6) ,1,0))  
    ,Cnt_low                                := SUM(GROUP,IF(realconf < 20                                                   ,1,0))  
  },true,FEW);


  ds_stats := dataset([
    {'count pProxidPairs'     ,count(pProxidPairs)}
   ,{'count ds_result_prep'   ,count(ds_result_prep   )}
   ,{'count ds_result'        ,count(ds_result   )}
   ,{'count ds_result above threshold'    ,count(ds_result(realconf >= MatchThreshold)   )}
   ,{'count ds_result below threshold'    ,count(ds_result(realconf <  MatchThreshold)   )}
   ,{'count ds_result below threshold but total positive score above threshold'    ,count(ds_result(realconf <  MatchThreshold,total_positive_score >= MatchThreshold)   )}
    
  ] ,{string stat ,unsigned statvalue});

  ds_Amex_Stats := dataset([

    {'EL no hits proxid IL cands'                   ,ut.fIntWithCommas(count(ds_result ))}
   ,{'score above threshold'                        ,ut.fIntWithCommas(ds_overall_table[1].Cnt_Above_Threshold)}
   ,{'--Above threshold with no force violations'   ,ut.fIntWithCommas(ds_overall_table[1].Cnt_Above_Threshold_with_no_force_failure)}
   ,{'--Above threshold even with force violations' ,ut.fIntWithCommas(ds_overall_table[1].Cnt_Above_Threshold_with_force_failure)}
   ,{'score below threshold'                        ,ut.fIntWithCommas(ds_overall_table[1].Cnt_Below_Threshold)}
   ,{'--force violations'                           ,ut.fIntWithCommas(ds_overall_table[1].Cnt_force_failures)}
   ,{'--borderline score(25-29 score)'              ,ut.fIntWithCommas(ds_overall_table[1].Cnt_borderline)}
   ,{'--medium     score(20-24 score)'              ,ut.fIntWithCommas(ds_overall_table[1].Cnt_medium    )}
   ,{'--low        score(< 20  score)'              ,ut.fIntWithCommas(ds_overall_table[1].Cnt_low       )}

  ]  ,{string stat, string statvalue});

  return when(ds_result ,parallel(
    output(ds_Amex_Stats ,named('ds_Amex_Stats')  ,EXTEND)
   ,output(ds_stats                       ,named('BIPV2_ProxID__Annotate_Matches_ds_stats'          ),all)
   ,output(ds_overall_table               ,named('BIPV2_ProxID__Annotate_Matches_ds_overall_table'  ),all)
   ,output(sort(ds_summary_table  ,-cnt)  ,named('BIPV2_ProxID__Annotate_Matches_ds_summary_table'  ),all)
   ,output(sort(ds_forcefailures_table  ,-cnt)  ,named('BIPV2_ProxID__Annotate_Matches_ds_forcefailures_table'),all)

   ,output(choosen(ds_result(realconf >= MatchThreshold)  ,100)  ,named('BIPV2_ProxID__Annotate_Matches_ds_result_above_threshold'),all)
   ,output(choosen(ds_result(realconf <  MatchThreshold)  ,100)  ,named('BIPV2_ProxID__Annotate_Matches_ds_result_below_threshold'),all)
   ,output(choosen(ds_result(realconf <  MatchThreshold,total_positive_score >= MatchThreshold)  ,100)  ,named('BIPV2_ProxID__Annotate_Matches_ds_result_below_threshold_but_total_positive_score_above_threshold'),all)
  
  ));
  
endmacro;