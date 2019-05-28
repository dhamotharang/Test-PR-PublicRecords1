/*
  BIPV2_Tools.SetDuns() 
    Refreshes the D&B fields; active_duns_number, hist_duns_number, deleted_key(duns_number), company_fein, deleted_fein.
    Explodes proxid and lgid3 clusters that contain a duns_number,cnp_name tuple that is deleted + that same duns_number
      with a different cnp_name that is not deleted.  After explosion of proxid to dotid for the offending clusters, 
      the old cluster will be grouped by dotid and cnp_name, setting the lowest dotid per cnp_name as the proxid.
      This is to reduce the increase in proxids by getting the low hanging fruit out of the way.  Doing this reduces the 
      increase in proxids from ~15% to 1.7%, for the first time this is run.  Subsequent build to build increases should
      be more like 0.1-0.2%.
    Allows duns_numbers and feins to come back to life if we get a replacement record from D&B for that duns.
  possible future improvements:
    can do more iterates for more collapses, although that seems to have dimishing returns.  BIPV2_Tools.mac_reform with loop could help.
    make it more generic to handle corp corrections.  in addition to deleted_key, would need to use the source field.
*/
import BIPV2_Build,bipv2,dnb_dmi,mdr,bipv2_files,ut,_control;
export SetDuns(
     dataset(BIPV2.CommonBase.Layout)                     ds_in
    ,boolean                                              pDoStrata       = true
    ,dataset(recordof(dnb_dmi.files().base.companies.qa)) pDuns_file      = dnb_dmi.files().base.companies.qa
    ,string                                               pPersistUnique  = ''
    ,string                                               pversion        = bipv2.KeySuffix
    ,boolean                                              pIsTesting      = false
    ,boolean                                              pOverwrite      = false
    ,string                                               pEmailList      = BIPV2_Build.mod_email.emailList
    ,unsigned6                                            pLgid3_example  = 0           
    ,boolean                                              pDebug_Outputs  = true
  ) := 
function
    l_dot := BIPV2.CommonBase.Layout;
  
  // -- Refresh Duns number fields first
  ds_sample         := ds_in;
  ds_refreshed_duns := BIPV2_Tools.refresh_duns(ds_sample,pDuns_file)  : persist('~persist::BIPV2_Tools::SetDuns::ds_refreshed_duns');
  
  // -- keep only non-zero proxid and lgid3 clusters for possible explosion.  zero proxid and lgid3s don't go through this logic
  ds_refreshed_duns_good_proxid := ds_refreshed_duns (proxid != 0)  : persist('~persist::BIPV2_Tools::SetDuns::ds_refreshed_duns_good_proxid');
  ds_refreshed_duns_zero_proxid := ds_refreshed_duns (proxid  = 0)  : persist('~persist::BIPV2_Tools::SetDuns::ds_refreshed_duns_zero_proxid');
  ds_refreshed_duns_zero_lgid3  := ds_refreshed_duns (lgid3   = 0);
  
  // -- append cnp_name BOW field.  this filters down the number of correction candidates for proxid and lgid3 to ones that will not come back together in a BOW match
  ds_append_bow_proxid := BIPV2_Tools.mac_Append_BOW_Info(proxid,ds_refreshed_duns_good_proxid) : persist('~persist::BIPV2_Tools::SetDuns::ds_append_bow_proxid');
  ds_append_bow_lgid3  := BIPV2_Tools.mac_Append_BOW_Info(lgid3 ,ds_refreshed_duns_good_proxid) : persist('~persist::BIPV2_Tools::SetDuns::ds_append_bow_lgid3' );
  
  output_bow_samples := parallel(
     output(choosen(ds_append_bow_proxid                                                         ,100)  ,named('ds_append_bow_proxid'                             ))
    ,output(choosen(ds_append_bow_proxid(isoverall_match      = false                           ),100)  ,named('ds_append_bow_proxid_overall_match_false'         ))
    ,output(choosen(ds_append_bow_proxid(isoverall_match      = true                            ),100)  ,named('ds_append_bow_proxid_overall_match'               ))
    ,output(choosen(ds_append_bow_proxid(is_good_bow_match    = true                            ),100)  ,named('ds_append_bow_proxid_BOW_match'                   ))
    ,output(choosen(ds_append_bow_proxid(is_good_hyphen_match = true                            ),100)  ,named('ds_append_bow_proxid_hyphen_match'                ))
    ,output(choosen(ds_append_bow_proxid(is_good_hyphen_match = true ,is_good_bow_match = false ),100)  ,named('ds_append_bow_proxid_hyphen_match_true_bow_false' ))
    ,output(choosen(ds_append_bow_proxid(is_good_hyphen_match = false,is_good_bow_match = true  ),100)  ,named('ds_append_bow_proxid_hyphen_match_false_bow_true' ))
  );
  ds_append_bow_proxid_filt := ds_append_bow_proxid(isoverall_match = false) ;
  ds_append_bow_lgid3_filt  := ds_append_bow_lgid3 (isoverall_match = false) ;


  // -- Get god keys for cnp_name from other sources for lgid3 and proxid
  ds_slim_prep   := table(ds_refreshed_duns_good_proxid,{dotid,proxid,lgid3,cnp_name,duns_number,deleted_key,prev_deleted_duns,company_fein,active_domestic_corp_key,active_enterprise_number,string sbfe_id := if(mdr.sourceTools.SourceIsBusiness_Credit(source) ,vl_id ,'')}
                                                        ,dotid,proxid,lgid3,cnp_name,duns_number,deleted_key,prev_deleted_duns,company_fein,active_domestic_corp_key,active_enterprise_number,                  if(mdr.sourceTools.SourceIsBusiness_Credit(source) ,vl_id ,''),merge);
  ds_other_cnp_name_sources       := table(ds_slim_prep ,{proxid,lgid3,cnp_name,duns_number,deleted_key,company_fein,active_domestic_corp_key,active_enterprise_number,sbfe_id} ,proxid,lgid3,cnp_name,duns_number,deleted_key,company_fein,active_domestic_corp_key,active_enterprise_number,sbfe_id ,merge);
  ds_other_cnp_name_sources_filt  := ds_other_cnp_name_sources(deleted_key = '',duns_number != '' or company_fein != '' or active_domestic_corp_key != '' or active_enterprise_number != '' or sbfe_id != '');
  ds_other_cnp_name_sources_norm := normalize(ds_other_cnp_name_sources_filt ,5  ,transform({unsigned6 proxid,unsigned6 lgid3,string cnp_name,string god_key}
    ,self.god_key := choose(counter ,if(trim(left.duns_number             ) != '','DUNS-'    + trim(left.duns_number               ),'')
                                    ,if(trim(left.company_fein            ) != '','FEIN-'    + trim(left.company_fein              ),'')
                                    ,if(trim(left.active_domestic_corp_key) != '','CORPKEY-' + trim(left.active_domestic_corp_key  ),'') 
                                    ,if(trim(left.active_enterprise_number) != '','ENT_NUM-' + trim(left.active_enterprise_number  ),'') 
                                    ,if(trim(left.sbfe_id                 ) != '','SBFE_ID-' + trim(left.sbfe_id                   ),'')
                     )
    ,self         := left
  ))(god_key != '');
  ds_other_cnp_name_sources_dedup_proxid := table(ds_other_cnp_name_sources_norm ,{proxid,cnp_name,dataset({string god_key}) god_keys := dataset([{god_key}],{string god_key})}  ,proxid,cnp_name ,god_key,merge);
  ds_other_cnp_name_sources_dedup_lgid3  := table(ds_other_cnp_name_sources_norm ,{lgid3 ,cnp_name,dataset({string god_key}) god_keys := dataset([{god_key}],{string god_key})}  ,lgid3 ,cnp_name ,god_key,merge);
 
  // -- rollup god keys by ID
  ds_other_cnp_name_sources_rollup_proxid := rollup(sort(distribute(ds_other_cnp_name_sources_dedup_proxid ,hash(proxid,cnp_name)),proxid,cnp_name,god_keys[1].god_key,local)  ,left.proxid = right.proxid and left.cnp_name = right.cnp_name,transform(recordof(left)
    ,self.god_keys := left.god_keys + right.god_keys
    ,self          := left
  )  ,local) : persist('~persist::BIPV2_Tools::SetDuns::ds_other_cnp_name_sources_rollup_proxid');

  ds_other_cnp_name_sources_rollup_lgid3 := rollup(sort(distribute(ds_other_cnp_name_sources_dedup_lgid3 ,hash(lgid3,cnp_name)),lgid3,cnp_name,god_keys[1].god_key,local)  ,left.lgid3 = right.lgid3 and left.cnp_name = right.cnp_name,transform(recordof(left)
    ,self.god_keys := left.god_keys + right.god_keys
    ,self          := left
  )  ,local);
  
  // -- join god keys onto BOW file proxid, then filter for clusters that do not have another god key that will bring them back together.  
  ds_get_god_keys_left_proxid  := join(ds_append_bow_proxid_filt   ,ds_other_cnp_name_sources_rollup_proxid  ,left.proxid = right.proxid and left.cnp_name_left  = right.cnp_name ,transform({recordof(left),dataset({string god_key}) god_keys_left },self := left,self.god_keys_left  := right.god_keys) ,left outer,hash);
  ds_get_god_keys_right_proxid := join(ds_get_god_keys_left_proxid ,ds_other_cnp_name_sources_rollup_proxid  ,left.proxid = right.proxid and left.cnp_name_right = right.cnp_name ,transform({recordof(left),dataset({string god_key}) god_keys_right},self := left,self.god_keys_right := right.god_keys) ,left outer,hash)
   : persist('~persist::BIPV2_Tools::SetDuns::ds_get_god_keys_right');
  
  ds_eval_god_keys_proxid := project(distribute(ds_get_god_keys_right_proxid),transform(
    {recordof(left),unsigned cnt_left_god_keys,unsigned cnt_right_god_keys,unsigned cnt_total_god_keys,unsigned cnt_total_deduped_god_keys,boolean did_god_keys_validate}
    ,self.cnt_left_god_keys           := count(left.god_keys_left )
    ,self.cnt_right_god_keys          := count(left.god_keys_right)
    ,self.cnt_total_god_keys          := self.cnt_left_god_keys + self.cnt_right_god_keys
    ,self.cnt_total_deduped_god_keys  := count(table(left.god_keys_left + left.god_keys_right,{god_key},god_key,few))
    ,self.did_god_keys_validate       := if(self.cnt_total_deduped_god_keys = self.cnt_total_god_keys  ,false  ,true)
    ,self                             := left
  ))
   : persist('~persist::BIPV2_Tools::SetDuns::ds_eval_god_keys');
  
  
  ds_eval_god_keys_not_validated_proxid := ds_eval_god_keys_proxid(did_god_keys_validate = false);
  
  // -- join god keys onto BOW file lgid3, then filter for clusters that do not have another god key that will bring them back together.  
  ds_get_god_keys_left_lgid3  := join(ds_append_bow_lgid3_filt   ,ds_other_cnp_name_sources_rollup_lgid3  ,left.lgid3 = right.lgid3 and left.cnp_name_left  = right.cnp_name ,transform({recordof(left),dataset({string god_key}) god_keys_left },self := left,self.god_keys_left  := right.god_keys) ,left outer,hash);
  ds_get_god_keys_right_lgid3 := join(ds_get_god_keys_left_lgid3 ,ds_other_cnp_name_sources_rollup_lgid3  ,left.lgid3 = right.lgid3 and left.cnp_name_right = right.cnp_name ,transform({recordof(left),dataset({string god_key}) god_keys_right},self := left,self.god_keys_right := right.god_keys) ,left outer,hash)
   : persist('~persist::BIPV2_Tools::SetDuns::ds_get_god_keys_right_lgid3');
  
  ds_eval_god_keys_lgid3 := project(distribute(ds_get_god_keys_right_lgid3),transform(
    {recordof(left),unsigned cnt_left_god_keys,unsigned cnt_right_god_keys,unsigned cnt_total_god_keys,unsigned cnt_total_deduped_god_keys,boolean did_god_keys_validate}
    ,self.cnt_left_god_keys  := count(left.god_keys_left )
    ,self.cnt_right_god_keys := count(left.god_keys_right)
    ,self.cnt_total_god_keys := self.cnt_left_god_keys + self.cnt_right_god_keys
    ,self.cnt_total_deduped_god_keys := count(table(left.god_keys_left + left.god_keys_right,{god_key},god_key,few))
    ,self.did_god_keys_validate      := if(self.cnt_total_deduped_god_keys = self.cnt_total_god_keys  ,false  ,true)
    ,self                             := left
  ))
   : persist('~persist::BIPV2_Tools::SetDuns::ds_eval_god_keys_lgid3');
  
  ds_eval_god_keys_not_validated_lgid3 := ds_eval_god_keys_lgid3(did_god_keys_validate = false);
  
  // -- join back to full file to get all the records for the IDs that will be exploded
  ds_get_all_proxid_records := if(exists(ds_refreshed_duns_good_proxid)  ,join(ds_sample ,table(ds_eval_god_keys_not_validated_proxid,{proxid},proxid,merge)  ,left.proxid = right.proxid ,transform(left)  ,hash)  ,dataset([],recordof(ds_sample)));
  ds_get_all_seleid_records := if(exists(ds_refreshed_duns_good_proxid)  ,join(ds_sample ,table(ds_eval_god_keys_not_validated_lgid3 ,{lgid3 },lgid3 ,merge)  ,left.lgid3  = right.lgid3  ,transform(left)  ,hash)  ,dataset([],recordof(ds_sample)));
  
  // -- reset the clusters if necessary
  ds_refreshed_duns_out := project(ds_refreshed_duns  ,bipv2.commonbase.layout);  
  reset_clusters        := bipv2_tools.mac_reset_clusters(ds_get_all_proxid_records,ds_get_all_seleid_records ,pReturnFullPatchedDataset := true,pTurnOffAgg := true,pDs_Full_File := ds_refreshed_duns_out);

  ds_return := if(exists(ds_get_all_proxid_records) or exists(ds_get_all_seleid_records)
                  ,project(reset_clusters,bipv2.commonbase.layout) + project(ds_refreshed_duns_zero_proxid,bipv2.commonbase.layout)
                  ,ds_refreshed_duns_out
               )  : persist('~persist::BIPV2_Tools::SetDuns::ds_return');


  lay_cands_stats   := {string stat, unsigned value};
  lay_refresh_stats := {string file,string field,string stat,string value ,string pct_change := ''};
  lay_bow_info      := {string ID  ,string file  ,unsigned cnt_records ,unsigned cnt_clusters };

  ds_cands_stats    := wk_ut.get_ds_result(workunit,'ds_candidates_stats'           ,lay_cands_stats  );
  ds_refresh_stats  := wk_ut.get_ds_result(workunit,'Stats_BIPV2_Tools_Refresh_Duns',lay_refresh_stats);
  ds_bow_info       := wk_ut.get_ds_result(workunit,'Stats_mac_Append_BOW_Info'     ,lay_bow_info     );

  lay_strata := {string file,unsigned countgroup,integer diff_in_out0,unsigned records_affected_lgid3  ,unsigned records_affected_total 
                 ,unsigned proxids_in ,unsigned proxids_out ,unsigned cnt_proxid_increase ,unsigned pct_proxid_increase ,unsigned cnt_blank_proxids
                 ,unsigned lgid3s_in  ,unsigned lgid3s_out  ,unsigned cnt_lgid3_increase  ,unsigned pct_lgid3_increase  ,unsigned cnt_blank_lgid3s
                 ,unsigned cnp_name_in     ,unsigned cnp_name_out 
                 ,unsigned duns_number_in  ,unsigned duns_number_out 
                 ,unsigned active_duns_in  ,unsigned active_duns_out 
                 ,unsigned hist_duns_in    ,unsigned hist_duns_out 
                 ,unsigned deleted_duns_in ,unsigned deleted_duns_out 
                 ,unsigned company_fein_in ,unsigned company_fein_out 
                 ,unsigned deleted_fein_in ,unsigned deleted_fein_out     
   }; //28 count fields
 
  ds_strata := dataset([
     {ds_refresh_stats(trim(file) = 'D&B DMI')[1].value,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}  //D&B dmi filename row so we know which filename it pulled in easily
    ,{'Current'                                         
     ,(unsigned)ds_refresh_stats(trim(file) = 'Input',trim(stat) = 'Count Records')[1].value               //,unsigned countgroup
     ,(integer )ds_refresh_stats(trim(file) = 'Input',trim(stat) = 'Count Records')[1].value - (integer)ds_refresh_stats(trim(file) = 'Output',trim(stat) = 'Count Records')[1].value               //,integer diff_in_out0
     ,ds_cands_stats(trim(stat) = 'seleid candidate records'  )[1].value               //,unsigned records_affected_lgid3  
     ,ds_cands_stats(trim(stat) = 'Combined candidate records')[1].value                //,unsigned records_affected_total 
     ,ds_cands_stats(trim(stat) = 'proxid candidates'         )[1].value               //,unsigned proxids_in 
     ,ds_cands_stats(trim(stat) = 'total reformed proxids'    )[1].value               //,unsigned proxids_out 
     ,ds_cands_stats(trim(stat) = 'total reformed proxids'    )[1].value - ds_cands_stats(trim(stat) = 'proxid candidates')[1].value               //,unsigned cnt_proxid_increase 
     
     ,(unsigned)((real8)realformat(
                                    (ds_cands_stats(trim(stat) = 'total reformed proxids')[1].value - ds_cands_stats(trim(stat) = 'proxid candidates')[1].value) / ds_bow_info(trim(id) = 'proxid',trim(file) = 'Input')[1].cnt_clusters  * 100.0  ,6,2) * 100 )          //,unsigned pct_proxid_increase 
     
     ,count(ds_refreshed_duns_zero_proxid)               //,unsigned cnt_blank_proxids
     ,ds_cands_stats(trim(stat) = 'seleid candidates'     )[1].value               //,unsigned lgid3s_in  
     ,ds_cands_stats(trim(stat) = 'total reformed seleids')[1].value               //,unsigned lgid3s_out  
     ,ds_cands_stats(trim(stat) = 'total reformed seleids')[1].value - ds_cands_stats(trim(stat) = 'seleid candidates')[1].value               //,unsigned cnt_lgid3_increase  
     
     ,(unsigned)((real8)realformat(ds_cands_stats(trim(stat) = 'total reformed seleids' )[1].value - ds_cands_stats(trim(stat) = 'seleid candidates')[1].value /  ds_bow_info(trim(id) = 'lgid3',trim(file) = 'Input')[1].cnt_clusters * 100.0  ,6,2) * 100 )               //,unsigned pct_lgid3_increase  
     
     ,count(ds_refreshed_duns_zero_lgid3)               //,unsigned cnt_blank_lgid3s
     ,(unsigned)ds_refresh_stats(trim(file) = 'Input' ,trim(field) = 'cnp_name'           ,trim(stat) = 'Count NonBlank')[1].value               //,unsigned cnp_name_in     
     ,(unsigned)ds_refresh_stats(trim(file) = 'Output',trim(field) = 'cnp_name'           ,trim(stat) = 'Count NonBlank')[1].value               //,unsigned cnp_name_out 
     ,(unsigned)ds_refresh_stats(trim(file) = 'Input' ,trim(field) = 'duns_number'        ,trim(stat) = 'Count NonBlank')[1].value               //,unsigned duns_number_in  
     ,(unsigned)ds_refresh_stats(trim(file) = 'Output',trim(field) = 'duns_number'        ,trim(stat) = 'Count NonBlank')[1].value               //,unsigned duns_number_out 
     ,(unsigned)ds_refresh_stats(trim(file) = 'Input' ,trim(field) = 'active_duns_number' ,trim(stat) = 'Count NonBlank')[1].value               //,unsigned active_duns_in  
     ,(unsigned)ds_refresh_stats(trim(file) = 'Output',trim(field) = 'active_duns_number' ,trim(stat) = 'Count NonBlank')[1].value               //,unsigned active_duns_out 
     ,(unsigned)ds_refresh_stats(trim(file) = 'Input' ,trim(field) = 'hist_duns_number'   ,trim(stat) = 'Count NonBlank')[1].value               //,unsigned hist_duns_in    
     ,(unsigned)ds_refresh_stats(trim(file) = 'Output',trim(field) = 'hist_duns_number'   ,trim(stat) = 'Count NonBlank')[1].value               //,unsigned hist_duns_out 
     ,(unsigned)ds_refresh_stats(trim(file) = 'Input' ,trim(field) = 'deleted_key'        ,trim(stat) = 'Count NonBlank')[1].value               //,unsigned deleted_duns_in 
     ,(unsigned)ds_refresh_stats(trim(file) = 'Output',trim(field) = 'deleted_key'        ,trim(stat) = 'Count NonBlank')[1].value               //,unsigned deleted_duns_out 
     ,(unsigned)ds_refresh_stats(trim(file) = 'Input' ,trim(field) = 'company_fein'       ,trim(stat) = 'Count NonBlank')[1].value               //,unsigned company_fein_in 
     ,(unsigned)ds_refresh_stats(trim(file) = 'Output',trim(field) = 'company_fein'       ,trim(stat) = 'Count NonBlank')[1].value               //,unsigned company_fein_out 
     ,(unsigned)ds_refresh_stats(trim(file) = 'Input' ,trim(field) = 'deleted_fein'       ,trim(stat) = 'Count NonBlank')[1].value               //,unsigned deleted_fein_in 
     ,(unsigned)ds_refresh_stats(trim(file) = 'Output',trim(field) = 'deleted_fein'       ,trim(stat) = 'Count NonBlank')[1].value               //,unsigned deleted_fein_out      
    }
  ],lay_strata)
  : independent;
     
  import strata;
  Strata_explode_stats := if(pDoStrata = true ,Strata.macf_CreateXMLStats(ds_strata   ,'BIPV2','RunIngest'  ,pversion ,pEmailList ,'Proxid_Correction_Stats' ,'SetDuns'   ,pIsTesting,pOverwrite));
  
  // -- do some stats on the bow and god key stuff
  ds_stats := dataset([
     {'SetDuns','Input'                                     ,count(ds_in                                  ) ,count(table(ds_in                                  ,{proxid},proxid,merge))}
    ,{'SetDuns','Output'                                    ,count(ds_return                              ) ,count(table(ds_return                              ,{proxid},proxid,merge))}
    ,{'SetDuns','ds_refreshed_duns_good_proxid'             ,count(ds_refreshed_duns_good_proxid          ) ,count(table(ds_refreshed_duns_good_proxid          ,{proxid},proxid,merge))}
    ,{'SetDuns','ds_refreshed_duns_zero_proxid'             ,count(ds_refreshed_duns_zero_proxid          ) ,0                                                                          }
    ,{'SetDuns','reset_clusters'                            ,count(reset_clusters                         ) ,count(table(reset_clusters                         ,{proxid},proxid,merge))}

    ,{'Proxid','ds_append_bow_proxid_filt'                  ,count(ds_append_bow_proxid_filt              ) ,count(table(ds_append_bow_proxid_filt              ,{proxid},proxid,merge))}
    ,{'Proxid','ds_get_god_keys_left'                       ,count(ds_get_god_keys_left_proxid            ) ,count(table(ds_get_god_keys_left_proxid            ,{proxid},proxid,merge))}
    ,{'Proxid','ds_get_god_keys_right'                      ,count(ds_get_god_keys_right_proxid           ) ,count(table(ds_get_god_keys_right_proxid           ,{proxid},proxid,merge))}
    ,{'Proxid','ds_eval_god_keys'                           ,count(ds_eval_god_keys_proxid                ) ,count(table(ds_eval_god_keys_proxid                ,{proxid},proxid,merge))}
    ,{'Proxid','ds_eval_god_keys_not_validated'             ,count(ds_eval_god_keys_not_validated_proxid  ) ,count(table(ds_eval_god_keys_not_validated_proxid  ,{proxid},proxid,merge))}
   
    ,{'lgid3','ds_append_bow_lgid3_filt'                    ,count(ds_append_bow_lgid3_filt               ) ,count(table(ds_append_bow_lgid3_filt               ,{lgid3 },lgid3 ,merge))}
    ,{'lgid3','ds_get_god_keys_left_lgid3'                  ,count(ds_get_god_keys_left_lgid3             ) ,count(table(ds_get_god_keys_left_lgid3             ,{lgid3 },lgid3 ,merge))}
    ,{'lgid3','ds_get_god_keys_right_lgid3'                 ,count(ds_get_god_keys_right_lgid3            ) ,count(table(ds_get_god_keys_right_lgid3            ,{lgid3 },lgid3 ,merge))}
    ,{'lgid3','ds_eval_god_keys_lgid3'                      ,count(ds_eval_god_keys_lgid3                 ) ,count(table(ds_eval_god_keys_lgid3                 ,{lgid3 },lgid3 ,merge))}
    ,{'lgid3','ds_eval_god_keys_not_validated_lgid3'        ,count(ds_eval_god_keys_not_validated_lgid3   ) ,count(table(ds_eval_god_keys_not_validated_lgid3   ,{lgid3 },lgid3 ,merge))}
  
  ],{string ID  ,string file  ,unsigned cnt_records ,unsigned cnt_clusters });

  output_rest_stats := parallel(    
     output(ds_stats                                                ,named('Stats_mac_Append_BOW_Info'              ),extend,all)
    ,output(choosen(ds_append_bow_proxid_filt                 ,100) ,named('ds_append_bow_proxid_filt'              ))
    ,output(choosen(ds_get_god_keys_left_proxid               ,100) ,named('ds_get_god_keys_left_proxid'            ))
    ,output(choosen(ds_get_god_keys_right_proxid              ,100) ,named('ds_get_god_keys_right_proxid'           ))
    ,output(choosen(ds_eval_god_keys_proxid                   ,100) ,named('ds_eval_god_keys_proxid'                ))
    ,output(choosen(ds_eval_god_keys_not_validated_proxid     ,100) ,named('ds_eval_god_keys_not_validated_proxid'  ))
    
    ,output(choosen(ds_append_bow_lgid3_filt                  ,100) ,named('ds_append_bow_lgid3_filt'               ))
    ,output(choosen(ds_get_god_keys_left_lgid3                ,100) ,named('ds_get_god_keys_left_lgid3'             ))
    ,output(choosen(ds_get_god_keys_right_lgid3               ,100) ,named('ds_get_god_keys_right_lgid3'            ))
    ,output(choosen(ds_eval_god_keys_lgid3                    ,100) ,named('ds_eval_god_keys_lgid3'                 ))
    ,output(choosen(ds_eval_god_keys_not_validated_lgid3      ,100) ,named('ds_eval_god_keys_not_validated_lgid3'   ))
  
    ,output(choosen(ds_slim_prep                              ,100) ,named('ds_slim_prep'                           ))
    ,output(choosen(ds_other_cnp_name_sources                 ,100) ,named('ds_other_cnp_name_sources'              ))
    ,output(choosen(ds_other_cnp_name_sources_filt            ,100) ,named('ds_other_cnp_name_sources_filt'         ))
    ,output(choosen(ds_other_cnp_name_sources_norm            ,100) ,named('ds_other_cnp_name_sources_norm'         ))
    ,output(choosen(ds_other_cnp_name_sources_dedup_proxid    ,100) ,named('ds_other_cnp_name_sources_dedup_proxid' ))
    ,output(choosen(ds_other_cnp_name_sources_rollup_proxid   ,100) ,named('ds_other_cnp_name_sources_rollup_proxid'))
    ,output(choosen(ds_other_cnp_name_sources_dedup_lgid3     ,100) ,named('ds_other_cnp_name_sources_dedup_lgid3'  ))
    ,output(choosen(ds_other_cnp_name_sources_rollup_lgid3    ,100) ,named('ds_other_cnp_name_sources_rollup_lgid3' ))
  );
  
  output_all := parallel(
     output_bow_samples
    ,output_rest_stats
    ,output(dataset([],{string stat, unsigned value})  ,named('ds_candidates_stats'),extend,all)  //just in case this doesn't get run
    ,Strata_explode_stats
  );
  
  return when(ds_return,output_all);
    
end;
