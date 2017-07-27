import BIPv2_HRCHY, BIPV2_Files, DCAV2, DNB_DMI, Frandx,tools,BIPV2;
// Preprocess
export build_hrchy(
   string                                           pversion    = BIPV2.KeySuffix
  ,dataset(BIPV2_Files.layout_proxid) 							head        = BIPV2_Files.files_proxid().DS_PROXID_BUILT
	,dataset(DCAV2.layouts.Base.companies) 					  lncad       = BIPV2_Files.files_hrchy.lnca							
	,dataset(recordof(BIPV2_Files.files_hrchy.duns))  dunsd       = BIPV2_Files.files_hrchy.duns					
	,dataset(Frandx.layouts.Base)										  frand       = BIPV2_Files.files_hrchy.fran
  ,boolean                                          pPromote2qa = true
  
) := module
		/* ---------------------- Linking --------------------------------*/
		shared _build			:= BIPv2_HRCHY.mod_Build(head, lncad, dunsd, frand);
		export Linking 		:= output(_build.PatchedFile,, BIPv2_HRCHY.filenames(pversion).base.logical, update, compressed);
    
    shared kys        := BIPv2_HRCHY.Keys(pversion,pLgidTable := _build.lgidtable);
		export KeyProxID 	:= tools.macf_WriteIndex('kys.HrchyProxid.logical');
		export KeyLGID 	  := tools.macf_WriteIndex('kys.HrchyLgid.logical'  );
		
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
    
    /* ---------------------- Strata Quick ID Check --------------------------------*/
    import BIPV2_Strata,strata;
    export dostrata_ID_Check(boolean pIsTesting = false) := BIPV2_Strata.mac_BIP_ID_Check(head,'Hrchy','Infile',pversion,pIsTesting);
    
		export runIter := 
			sequential(dostrata_ID_Check(), parallel(DoBuild, DoStats), DoSuperFileMoves, doQAPromotion) 
		: 
			SUCCESS(mod_email.SendSuccessEmail(,'BIPv2', , 'HRCHY')), 
			FAILURE(mod_email.SendFailureEmail(,'BIPv2', failmessage, 'HRCHY'));
end;
