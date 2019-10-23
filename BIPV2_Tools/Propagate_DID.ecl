/*
  BIPV2_Tools.Propagate_DID -- propagate the DID field throughout another ID only if there is only 1 DID in that BIP ID
*/
import Strata,BIPV2_Build,bipv2;
EXPORT Propagate_DID(
   pDataset
  ,pBuild_Step    = '\'commonbase\''
  ,pBuild_SubStep = '\'output\'' 
  ,pStatType      = '\'propagate_DID\''
  ,pIsTesting     = 'false'                           // true = do not send to strata.  false = send to strata
  ,pBIP_ID        = 'empid'                           // bip id to propagate the DID throughout
  ,pDID_Field     = 'contact_did'                     // DID field
  ,pversion       = 'bipv2.KeySuffix'
  ,pEmail_List    = 'BIPV2_Build.mod_email.emailList'
  ,pUniqueOutput  = '\'\''
) :=
functionmacro
  import Strata,BIPV2_Build,bipv2;
  #uniquename(DID)
  #SET(DID  ,'orig_' + #TEXT(pDID_Field))
  
  ds_empid    := pDataset(pBIP_ID != 0);
  ds_no_empid := pDataset(pBIP_ID  = 0);
  count_Total_BIP_IDs := count(table(ds_empid ,{pBIP_ID   },pBIP_ID   ,merge));
  count_Total_DIDs    := count(table(ds_empid ,{pDID_Field},pDID_Field,merge));
  
  ds_table1               := table(ds_empid(pDID_Field != (TYPEOF(pDataset.pDID_Field))'' ),{pBIP_ID,pDID_Field},pBIP_ID,pDID_Field,merge);
  ds_table2               := table(ds_table1,{pBIP_ID,unsigned cnt := count(group)},pBIP_ID,merge);
  ds_BIP_IDs_with_one_DID := ds_table2(cnt = 1);
  ds_BIP_IDs_with_gt1_DID := ds_table2(cnt > 1);
  ds_BIP_IDs_with_no_DID  := table(table(ds_empid ,{pBIP_ID,pDID_Field},pBIP_ID,pDID_Field,merge),{pBIP_ID,unsigned cnt_blanks := sum(group,if(pDID_Field = (TYPEOF(pDataset.pDID_Field))'' ,1,0)),unsigned cnt_records := count(group)},pBIP_ID,merge)(cnt_records = cnt_blanks);
  
  ds_get_good_DIDs        := join(ds_table1  ,ds_BIP_IDs_with_one_DID  ,left.pBIP_ID = right.pBIP_ID ,transform(left),hash);
  
  ds_propagate := join(ds_empid ,ds_get_good_DIDs ,left.pBIP_ID = right.pBIP_ID ,transform({ds_empid.pBIP_ID,boolean changed_did,ds_empid.pDID_Field,typeof(pDataset.pDID_Field) %DID%,recordof(left) - pDID_Field - pBIP_ID}
    ,self.pDID_Field  := if(right.pBIP_ID  != 0 and left.pDID_Field = (TYPEOF(pDataset.pDID_Field))'' ,right.pDID_Field ,left.pDID_Field)
    ,self.changed_did := if(right.pBIP_ID  != 0 and left.pDID_Field = (TYPEOF(pDataset.pDID_Field))'' ,true             ,false          )
    ,self.%DID%       := left.pDID_Field
    ,self             := left
  ),hash,left outer);
  
  BIP_IDS_with_propagation  := table(ds_propagate(changed_did = true)  ,{pBIP_ID},pBIP_ID,merge);
  count_total_records_changed     := count(ds_propagate(changed_did = true));
  count_BIP_IDS_with_propagation  := count(BIP_IDS_with_propagation);
  
  ds_table3                               := table(ds_propagate(pDID_Field != (TYPEOF(pDataset.pDID_Field))'') ,{pBIP_ID,pDID_Field},pBIP_ID,pDID_Field,merge);
  ds_table4                               := table(ds_table3,{pBIP_ID,unsigned cnt := count(group)},pBIP_ID,merge);
  ds_BIP_IDs_with_one_DID_after_propagate := ds_table4(cnt = 1);
  
  count_diff_one_did_bip_ids0 := count(ds_BIP_IDs_with_one_DID) - count(ds_BIP_IDs_with_one_DID_after_propagate );
  count_diff_output_n_input0  := count(ds_empid               ) - count(ds_propagate                            );
  count_records_with_did_before := count(ds_empid    (pDID_Field != (TYPEOF(pDataset.pDID_Field))''));
  count_records_with_did_after  := count(ds_propagate(pDID_Field != (TYPEOF(pDataset.pDID_Field))''));
  pct_increase_did_population   := (count_records_with_did_after - count_records_with_did_before) / count_records_with_did_before * 100.0;
  
  sample_propagated_dids := join(ds_propagate ,choosen(BIP_IDS_with_propagation,100) ,left.pBIP_ID = right.pBIP_ID ,transform(left),hash,lookup);
  
  ds_concat := project(ds_propagate,recordof(pDataset)) + ds_no_empid;
  count_diff_output_n_raw_input0  := count(pDataset               ) - count(ds_concat                            );
  
  ds_strata := dataset([
     {#TEXT(pBIP_ID)                                                                                            //BIP_ID_Field
     ,#TEXT(pDID_Field)                                                                                         //DID_Field
     ,count(pDataset               )                                                                            //cnt_input                 //countgroup
     ,count(ds_concat)                                                                                          //cnt_output
     ,count(pDataset               ) - count(ds_concat)                                                         //cnt_input_minus_output0 
     ,count_Total_BIP_IDs                                                                                       //cnt_Total_BIP_IDs
     ,count_Total_DIDs                                                                                          //cnt_Total_DIDs
     ,count(ds_empid                )                                                                           //cnt_with_BIP_ID
     ,count(ds_no_empid             )                                                                           //cnt_without_BIP_ID
     ,count_records_with_did_before                                                                             //cnt_with_DID_before
     ,count_records_with_did_after                                                                              //cnt_with_DID_after  
     ,(count_records_with_did_after - count_records_with_did_before)                                            //cnt_DID_Lift  
     ,(integer)((real8)realformat(pct_increase_did_population,6,2) * 100)                                       //pct_DID_Lift  
     ,(integer)((real8)realformat(count(ds_BIP_IDs_with_one_DID ) / count_Total_BIP_IDs * 100.0  ,6,2) * 100.0) //pct_BIP_IDs_w_1_DID          
     ,(integer)((real8)realformat(count(ds_BIP_IDs_with_gt1_DID ) / count_Total_BIP_IDs * 100.0  ,6,2) * 100.0) //pct_BIP_IDs_w_gt1_DID   
     ,(integer)((real8)realformat(count(ds_BIP_IDs_with_no_DID  ) / count_Total_BIP_IDs * 100.0  ,6,2) * 100.0) //pct_BIP_IDs_w_no_DID   
     ,count(ds_BIP_IDs_with_one_DID )                                                                           //cnt_BIP_IDs_w_1_DID_before          
     ,count(ds_BIP_IDs_with_one_DID_after_propagate)                                                            //cnt_BIP_IDs_w_1_DID_after
     ,count(ds_BIP_IDs_with_one_DID ) - count(ds_BIP_IDs_with_one_DID_after_propagate)                          //cnt_single_DID_diff0                
     
     
     }  
  ],{string   BIP_ID_Field
    ,string   DID_Field
    ,integer  cnt_input                 //countgroup
    ,integer  cnt_output
    ,integer  cnt_input_minus_output0 
    ,integer  cnt_Total_BIP_IDs        
    ,integer  cnt_Total_DIDs        
    ,integer  cnt_with_BIP_ID
    ,integer  cnt_without_BIP_ID
    ,integer  cnt_with_DID_before
    ,integer  cnt_with_DID_after  
    ,integer  cnt_DID_Lift  
    ,integer  pct_DID_Lift  
    ,integer  pct_BIP_IDs_w_1_DID          
    ,integer  pct_BIP_IDs_w_gt1_DID        
    ,integer  pct_BIP_IDs_w_no_DID        
    ,integer  cnt_BIP_IDs_w_1_DID_before          
    ,integer  cnt_BIP_IDs_w_1_DID_after
    ,integer  cnt_single_DID_diff0                
  })
  : independent;
  
  //so for propagation, what do I care about?
  /*
    count total records
    count unique empids
    count unique dids
    count with empid
    count with did
    count with empid and did before
    count with empid and did after
    count affected empids
    pct affected empids
    count did lift
    pct did lift
  */    
  
  ID_Check_Strata	:= Strata.macf_CreateXMLStats (ds_strata ,'BIPV2',pBuild_Step  ,pversion	,pEmail_List	,pStatType ,pBuild_SubStep	,pIsTesting,pOverwrite := false);
  outputs := parallel(
     output(ds_strata                                                                                     ,named('ds_strata'                                      + pUniqueOutput))
    ,ID_Check_Strata
    ,output('-------------------BIPV2_Tools.Propagate_DID Important Stats Follow----------------------'   ,named('_'                                              + pUniqueOutput))
    ,output(count(pDataset                )                                                               ,named('count_Input'                                    + pUniqueOutput))
    ,output(count(ds_concat               )                                                               ,named('count_Output'                                   + pUniqueOutput))
    ,output(count_diff_output_n_input0                                                                    ,named('count_diff_output_n_input0'                     + pUniqueOutput))
    ,output(count_diff_output_n_raw_input0                                                                ,named('count_diff_output_n_raw_input0'                 + pUniqueOutput))
    ,output(count_diff_one_did_bip_ids0                                                                   ,named('count_diff_one_did_bip_ids0'                    + pUniqueOutput))
    ,output(count(ds_empid                )                                                               ,named('count_ds_with_empid'                            + pUniqueOutput))
    ,output(count(ds_no_empid             )                                                               ,named('count_ds_no_empid'                              + pUniqueOutput))
    ,output(count_records_with_did_before                                                                 ,named('count_records_with_did_before'                  + pUniqueOutput))
    ,output(count_records_with_did_after                                                                  ,named('count_records_with_did_after'                   + pUniqueOutput))
    ,output(realformat(pct_increase_did_population,6,2)                                                   ,named('pct_increase_did_population'                    + pUniqueOutput))
    ,output(topn(sample_propagated_dids     ,300,pBIP_ID,%DID%,pDID_Field)                                ,named('topn_sample_propagated_dids'                    + pUniqueOutput),all)
    
    ,output('-------------------BIPV2_Tools.Propagate_DID Extra Stats Follow----------------------'       ,named('__'                                             + pUniqueOutput))
    ,output(count(ds_table1                         )                                                     ,named('count_ds_table1'                                + pUniqueOutput))
    ,output(count(ds_table2                         )                                                     ,named('count_ds_table2'                                + pUniqueOutput))
    ,output(count(ds_BIP_IDs_with_one_DID           )                                                     ,named('count_ds_BIP_IDs_with_one_DID'                  + pUniqueOutput))
    ,output(count(ds_get_good_DIDs                  )                                                     ,named('count_ds_get_good_DIDs'                         + pUniqueOutput))
    ,output(count(ds_propagate                      )                                                     ,named('count_ds_propagate'                             + pUniqueOutput))
  
    ,output(count_total_records_changed                                                                   ,named('count_total_records_changed'                    + pUniqueOutput))
    ,output(count_BIP_IDS_with_propagation                                                                ,named('count_BIP_IDS_with_propagation'                 + pUniqueOutput))
    ,output(count(ds_table3                              )                                                ,named('count_ds_table3'                                + pUniqueOutput))
    ,output(count(ds_table4                              )                                                ,named('count_ds_table4'                                + pUniqueOutput))
    ,output(count(ds_BIP_IDs_with_one_DID_after_propagate)                                                ,named('count_ds_BIP_IDs_with_one_DID_after_propagate'  + pUniqueOutput))
  
    ,output(choosen(ds_table1                                   ,100)                                     ,named('choosen_ds_table1'                              + pUniqueOutput))
    ,output(choosen(ds_table2                                   ,100)                                     ,named('choosen_ds_table2'                              + pUniqueOutput))
    ,output(choosen(ds_BIP_IDs_with_one_DID                     ,100)                                     ,named('choosen_ds_BIP_IDs_with_one_DID'                + pUniqueOutput))
    ,output(choosen(ds_get_good_DIDs                            ,100)                                     ,named('choosen_ds_get_good_DIDs'                       + pUniqueOutput))
    ,output(choosen(ds_propagate                                ,100)                                     ,named('choosen_ds_propagate'                           + pUniqueOutput))
    ,output(choosen(ds_table3                                   ,100)                                     ,named('choosen_ds_table3'                              + pUniqueOutput))
    ,output(choosen(ds_table4                                   ,100)                                     ,named('choosen_ds_table4'                              + pUniqueOutput))
    ,output(choosen(ds_BIP_IDs_with_one_DID_after_propagate     ,100)                                     ,named('choosen_ds_BIP_IDs_with_one_DID_after_propagate'+ pUniqueOutput))
    ,output('-------------------BIPV2_Tools.Propagate_DID End Stats----------------------'                ,named('___'                                            + pUniqueOutput))
  );
  
  return when(ds_concat,outputs);
  
endmacro;
