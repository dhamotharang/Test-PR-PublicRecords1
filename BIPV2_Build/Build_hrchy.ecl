import BIPv2_HRCHY, BIPV2_Files, DCAV2, DNB_DMI, Frandx,tools,BIPV2, BIPV2_PROXID, BIPV2_Blocklink,wk_ut,BIPV2_Tools;
// Preprocess
export build_hrchy(
   string                                           pversion    = BIPV2.KeySuffix
  ,dataset(BIPV2_Files.layout_proxid)               head        = BIPV2_Files.files_proxid().DS_PROXID_BUILT
  ,dataset(DCAV2.layouts.Base.companies)            lncad       = BIPV2_Files.files_hrchy.lnca              
  ,dataset(recordof(BIPV2_Files.files_hrchy.duns))  dunsd       = BIPV2_Files.files_hrchy.duns          
  ,dataset(Frandx.layouts.Base)                     frand       = BIPV2_Files.files_hrchy.fran
  ,boolean                                          pPromote2qa = true
  ,string                                           headstring  = BIPV2_Files.files_proxid().FILE_PROXID_BUILT
  ,boolean                                          pIsTesting  = false
  
) := module
    /* ---------------------- Linking --------------------------------*/ 
    
    shared DATASET(BIPV2_Files.layout_proxid) ResetSomeLgid3(DATASET(BIPV2_Files.layout_proxid) ds) := FUNCTION
      ds_lgid:=BIPV2_Blocklink.ManualOverlinksProxID.lgid_to_reset;
      ds_sele:=BIPV2_Blocklink.ManualOverlinksLGID3.sele_to_reset;
      ds_all:=ds_lgid+ds_sele;
      ds_f:=dedup(ds_all,orgid,all);
      ds_f1:=join(BIPV2.CommonBase.ds_base, ds_f, left.orgid=right.orgid, transform({unsigned6 lgid3}, self.lgid3:=left.lgid3),lookup);
      ds_f2:=dedup(ds_f1,lgid3,all);
      JJ:=join(ds,ds_f2,left.lgid3=right.lgid3, transform(BIPV2_Files.layout_proxid,
              self.lgid3 :=if(left.lgid3=right.lgid3, 0, left.lgid3);
              self :=left), left outer, lookup);
      return JJ;
    END;

    shared head1:=ResetSomeLgid3(head);
    
    shared _build     := BIPv2_HRCHY.mod_Build(head1, lncad, dunsd, frand);
    export Linking    := output(_build.PatchedFile,, BIPv2_HRCHY.filenames(pversion).base.logical, update, compressed);
    
    shared kys        := BIPv2_HRCHY.Keys(pversion,pLgidTable := _build.lgidtable);
    export KeyProxID  := tools.macf_WriteIndex('kys.HrchyProxid.logical');
    export KeyLGID    := tools.macf_WriteIndex('kys.HrchyLgid.logical'  );
    
    /* ---------------------- Superfile --------------------------------*/
    export promote2built    := BIPv2_HRCHY.Promote(pversion).new2built;
    export lpromote2QA      := BIPv2_HRCHY.Promote(pversion).built2QA;
    
    /* ---------------------- Indexes?? --------------------------------*/
      
    /* ---------------------- Other?? --------------------------------*/
    
    
    /* ---------------------- Build All --------------------------------*/
    export DoBuild          := parallel(linking, KeyProxID, KeyLGID);
    export DoSuperFileMoves := parallel(promote2built);
    shared patched1_ddp     := dedup(_build.PatchedFile, proxid, all);
    export DoStats := 
    parallel(
       output(count(_build.PatchedFile(has_lgid))                     , named('count_records_has_lgid'))
      ,output(count(dedup(_build.PatchedFile(has_lgid), proxid, all)) , named('count_proxids_has_lgid'))
    
      ,output(count(patched1_ddp(has_lgid))                           , named('count_hrchy_proxids_has_lgid'))
      ,output(count(patched1_ddp(is_ult_level))                       , named('count_hrchy_proxids_is_ult_level'))
      ,output(count(patched1_ddp(is_org_level))                       , named('count_hrchy_proxids_is_org_level'))
      ,output(count(patched1_ddp(is_sele_level))                      , named('count_hrchy_proxids_is_sele_level'))
      ,output(count(patched1_ddp(parent_proxid > 0))                  , named('count_hrchy_proxids_has_parent_proxid'))
      ,output(sum(patched1_ddp(is_ult_level), nodes_total)            , named('sum_hrchy_total_nodes'))                 
      ,output(choosen(patched1_ddp(is_sele_level and proxid <> sele_proxid), 100), named('sample_hrchy_sele_proxid_disagree_with_is_sele'))
      ,output(count(patched1_ddp(is_sele_level and proxid <> sele_proxid)), named('count_hrchy_sele_proxid_disagree_with_is_sele'))
      ,output(count(dedup(patched1_ddp, ultid, all))                      , named('count_hrchy_UltIDs'))
      ,output(count(dedup(patched1_ddp, orgid, all))                      , named('count_hrchy_OrgIDs'))
      ,output(count(dedup(patched1_ddp, SELEID, all))                     , named('count_hrchy_SELEIDs'))
      
      ,output(count(dedup(patched1_ddp(ultid = orgid), ultid, all))       , named('count_hrchy_UltIDs_contain_matching_OrgID'))//should match 3 counts directly above
      ,output(count(dedup(patched1_ddp(orgid = SELEID), orgid, all))      , named('count_hrchy_OrgIDs_contain_matching_SELEID'))
      ,output(count(dedup(patched1_ddp(SELEID = proxid), SELEID, all))    , named('count_hrchy_SELEIDs_contain_matching_ProxID'))           
      
    );
    
    shared doQAPromotion := if(pPromote2qa = true  ,lpromote2QA);
    
    import BIPV2_Strata,strata,linkingtools,BIPV2_QA_Tool;

    /* ---------------------- Proxid Persistence Stats --------------------------------*/
    shared ds_proxid_persistence_stats                := BIPV2_Strata.PersistenceStats(BIPV2_Files.files_proxid().DS_PROXID_BUILT, BIPV2.CommonBase.DS_BASE,rcid,proxid) : independent;
    shared QA_Tool_Proxid_persistence_record_stats    := BIPV2_QA_Tool.mac_persistence_records_stats(ds_proxid_persistence_stats ,'Proxid' ,pversion);
    shared QA_Tool_Proxid_persistence_cluster_stats   := BIPV2_QA_Tool.mac_persistence_cluster_stats(ds_proxid_persistence_stats ,'Proxid' ,pversion);

    /* ---------------------- Strata Quick ID Check --------------------------------*/
    export dostrata_ID_Check(boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(head1,'Hrchy','Infile',pversion,pIsTesting);
    
    /* ---------------------- Copy Intermediate file to Storage Thor --------------------------------*/
    export kick_copy2_storage_thor := BIPV2_Tools.Copy2_Storage_Thor('~' + nothor(std.file.superfilecontents(headstring)[1].name),pversion,'Build_hrchy');

    export runIter := 
      sequential(
       if(pIsTesting = false,sequential(
          BIPV2_Proxid._TraceBackKeys(pversion).out
         ,output('finished proxid key and super files')
         ,dostrata_ID_Check()
         ,Strata.macf_CreateXMLStats(ds_proxid_persistence_stats ,'BIPV2','Persistence' ,BIPV2.KeySuffix,BIPV2_Build.mod_email.emailList,'PROXID','Stats',false,false) //group on cluster_type, stat_desc
         ,QA_Tool_Proxid_persistence_record_stats 
         ,QA_Tool_Proxid_persistence_cluster_stats
         ,output('finished strata')
      ))
      ,parallel(DoBuild, DoStats)
      ,output('finished DoBuild and DoStats')
      , DoSuperFileMoves
      ,output('finished DoSuperFileMoves')
      , doQAPromotion
      ,output('finished doQAPromotion')     
      , BIPV2_Blocklink.ManualOverlinksProxID.removeLgidCandidate()
      ,output('finished proxblocklink cleanup') 
      ,BIPV2_Blocklink.ManualOverlinksLGID3.removeSeleCandidate()
      ,output('finished Lgid3blocklink cleanup')
       ,if(not wk_ut._constants.IsDev and pIsTesting = false,output(kick_copy2_storage_thor ,named('copy2_Storage_Thor__html')))  //copy orig file to storage thor      
      
      ) 
    : 
      SUCCESS(mod_email.SendSuccessEmail(,'BIPv2', , 'HRCHY')), 
      FAILURE(mod_email.SendFailureEmail(,'BIPv2', failmessage, 'HRCHY'));
end;
