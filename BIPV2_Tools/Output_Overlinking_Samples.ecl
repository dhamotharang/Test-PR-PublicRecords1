EXPORT Output_Overlinking_Samples(

   pversion         = 'bipv2.KeySuffix'
  ,pID              = 'proxid'
  ,pDataset         = 'bipv2.CommonBase.ds_built'
  ,pBOW_field       = 'cnp_name'
  ,pBOW_Index       = 'BIPV2_proxid.specificities(BIPV2_proxid.In_DOT_Base).cnp_name_values_index'
  ,pBOW_Function    = 'SALT30.MatchBagOfWords'
  ,pBOW_Mode        = '46614'
  ,pBOW_Score_Mode  = '1'
  ,pName_Force      = 'BIPV2_ProxID.Config.cnp_name_Force'

) :=
functionmacro

  import BIPV2_Tools,BIPV2_proxid,SALT30,bipv2;
  overlinking_info := BIPV2_Tools.mac_Compile_Overlinking_Info(pID,pDataset,pBOW_field,pBOW_Index,pBOW_Function,pBOW_Mode,pBOW_Score_Mode,pName_Force);

  ds_sample := pDataset;
  ds_overlinking := dataset('~base::BIPV2_Tools::mac_Compile_Overlinking_Info::' + pversion  ,recordof(overlinking_info),flat);

  topn_cnt_salt_mismatches            := topn(ds_overlinking,100,-cnt_salt_mismatches                  );
  topn_cnt_substring_mismatch_lt3     := topn(ds_overlinking,100,-cnt_substring_mismatch_lt3           );
  topn_cnt_substring_mismatch_lt4     := topn(ds_overlinking,100,-cnt_substring_mismatch_lt4           );
  topn_cnt_substring_mismatch_lt5     := topn(ds_overlinking,100,-cnt_substring_mismatch_lt5           );
  topn_cnt_complete_mismatch_lt3_strGT10    := topn(ds_overlinking,100,-cnt_complete_mismatch_lt3_strGT10            );
  topn_cnt_complete_mismatch_lt3      := topn(ds_overlinking,100,-cnt_complete_mismatch_lt3            );
  topn_cnt_complete_mismatch_lt4      := topn(ds_overlinking,100,-cnt_complete_mismatch_lt4            );
  topn_cnt_complete_mismatch_lt5      := topn(ds_overlinking,100,-cnt_complete_mismatch_lt5            );
  topn_cnt_overall_matches            := topn(ds_overlinking,100,-cnt_overall_matches                  );
  topn_cnt_salt_mismatches_plus_all   := topn(ds_overlinking,100,-(cnt_salt_mismatches + count_all)    );
  topn_count_all                      := topn(ds_overlinking,100,-count_all                            );
  topn_count_dotids                   := topn(ds_overlinking,100,-count_dotids                         );
  #IF(#TEXT(pID) not in ['proxid','dotid'])
  topn_count_proxids                  := topn(ds_overlinking,100,-count_proxids                        );
  #END
  topn_count_keys                     := topn(ds_overlinking,100,-count_keys                           );
  topn_count_cnp_names                := topn(ds_overlinking,100,-count_cnp_name_raws                  );
  topn_count_a_dunss                  := topn(ds_overlinking,100,-count_a_dunss                        );
  topn_count_a_entnums                := topn(ds_overlinking,100,-count_a_entnums                      );
  topn_count_a_corpkeys               := topn(ds_overlinking,100,-count_a_corpkeys                     );
  topn_count_feins                    := topn(ds_overlinking,100,-count_feins                          );
  topn_count_sbfe_ids                 := topn(ds_overlinking,100,-count_sbfe_ids                       );
  topn_count_vl_ids                   := topn(ds_overlinking,100,-count_vl_ids                         );
  topn_count_source_record_ids        := topn(ds_overlinking,100,-count_source_record_ids              );
  topn_count_addresss                 := topn(ds_overlinking,100,-count_addresss                       );
  topn_count_company_phones           := topn(ds_overlinking,100,-count_company_phones                 );



  ds_all_topns :=   
    topn_cnt_salt_mismatches         
  + topn_cnt_substring_mismatch_lt3  
  + topn_cnt_substring_mismatch_lt4  
  + topn_cnt_substring_mismatch_lt5  
  + topn_cnt_complete_mismatch_lt3_strGT10   
  + topn_cnt_complete_mismatch_lt3   
  + topn_cnt_complete_mismatch_lt4   
  + topn_cnt_complete_mismatch_lt5   
  + topn_cnt_overall_matches         
  + topn_cnt_salt_mismatches_plus_all
  + topn_count_all                   
  #IF(#TEXT(pID) not in ['proxid','dotid'])
  + topn_count_proxids  
  #END
  + topn_count_dotids                   
  + topn_count_keys                  
  + topn_count_cnp_names             
  + topn_count_a_dunss               
  + topn_count_a_entnums             
  + topn_count_a_corpkeys            
  + topn_count_feins                 
  + topn_count_sbfe_ids              
  + topn_count_vl_ids                
  + topn_count_source_record_ids     
  + topn_count_addresss              
  + topn_count_company_phones        
  ;
  ds_all_sample_proxids := table(ds_all_topns     ,{proxid} ,proxid);

  ds_sample_filtered      := ds_sample(proxid in set(ds_all_sample_proxids,proxid)) : persist('~persist::lbentley::BH.221::ds_sample_filtered');
  ds_sample_filtered_agg  := BIPV2_Tools.AggregateProxidElements(ds_sample_filtered   );
  ds_sample_filtered_agg_counts := join(ds_sample_filtered_agg  ,dedup(sort(ds_all_topns,proxid),proxid) ,left.proxid = right.proxid ,transform({recordof(ds_sample_filtered_agg) or recordof(ds_all_topns) - sources},self := left,self := right),hash);

  topn_cnt_salt_mismatches_agg            := topn(ds_sample_filtered_agg_counts,100,-cnt_salt_mismatches                  );
  topn_cnt_substring_mismatch_lt3_agg     := topn(ds_sample_filtered_agg_counts,100,-cnt_substring_mismatch_lt3           );
  topn_cnt_substring_mismatch_lt4_agg     := topn(ds_sample_filtered_agg_counts,100,-cnt_substring_mismatch_lt4           );
  topn_cnt_substring_mismatch_lt5_agg     := topn(ds_sample_filtered_agg_counts,100,-cnt_substring_mismatch_lt5           );
  topn_cnt_complete_mismatch_lt3_strGT10_agg      := topn(ds_sample_filtered_agg_counts,100,-cnt_complete_mismatch_lt3_strGT10            );
  topn_cnt_complete_mismatch_lt3_agg      := topn(ds_sample_filtered_agg_counts,100,-cnt_complete_mismatch_lt3            );
  topn_cnt_complete_mismatch_lt4_agg      := topn(ds_sample_filtered_agg_counts,100,-cnt_complete_mismatch_lt4            );
  topn_cnt_complete_mismatch_lt5_agg      := topn(ds_sample_filtered_agg_counts,100,-cnt_complete_mismatch_lt5            );
  topn_cnt_overall_matches_agg            := topn(ds_sample_filtered_agg_counts,100,-cnt_overall_matches                  );
  topn_cnt_salt_mismatches_plus_all_agg   := topn(ds_sample_filtered_agg_counts,100,-(cnt_salt_mismatches + count_all)    );
  topn_count_all_agg                      := topn(ds_sample_filtered_agg_counts,100,-count_all                            );
  topn_count_dotids_agg                   := topn(ds_sample_filtered_agg_counts,100,-count_dotids                         );
  #IF(#TEXT(pID) not in ['proxid','dotid'])
  topn_count_proxids_agg                  := topn(ds_sample_filtered_agg_counts,100,-count_proxids                        );
  #END
  topn_count_keys_agg                     := topn(ds_sample_filtered_agg_counts,100,-count_keys                           );
  topn_count_cnp_names_agg                := topn(ds_sample_filtered_agg_counts,100,-count_cnp_name_raws                  );
  topn_count_a_dunss_agg                  := topn(ds_sample_filtered_agg_counts,100,-count_a_dunss                        );
  topn_count_a_entnums_agg                := topn(ds_sample_filtered_agg_counts,100,-count_a_entnums                      );
  topn_count_a_corpkeys_agg               := topn(ds_sample_filtered_agg_counts,100,-count_a_corpkeys                     );
  topn_count_feins_agg                    := topn(ds_sample_filtered_agg_counts,100,-count_feins                          );
  topn_count_sbfe_ids_agg                 := topn(ds_sample_filtered_agg_counts,100,-count_sbfe_ids                       );
  topn_count_vl_ids_agg                   := topn(ds_sample_filtered_agg_counts,100,-count_vl_ids                         );
  topn_count_source_record_ids_agg        := topn(ds_sample_filtered_agg_counts,100,-count_source_record_ids              );
  topn_count_addresss_agg                 := topn(ds_sample_filtered_agg_counts,100,-count_addresss                       );
  topn_count_company_phones_agg           := topn(ds_sample_filtered_agg_counts,100,-count_company_phones                 );

  /*
    potential overlinked clusters
    by fein
    by corpkey
    by duns
    by all godkeys
    by all godkeys plus cnp_names
    by mismatched company names
    by all unique entities
    more detailed overlinking info
    
  */
  return sequential(
     output(overlinking_info ,,'~base::BIPV2_Tools::mac_Compile_Overlinking_Info::' + pversion,__compressed__,overwrite)
    ,parallel(
       output('-------------------------------------------------------------'   ,named('___________________________'     ))
      ,output('Most Likely Overlinked Clusters(Aggregated) by Counts Of....'    ,named('___'))
      ,output(topn_cnt_salt_mismatches_plus_all_agg                             ,named('All_Fields_Plus_BOW_Mismatches'         ),all)
      ,output(topn_cnt_salt_mismatches_agg                                      ,named('SALT_BOW_Mismatches'                    ),all)
      ,output(topn_cnt_complete_mismatch_lt3_strGT10_agg                        ,named('SALT_BOW_Mismatches_more_Different'     ),all)
      ,output(topn_cnt_overall_matches_agg                                      ,named('Overall_Matches'                        ),all)
      ,output(topn_count_all_agg                                                ,named('All_Fields'                             ),all)
      ,output(topn_count_dotids_agg                                             ,named('Dotids'                                 ),all)
      #IF(#TEXT(pID) not in ['proxid','dotid'])                     
      ,output(topn_count_proxids_agg                                            ,named('Proxids'                                ),all)
      #END                      
      ,output(topn_count_keys_agg                                               ,named('All_God_Keys'                           ),all)
      ,output(topn_count_cnp_names_agg                                          ,named('Cnp_Names'                              ),all)
      ,output(topn_count_a_dunss_agg                                            ,named('Duns_Numbers'                           ),all)
      ,output(topn_count_a_entnums_agg                                          ,named('Enterprise_Numbers'                     ),all)
      ,output(topn_count_a_corpkeys_agg                                         ,named('Corpkeys'                               ),all)
      ,output(topn_count_feins_agg                                              ,named('Feins'                                  ),all)
      ,output(topn_count_sbfe_ids_agg                                           ,named('SBFE_IDs'                               ),all)
      ,output(topn_count_vl_ids_agg                                             ,named('VL_IDs'                                 ),all)
      ,output(topn_count_source_record_ids_agg                                  ,named('Source_Rids'                            ),all)
      ,output(topn_count_addresss_agg                                           ,named('Addresses'                              ),all)
      ,output(topn_count_company_phones_agg                                     ,named('Phones'                                 ),all)

      ,output('-------------------------------------------------------------'   ,named('__________________________'     ))
      ,output('Most Likely Overlinked Clusters by Counts Of....'                ,named('__'                             ))
      ,output(topn(ds_overlinking,500,-(cnt_salt_mismatches + count_all)    )   ,named('All_Fields_N_BOW_Mismatches_'   ),all)
      ,output(topn(ds_overlinking,500,-cnt_salt_mismatches                  )   ,named('SALT_BOW_Mismatches_'           ),all)
      ,output(topn(ds_overlinking,500,-cnt_complete_mismatch_lt3_strGT10    )   ,named('SALT_BOW_Mismatches_more_Different_'),all)
      ,output(topn(ds_overlinking,500,-cnt_overall_matches                  )   ,named('Overall_Matches_'               ),all)
      ,output(topn(ds_overlinking,500,-count_all                            )   ,named('All_Fields_'                    ),all)
      // ,output(topn(ds_overlinking,500,-cnt_dotids                           )   ,named('Dotids_'                        ),all)//not sure why getting error with this
      #IF(#TEXT(pID) not in ['proxid','dotid']) 
      ,output(topn(ds_overlinking,500,-cnt_proxids                          )   ,named('Proxids_'                       ),all)
      #END  
      ,output(topn(ds_overlinking,500,-count_keys                           )   ,named('All_God_Keys_'                  ),all)
      ,output(topn(ds_overlinking,500,-count_cnp_name_raws                  )   ,named('Cnp_Names_'                     ),all)
      ,output(topn(ds_overlinking,500,-count_a_dunss                        )   ,named('Duns_Numbers_'                  ),all)
      ,output(topn(ds_overlinking,500,-count_a_entnums                      )   ,named('Enterprise_Numbers_'            ),all)
      ,output(topn(ds_overlinking,500,-count_a_corpkeys                     )   ,named('Corpkeys_'                      ),all)
      ,output(topn(ds_overlinking,500,-count_feins                          )   ,named('Feins_'                         ),all)
      ,output(topn(ds_overlinking,500,-count_sbfe_ids                       )   ,named('SBFE_IDs_'                      ),all)
      ,output(topn(ds_overlinking,500,-count_vl_ids                         )   ,named('VL_IDs_'                        ),all)
      ,output(topn(ds_overlinking,500,-count_source_record_ids              )   ,named('Source_Rids_'                   ),all)
      ,output(topn(ds_overlinking,500,-count_addresss                       )   ,named('Addresses_'                     ),all)
      ,output(topn(ds_overlinking,500,-count_company_phones                 )   ,named('Phones_'                        ),all)

      ,output('-------------------------------------------------------------'   ,named('____________________________'))
    
      // ,overlinking_info.output_debug
  ));


endmacro;