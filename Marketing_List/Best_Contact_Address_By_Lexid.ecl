import dx_BestRecords,Header,doxie,InsuranceHeader_xlink,SALT37,Address;
// import dx_BestRecords,Header,doxie,InsuranceHeader_xlink,SALT37,Address;
// -- Append address for lexid records

EXPORT Best_Contact_Address_By_Lexid(
  
  p_Contact_Lexids                                        //dataset(doxie.layout_references)  just did(s)
 ,pWatchdog_Best_Key  = 'Marketing_List.Source_Files().watchdog_best'
 ,pOutputDebug        = 'false'
) :=
functionmacro
  
  // -- 1. join contact lexids to watchdog key to get marketing bitmaps for each lexid to use in marketing suppression
  ds_join2watchdog := join(p_Contact_Lexids ,pWatchdog_Best_Key ,left.did = right.did ,transform(right)   ,keyed);  
  
  // -- 2. filter for only marketing permissable sources
  ds_filtered_header_recs := ds_join2watchdog(permissions & dx_BestRecords.Constants.PERM_TYPE.marketing > 0);  //817,659,349 
  
  // -- 3. slim down to just DID again to prep for address hierarchy macro & dedup on DID
  ds_filtered_header_recs_dedup := project(table(ds_filtered_header_recs  ,{did} ,did ,merge) ,doxie.layout_references);
  
  // -- 4. use consumer best macro to rank addresses per lexid to pick best
  // Header.Mac_Append_Addr_Ind   // not in Boca Public Records yet, just on roxie.  once merged, should be able to use it.
  ds_append_address_hierarchy := Header.Append_addr_ind(ds_filtered_header_recs_dedup  ,bypassQH := true);
  
  // -- 5. join #2 to #4 on did and address to get only the ones that are marketing permissable.  idl has city_name instead of city.  also grab unit_desig while we're at it since that is missing from watchdog best.
  ds_filtered_header_recs_dedup_addr  := table(ds_filtered_header_recs  ,{did,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4} 
                                                                        , did,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4 ,merge);
  ds_marketing_permissable_addresses  := join(ds_append_address_hierarchy  ,ds_filtered_header_recs_dedup_addr 
    ,   left.did = right.did
    and left.prim_range = right.prim_range
    and left.prim_name  = right.prim_name
    and left.sec_range  = right.sec_range
    and left.city       = right.city_name
    and left.st         = right.st
    and left.zip        = right.zip
    ,transform({string unit_desig ,recordof(left)} ,self.unit_desig := right.unit_desig ,self := left ) ,keep(1),hash);
  
  // -- 6. sort results by did, lowest addr_ind, lowest_best_addr_ind(maybe = 'B'?), and dedup by did. 
  ds_best_contact_address_by_lexid_dist  := distribute  (ds_marketing_permissable_addresses    ,did                                                                               );
  ds_best_contact_address_by_lexid_sort  := sort        (ds_best_contact_address_by_lexid_dist ,did,(integer)addr_ind,if(best_addr_ind = 'B',1,2)  ,(integer)best_addr_rank ,local);
  ds_best_contact_address_by_lexid_dedup := dedup       (ds_best_contact_address_by_lexid_sort ,did                                                                         ,local);
  
  // -- 7. reformat for output, compose address line 1.
  ds_result := project(ds_best_contact_address_by_lexid_dedup ,transform(
     Marketing_List.Layouts.best_lexid_contact_address
    ,self.lexid           := left.did
    ,self.contact_address := Address.Addr1FromComponents(left.prim_range ,left.predir ,left.prim_name  ,left.addr_suffix  ,left.postdir  ,left.unit_desig ,left.sec_range)
    ,self.city            := left.city
    ,self.state           := left.st
    ,self.zip5            := left.zip
  
  ));

  output_debug := parallel(
    output('---------------------Marketing_List.Best_Contact_Address_By_Lexid---------------------'                ,named('Marketing_List_Best_Contact_Address_By_Lexid'                    ),all)
   ,output(choosen(p_Contact_Lexids                       ,100),named('Best_Contact_Address_By_Lexid_p_Contact_Lexids'                       ))
   ,output(choosen(ds_join2watchdog                       ,100),named('Best_Contact_Address_By_Lexid_ds_join2watchdog'                       ))
   ,output(choosen(ds_filtered_header_recs                ,100),named('Best_Contact_Address_By_Lexid_ds_filtered_header_recs'                ))
   ,output(choosen(ds_filtered_header_recs_dedup          ,100),named('Best_Contact_Address_By_Lexid_ds_filtered_header_recs_dedup'          ))
   ,output(choosen(ds_append_address_hierarchy            ,100),named('Best_Contact_Address_By_Lexid_ds_append_address_hierarchy'            ))
   ,output(choosen(ds_filtered_header_recs_dedup_addr     ,100),named('Best_Contact_Address_By_Lexid_ds_filtered_header_recs_dedup_addr'     ))
   ,output(choosen(ds_marketing_permissable_addresses     ,100),named('Best_Contact_Address_By_Lexid_ds_marketing_permissable_addresses'     ))
   ,output(choosen(ds_best_contact_address_by_lexid_dist  ,100),named('Best_Contact_Address_By_Lexid_ds_best_contact_address_by_lexid_dist'  ))
   ,output(choosen(ds_best_contact_address_by_lexid_sort  ,100),named('Best_Contact_Address_By_Lexid_ds_best_contact_address_by_lexid_sort'  ))
   ,output(choosen(ds_best_contact_address_by_lexid_dedup ,100),named('Best_Contact_Address_By_Lexid_ds_best_contact_address_by_lexid_dedup' ))
   ,output(choosen(ds_result                              ,100),named('Best_Contact_Address_By_Lexid_ds_result'                              ))
  );                                                      

  return when(ds_result ,if(pOutputDebug = true ,output_debug));

endmacro;