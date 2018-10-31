import BIPv2_Files, ut, BIPv2_PostProcess, BIPV2_PROX_SALT_int_fullfile,tools,BIPv2_HRCHY,BIPV2,tools,BIPV2_Tools;
EXPORT proc_segmentation(
   string                            pversion
  ,dataset(BIPV2.CommonBase.layout ) pInputDirty          = BIPV2.CommonBase.DS_BUILT
  ,boolean                           pPromote2QA          = false
  ,boolean                           pOverwrite           = false
  ,string                            pToday               = bipv2.KeySuffix_mod2.MostRecentWithIngestVersionDate//in case you want to run as of a date in the past.  default to date of newest data.
  ,boolean                           pTurnOffStrata       = false
  ,string                            pGoldOutputModifier  = ''
  ,boolean                           pPopulateStatus      = false
  
) := 
module
    shared ds_Input_clean := BIPV2.CommonBase.clean(pInputDirty         ) : persist('~persist::BIPV2_PostProcess::proc_segmentation.ds_Input_clean' + pGoldOutputModifier);
    // shared ds_Input_clean := pInputDirty         ;
    lrec := {ds_Input_clean.ultid ,ds_Input_clean.orgid ,ds_Input_clean.seleid  ,ds_Input_clean.proxid ,ds_Input_clean.powid  ,ds_Input_clean.source  ,ds_Input_clean.company_status_derived  ,ds_Input_clean.dt_first_seen ,ds_Input_clean.dt_last_seen  ,ds_Input_clean.dt_vendor_first_reported  ,ds_Input_clean.dt_vendor_last_reported       };
    ds_set_status_prep  :=   table(ds_Input_clean  ,lrec  ,ultid   ,orgid   ,seleid    ,proxid   ,powid    ,source    ,company_status_derived    ,dt_first_seen   ,dt_last_seen    ,dt_vendor_first_reported    ,dt_vendor_last_reported   ,merge);

    ds_set_status_proxid_private        := BIPV2_Tools.mac_Set_Statuses(ds_set_status_prep            ,proxid ,proxid_status_private  ,true );
    ds_set_status_powid_private         := BIPV2_Tools.mac_Set_Statuses(ds_set_status_proxid_private  ,powid  ,powid_status_private   ,true );
    ds_set_status_seleid_private        := BIPV2_Tools.mac_Set_Statuses(ds_set_status_powid_private   ,seleid ,seleid_status_private  ,true );
    ds_set_status_orgid_private         := BIPV2_Tools.mac_Set_Statuses(ds_set_status_seleid_private  ,orgid  ,orgid_status_private   ,true );
    ds_set_status_ultid_private         := BIPV2_Tools.mac_Set_Statuses(ds_set_status_orgid_private   ,ultid  ,ultid_status_private   ,true );
    ds_set_status_proxid_public         := BIPV2_Tools.mac_Set_Statuses(ds_set_status_ultid_private   ,proxid ,proxid_status_public   ,false);
    ds_set_status_powid_public          := BIPV2_Tools.mac_Set_Statuses(ds_set_status_proxid_public   ,powid  ,powid_status_public    ,false);
    ds_set_status_seleid_public         := BIPV2_Tools.mac_Set_Statuses(ds_set_status_powid_public    ,seleid ,seleid_status_public   ,false);
    ds_set_status_orgid_public          := BIPV2_Tools.mac_Set_Statuses(ds_set_status_seleid_public   ,orgid  ,orgid_status_public    ,false);
    ds_set_status_ultid_public1         := BIPV2_Tools.mac_Set_Statuses(ds_set_status_orgid_public    ,ultid  ,ultid_status_public    ,false);
    shared ds_set_status_ultid_public := join(ds_Input_clean  
    ,table(ds_set_status_ultid_public1,{proxid
,proxid_status_private    
,powid_status_private     
,seleid_status_private    
,orgid_status_private     
,ultid_status_private     
,proxid_status_public     
,powid_status_public      
,seleid_status_public     
,orgid_status_public      
,ultid_status_public      
    ,},proxid
,proxid_status_private    
,powid_status_private     
,seleid_status_private    
,orgid_status_private     
,ultid_status_private     
,proxid_status_public     
,powid_status_public      
,seleid_status_public     
,orgid_status_public      
,ultid_status_public      
    ,merge)  
    ,left.proxid = right.proxid  
      ,transform(recordof(left)
        ,self.proxid_status_private  := right.proxid_status_private
        ,self.powid_status_private   := right.powid_status_private 
        ,self.seleid_status_private  := right.seleid_status_private
        ,self.orgid_status_private   := right.orgid_status_private 
        ,self.ultid_status_private   := right.ultid_status_private 
        ,self.proxid_status_public   := right.proxid_status_public 
        ,self.powid_status_public    := right.powid_status_public  
        ,self.seleid_status_public   := right.seleid_status_public 
        ,self.orgid_status_public    := right.orgid_status_public  
        ,self.ultid_status_public    := right.ultid_status_public
        ,self   := left
      
      ) 
      ,keep(1),hash,left outer);
    export pInput := if(pPopulateStatus = true  ,ds_set_status_ultid_public
                                                ,ds_Input_clean            
    ) : persist('~persist::BIPV2_PostProcess::proc_segmentation.pInput' + pGoldOutputModifier);
    
////// -- patch status fields on full dirty file for output
    ds_proxid_slim_private  := table(ds_set_status_ultid_public  ,{proxid ,proxid_status_private}   ,proxid ,proxid_status_private,merge);//should be only 1 status per proxid
    ds_powid_slim_private   := table(ds_set_status_ultid_public  ,{powid  ,powid_status_private }   ,powid  ,powid_status_private ,merge);//should be only 1 status per proxid
    ds_seleid_slim_private  := table(ds_set_status_ultid_public  ,{seleid ,seleid_status_private}   ,seleid ,seleid_status_private,merge);//should be only 1 status per proxid
    ds_orgid_slim_private   := table(ds_set_status_ultid_public  ,{orgid  ,orgid_status_private }   ,orgid  ,orgid_status_private ,merge);//should be only 1 status per proxid
    ds_ultid_slim_private   := table(ds_set_status_ultid_public  ,{ultid  ,ultid_status_private }   ,ultid  ,ultid_status_private ,merge);//should be only 1 status per proxid
    ds_proxid_slim_public   := table(ds_set_status_ultid_public  ,{proxid ,proxid_status_public }   ,proxid ,proxid_status_public ,merge);//should be only 1 status per proxid
    ds_powid_slim_public    := table(ds_set_status_ultid_public  ,{powid  ,powid_status_public  }   ,powid  ,powid_status_public  ,merge);//should be only 1 status per proxid
    ds_seleid_slim_public   := table(ds_set_status_ultid_public  ,{seleid ,seleid_status_public }   ,seleid ,seleid_status_public ,merge);//should be only 1 status per proxid
    ds_orgid_slim_public    := table(ds_set_status_ultid_public  ,{orgid  ,orgid_status_public  }   ,orgid  ,orgid_status_public  ,merge);//should be only 1 status per proxid
    ds_ultid_slim_public    := table(ds_set_status_ultid_public  ,{ultid  ,ultid_status_public  }   ,ultid  ,ultid_status_public  ,merge);//should be only 1 status per proxid
    
    ds_join_proxid_private  := join(pInputDirty            ,ds_proxid_slim_private  ,left.proxid = right.proxid ,transform(recordof(left) ,self.proxid_status_private  := if(right.proxid != 0  ,right.proxid_status_private  ,BIPV2_PostProcess.constants.Inactive_NoActivity),self := left) ,left outer,hash,keep(1));
    ds_join_powid_private   := join(ds_join_proxid_private ,ds_powid_slim_private   ,left.powid  = right.powid  ,transform(recordof(left) ,self.powid_status_private   := if(right.powid  != 0  ,right.powid_status_private   ,BIPV2_PostProcess.constants.Inactive_NoActivity),self := left) ,left outer,hash,keep(1));
    ds_join_seleid_private  := join(ds_join_powid_private  ,ds_seleid_slim_private  ,left.seleid = right.seleid ,transform(recordof(left) ,self.seleid_status_private  := if(right.seleid != 0  ,right.seleid_status_private  ,BIPV2_PostProcess.constants.Inactive_NoActivity),self := left) ,left outer,hash,keep(1));
    ds_join_orgid_private   := join(ds_join_seleid_private ,ds_orgid_slim_private   ,left.orgid  = right.orgid  ,transform(recordof(left) ,self.orgid_status_private   := if(right.orgid  != 0  ,right.orgid_status_private   ,BIPV2_PostProcess.constants.Inactive_NoActivity),self := left) ,left outer,hash,keep(1));
    ds_join_ultid_private   := join(ds_join_orgid_private  ,ds_ultid_slim_private   ,left.ultid  = right.ultid  ,transform(recordof(left) ,self.ultid_status_private   := if(right.ultid  != 0  ,right.ultid_status_private   ,BIPV2_PostProcess.constants.Inactive_NoActivity),self := left) ,left outer,hash,keep(1));
  
    ds_join_proxid_public       := join(ds_join_ultid_private  ,ds_proxid_slim_public   ,left.proxid = right.proxid ,transform(recordof(left) ,self.proxid_status_public   := if(right.proxid != 0  ,right.proxid_status_public   ,BIPV2_PostProcess.constants.Inactive_NoActivity),self := left) ,left outer,hash,keep(1));
    ds_join_powid_public        := join(ds_join_proxid_public  ,ds_powid_slim_public    ,left.powid  = right.powid  ,transform(recordof(left) ,self.powid_status_public    := if(right.powid  != 0  ,right.powid_status_public    ,BIPV2_PostProcess.constants.Inactive_NoActivity),self := left) ,left outer,hash,keep(1));
    ds_join_seleid_public       := join(ds_join_powid_public   ,ds_seleid_slim_public   ,left.seleid = right.seleid ,transform(recordof(left) ,self.seleid_status_public   := if(right.seleid != 0  ,right.seleid_status_public   ,BIPV2_PostProcess.constants.Inactive_NoActivity),self := left) ,left outer,hash,keep(1));
    ds_join_orgid_public        := join(ds_join_seleid_public  ,ds_orgid_slim_public    ,left.orgid  = right.orgid  ,transform(recordof(left) ,self.orgid_status_public    := if(right.orgid  != 0  ,right.orgid_status_public    ,BIPV2_PostProcess.constants.Inactive_NoActivity),self := left) ,left outer,hash,keep(1));
    export ds_join_ultid_public := join(ds_join_orgid_public   ,ds_ultid_slim_public    ,left.ultid  = right.ultid  ,transform(recordof(left) ,self.ultid_status_public    := if(right.ultid  != 0  ,right.ultid_status_public    ,BIPV2_PostProcess.constants.Inactive_NoActivity),self := left) ,left outer,hash,keep(1))
     : persist('~persist::BIPV2_PostProcess::proc_segmentation.ds_join_ultid_public' + pGoldOutputModifier);
    // -- since i am now using the full file to set the status, don't need to join the dirty file back to the clean file to append status.
    // export ds_join_ultid_public := ds_set_status_ultid_public;

    // ------------------------------------------------------------------
    // -- Begin Use for speedy test purposes, only do proxid and seleid
    // ------------------------------------------------------------------
    lrec_test := {ds_Input_clean.seleid  ,ds_Input_clean.proxid,ds_Input_clean.ultid,ds_Input_clean.orgid,ds_Input_clean.powid ,ds_Input_clean.source  ,ds_Input_clean.company_status_derived  ,ds_Input_clean.dt_first_seen ,ds_Input_clean.dt_last_seen  ,ds_Input_clean.dt_vendor_first_reported  ,ds_Input_clean.dt_vendor_last_reported       };
    ds_set_status_prep_test  :=   table(ds_Input_clean  ,lrec_test  ,seleid    ,proxid  ,source    ,company_status_derived    ,dt_first_seen   ,dt_last_seen    ,dt_vendor_first_reported    ,dt_vendor_last_reported   ,merge);

    ds_set_status_proxid_private_test := BIPV2_Tools.mac_Set_Statuses(ds_set_status_prep_test             ,proxid ,proxid_status_private  ,true ,,,pToday);
    ds_set_status_seleid_private_test := BIPV2_Tools.mac_Set_Statuses(ds_set_status_proxid_private_test   ,seleid ,seleid_status_private  ,true ,,,pToday);
    ds_set_status_proxid_public_test  := BIPV2_Tools.mac_Set_Statuses(ds_set_status_seleid_private_test   ,proxid ,proxid_status_public   ,false,,,pToday);
    ds_set_status_seleid_public_test1  := BIPV2_Tools.mac_Set_Statuses(ds_set_status_proxid_public_test   ,seleid ,seleid_status_public   ,false,,,pToday);
    ds_table_seleid_status            := table(ds_set_status_seleid_public_test1,{proxid,proxid_status_private,seleid_status_private,proxid_status_public,seleid_status_public},proxid,proxid_status_private,seleid_status_private,proxid_status_public,seleid_status_public,merge);
    
    shared ds_set_status_seleid_public_test := join(ds_Input_clean  
    ,ds_table_seleid_status
    ,left.proxid = right.proxid  
      ,transform(recordof(left)
        ,self.proxid_status_private  := right.proxid_status_private
        ,self.seleid_status_private  := right.seleid_status_private
        ,self.proxid_status_public   := right.proxid_status_public 
        ,self.seleid_status_public   := right.seleid_status_public 
        ,self   := left
      
      ) 
      ,keep(1),hash,left outer)
     : persist('~persist::BIPV2_PostProcess::proc_segmentation.ds_set_status_seleid_public_test' + pGoldOutputModifier);
    
    ds_proxid_slim_private_test      := table(ds_set_status_seleid_public_test  ,{proxid ,proxid_status_private}   ,proxid ,proxid_status_private,merge);//should be only 1 status per proxid
    ds_seleid_slim_private_test      := table(ds_set_status_seleid_public_test  ,{seleid ,seleid_status_private}   ,seleid ,seleid_status_private,merge);//should be only 1 status per proxid
    ds_proxid_slim_public_test       := table(ds_set_status_seleid_public_test  ,{proxid ,proxid_status_public }   ,proxid ,proxid_status_public ,merge);//should be only 1 status per proxid
    ds_seleid_slim_public_test       := table(ds_set_status_seleid_public_test  ,{seleid ,seleid_status_public }   ,seleid ,seleid_status_public ,merge);//should be only 1 status per proxid
    
    ds_join_proxid_private_test      := join(pInputDirty                  ,ds_proxid_slim_private_test  ,left.proxid = right.proxid ,transform(recordof(left) ,self.proxid_status_private  := if(right.proxid != 0  ,right.proxid_status_private  ,BIPV2_PostProcess.constants.Inactive_NoActivity),self := left) ,left outer,hash,keep(1));
    ds_join_seleid_private_test      := join(ds_join_proxid_private_test  ,ds_seleid_slim_private_test  ,left.seleid = right.seleid ,transform(recordof(left) ,self.seleid_status_private  := if(right.seleid != 0  ,right.seleid_status_private  ,BIPV2_PostProcess.constants.Inactive_NoActivity),self := left) ,left outer,hash,keep(1));
  
    ds_join_proxid_public_test       := join(ds_join_seleid_private_test  ,ds_proxid_slim_public_test   ,left.proxid = right.proxid ,transform(recordof(left) ,self.proxid_status_public   := if(right.proxid != 0  ,right.proxid_status_public   ,BIPV2_PostProcess.constants.Inactive_NoActivity),self := left) ,left outer,hash,keep(1));
    export ds_join_seleid_public_test       := join(ds_join_proxid_public_test   ,ds_seleid_slim_public_test   ,left.seleid = right.seleid ,transform(recordof(left) ,self.seleid_status_public   := if(right.seleid != 0  ,right.seleid_status_public   ,BIPV2_PostProcess.constants.Inactive_NoActivity),self := left) ,left outer,hash,keep(1))
     : persist('~persist::BIPV2_PostProcess::proc_segmentation.ds_join_seleid_public_test' + pGoldOutputModifier);

    BIPV2_PostProcess.macPartition(ds_set_status_seleid_public_test, ProxID, ProxFree_test, ProxProb_test)
    BIPV2_PostProcess.macPartition(ds_set_status_seleid_public_test, SELEID, SeleFree_test, SeleProb_test)
    
    // Gold Segmentation
    export modgoldSELEV2_test       := BIPV2_PostProcess.segmentation_gold(SeleFree_test,   'SELEID',pToday, 'V2'          + pGoldOutputModifier);
    export modgoldSELEV2P_test      := BIPV2_PostProcess.segmentation_gold(SeleProb_test,   'SELEID',pToday, 'V2Probation' + pGoldOutputModifier);    
    
    // Segmentation Stats
    export modProxV2_test           := BIPv2_PostProcess.segmentation(ProxFree_test, 'PROXID',pToday);
    export modProxV2P_test          := BIPv2_PostProcess.segmentation(ProxProb_test, 'PROXID',pToday);
    
    export modSeleV2_test           := BIPv2_PostProcess.segmentation(SeleFree_test, 'SELEID',pToday);
    export modSeleV2P_test          := BIPv2_PostProcess.segmentation(SeleProb_test, 'SELEID',pToday);

    export patched_test := 
    BIPV2_PostProcess.append_segtype(
       ds_join_seleid_public_test
      ,modgoldSELEV2_test._gold       + modgoldSELEV2P_test._gold
      ,dataset([],recordof(modSeleV2_test.result_w_desc   ))  
      ,dataset([],recordof(modSeleV2P_test.result_w_desc  ))
      ,dataset([],recordof(modSeleV2_test.result_w_desc   ))
      ,dataset([],recordof(modSeleV2P_test.result_w_desc  ))
      ,modSeleV2_test.result_w_desc 
      ,modSeleV2P_test.result_w_desc
      ,modProxV2_test.result_w_desc   
      ,modProxV2P_test.result_w_desc
      ,dataset([],recordof(modSeleV2_test.result_w_desc   ))  
      ,dataset([],recordof(modSeleV2P_test.result_w_desc  ))
    ).result;

    export modgoldSELEV2_test_out   := modgoldSELEV2_test.out   ;
    export modgoldSELEV2P_test_out  := modgoldSELEV2P_test.out  ; 
    export modProxV2_test_stats     := modProxV2_test.stats     ;
    export modProxV2P_test_stats    := modProxV2P_test.stats    ;
    export modSeleV2_test_stats     := modSeleV2_test.stats     ; 
    export modSeleV2P_test_stats    := modSeleV2P_test.stats    ;
    
    export ds_important_stats := dataset([
       {'Proxid' ,'Total'  ,'Actives' ,modProxV2_test_stats(trim(segtype,all) = 'TOTAL',trim(segsubtype,all) = 'Active')[1].total}
      ,{'Seleid' ,'Total'  ,'Actives' ,modSeleV2_test_stats(trim(segtype,all) = 'TOTAL',trim(segsubtype,all) = 'Active')[1].total}
      ,{'Seleid' ,'Total'  ,'Gold'    ,count(modgoldSELEV2_test._gold)}
    ],{string ID,string stat, string subtype  ,unsigned cnt});
    
    
    export prox_sele_test_stats := parallel(
       output(ds_important_stats  ,named('ds_important_stats'),extend,all)
      ,output(pToday ,named('Todays_Date_For_Calculating_Actives'),overwrite)
      ,modgoldSELEV2_test_out
      ,modgoldSELEV2P_test_out
      ,output(modProxV2_test_stats   ,named('ProxSegmentationStatsV2'          ))
      ,output(modProxV2P_test_stats  ,named('ProxSegmentationStatsV2Probation' ))
      ,output(modSeleV2_test_stats   ,named('SeleSegmentationStatsV2'          ))
      ,output(modSeleV2P_test_stats  ,named('SeleSegmentationStatsV2Probation' ))
    );


    // ------------------------------------------------------------------
    // -- End Use for speedy test purposes, only do proxid and seleid
    // ------------------------------------------------------------------


//////
    shared version  := pversion;
    shared fnames   := filenames(pversion);
    
    BIPV2_PostProcess.macPartition(pInput, ProxID, ProxFree, ProxProb)
    BIPV2_PostProcess.macPartition(pInput, POWID,  PowFree,  PowProb)
    BIPV2_PostProcess.macPartition(pInput, SELEID, SeleFree, SeleProb)
    BIPV2_PostProcess.macPartition(pInput, OrgID,  OrgFree,  OrgProb)
    BIPV2_PostProcess.macPartition(pInput, UltID,  UltFree,  UltProb)
    
    // Gold Segmentation
    export modgoldSELEV2      := BIPV2_PostProcess.segmentation_gold(SeleFree,  'SELEID',pToday, 'V2'          + pGoldOutputModifier);
    export modgoldSELEV2P     := BIPV2_PostProcess.segmentation_gold(SeleProb,  'SELEID',pToday, 'V2Probation' + pGoldOutputModifier);    
    
    export goldSELEV2         := modgoldSELEV2.out;
    export goldSELEV2P        := modgoldSELEV2P.out;
    
    // Segmentation Stats
    export modProxV2          := BIPv2_PostProcess.segmentation(ProxFree, 'PROXID',pToday);
    shared modProxV2P         := BIPv2_PostProcess.segmentation(ProxProb, 'PROXID',pToday);
    
    shared modPowV2           := BIPv2_PostProcess.segmentation(PowFree,  'POWID',pToday);
    shared modPowV2P          := BIPv2_PostProcess.segmentation(PowProb,  'POWID',pToday);
    export modSeleV2          := BIPv2_PostProcess.segmentation(SeleFree, 'SELEID',pToday);
    export modSeleV2P         := BIPv2_PostProcess.segmentation(SeleProb, 'SELEID',pToday);
    
    shared modorgV2           := BIPv2_PostProcess.segmentation(OrgFree, 'ORGID',pToday);
    shared modorgV2P          := BIPv2_PostProcess.segmentation(OrgProb, 'ORGID',pToday);
    
    shared modultV2           := BIPv2_PostProcess.segmentation(UltFree ,'ULTID',pToday);
    shared modultV2P          := BIPv2_PostProcess.segmentation(UltProb ,'ULTID',pToday);
    // -- Seg stats for residential address businesses
    shared modProxV2_res      := BIPv2_PostProcess.segmentation(ProxFree(address_type_derived = 'R')  ,'PROXID' ,pToday);   
    shared modPowV2_res       := BIPv2_PostProcess.segmentation(PowFree (address_type_derived = 'R')  ,'POWID'  ,pToday);
    shared modSeleV2_res      := BIPv2_PostProcess.segmentation(SeleFree(address_type_derived = 'R')  ,'SELEID' ,pToday);
    shared modorgV2_res       := BIPv2_PostProcess.segmentation(OrgFree (address_type_derived = 'R')  ,'ORGID'  ,pToday);
    shared modultV2_res       := BIPv2_PostProcess.segmentation(UltFree (address_type_derived = 'R')  ,'ULTID'  ,pToday);
    // -- Seg stats for business address businesses
    shared modProxV2_biz      := BIPv2_PostProcess.segmentation(ProxFree(address_type_derived = 'B')  ,'PROXID' ,pToday);   
    shared modPowV2_biz       := BIPv2_PostProcess.segmentation(PowFree (address_type_derived = 'B')  ,'POWID'  ,pToday);
    shared modSeleV2_biz      := BIPv2_PostProcess.segmentation(SeleFree(address_type_derived = 'B')  ,'SELEID' ,pToday);
    shared modorgV2_biz       := BIPv2_PostProcess.segmentation(OrgFree (address_type_derived = 'B')  ,'ORGID'  ,pToday);
    shared modultV2_biz       := BIPv2_PostProcess.segmentation(UltFree (address_type_derived = 'B')  ,'ULTID'  ,pToday);
    // Write out Result stats
    // shared createProxFile  := tools.macf_writefile(fnames.ProxidSegs.logical ,modProx.result ,,,pOverwrite);
    // shared createSeleFile  := tools.macf_writefile(fnames.SeleidSegs.logical ,modSele.result ,,,pOverwrite);
    // shared createOrgFile     := tools.macf_writefile(fnames.OrgidSegs.logical  ,modOrg.result  ,,,pOverwrite);
    // shared createUltFile     := tools.macf_writefile(fnames.UltidSegs.logical  ,modUlt.result  ,,,pOverwrite);
    // Output to workunit Seg Stats
    shared outputProxStatsV2  := output(modProxV2.stats ,named('ProxSegmentationStatsV2'));
    shared outputProxStatsV2P := output(modProxV2P.stats ,named('ProxSegmentationStatsV2Probation'));
    
    shared outputPowStatsV2   := output(modPowV2.stats  ,named('PowSegmentationStatsV2'));
    shared outputPowStatsV2P  := output(modPowV2P.stats ,named('PowSegmentationStatsV2Probation'));
    shared outputSeleStatsV2  := output(modSeleV2.stats  ,named('SeleSegmentationStatsV2'));
    shared outputSeleStatsV2P := output(modSeleV2P.stats ,named('SeleSegmentationStatsV2Probation'));
    
    shared outputOrgStatsV2   := output(modOrgV2.stats  ,named('OrgSegmentationStatsV2' ));
    shared outputOrgStatsV2P  := output(modOrgV2P.stats  ,named('OrgSegmentationStatsV2Probation' ));
    
    // shared outputUltStats    := output(modUlt.stats  ,named('UltSegmentationStats' ));
    // setup field stats and counts
    shared fieldstat          := BIPV2_PostProcess.fieldStats       (pInput                             );
    shared fieldstatHrchyGT1  := BIPV2_PostProcess.fieldStats       (pInput(nodes_total > 1), 'HrchyGT1');
    
    shared Proxstats          := BIPV2_PostProcess.fieldstats_prox  (pversion,pInput,modProxV2.result);
    shared Powstats           := BIPV2_PostProcess.fieldstats_pow   (pversion,pInput,modPowV2.result );
    shared Selestats          := BIPV2_PostProcess.fieldstats_sele  (pversion,pInput,modSeleV2.result);
    shared orgstats           := BIPV2_PostProcess.fieldstats_org   (pversion,pInput,modOrgV2.result );
    shared ultstats           := BIPV2_PostProcess.fieldstats_ult   (pversion,pInput,modUltV2.result );
    
    shared SelestatsGold      := BIPV2_PostProcess.fieldstats_sele  (pversion,pInput,pSegStats := project(modgoldSELEV2._gold,    transform(BIPV2_PostProcess.layouts.laysegmentation, self := left, self.inactive := left.inactives[1].inactive, self := [])));
    shared SelestatsNotGold   := BIPV2_PostProcess.fieldstats_sele  (pversion,pInput,pSegStats := project(modgoldSELEV2._Notgold, transform(BIPV2_PostProcess.layouts.laysegmentation, self := left, self.inactive := left.inactives[1].inactive, self := [])));
    
    
    // Output Field & Entity Stats to workunit
    shared TotalRecCount              := output(count(pInput)                       , named('TotalRecordCount'                    ));
    shared bipEntityCnt               := output(fieldstat.uniqueIDCounts            , named('EntityCount'                         ));
    shared HrchyGT1_IDCounts          := output(fieldstatHrchyGT1.uniqueIDCounts    , named('Hrchy_GT1_IDCounts'                  ));
    
    shared activeStats_prox           := output(Proxstats.active_fieldStats         , named('V2_FieldStats_Active_PROX'           ));
    shared activeStats_pow            := output(Powstats.active_fieldStats          , named('V2_FieldStats_Active_POW'            ));
    shared activeStats_sele           := output(Selestats.active_fieldStats         , named('V2_FieldStats_Active_SELE'           ));
    shared activeStats_org            := output(orgstats.active_fieldStats          , named('V2_FieldStats_Active_ORG'            ));
    shared activeStats_ult            := output(ultstats.active_fieldStats          , named('V2_FieldStats_Active_Ult'            ));
    shared activeStats_sele_Gold      := output(SelestatsGold.active_fieldStats     , named('V2_FieldStats_Active_SELE_Gold'      ));   
    shared activeStats_sele_notGold   := output(SelestatsNotGold.active_fieldStats  , named('V2_FieldStats_Active_SELE_NotGold'   ));   
    shared inactiveStats_prox         := output(Proxstats.inactive_fieldStats       , named('V2_FieldStats_Inactive_PROX'         ));
    shared inactiveStats_pow          := output(Powstats.inactive_fieldStats        , named('V2_FieldStats_Inactive_POW'          ));
    shared inactiveStats_sele         := output(Selestats.inactive_fieldStats       , named('V2_FieldStats_Inactive_SELE'         ));
    shared inactiveStats_org          := output(orgstats.inactive_fieldStats        , named('V2_FieldStats_Inactive_ORG'          ));
    shared inactiveStats_ult          := output(ultstats.inactive_fieldStats        , named('V2_FieldStats_Inactive_Ult'          ));
    shared inactiveStats_sele_Gold    := output(SelestatsGold.inactive_fieldStats   , named('V2_FieldStats_Inactive_SELE_Gold'    ));
    shared inactiveStats_sele_notGold := output(SelestatsNotGold.inactive_fieldStats, named('V2_FieldStats_Inactive_SELE_NotGold' ));
    // Counts
    shared sicCount             := output(fieldstat.sicCounts           , named('V1_ProxFile_SICDistribution'  ), all);
    shared naicsCount           := output(fieldstat.naicsCounts         , named('V1_ProxFile_NAICSDistribution'), all);
    // ID Counts
    shared IDChange             := output(BIPV2_PostProcess.fieldStats_IDcounts(pInput).change                ,named('IdChangeTable'));
    shared IDCountBuckets       := output(BIPV2_PostProcess.fieldStats_IDcounts(pInput).buckets               ,named('IDCountBuckets'));
    shared TotalProxIDsInLGID3  := output(BIPV2_PostProcess.fieldStats_IDcounts(pInput).TotalProxIDsInLGID3   ,named('TotalProxIDsInLGID3'));
    shared XTabProxIDsInLGID3   := output(BIPV2_PostProcess.fieldStats_IDcounts(pInput).XTabProxIDsInLGID3    ,named('XTabProxIDsInLGID3'));
    shared TotalProxIDsInHrchy  := output(BIPV2_PostProcess.fieldStats_IDcounts(pInput).TotalProxIDsInHrchy   ,named('TotalProxIDsInHrchy'));
    shared XTabProxIDsInHrchy   := output(BIPV2_PostProcess.fieldStats_IDcounts(pInput).XTabProxIDsInHrchy    ,named('XTabProxIDsInHrchy'));
    
    // Run build process    
    export patched := 
    BIPV2_PostProcess.append_segtype(
       ds_join_ultid_public
      ,modgoldSELEV2._gold      + modgoldSELEV2P._gold
      ,modUltV2.result_w_desc   , modUltV2P.result_w_desc
      ,modOrgV2.result_w_desc   , modOrgV2P.result_w_desc
      ,modSeleV2.result_w_desc  , modSeleV2P.result_w_desc
      ,modProxV2.result_w_desc  , modProxV2P.result_w_desc
      ,modPowV2.result_w_desc   , modPowV2P.result_w_desc
    ).result;
    
    export outputPatched := tools.macf_WriteFile(filenames(pversion).Patched.logical,patched);
    
    
// -- add active, inactive, defunct stats
  export joinsegs := sort(join(
     modProxV2.stats
    ,modSeleV2.stats
    ,   left.segtype    = right.segtype
    and left.segsubtype = right.segsubtype
    ,transform(
      {recordof(left) - total,unsigned8 total_seleids,unsigned8 total_proxids}
      ,self.total_proxids := left.total
      ,self.total_seleids := right.total
      ,self               := left
    )
    ,full outer
  ),segtype,segsubtype);
  
  export joinsegs2 := sort(join(
     joinsegs
    ,modOrgV2.stats
    ,   left.segtype    = right.segtype
    and left.segsubtype = right.segsubtype
    ,transform(
      {recordof(left),unsigned8 total_orgids}
      ,self.total_orgids := right.total
      ,self              := left
    )
    ,full outer
  ),segtype,segsubtype);
  export joinsegs3 := sort(join(
     joinsegs2
    ,modPowV2.stats
    ,   left.segtype    = right.segtype
    and left.segsubtype = right.segsubtype
    ,transform(
      {recordof(left),unsigned8 total_Powids}
      ,self.total_Powids := right.total
      ,self              := left
    )
    ,full outer
  ),segtype,segsubtype);
  
  export joinsegs4 := sort(join(
     joinsegs3
    ,modUltV2.stats
    ,   left.segtype    = right.segtype
    and left.segsubtype = right.segsubtype
    ,transform(
      {recordof(left),unsigned8 total_Ultids}
      ,self.total_Ultids := right.total
      ,self              := left
    )
    ,full outer
  ),segtype,segsubtype);
  export segs_fixed := project(joinsegs4 ,transform(
    {recordof(left) - segsubtype}
    ,self.segtype := map( trim(left.segtype,all) = 'TOTAL'     and trim(left.segsubtype,all) = 'Active'           => 'Total Active'
                         ,trim(left.segtype,all) = 'INACTIVE'  and trim(left.segsubtype,all) = 'NoActivity'       => 'Total Inactive'
                         ,trim(left.segtype,all) = 'INACTIVE'  and trim(left.segsubtype,all) = 'ReportedInactive' => 'Total Defunct'
                         ,''
                     );
    ,self := left
  ));
  export segs_fixed_filtered := segs_fixed(segtype != '');
  export output_segs_fixed_filtered := output(segs_fixed_filtered ,named('AllSegStatsV2' + pGoldOutputModifier));
  
  export bip_2_2_status_per_id      := BIPV2_PostProcess.mac_Status_Per_ID(modProxV2.stats    ,modPowV2.stats    ,modSeleV2.stats    ,modOrgV2.stats    ,modUltV2.stats     );
  export bip_2_2_status_per_id_res  := BIPV2_PostProcess.mac_Status_Per_ID(modProxV2_res.stats,modPowV2_res.stats,modSeleV2_res.stats,modOrgV2_res.stats,modUltV2_res.stats );
  export bip_2_2_status_per_id_biz  := BIPV2_PostProcess.mac_Status_Per_ID(modProxV2_biz.stats,modPowV2_biz.stats,modSeleV2_biz.stats,modOrgV2_biz.stats,modUltV2_biz.stats );
  
  export bip_2_2_status_per_id_all  := sort(
    table(bip_2_2_status_per_id     ,{status,BIP_ID,string address_type := 'All'         ,countgroup,cnt})
  + table(bip_2_2_status_per_id_res ,{status,BIP_ID,string address_type := 'Residential' ,countgroup,cnt})
  + table(bip_2_2_status_per_id_biz ,{status,BIP_ID,string address_type := 'Business'    ,countgroup,cnt})
  ,status,bip_id,address_type);
   
// -- add active, inactive, defunct stats
  //////////////// ---------------------
  import strata,bipv2_build;
  export lay_id_change    := recordof(BIPV2_PostProcess.fieldStats_IDcounts(pInput).change );   
  export lay_id_count     := recordof(BIPV2_PostProcess.fieldStats_IDcounts(pInput).buckets);   
  export lay_seg_stats    := recordof(modProxV2.stats                                      );                  
  
  export do_strata(
     string                       pversion              = bipv2.KeySuffix
    ,dataset(lay_id_change    )   pIDChange             = BIPV2_PostProcess.fieldStats_IDcounts(pInput).change  
    ,dataset(lay_id_count     )   pIDCountBuckets       = BIPV2_PostProcess.fieldStats_IDcounts(pInput).buckets 
    // ,dataset(lay_entity_count )   pbipEntityCnt          = fieldstat.uniqueIDCounts      //this is included in the idcount buckets                       
    ,dataset(lay_seg_stats    )   pProxStatsV2          = modProxV2.stats                                       
    ,dataset(lay_seg_stats    )   pProxStatsV2_res      = modProxV2_res.stats                                       
    ,dataset(lay_seg_stats    )   pProxStatsV2_biz      = modProxV2_biz.stats                                       
    ,dataset(lay_seg_stats    )   pProxStatsV2P         = modProxV2P.stats                                      
    ,dataset(lay_seg_stats    )   pSeleStatsV2          = modSeleV2.stats                                       
    ,dataset(lay_seg_stats    )   pSeleStatsV2_res      = modSeleV2_res.stats                                       
    ,dataset(lay_seg_stats    )   pSeleStatsV2_biz      = modSeleV2_biz.stats  
    ,dataset(lay_seg_stats    )   pSeleStatsV2P         = modSeleV2P.stats                                      
    ,dataset(lay_seg_stats    )   pPowStatsV2           = modPowV2.stats                                       
    ,dataset(lay_seg_stats    )   pPowStatsV2_res       = modPowV2_res.stats                                       
    ,dataset(lay_seg_stats    )   pPowStatsV2_biz       = modPowV2_biz.stats                                       
    ,dataset(lay_seg_stats    )   pOrgStatsV2           = modOrgV2.stats                                       
    ,dataset(lay_seg_stats    )   pOrgStatsV2_res       = modOrgV2_res.stats                                       
    ,dataset(lay_seg_stats    )   pOrgStatsV2_biz       = modOrgV2_biz.stats                                       
    
    ,dataset(lay_seg_stats    )   pUltStatsV2           = modUltV2.stats                                       
    ,dataset(lay_seg_stats    )   pUltStatsV2_res       = modUltV2_res.stats                                       
    ,dataset(lay_seg_stats    )   pUltStatsV2_biz       = modUltV2_biz.stats                                       
    ,boolean                      pIsTesting            = false
    ,boolean                      pOverwrite            = false
  ) := 
  function
       // IDChange            := output(BIPV2_PostProcess.fieldStats_IDcounts(pInput).change    ,named('IdChangeTable'  ));
    // IDCountBuckets       := output(BIPV2_PostProcess.fieldStats_IDcounts(pInput).buckets   ,named('IDCountBuckets' ));
    // bipEntityCnt       := output(fieldstat.uniqueIDCounts                                ,named('EntityCount'    ));
    // outputProxStatsV2    := output(modProxV2.stats                                         ,named('ProxSegmentationStatsV2'));
    // outputProxStatsV2P := output(modProxV2P.stats                                        ,named('ProxSegmentationStatsV2Probation'));
    // outputSeleStatsV2 := output(modSeleV2.stats                                         ,named('SeleSegmentationStatsV2'));
    // outputSeleStatsV2P := output(modSeleV2P.stats                                        ,named('SeleSegmentationStatsV2Probation'));
    lay_id_change_int := 
    record
      string   idtype           ;
      unsigned countGroup       ;
      unsigned pct_measured     ;
      unsigned pct_sameIDs      ;
      unsigned pct_sameUltIDs   ;
      unsigned pct_sameOrgIDs   ;
      unsigned pct_sameSELEIDs  ;
      unsigned pct_sameProxIDs  ;
      unsigned pct_samePOWIDs   ;
      unsigned pct_sameEmpIDs   ;
    end;
    
    //multiply *100 to take reals to integers with two places.  this way, can keep each stat and not worry about being different scales
    ds_IDChange := project(pIDChange  ,transform(lay_id_change_int
      ,self.countGroup       := 10000
      ,self.pct_measured     := (unsigned)(left.pct_measured     * 100)
      ,self.pct_sameIDs      := (unsigned)(left.pct_sameIDs      * 100)
      ,self.pct_sameUltIDs   := (unsigned)(left.pct_sameUltIDs   * 100)
      ,self.pct_sameOrgIDs   := (unsigned)(left.pct_sameOrgIDs   * 100)
      ,self.pct_sameSELEIDs  := (unsigned)(left.pct_sameSELEIDs  * 100)
      ,self.pct_sameProxIDs  := (unsigned)(left.pct_sameProxIDs  * 100)
      ,self.pct_samePOWIDs   := (unsigned)(left.pct_samePOWIDs   * 100)
      ,self.pct_sameEmpIDs   := (unsigned)(left.pct_sameEmpIDs   * 100)
      ,self := left));
    
    lay_id_counts := record
      string    BIP_ID                        ;
      unsigned  countGroup       ;
      unsigned6 average_count             ;
      unsigned6 median_count              ;  
      unsigned6 max_count                 ;
      // unsigned6 total_count               ; 
      unsigned6 total_IDs                 ;
      unsigned6 sum_buckets               ; 
      unsigned6 count_1                   ;
      unsigned6 count_2_to_4              ; 
      unsigned6 count_5_to_19             ;
      unsigned6 count_20_to_49            ; 
      unsigned6 count_50_to_99            ;
      unsigned6 count_100_to_249          ; 
      unsigned6 count_250_to_999          ;
      unsigned6 count_1000_to_9999        ; 
      unsigned6 count_10000_to_99999      ;
      unsigned6 count_100000_to_999999    ; 
      unsigned6 count_1000000_plus        ;
    end;   
    
    ds_idcounts := project(pIDCountBuckets  ,transform(lay_id_counts,self.average_count := (unsigned)(left.average_count * 100.0),self.countGroup := left.total_count,self.BIP_ID := left.id,self := left));
    
    // ----- prox seg v2 stats
    joinProxV2 := sort(join(pProxStatsV2  ,pProxStatsV2P  ,left.segtype = right.segtype and left.segsubtype = right.segsubtype  ,transform({string segtype,string segsubtype,unsigned countGroup,unsigned Regular,unsigned Probation}
      ,self.countGroup    := left.total + right.total
      ,self.Regular       := left.total
      ,self.Probation     := right.total
      ,self.segtype       := trim(left.segtype    ,all)
      ,self.segsubtype    := trim(left.segsubtype ,all)
    ),full outer),segtype,segsubtype);
          
    // ----- Sele seg v2 stats
    joinSeleV2 := sort(join(pSeleStatsV2  ,pSeleStatsV2P  ,left.segtype = right.segtype and left.segsubtype = right.segsubtype  ,transform({string segtype,string segsubtype,unsigned countGroup,unsigned Regular,unsigned Probation}
      ,self.countGroup    := left.total + right.total
      ,self.Regular       := left.total
      ,self.Probation     := right.total
      ,self.segtype       := trim(left.segtype    ,all)
      ,self.segsubtype    := trim(left.segsubtype ,all)
    ),full outer),segtype,segsubtype);
    
    
    // -- BIP 2.2 stats, status per ID of businesses with residential addresses
    bip_22_status_per_id      := BIPV2_PostProcess.mac_Status_Per_ID(pProxStatsV2    ,pPowStatsV2    ,pSeleStatsV2    ,pOrgStatsV2    ,pUltStatsV2     );
    bip_22_status_per_id_res  := BIPV2_PostProcess.mac_Status_Per_ID(pProxStatsV2_res,pPowStatsV2_res,pSeleStatsV2_res,pOrgStatsV2_res,pUltStatsV2_res );
    bip_22_status_per_id_biz  := BIPV2_PostProcess.mac_Status_Per_ID(pProxStatsV2_biz,pPowStatsV2_biz,pSeleStatsV2_biz,pOrgStatsV2_biz,pUltStatsV2_biz );
  
    bip_2_2_status  := sort(
      table(bip_22_status_per_id     ,{status,BIP_ID,string address_type := 'All'         ,countgroup,cnt})
    + table(bip_22_status_per_id_res ,{status,BIP_ID,string address_type := 'Residential' ,countgroup,cnt})
    + table(bip_22_status_per_id_biz ,{status,BIP_ID,string address_type := 'Business'    ,countgroup,cnt})
    ,status,bip_id,address_type);
    return parallel(
    
       Strata.macf_CreateXMLStats(ds_IDChange   ,'BIPV2','Segmentation' ,pversion ,BIPV2_Build.mod_email.emailList  ,'Change'           ,'ID'             ,pIsTesting,pOverwrite) //group on idtype
      ,Strata.macf_CreateXMLStats(ds_idcounts   ,'BIPV2','Segmentation' ,pversion ,BIPV2_Build.mod_email.emailList  ,'BucketCounts'     ,'ID'             ,pIsTesting,pOverwrite) //group on BIP_ID
      ,Strata.macf_CreateXMLStats(joinProxV2    ,'BIPV2','Segmentation' ,pversion ,BIPV2_Build.mod_email.emailList  ,'StatsV2'          ,'Proxid'         ,pIsTesting,pOverwrite) //group on segtype,segsubtype
      ,Strata.macf_CreateXMLStats(joinSeleV2    ,'BIPV2','Segmentation' ,pversion ,BIPV2_Build.mod_email.emailList  ,'StatsV2'          ,'Seleid'         ,pIsTesting,pOverwrite) //group on segtype,segsubtype
      ,Strata.macf_CreateXMLStats(bip_2_2_status,'BIPV2','2.2'          ,pversion ,BIPV2_Build.mod_email.emailList  ,'at_address_type'  ,'business_status',pIsTesting,pOverwrite);//group on status, BIP_ID,address_type
      
    );
  
  end;
  //////////////// ---------------------
  // -- executive stats email to paul
  ds_seg_stats          := segs_fixed_filtered;
  ds_id_counts          := strata.macf_Uniques(pInput ,,,false,['proxid','powid','lgid3','seleid','orgid','ultid']);
  ds_total_record_count := count(pInput);
  ds_new_record_count   := count(pInput(ingest_status = 'New'));
  
  ds_id_counts_prep     := dataset([{'Total',sum(ds_seg_stats,total_seleids),sum(ds_seg_stats,total_proxids),sum(ds_seg_stats,total_orgids),sum(ds_seg_stats,total_powids),sum(ds_seg_stats,total_ultids)}]  ,recordof(ds_seg_stats));
  ds_workman := BIPV2_Build.files().workunit_history.qa;
  // output(ds_workman(version = pversion),all);
  ds_filt_dot  := ds_workman(version = pversion ,state = 'completed'  ,regexfind('^BIPV2_DOTID .*? iter .*$' ,name,nocase)  );
  ds_filt_prox := ds_workman(version = pversion ,state = 'completed'  ,regexfind('^BIPV2_proxid .*? iter .*$',name,nocase)  );

  import wk_ut;
  ds_dot := project(ds_filt_dot,transform({string wuid,unsigned cleaves}
    ,self.cleaves := (unsigned)wk_ut.get_Scalar_Result(left.wuid,'DOTidsCreatedByCleave')
    ,self := left
  ));
  ds_prox := project(ds_filt_prox,transform({string wuid,unsigned cleaves,unsigned slices}
    ,self.cleaves := (unsigned)wk_ut.get_Scalar_Result(left.wuid,'ProxidsCreatedByCleave' )
    ,self.slices  := (unsigned)wk_ut.get_Scalar_Result(left.wuid,'SlicesPerformed'        )
    ,self         := left
  ));
  ds_overlink_splits     := dataset([{'Overlink Splits',0,sum(ds_prox,cleaves) + sum(ds_prox,slices),0,0,0}]  ,recordof(ds_seg_stats));

  ds_to_attach := ds_seg_stats & ds_id_counts_prep & ds_overlink_splits; 
  
    // -- Send the stat dataset as an attachment to David for the newsletter
  export email_executive_dashboard := sequential(
   apply(global(ds_filt_dot + ds_filt_prox,few)  ,output(wk_ut.Restore_Workunit(wuid,esp),named('restoring_wuids'),extend) )
    ,tools.Send_Email_CSV_Attachment(
     ds_to_attach                                           // dataset to attach to email.  please no non-printable characters or quotes, etc.  mostly this should be stats
    ,'BIPV2 Executive Dashboard for Sprint ' + BIPV2.KeySuffix_mod2.SprintNumber(pversion) + ' version '   // Email subject.  the version will be added to this(if not blank).
    ,  'Attached is the spreadsheet with segmentation stats and ID counts for sprint ' + BIPV2.KeySuffix_mod2.SprintNumber(pversion) + '\r\n'                    // Email Body.  The workunit will be automatically added.
     + 'Total Record Count\t: ' + ut.fIntWithCommas(ds_total_record_count) + '\r\n'
     + 'Total new records\t: '  + ut.fIntWithCommas(ds_new_record_count  )
    ,'bipv2_executive_dashboard_sprint_' + BIPV2.KeySuffix_mod2.SprintNumber(pversion) + '_' + pversion + '.csv'       // Email Attachment Filename.
    ,BIPV2_Build.mod_email.emailList //'laverne.bentley@lexisnexis.com'                                      // List of email recipients
    ,pversion                                         // version of stats.  this is optional
  ));

  // --------------------------------
    export run := sequential(
      parallel( 
         output(pToday                                      ,named('IngestDate'   ))
        ,output(pversion                                    ,named('BuildDate'    ))
        ,output(BIPV2.KeySuffix_mod2.MostRecentSprintNumber ,named('SprintNumber' ))
        , output_segs_fixed_filtered
        , email_executive_dashboard
        , goldSELEV2
        , goldSELEV2P
        
        , outputProxStatsV2 
        , outputProxStatsV2P
        , outputPowStatsV2  
        , outputPowStatsV2P
        , outputSeleStatsV2 
        , outputSeleStatsV2P
        
        , outputOrgStatsV2 
        , outputOrgStatsV2P
        
        , bipEntityCnt 
        , HrchyGT1_IDCounts
        , TotalRecCount
        , activeStats_prox          ,inactiveStats_prox
        , activeStats_pow           ,inactiveStats_pow
        , activeStats_sele          ,inactiveStats_sele
        , activeStats_org           ,inactiveStats_org
        , activeStats_ult           ,inactiveStats_ult
        , activeStats_sele_Gold     ,inactiveStats_sele_Gold
        , activeStats_sele_notGold  ,inactiveStats_sele_notGold
        , sicCount         ,naicsCount
        , IDChange
        , IDCountBuckets
        , TotalProxIDsInLGID3,XTabProxIDsInLGID3
        , TotalProxIDsInHrchy,XTabProxIDsInHrchy
        ,if(pTurnOffStrata  = false ,do_strata())
        // ,outputPatched
      )
      ,promote(pversion).new2built
      // ,if(pPromote2QA = true  ,Promote(pversion).Built2QA)
    ) : 
     SUCCESS(send_emails(pversion).buildsuccess) 
    ,FAILURE(send_emails(pversion).buildfailure)
    ;
end;
