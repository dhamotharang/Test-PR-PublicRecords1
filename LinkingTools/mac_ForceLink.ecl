EXPORT mac_ForceLink(

   pDataset                       //= 'bipv2.commonbase.ds_base'
  ,pID                            //= 'proxid'                                    // or 'lgid3'
  ,pUnderlink_file                //= 'BIPV2_ForceLink.files.Proxid_Underlink' //{proxid, integer underlinkid}.  also can be 'BIPV2_LGID3.ManualUnderLinks.dataIn_file'
  ,pExtraResearchFields = '\'\''  //= '\'cnp_name,prim_range,prim_name,st\''                                      //optional fields to use to unique on so you can see a better representation of clusters.
  ,pOutputDebug         = 'false'
) :=
functionmacro

  import ut;
  
  #UNIQUENAME(ID                    )
  #UNIQUENAME(OLD_ID                )
  #UNIQUENAME(UNDERLINKID           )
  #UNIQUENAME(DIDPATCH              )
  #UNIQUENAME(EXTRARESEARCHFIELDS   )

  #SET(ID                   ,                  trim(#TEXT(pID)))
  #SET(OLD_ID               ,'old_'          + trim(#TEXT(pID)))
  #SET(UNDERLINKID          ,'underlinkid_'  + trim(#TEXT(pID)))
  #SET(DIDPATCH             ,'didpatch_'     + trim(#TEXT(pID)))
  #SET(EXTRARESEARCHFIELDS  ,                  trim(pExtraResearchFields))

  // -- Slim down and dedup input file to just IDs
  ds_base := table(pDataset ,{%ID%} ,%ID% ,merge) : persist('~persist::BIPV2_ForceLink::mac_ForceLink::ds_base.' + %'ID'%  );
  
  // -- join underlink file to base file on ID, inner join, add underlinkid to base
  // -- then sort on underlinkid, ID
  // -- group on underlinkid and then reset the ID to the lowest ID
  ds_base_underlinks     := join(ds_base ,pUnderlink_file  ,left.%ID% = right.%ID% ,transform({integer %UNDERLINKID%,boolean %DIDPATCH% := false,unsigned6 %ID%,unsigned6 %OLD_ID%},self.%OLD_ID% := left.%ID%,self.%UNDERLINKID% := right.underlinkid,self := left)  ,hash);
  ds_base_NOT_underlinks := join(ds_base ,pUnderlink_file  ,left.%ID% = right.%ID% ,transform(left)  ,left only  ,hash);

  ds_dist    := distribute(ds_base_underlinks  ,%UNDERLINKID%             );
  ds_sort    := sort      (ds_dist             ,%UNDERLINKID% ,%ID% ,local);
  ds_group   := group     (ds_sort             ,%UNDERLINKID%       ,local);
  ds_iterate := iterate(ds_group  ,transform(
    recordof(left)
    ,self.%UNDERLINKID% := right.%UNDERLINKID%
    ,self.%ID%          := if(left.%ID% = 0 ,right.%ID% ,left.%ID% )
    ,self.%OLD_ID%      := right.%ID%
    ,self.%DIDPATCH%    := if(left.%ID% = 0 ,false      ,true      )
    ,self               := right
  ));

  // -- concatenate patched IDs with rest of slim input file
  // ds_patch_concat := group(project(ds_iterate ,recordof(ds_base))) + ds_base_NOT_underlinks;
  
  // -- patch full input file with new IDs
  ds_patch_input_file := join(pDataset  ,table(ds_iterate(%ID% != %OLD_ID%),{%ID%,%OLD_ID%,%UNDERLINKID%} ,%ID%,%OLD_ID%,%UNDERLINKID%)  
    ,left.%ID% = right.%OLD_ID% 
    ,transform({integer %UNDERLINKID%,unsigned6 %OLD_ID%,unsigned6 %ID%,recordof(left) - %ID%}
      ,self.%UNDERLINKID%   := right.%UNDERLINKID%
      ,self.%OLD_ID%        := left.%ID%
      ,self.%ID%            := if(right.%ID% != 0 ,right.%ID% ,left.%ID%)
      ,self                 := left
    )  
    ,left outer  ,lookup 
  );

  ds_patched_records := ds_patch_input_file (%ID% != %OLD_ID%);
  
  #IF(trim(%'EXTRARESEARCHFIELDS'%) = '')
  ds_get_complete_patched_picture := join(ds_patch_input_file ,table(ds_patched_records ,{%ID%} ,%ID% ,merge)  ,left.%ID% = right.%ID%  ,transform(left)  ,hash);
  #ELSE
  ds_get_complete_patched_picture1 := join(ds_patch_input_file ,table(ds_patched_records ,{%ID%} ,%ID% ,merge)  ,left.%ID% = right.%ID%  ,transform(left)  ,hash);
  ds_get_complete_patched_picture2 := table(ds_get_complete_patched_picture1  ,{%UNDERLINKID%,%ID%,%OLD_ID%,%EXTRARESEARCHFIELDS%} ,%UNDERLINKID%,%ID%,%OLD_ID%,%EXTRARESEARCHFIELDS% ,merge);
  ds_get_complete_patched_picture  := join(ds_get_complete_patched_picture2 ,ds_get_complete_patched_picture2(%UNDERLINKID% != 0)  ,left.%ID% = right.%ID%  ,transform(recordof(left)
    ,self.%UNDERLINKID% := right.%UNDERLINKID%
    ,self               := left
  )  ,keep(1),hash);
  #END
  
  // -- Output Stats
  ds_stats := dataset([
    {'ID'                             ,%'ID'%                                                                                             }
   ,{'pDataset'                       ,ut.fIntWithCommas( count(pDataset                                                                ))}
   ,{'ds_base'                        ,ut.fIntWithCommas( count(ds_base                                                                 ))}
   ,{'pUnderlink_file'                ,ut.fIntWithCommas( count(pUnderlink_file                                                         ))}
   ,{'ds_base_underlinks'             ,ut.fIntWithCommas( count(ds_base_underlinks                                                      ))}
   ,{'ds_base_NOT_underlinks'         ,ut.fIntWithCommas( count(ds_base_NOT_underlinks                                                  ))}
   ,{'ds_dist'                        ,ut.fIntWithCommas( count(ds_dist                                                                 ))}
   ,{'ds_sort'                        ,ut.fIntWithCommas( count(ds_sort                                                                 ))}
   ,{'ds_group'                       ,ut.fIntWithCommas( count(ds_group                                                                ))}
   ,{'ds_iterate'                     ,ut.fIntWithCommas( count(ds_iterate                                                              ))}
   ,{'ds_iterate patched'             ,ut.fIntWithCommas( count(ds_iterate              (  %DIDPATCH% = true and %ID%     != %OLD_ID% ) ))}
   ,{'ds_iterate NOT patched'         ,ut.fIntWithCommas( count(ds_iterate              (~(%DIDPATCH% = true and %ID%     != %OLD_ID%)) ))}
   // ,{'ds_patch_concat'                ,ut.fIntWithCommas( count(ds_patch_concat                                                         ))}
   ,{'ds_patch_input_file'            ,ut.fIntWithCommas( count(ds_patch_input_file                                                     ))}
   ,{'ds_patch_input_file did patch'  ,ut.fIntWithCommas( count(ds_patch_input_file     (                        %OLD_ID% != %ID%     ) ))}

  ]  ,{string stat_description  ,string stat_value});

  mac_id_table(pTableIn) := functionmacro
    return table(pTableIn ,{%UNDERLINKID% ,%DIDPATCH%,%OLD_ID%,%ID%} ,%UNDERLINKID% ,%DIDPATCH%,%OLD_ID%,%ID% ,merge);
  endmacro;
  
  // -- Output Debug Outputs
  output_debug := parallel(
     output('--------------------- LinkingTools.mac_ForceLink ' + %'ID'% + ' Start Outputs----------------------------------'         ,named('____________LinkingTools_mac_ForceLink_'                      + %'ID'% + '_Start_Outputs____________')) 
    ,output(ds_stats                                                                                                                  ,named('LinkingTools_mac_ForceLink_ds_stats_'                         + %'ID'%))
    ,output(topn    (             ds_get_complete_patched_picture                          ,300  , -%UNDERLINKID% ,%ID% ,%OLD_ID% )   ,named('LinkingTools_mac_ForceLink_ds_patched_'                       + %'ID'%))
    ,output('--------------------- LinkingTools.mac_ForceLink ' + %'ID'% + ' More Outputs----------------------------------'          ,named('____________LinkingTools_mac_ForceLink_'                      + %'ID'% + '_More_Outputs____________' )) 
    ,output(topn    (             pDataset                                                 ,100  ,  %ID%                          )   ,named('LinkingTools_mac_ForceLink_pDataset_'                         + %'ID'%))
    ,output(topn    (             pUnderlink_file                                          ,100  ,  underlinkid   ,%ID%           )   ,named('LinkingTools_mac_ForceLink_pUnderlink_file_'                  + %'ID'%))
    ,output(topn    (mac_id_table(ds_base_underlinks                                      ),100  ,  %UNDERLINKID% ,%ID%           )   ,named('LinkingTools_mac_ForceLink_ds_base_underlinks_'               + %'ID'%))
    ,output(choosen (             ds_base_NOT_underlinks                                   ,100                                   )   ,named('LinkingTools_mac_ForceLink_ds_base_NOT_underlinks_'           + %'ID'%))
    ,output(topn    (mac_id_table(ds_dist                                                 ),100  ,  %UNDERLINKID% ,%ID%           )   ,named('LinkingTools_mac_ForceLink_ds_dist_'                          + %'ID'%))
    ,output(topn    (mac_id_table(ds_sort                                                 ),100  ,  %UNDERLINKID% ,%ID%           )   ,named('LinkingTools_mac_ForceLink_ds_sort_'                          + %'ID'%))
    ,output(topn    (mac_id_table(group(ds_group)                                         ),100  ,  %UNDERLINKID% ,%ID%           )   ,named('LinkingTools_mac_ForceLink_ds_group_'                         + %'ID'%))
    ,output(topn    (mac_id_table(ds_iterate                                              ),100  ,  %UNDERLINKID% ,%ID%           )   ,named('LinkingTools_mac_ForceLink_ds_iterate_'                       + %'ID'%))
    ,output(topn    (mac_id_table(ds_iterate(  %DIDPATCH% = true and %ID% != %OLD_ID% )   ),100  ,  %UNDERLINKID% ,%ID%           )   ,named('LinkingTools_mac_ForceLink_ds_iterate_patched_'               + %'ID'%))
    ,output(topn    (mac_id_table(ds_iterate(~(%DIDPATCH% = true and %ID% != %OLD_ID%))   ),100  ,  %UNDERLINKID% ,%ID%           )   ,named('LinkingTools_mac_ForceLink_ds_iterate_NOT_patched_'           + %'ID'%))
    // ,output(choosen (             ds_patch_concat                                          ,100                                )   ,named('LinkingTools_mac_ForceLink_ds_patch_concat_'                  + %'ID'%))
                                    
    ,output(choosen (             ds_patch_input_file                                      ,100                                   )   ,named('LinkingTools_mac_ForceLink_ds_patch_input_file_'              + %'ID'%))
    ,output(choosen (             ds_patch_input_file (%ID% != %OLD_ID%)                   ,100                                   )   ,named('LinkingTools_mac_ForceLink_ds_patch_input_file_patched_'      + %'ID'%))
    ,output('--------------------- LinkingTools.mac_ForceLink ' + %'ID'% + ' End Outputs----------------------------------'           ,named('____________LinkingTools_mac_ForceLink_'                      + %'ID'% + '_End_Outputs____________')) 
  
  );

  ds_out := project(ds_patch_input_file  ,recordof(pDataset));
  
  return when(if(exists(pUnderlink_file)  ,ds_out ,pDataset) ,if(pOutputDebug = true and exists(pUnderlink_file) ,output_debug));


endmacro;