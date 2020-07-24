import bipv2,tools;

/* 
  mac_Calculate_Gold() BH-780 -- revisit gold calculation

    -- Set gold field, seleid is default

idea for new gold calc:

        isActive
AND isNotJustPOBox

AND contains 2 or more trusted sources

*/
EXPORT mac_Calculate_Gold(

   pBase_File               = 'bipv2.CommonBase.ds_clean'                   //assuming this dataset is ds_clean or cleaned
  ,pBIP_ID                  = 'seleid'
  ,pGold_Fieldname          = 'sele_gold'
  ,pActive_Fieldname        = 'seleid_status_private'
  ,pActive_Fieldname_score  = 'seleid_status_private_score'
  ,pActiveScoreMinimum      = '3'                                                                 // high confidence
  // ,pSet_Trusted_Sources     = 'BIPV2_Statuses._Config.set_High_Conf'   // sources required to be in cluster.  TRY HIGH CONF
  ,pSet_Trusted_Sources     = 'BIPV2_Statuses._Config.set_High_Conf + bipv2.mod_sources.set_trusted'   // sources required to be in cluster.  TRY HIGH CONF
  ,pBIP_ID_Test_Value       = '0'
  ,pOutputNameModifier      = '' 
  ,pShow_Work               = 'false'
) :=
FUNCTIONMACRO

  import tools,ut;
  
  ds_base := pBase_File;
  
  // -- 1. Only active clusters with score of 3
  ds_active_clusters := ds_base(trim(pActive_Fieldname) = ''  ,pActive_Fieldname_score >= pActiveScoreMinimum);
  
  // -- 2. aggregate prim name and source fields per seleid for active clusters with score of 3
  ds_slim     := table(ds_active_clusters  ,{pBIP_ID ,prim_name,source} ,pBIP_ID  ,prim_name ,source,merge);
  ds_slim_agg := tools.mac_AggregateFieldsPerID( ds_slim, pBIP_ID,,FALSE);

  // -- 3. define condition so that there are not just PO Box addresses in cluster
  is_Just_POBox             := exists(ds_slim_agg.prim_names(prim_name[1..6] = 'PO BOX')) and count(ds_slim_agg.prim_names) = count(ds_slim_agg.prim_names(prim_name[1..6] = 'PO BOX'));
  is_Not_Just_POBox         := ~is_Just_POBox;

  // -- 4. define condition so seleid contains two or more trusted sources
  // Contains_Trusted_Sources  := (exists(ds_slim_agg.sources(source in MDR.sourceTools.set_CorpV2)) or count(ds_slim_agg.sources(source in pSet_Trusted_Sources)) > 1);
  Contains_Trusted_Sources  := (count(ds_slim_agg.sources(source in pSet_Trusted_Sources)) > 1);

  // -- 5. Apply filter conditions to aggregated dataset.
  ds_slim_gold              := ds_slim_agg(Contains_Trusted_Sources ,is_Not_Just_POBox);
  
  // -- 6. take seleids that satisfied condition, they are gold.
  ds_slim_gold_justid       := table(ds_slim_gold,{pBIP_ID});
  
  // -- 7. patch gold info onto input file
  ds_patch_gold := join(pBase_File  ,ds_slim_gold_justid  ,left.pBIP_ID = right.pBIP_ID ,transform(recordof(left)
    ,self.pGold_Fieldname := if(right.pBIP_ID != 0  ,'G'  ,'')
    ,self                 := left
  )  ,left outer,hash);


  // -- 8. results dataset
  ds_result := ds_patch_gold;
  
  // -- Gold Calculation Stats
  count_old_golds := count(table(ds_base(pGold_Fieldname = 'G'  ),{pBIP_ID}  ,pBIP_ID ,merge));
  count_new_golds := count(ds_slim_gold_justid            );
  
  count_ds_base             := count(ds_base                       );
  count_ds_active_clusters  := count(ds_active_clusters            );
  count_ds_slim             := count(ds_slim                       );
  count_ds_slim_agg         := count(ds_slim_agg                   );
  count_ds_slim_gold        := count(ds_slim_gold                  );
  count_ds_slim_gold_justid := count(ds_slim_gold_justid           );
  count_ds_patch_gold       := count(ds_patch_gold                 );

  ds_stats := dataset([
    {'Count Input'                ,ut.fIntWithCommas(count(ds_base            ))  ,ut.fIntWithCommas(count(table(ds_base            ,{pBIP_ID}  ,pBIP_ID ,merge))) ,ut.fIntWithCommas(count(table(ds_base           (trim(pActive_Fieldname) = ''),{pBIP_ID}  ,pBIP_ID ,merge)))  ,ut.fIntWithCommas(count(table(ds_base            (pGold_Fieldname = 'G'  ) ,{pBIP_ID}  ,pBIP_ID ,merge)))  }
   ,{'count_ds_active_clusters '  ,ut.fIntWithCommas(count(ds_active_clusters ))  ,ut.fIntWithCommas(count(table(ds_active_clusters ,{pBIP_ID}  ,pBIP_ID ,merge))) ,ut.fIntWithCommas(count(table(ds_active_clusters(trim(pActive_Fieldname) = ''),{pBIP_ID}  ,pBIP_ID ,merge)))  ,ut.fIntWithCommas(count(table(ds_active_clusters (pGold_Fieldname = 'G'  ) ,{pBIP_ID}  ,pBIP_ID ,merge)))  }
   ,{'count_ds_slim            '  ,ut.fIntWithCommas(count(ds_slim            ))  ,ut.fIntWithCommas(count(table(ds_slim            ,{pBIP_ID}  ,pBIP_ID ,merge))) ,ut.fIntWithCommas(count(table(ds_slim                                         ,{pBIP_ID}  ,pBIP_ID ,merge)))  ,''                                                                                                         }   
   ,{'count_ds_slim_agg        '  ,ut.fIntWithCommas(count(ds_slim_agg        ))  ,ut.fIntWithCommas(count(table(ds_slim_agg        ,{pBIP_ID}  ,pBIP_ID ,merge))) ,ut.fIntWithCommas(count(table(ds_slim_agg                                     ,{pBIP_ID}  ,pBIP_ID ,merge)))  ,''                                                                                                         }

   ,{'count_ds_slim_gold       '  ,ut.fIntWithCommas(count(ds_slim_gold       ))  ,ut.fIntWithCommas(count(table(ds_slim_gold       ,{pBIP_ID}  ,pBIP_ID ,merge))) ,ut.fIntWithCommas(count(table(ds_slim_gold                                    ,{pBIP_ID}  ,pBIP_ID ,merge)))  ,ut.fIntWithCommas(count(table(ds_slim_gold                                 ,{pBIP_ID}  ,pBIP_ID ,merge)))  }
   ,{'count_ds_slim_gold_justid'  ,ut.fIntWithCommas(count(ds_slim_gold_justid))  ,ut.fIntWithCommas(count(table(ds_slim_gold_justid,{pBIP_ID}  ,pBIP_ID ,merge))) ,ut.fIntWithCommas(count(table(ds_slim_gold_justid                             ,{pBIP_ID}  ,pBIP_ID ,merge)))  ,ut.fIntWithCommas(count(table(ds_slim_gold_justid                          ,{pBIP_ID}  ,pBIP_ID ,merge)))  }
   
   ,{'count_ds_patch_gold      '  ,ut.fIntWithCommas(count(ds_patch_gold      ))  ,ut.fIntWithCommas(count(table(ds_patch_gold      ,{pBIP_ID}  ,pBIP_ID ,merge))) ,ut.fIntWithCommas(count(table(ds_patch_gold(trim(pActive_Fieldname) = '')     ,{pBIP_ID}  ,pBIP_ID ,merge)))  ,ut.fIntWithCommas(count(table(ds_patch_gold      (pGold_Fieldname = 'G'  ) ,{pBIP_ID}  ,pBIP_ID ,merge)))  }
  
  ]  ,{string stat,string count_records ,string count_clusters  ,string count_actives ,string count_golds});
  
#IF(pShow_Work = true)
  // -- return result
  return when(ds_result
    ,parallel(
      output(ds_stats                                                                                 ,named('BIPV2_PostProcess_mac_Calculate_Gold_ds_stats_'            + #TEXT(pBIP_ID)))
    ,if(pBIP_ID_Test_Value != 0
    ,parallel(
       output(choosen(ds_base             (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_PostProcess_mac_Calculate_Gold_ds_base_'             + #TEXT(pBIP_ID)))
      ,output(choosen(ds_active_clusters  (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_PostProcess_mac_Calculate_Gold_ds_active_clusters_'  + #TEXT(pBIP_ID)))
      ,output(choosen(ds_slim             (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_PostProcess_mac_Calculate_Gold_ds_slim_'             + #TEXT(pBIP_ID)))
      ,output(choosen(ds_slim_agg         (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_PostProcess_mac_Calculate_Gold_ds_slim_agg_'         + #TEXT(pBIP_ID)))
      ,output(choosen(ds_slim_gold        (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_PostProcess_mac_Calculate_Gold_ds_slim_gold_'        + #TEXT(pBIP_ID)))
      ,output(choosen(ds_patch_gold       (pBIP_ID_Test_Value = 0 or pBIP_ID = pBIP_ID_Test_Value),100),named('BIPV2_PostProcess_mac_Calculate_Gold_ds_patch_gold_'       + #TEXT(pBIP_ID)))
    ))                                                                                                                                                                                   
  ));
#ELSE
  return ds_result;
#END

ENDMACRO;