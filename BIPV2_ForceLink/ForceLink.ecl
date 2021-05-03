EXPORT ForceLink(

   pDataset               = 'bipv2.commonbase.ds_base'
  ,pProxidUnderlink_file  = 'BIPV2_Proxid.ManualUnderLinks.dataIn_file' //{proxid, integer underlinkid}
  ,pLgid3Underlink_file   = 'BIPV2_LGID3.ManualUnderLinks.dataIn_file'  //{lgid3 , integer underlinkid}
  ,pOutputDebug           = 'false'
  ,pQuickTest             = 'false'
) :=
functionmacro

  import bipv2,BIPV2_Proxid,BIPV2_LGID3;

  ds_base := table(pDataset ,{lgid3,proxid} ,lgid3,proxid ,merge) : persist('~persist::BIPV2_Build::ForceLink::ds_base');
  
  // -- look at proxid first
  // -- join proxid underlink file to base file on proxid, inner join, add underlinkid to base
  // -- then sort on underlinkid, proxid.
  // -- group on underlinkid and then reset the proxid to the lowest proxid
  ds_base_proxid_underlinks     := join(ds_base ,pProxidUnderlink_file  ,left.proxid = right.proxid ,transform({integer underlinkid,boolean didpatch := false,unsigned6 proxid,unsigned6 old_proxid,recordof(left) - proxid},self.old_proxid := left.proxid,self.underlinkid := right.underlinkid,self := left)  ,hash);
  ds_base_proxid_NOT_underlinks := join(ds_base ,pProxidUnderlink_file  ,left.proxid = right.proxid ,transform(left)  ,left only  ,hash);

  ds_proxid_dist    := distribute(ds_base_proxid_underlinks  ,underlinkid);
  ds_proxid_sort    := sort      (ds_proxid_dist             ,underlinkid,proxid,local);
  ds_proxid_group   := group     (ds_proxid_sort             ,underlinkid       ,local);
  ds_proxid_iterate := iterate(ds_proxid_group  ,transform(
    recordof(left)
    ,self.underlinkid := right.underlinkid
    ,self.proxid      := if(left.proxid = 0 ,right.proxid,left.proxid )
    ,self.old_proxid  := right.proxid
    ,self.didpatch    := if(left.proxid = 0 ,false       ,true        )
    ,self             := right
  ));

  ds_proxid_patch_concat := group(project(ds_proxid_iterate ,recordof(ds_base))) + ds_base_proxid_NOT_underlinks;
  
  // -- lgid3
  ds_base_lgid3_underlinks     := join(ds_proxid_patch_concat ,plgid3Underlink_file  ,left.lgid3 = right.lgid3 ,transform({integer underlinkid,boolean didpatch := false,unsigned6 lgid3,unsigned6 old_lgid3,recordof(left) - lgid3},self.old_lgid3 := left.lgid3,self.underlinkid := right.underlinkid,self := left)  ,hash);
  ds_base_lgid3_NOT_underlinks := join(ds_proxid_patch_concat ,plgid3Underlink_file  ,left.lgid3 = right.lgid3 ,transform(left)  ,left only  ,hash);

  ds_lgid3_dist  := distribute(ds_base_lgid3_underlinks  ,underlinkid);
  ds_lgid3_sort  := sort      (ds_lgid3_dist             ,underlinkid,lgid3,local);
  ds_lgid3_group := group     (ds_lgid3_sort             ,underlinkid       ,local);
  ds_lgid3_iterate := iterate(ds_lgid3_group  ,transform(
    recordof(left)
    ,self.underlinkid := right.underlinkid
    ,self.lgid3       := if(left.lgid3 = 0 ,right.lgid3,left.lgid3 )
    ,self.old_lgid3   := right.lgid3
    ,self.didpatch    := if(left.lgid3 = 0 ,false       ,true        )
    ,self             := right
  ));

  ds_lgid3_patch_concat := group(project(ds_lgid3_iterate ,recordof(ds_base))) + ds_base_lgid3_NOT_underlinks;

  ds_patch_proxid := join(pDataset        ,table(ds_proxid_iterate(proxid != old_proxid),{proxid,old_proxid} ,proxid,old_proxid)  ,left.proxid = right.old_proxid ,transform({unsigned6 old_proxid,unsigned6 proxid,recordof(left) - proxid},self.old_proxid := left.proxid,self.proxid := if(right.proxid != 0 ,right.proxid ,left.proxid),self := left)  ,left outer  ,lookup );
  ds_patch_lgid3  := join(ds_patch_proxid ,table(ds_lgid3_iterate (lgid3  != old_lgid3 ),{lgid3 ,old_lgid3 } ,lgid3 ,old_lgid3 )  ,left.lgid3  = right.old_lgid3  ,transform({unsigned6 old_lgid3 ,unsigned6 lgid3 ,recordof(left) - lgid3 },self.old_lgid3  := left.lgid3 ,self.lgid3  := if(right.lgid3  != 0 ,right.lgid3  ,left.lgid3 ),self := left)  ,left outer  ,lookup );

  ds_stats := dataset([
    {'pDataset'                       ,ut.fIntWithCommas( count(pDataset                          ))}
   ,{'ds_base'                        ,ut.fIntWithCommas( count(ds_base                           ))}
   ,{'pProxidUnderlink_file'          ,ut.fIntWithCommas( count(pProxidUnderlink_file             ))}
   ,{'ds_base_proxid_underlinks'      ,ut.fIntWithCommas( count(ds_base_proxid_underlinks         ))}
   ,{'ds_base_proxid_NOT_underlinks'  ,ut.fIntWithCommas( count(ds_base_proxid_NOT_underlinks     ))}
   ,{'ds_proxid_dist'                 ,ut.fIntWithCommas( count(ds_proxid_dist                    ))}
   ,{'ds_proxid_sort'                 ,ut.fIntWithCommas( count(ds_proxid_sort                    ))}
   ,{'ds_proxid_group'                ,ut.fIntWithCommas( count(ds_proxid_group                   ))}
   ,{'ds_proxid_iterate'              ,ut.fIntWithCommas( count(ds_proxid_iterate                 ))}
   ,{'ds_proxid_iterate patched'      ,ut.fIntWithCommas( count(ds_proxid_iterate(  didpatch = true and proxid != old_proxid )))}
   ,{'ds_proxid_iterate NOT patched'  ,ut.fIntWithCommas( count(ds_proxid_iterate(~(didpatch = true and proxid != old_proxid))))}
   ,{'ds_proxid_patch_concat'         ,ut.fIntWithCommas( count(ds_proxid_patch_concat            ))}

   ,{'pLgid3Underlink_file'           ,ut.fIntWithCommas( count(pLgid3Underlink_file              ))}
   ,{'ds_base_lgid3_underlinks'       ,ut.fIntWithCommas( count(ds_base_lgid3_underlinks          ))}
   ,{'ds_base_lgid3_NOT_underlinks'   ,ut.fIntWithCommas( count(ds_base_lgid3_NOT_underlinks      ))}
   ,{'ds_lgid3_dist'                  ,ut.fIntWithCommas( count(ds_lgid3_dist                     ))}
   ,{'ds_lgid3_sort'                  ,ut.fIntWithCommas( count(ds_lgid3_sort                     ))}
   ,{'ds_lgid3_group'                 ,ut.fIntWithCommas( count(ds_lgid3_group                    ))}
   ,{'ds_lgid3_iterate'               ,ut.fIntWithCommas( count(ds_lgid3_iterate                  ))}
   ,{'ds_lgid3_iterate patched'       ,ut.fIntWithCommas( count(ds_lgid3_iterate(  didpatch = true and lgid3 != old_lgid3 )))}
   ,{'ds_lgid3_iterate NOT patched'   ,ut.fIntWithCommas( count(ds_lgid3_iterate(~(didpatch = true and lgid3 != old_lgid3))))}
   // ,{'ds_lgid3_patch_concat'          ,ut.fIntWithCommas( count(ds_lgid3_patch_concat             ))}
  
   ,{'ds_patch_proxid'                ,ut.fIntWithCommas( count(ds_patch_proxid                       ))}
   ,{'ds_patch_proxid did patch'      ,ut.fIntWithCommas( count(ds_patch_proxid(old_proxid != proxid) ))}
   ,{'ds_patch_lgid3'                 ,ut.fIntWithCommas( count(ds_patch_lgid3                        ))}
   ,{'ds_patch_lgid3 did patch'       ,ut.fIntWithCommas( count(ds_patch_lgid3 (old_lgid3  != lgid3 ) ))}

  ]  ,{string stat_description  ,string stat_value});

  mac_id_table(pTableIn ,pID) := functionmacro
    #UNIQUENAME(old_ID)
    #SET(old_ID ,'old_' + trim(#TEXT(pID)) )
    return table(pTableIn ,{underlinkid ,didpatch,%old_ID%,pID} ,underlinkid ,didpatch,%old_ID%,pID ,merge);
  endmacro;
  
  output_debug := parallel(
     output(ds_stats                                                                                                                    ,named('ds_stats'                     ))
    ,output(topn    (             pDataset                                                              ,100  ,proxid               )   ,named('pDataset'                     ))
    ,output(topn    (             pProxidUnderlink_file                                                 ,100  ,underlinkid  ,proxid )   ,named('pProxidUnderlink_file'        ))
    ,output(topn    (mac_id_table(ds_base_proxid_underlinks                                     ,proxid),100  ,underlinkid  ,proxid )   ,named('ds_base_proxid_underlinks'    ))
    ,output(choosen (             ds_base_proxid_NOT_underlinks                                         ,100                        )   ,named('ds_base_proxid_NOT_underlinks'))
    ,output(topn    (mac_id_table(ds_proxid_dist                                                ,proxid),100  ,underlinkid  ,proxid )   ,named('ds_proxid_dist'               ))
    ,output(topn    (mac_id_table(ds_proxid_sort                                                ,proxid),100  ,underlinkid  ,proxid )   ,named('ds_proxid_sort'               ))
    ,output(topn    (mac_id_table(ds_proxid_group                                               ,proxid),100  ,underlinkid  ,proxid )   ,named('ds_proxid_group'              ))
    ,output(topn    (mac_id_table(ds_proxid_iterate                                             ,proxid),100  ,underlinkid  ,proxid )   ,named('ds_proxid_iterate'            ))
    ,output(topn    (mac_id_table(ds_proxid_iterate(  didpatch = true and proxid != old_proxid ),proxid),100  ,underlinkid  ,proxid )   ,named('ds_proxid_iterate_patched'    ))
    ,output(topn    (mac_id_table(ds_proxid_iterate(~(didpatch = true and proxid != old_proxid)),proxid),100  ,underlinkid  ,proxid )   ,named('ds_proxid_iterate_NOT_patched'))
    ,output(choosen (             ds_proxid_patch_concat                                                ,100                        )   ,named('ds_proxid_patch_concat'       ))
                    
    ,output(topn    (             pLgid3Underlink_file                                                ,100  ,underlinkid  ,lgid3  )   ,named('pLgid3Underlink_file'         ))
    ,output(topn    (mac_id_table(ds_base_lgid3_underlinks                                    ,lgid3) ,100  ,underlinkid  ,lgid3  )   ,named('ds_base_lgid3_underlinks'     ))
    ,output(choosen (             ds_base_lgid3_NOT_underlinks                                        ,100                        )   ,named('ds_base_lgid3_NOT_underlinks' ))
    ,output(topn    (mac_id_table(ds_lgid3_dist                                               ,lgid3) ,100  ,underlinkid  ,lgid3  )   ,named('ds_lgid3_dist'                ))
    ,output(topn    (mac_id_table(ds_lgid3_sort                                               ,lgid3) ,100  ,underlinkid  ,lgid3  )   ,named('ds_lgid3_sort'                ))
    ,output(topn    (mac_id_table(ds_lgid3_group                                              ,lgid3) ,100  ,underlinkid  ,lgid3  )   ,named('ds_lgid3_group'               ))
    ,output(topn    (mac_id_table(ds_lgid3_iterate                                            ,lgid3) ,100  ,underlinkid  ,lgid3  )   ,named('ds_lgid3_iterate'             ))
    ,output(topn    (mac_id_table(ds_lgid3_iterate(  didpatch = true and lgid3 != old_lgid3 ) ,lgid3) ,100  ,underlinkid  ,lgid3  )   ,named('ds_lgid3_iterate_patched'     ))
    ,output(topn    (mac_id_table(ds_lgid3_iterate(~(didpatch = true and lgid3 != old_lgid3)) ,lgid3) ,100  ,underlinkid  ,lgid3  )   ,named('ds_lgid3_iterate_NOT_patched' ))
    ,output(choosen (             ds_lgid3_patch_concat                                               ,100                        )   ,named('ds_lgid3_patch_concat'        ))
    ,output(choosen (             ds_patch_proxid                                                     ,100                        )   ,named('ds_patch_proxid'        ))
    ,output(choosen (             ds_patch_lgid3                                                      ,100                        )   ,named('ds_patch_lgid3'        ))
    ,output(choosen (             ds_patch_proxid (proxid != old_proxid)                              ,100                        )   ,named('ds_patch_proxid_patched'        ))
    ,output(choosen (             ds_patch_lgid3  (lgid3  != old_lgid3 )                              ,100                        )   ,named('ds_patch_lgid3_patched'        ))
  
  );

  ds_out := project(ds_patch_lgid3  ,recordof(pDataset));
  
  return when(ds_out ,if(pOutputDebug = true ,output_debug));


endmacro;