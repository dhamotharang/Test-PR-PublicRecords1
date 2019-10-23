export mac_reset_clusters(

   pProxidRecords2Reset
  ,pSeleidRecords2Reset
  ,pGet_all_proxid_records_agg  = 'dataset([],recordof(BIPV2_Tools.Agg_Slim(bipv2.commonbase.layout,proxid)))'
  ,pGet_all_seleid_records_agg  = 'dataset([],recordof(BIPV2_Tools.Agg_Slim(bipv2.commonbase.layout,seleid)))'
  ,pNewDotid_Filename           = '\'\''
  ,pAdd2Superfile               = 'false'
  ,pPatchedFullFileName         = '\'\''      //blank = don't output it.  if you put a filename here, it will output the full patched file.
  ,pDs_Full_file                = 'BIPV2.CommonBase.DS_BASE'
  ,pReturnFullPatchedDataset    = 'false'
  ,pTurnOffAgg                  = 'false'
) :=
functionmacro

  // -- resetting occurs here
  ds_proxid_candidate_records_reset := project(pProxidRecords2Reset                                                                                              ,transform({recordof(left),unsigned6 old_proxid,unsigned6 old_seleid},self.old_proxid := left.proxid,self.proxid := left.dotid ,self.lgid3  := 0,self.seleid := 0,self := left,,self.old_seleid := left.seleid)) ;
  ds_seleid_candidate_records_reset := join(pSeleidRecords2Reset  ,table(pProxidRecords2Reset,{proxid},proxid,merge) ,left.proxid = right.proxid ,transform({recordof(left),unsigned6 old_proxid,unsigned6 old_seleid},self.old_proxid := left.proxid,self.old_seleid := left.seleid,self.lgid3  := left.proxid,self.seleid := self.lgid3/*test*/,self := left,self := []) ,left only ,hash);
  
  ds_concat_candidate_records := ds_proxid_candidate_records_reset + ds_seleid_candidate_records_reset  : persist('~persist::BIPV2_Tools::mac_reset_clusters::ds_concat_candidate_records');
  
  ds_base_patched             := project(ds_concat_candidate_records  ,bipv2.commonbase.layout);
  
  ds_base_not_patched         := join(pDs_Full_file  ,ds_base_patched ,left.rcid = right.rcid,transform(left),left only,hash);
  ds_base_full_concat         := ds_base_patched + ds_base_not_patched;


  // -- not ALL PROXIDS WITHIN THE SELEIDS NEED TO BE EXPLODED -- ONLY THE ONES THAT ARE PART OF THE PROXID RECORDS.  THE OTHER ONES ARE OK.  THIS SHOULD LOWER THE NUMBER OF PROXIDS.
  //ds_concat_candidate_records := dedup(sort(distribute(ds_proxid_candidate_records + ds_seleid_candidate_records,rcid),rcid,local),rcid,local)  : persist('~persist::lbentley::ds_concat_candidate_records');
  
  ds_candidate_rcids   := table(ds_concat_candidate_records  ,{rcid  } ,rcid   ,merge);
  ds_candidate_dotids  := table(ds_concat_candidate_records  ,{dotid } ,dotid  ,merge);
  ds_candidate_proxids := table(ds_concat_candidate_records  ,{proxid} ,proxid ,merge);
  ds_candidate_seleids := table(ds_concat_candidate_records  ,{seleid} ,seleid ,merge);
  
  
  // -- reform reset proxid clusters
  ds_proxid_reform_prep  := table(ds_proxid_candidate_records_reset  ,{dotid,old_proxid,cnp_name},dotid,old_proxid,cnp_name,merge);
  ds_reform_proxid       := BIPV2_Tools.mac_reform_clusters(ds_proxid_reform_prep ,dotid  ,cnp_name,20,old_proxid)
                            : persist('~persist::BIPV2_Tools::mac_reset_clusters::ds_reform_proxid');
  ds_patch_proxid        := join(ds_concat_candidate_records  ,table(ds_reform_proxid,{dotid,unsigned6 lowest_dotid := min(group,lowest_dotid)},dotid,merge) ,left.dotid = right.dotid  ,transform(recordof(left),self.proxid := if(right.dotid != 0,right.lowest_dotid,left.proxid),self := left),left outer,hash)
                              : persist('~persist::BIPV2_Tools::mac_reset_clusters::ds_patch_proxid');
  
  // -- reform reset seleid clusters
  ds_seleid_reform_prep  := table(ds_patch_proxid                   ,{proxid,old_seleid,cnp_name},proxid,old_seleid,cnp_name,merge);
  ds_reform_seleid       := BIPV2_Tools.mac_reform_clusters(ds_seleid_reform_prep ,proxid  ,cnp_name,20,old_seleid)
                            : persist('~persist::BIPV2_Tools::mac_reset_clusters::ds_reform_seleid');
  ds_patch_seleid        := join(ds_patch_proxid              ,table(ds_reform_seleid,{proxid,unsigned6 lowest_proxid := min(group,lowest_proxid)},proxid,merge) ,left.proxid = right.proxid  ,transform(recordof(left),self.lgid3 := if(right.proxid != 0,right.lowest_proxid,left.lgid3),self := left),left outer,hash)
                              : persist('~persist::BIPV2_Tools::mac_reset_clusters::ds_patch_seleid');

  ds_full_patched_reformed := project(ds_patch_seleid ,bipv2.commonbase.layout) + ds_base_not_patched;
  
  ds_candidate_proxids_reformed := table(ds_reform_proxid  ,{lowest_dotid} ,lowest_dotid ,merge);
  ds_candidate_seleids_reformed := table(ds_reform_seleid  ,{lowest_proxid} ,lowest_proxid ,merge);
  
  // -- do some stats
  ds_candidates_stats := dataset([
     {'proxid candidates'           ,count(table(pProxidRecords2Reset,{proxid},proxid,merge))}
    ,{'proxid candidate records'    ,count(pProxidRecords2Reset)}
    ,{'seleid candidates'           ,count(table(pSeleidRecords2Reset,{seleid},seleid,merge))}
    ,{'seleid candidate records'    ,count(pSeleidRecords2Reset)}
    ,{'combined proxid candidates'  ,count(ds_candidate_proxids)}
    ,{'combined seleid candidates'  ,count(ds_candidate_seleids)}
    ,{'Combined candidate records'  ,count(ds_candidate_rcids)}
    ,{'Combined candidate dotids'   ,count(ds_candidate_dotids)}
  
    ,{'total reformed proxids'   ,count(ds_candidate_proxids_reformed)}
    ,{'total reformed seleids'   ,count(ds_candidate_seleids_reformed)}
  
  ],{string stat, unsigned value});
  
  ds_stats := dataset([
     {'ds_base_patched    '       ,count(ds_base_patched          )}
    ,{'ds_base_not_patched'       ,count(ds_base_not_patched      )}
    ,{'ds_base_before     '       ,count(pDs_Full_file            )}
    ,{'ds_full_patched_reformed'  ,count(ds_full_patched_reformed )}
  
  ],{string stat  ,unsigned value});
    
  do_reset_reform := sequential(
     output(ds_candidates_stats           ,named('ds_candidates_stats'),extend,all)
#IF(trim(pNewDotid_Filename) != '')
    ,output(ds_concat_candidate_records  ,,pNewDotid_Filename ,overwrite,compressed)  // not full file because we want to run iterations on top of this sample set to see what happens
    ,if(pAdd2Superfile = true
      ,sequential(
         std.file.clearsuperfile(BIPV2_Files.files_dotid().FILE_BASE)
        ,std.file.addsuperfile(BIPV2_Files.files_dotid().FILE_BASE  ,pNewDotid_Filename)
      )
    )
#END
    ,if(trim(pPatchedFullFileName) != ''
      ,sequential(
         output(ds_full_patched_reformed  ,,pPatchedFullFileName ,overwrite,compressed)  // full file
      )
    )
    ,output(ds_stats ,named('ds_stats'))
  );
  
#IF(pTurnOffAgg = false)  
  output_matrix_and_samples := bipv2_tools.mac_get_overlinking_samples(pProxidRecords2Reset,pSeleidRecords2Reset,pGet_all_proxid_records_agg,pGet_all_seleid_records_agg);
#END  

  return_ops := parallel(
     do_reset_reform
    #IF(pTurnOffAgg = false)  
      ,output_matrix_and_samples
    #END
  );
#IF(pReturnFullPatchedDataset = false)
  return return_ops;
#ELSE
  return when(ds_full_patched_reformed ,return_ops);
#END

  
endmacro;