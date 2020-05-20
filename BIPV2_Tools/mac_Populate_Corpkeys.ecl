import corp2,paw,bipv2_files;

EXPORT mac_Populate_Corpkeys(

   pInput_file          = 'dataset([],BIPV2_ProxID.layout_DOT_Base)'
  ,pInactive_Corp_Keys  = 'PAW.fCorpInactives()'
  ,pCorp                = 'corp2.files().base.corp.qa'
  ,pDebugCorpkeys       = '[]'
  ,pPersistName         = '\'~persist::BIPV2_Tools::mac_Populate_Corpkeys::ds_result\''
) :=
functionmacro

  import bipv2_files,mdr,corp2,paw;

  // -- dedup to get all unique inactive corpkeys
  ds_inactive_corp_keys := table(pInactive_Corp_Keys ,{corp_key} ,corp_key ,merge);
  ds_prep_slim          := pInput_file;

  // -- Divide Input dataset into those with vl_ids and those without
  ds_bip_corp_records    := ds_prep_slim(  vl_id != '' and MDR.sourceTools.SourceIsCorpV2(source) );
  ds_bip_notcorp_records := ds_prep_slim(~(vl_id != '' and MDR.sourceTools.SourceIsCorpV2(source)));

  ds_slim_set_corpkey_fields := join(ds_bip_corp_records ,ds_inactive_corp_keys  ,trim(left.vl_id) = trim(right.corp_key)  ,transform(recordof(left)
    ,self.active_corp_key   := if(trim(right.corp_key)  = ''  ,left.vl_id ,'' )
    ,self.hist_corp_key     := if(trim(right.corp_key) != ''  ,left.vl_id ,'' )
    ,self                   := left
  ) ,left outer  ,hash);

  // -- do assumed name stuff
  ds_corpy_select_AN          := pCorp(corp_ln_name_type_cd = 'AN' or regexfind('ASSUMED',corp_ln_name_type_desc,nocase));
  ds_corpy_select_AN_corpkeys := table(ds_corpy_select_AN,{corp_key},corp_key,merge);

  ds_joinback_ans                     := join(table(pCorp,{corp_key,corp_ln_name_type_cd,corp_ln_name_type_desc},corp_key,corp_ln_name_type_cd,corp_ln_name_type_desc,merge)  ,ds_corpy_select_AN_corpkeys,left.corp_key = right.corp_key,transform(left),hash);
  ds_joinback_ans_countCorpkey_groups := table(ds_joinback_ans,{corp_key,unsigned8 cnt := count(group)},corp_key,merge);
  ds_joinback_ans_countCorpkey_gt1    := ds_joinback_ans_countCorpkey_groups(cnt > 1);
  ds_joinback_ans_countCorpkey_eq1    := ds_joinback_ans_countCorpkey_groups(cnt = 1);
  ds_SoloANCorpkeys                   := ds_joinback_ans_countCorpkey_eq1;

  ds_slim_blank_solo_AN_Corpkeys := join(
   distribute(ds_slim_set_corpkey_fields   , hash32(vl_id    ))
  ,distribute(ds_SoloANCorpkeys            , hash32(corp_key ))
  ,trim(left.vl_id) = trim(right.corp_key)
  ,transform(recordof(left)
    ,self.active_corp_key  := if(right.corp_key        = ''                     ,left.active_corp_key ,'')  // -- if it is a solo AN corpkey, it is not active
    ,self.hist_corp_key    := if(left.active_corp_key != self.active_corp_key   ,left.active_corp_key       // -- if we blanked out an active corpkey because of being solo AN, then mark as historic.  Otherwise keep the historic one.
                                                                                ,left.hist_corp_key   
                                       )
    ,self                           := left
  )
  ,left outer, local
  );

  ds_result := ds_slim_blank_solo_AN_Corpkeys + ds_bip_notcorp_records
    : persist(pPersistName);

  output_debug := parallel(
    output(choosen(pInput_file                          (count(pDebugCorpkeys) = 0 or trim(vl_id    ) in pDebugCorpkeys),100) ,named('pInput_file'                        ))
   ,output(choosen(pInactive_Corp_Keys                  (count(pDebugCorpkeys) = 0 or trim(corp_key ) in pDebugCorpkeys),100) ,named('pInactive_Corp_Keys'                ))
   ,output(choosen(pCorp                                (count(pDebugCorpkeys) = 0 or trim(corp_key ) in pDebugCorpkeys),100) ,named('pCorp'                              ))
   ,output(choosen(ds_inactive_corp_keys                (count(pDebugCorpkeys) = 0 or trim(corp_key ) in pDebugCorpkeys),100) ,named('ds_inactive_corp_keys'              ))
   ,output(choosen(ds_prep_slim                         (count(pDebugCorpkeys) = 0 or trim(vl_id    ) in pDebugCorpkeys),100) ,named('ds_prep_slim'                       ))
   ,output(choosen(ds_bip_corp_records                  (count(pDebugCorpkeys) = 0 or trim(vl_id    ) in pDebugCorpkeys),100) ,named('ds_bip_corp_records'                ))
   ,output(choosen(ds_bip_notcorp_records               (count(pDebugCorpkeys) = 0 or trim(vl_id    ) in pDebugCorpkeys),100) ,named('ds_bip_notcorp_records'             ))
   ,output(choosen(ds_slim_set_corpkey_fields           (count(pDebugCorpkeys) = 0 or trim(vl_id    ) in pDebugCorpkeys),100) ,named('ds_slim_set_corpkey_fields'         ))
   ,output(choosen(ds_corpy_select_AN                   (count(pDebugCorpkeys) = 0 or trim(corp_key ) in pDebugCorpkeys),100) ,named('ds_corpy_select_AN'                 ))
   ,output(choosen(ds_corpy_select_AN_corpkeys          (count(pDebugCorpkeys) = 0 or trim(corp_key ) in pDebugCorpkeys),100) ,named('ds_corpy_select_AN_corpkeys'        ))
   ,output(choosen(ds_joinback_ans                      (count(pDebugCorpkeys) = 0 or trim(corp_key ) in pDebugCorpkeys),100) ,named('ds_joinback_ans'                    ))
   ,output(choosen(ds_joinback_ans_countCorpkey_groups  (count(pDebugCorpkeys) = 0 or trim(corp_key ) in pDebugCorpkeys),100) ,named('ds_joinback_ans_countCorpkey_groups'))
   ,output(choosen(ds_joinback_ans_countCorpkey_gt1     (count(pDebugCorpkeys) = 0 or trim(corp_key ) in pDebugCorpkeys),100) ,named('ds_joinback_ans_countCorpkey_gt1'   ))
   ,output(choosen(ds_joinback_ans_countCorpkey_eq1     (count(pDebugCorpkeys) = 0 or trim(corp_key ) in pDebugCorpkeys),100) ,named('ds_joinback_ans_countCorpkey_eq1'   ))
   ,output(choosen(ds_SoloANCorpkeys                    (count(pDebugCorpkeys) = 0 or trim(corp_key ) in pDebugCorpkeys),100) ,named('ds_SoloANCorpkeys'                  ))
   ,output(choosen(ds_slim_blank_solo_AN_Corpkeys       (count(pDebugCorpkeys) = 0 or trim(vl_id    ) in pDebugCorpkeys),100) ,named('ds_slim_blank_solo_AN_Corpkeys'     ))
   ,output(choosen(ds_result                            (count(pDebugCorpkeys) = 0 or trim(vl_id    ) in pDebugCorpkeys),100) ,named('ds_result'                          ))
                                                     
  );

  
  return when(ds_result  ,if(count(pDebugCorpkeys) > 0 ,output_debug));
  
endmacro;