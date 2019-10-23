IMPORT wk_ut, _Control,idl_header,InsuranceHeader, insuranceheader_preprocess, InsuranceHeader_PostProcess, InsuranceHeader_Salt_T46,InsuranceHeader_Incremental,InsuranceHeader_Ingest;

export proc_postHeaderBuilds(pversion = 'InsuranceHeaderPost', doPromoteToQA = FALSE) := functionmacro;
		version			:= pversion;
		cluster			:= InsuranceHeader.proc_Constants.cluster;
		clusterFCRA := InsuranceHeader.proc_Constants.clusterFCRA;
		pollingFreq	:= InsuranceHeader.proc_Constants.pollingFreq;
		emailList := InsuranceHeader.proc_Constants.emailList;
		
		// set to TRUE for debugging generated ECL
		outECL := InsuranceHeader.proc_Constants.outECL;
		
		//Chunky2Slender
		slender_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_slender \' + pversion);\n InsuranceHeader.proc_Slender_Master(pversion);\n';
		slender := wk_ut.mac_ChainWuids(slender_ECL, 1, 1, version,['affectedDids','resultsCnt'], cluster, pOutputEcl := outECL, pUniqueOutput := 'slender', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::slender', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::slender::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);
		
    // Address Hierarchy
		addrHier_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_addrHier \' + pversion);\n InsuranceHeader.proc_addrHier_Master(pversion);\n';
		addrHier := wk_ut.mac_ChainWuids(addrHier_ECL, 1, 1, version,['PreClusterCount','PostClusterCount','MatchesPerformed'] , cluster, pOutputEcl := outECL, pUniqueOutput := 'addrHier', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::addrHier', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::addrHier::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);
    
	 // Create insurance header file
		post0_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_postprocess \' + pversion);\n InsuranceHeader.proc_post0_Master(pversion);\n';
		post0	:= wk_ut.mac_ChainWuids(post0_ECL, 1, 1, version, ,cluster, pOutputEcl := outECL, pUniqueOutput := 'post0', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::post0', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::post0::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);

		// Generate Stats
		stats_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_stats \' + pversion);\n InsuranceHeader.proc_stats_Master(pversion);\n';
		stats := wk_ut.mac_ChainWuids(stats_ECL, 1, 1, version,, cluster, pOutputEcl := outECL, pUniqueOutput := 'stats', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::stats', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::stats::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);

		// DID RID File 
		didRid_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_RidDidFile \' + pversion);\n InsuranceHeader.proc_didrid_Master(pversion);\n';
		didRid := wk_ut.mac_ChainWuids(didRid_ECL, 1, 1, version, , cluster, pOutputEcl := outECL, pUniqueOutput := 'didRid', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::didRid', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::didRid::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);
		
		// Cluster Health Indicator
		chi_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_chi \' + pversion);\n InsuranceHeader.proc_chi_Master(pversion);\n';
		chi := wk_ut.mac_ChainWuids(chi_ECL, 1, 1, version,, cluster, pOutputEcl := outECL, pUniqueOutput := 'chi', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::chi', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::chi::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);

		// Segmentation/CoreCheck
		segmentation_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_segmentation \' + pversion);\n InsuranceHeader.proc_segmentation_Master(pversion);\n';
		segmentation := wk_ut.mac_ChainWuids(segmentation_ECL, 1, 1, version,, cluster, pOutputEcl := outECL, pUniqueOutput := 'segmentation', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::segmentation', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::segmentation::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);
		
    // relatives
		relatives_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_relatives \' + pversion);\n InsuranceHeader.proc_relatives_Master(pversion);\n';
		relatives := wk_ut.mac_ChainWuids(relatives_ECL, 1, 1, version, , cluster, pOutputEcl := outECL, pUniqueOutput := 'relatives', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::relatives', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::relatives::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);

		// FCRA Header
		fcra_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_fcra \' + pversion);\n InsuranceHeader.proc_fcra_Master(pversion);\n';
		fcra := wk_ut.mac_ChainWuids(fcra_ECL, 1, 1, version,, clusterFCRA, pOutputEcl := outECL, pUniqueOutput := 'fcra', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::fcra', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::fcra::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);
		
		// Xlink specificities keys
		xLink_spec_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_xlink_specificities\' + pversion);\n InsuranceHeader.proc_xlink_specificities(pversion);\n';
		xLinkSpec := wk_ut.mac_ChainWuids(xLink_spec_ECL, 1, 1, version, , cluster, pOutputEcl := outECL, pUniqueOutput := 'xLinkSpec', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::xLinkSpec', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::xLinkSpec::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);
			
		// LAB keys
		xLink_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_xLink\' + pversion);\n InsuranceHeader.proc_xlink_Master(pversion).runXLink;\n';
		xLink := wk_ut.mac_ChainWuids(xLink_ECL, 1, 1, version, , cluster, pOutputEcl := outECL, pUniqueOutput := 'xLink', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::xLink', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::xLink::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);

		// Build Full Build Delta Base file this is treated as incremental build 
		FullDeltaBase_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc fulldelta base\' + pversion);\n InsuranceHeader.proc_xlink_Master(pversion).runFulldeltabase;\n';
		FullDeltaBase := wk_ut.mac_ChainWuids(FullDeltaBase_ECL, 1, 1, version, , cluster, pOutputEcl := outECL, pUniqueOutput := 'fulldeltabase', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::fulldeltabase', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::fulldeltabase::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);
		
		// Build Full Build Delta Inc address hierarchy 
		FullDeltahierarchy_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc fulldelta hierarchy\' + pversion);\n InsuranceHeader.proc_xlink_Master(pversion).runFulldeltaHierarchy;\n';
		FullDeltahierarchy := wk_ut.mac_ChainWuids(FullDeltahierarchy_ECL, 1, 1, version, , cluster, pOutputEcl := outECL, pUniqueOutput := 'fulldeltahierarchy', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::fulldeltaHierarchy', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::fulldeltaHierarchy::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);

		// Build Full Build Delta Inc Best 
		FullDeltaBest_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc fulldelta Best\' + pversion);\n InsuranceHeader.proc_xlink_Master(pversion).runFulldeltaBest;\n';
		FullDeltaBest := wk_ut.mac_ChainWuids(FullDeltaBest_ECL, 1, 1, version, , cluster, pOutputEcl := outECL, pUniqueOutput := 'fulldeltabest', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::fulldeltabest', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::fulldeltabest::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);

		// Build Full Build Delta xink Keys ,  promote to QA  
		FullDeltaBaseKeys_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc fulldelta keys\' + pversion);\n InsuranceHeader.proc_xlink_Master(pversion).runFulldeltaKeys;\n';
	  FullDeltaBaseKeys := wk_ut.mac_ChainWuids(FullDeltaBaseKeys_ECL, 1, 1, version, , cluster, pOutputEcl := outECL, pUniqueOutput := 'fulldeltakeys', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::fulldeltakeys', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::fulldeltakeys::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);
		
		// Promote Full Lab Keys to QA ,update dops , orbit etc.. 
		XlinkPromote_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_xLink_promote\' + pversion);\nInsuranceHeader.proc_xlink_Master(pversion).runXlinkPromote;\n';
		XlinkPromote := wk_ut.mac_ChainWuids(XlinkPromote_ECL, 1, 1, version, , cluster, pOutputEcl := outECL, pUniqueOutput := 'xLinkprmote', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::xLinkpromote', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::xLinkpromote::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);
 		
		// hhid	
		hhid_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_hhid \' + pversion);\n InsuranceHeader.proc_hhid_Master(pversion);\n';
		hhid := wk_ut.mac_ChainWuids(hhid_ECL, 1, 1, version, , cluster, pOutputEcl := outECL, pUniqueOutput := 'hhid', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::hhid', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::hhid::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);
		
  	// Non Linking Keys -> CIIDPhone , DL verification , Best SSN etc.. 
		
		AncillaryKeys_ECL   := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.Build_AncillaryKeys \' + pversion);\n InsuranceHeader.Build_AncillaryKeys_Master(pversion);\n';
	  AncillaryKeys       := wk_ut.mac_ChainWuids(AncillaryKeys_ECL, 1, 1, version,, cluster, pOutputEcl := outECL, pUniqueOutput := 'AncillaryKeys', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::AncillaryKeys', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::AncillaryKeys::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);

		// Remote Linking

		RemoteLinking_ECL		:= 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_remoteLinking_master \' + pversion);\n InsuranceHeader.proc_remoteLinking_Master(pversion);\n';
		RemoteLinking				:= wk_ut.mac_ChainWuids(RemoteLinking_ECL, 1, 1, version,, cluster, pOutputEcl := outECL, pUniqueOutput := 'RemoteLinking', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::RemoteLinking', pOutputSuperfile := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::RemoteLinking::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);

		// specificities keys (for 2-step specificity in internal linking LexID build)
		BuildSpecificityKey_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_specificity \' + pversion);\n InsuranceHeader.proc_specificity_Master(pversion);\n';
		BuildSpecificityKey := wk_ut.mac_ChainWuids(BuildSpecificityKey_ECL, 1, 1, version, , cluster, pOutputEcl := outECL, pUniqueOutput := 'specificity', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.PostProc_Prefix + version + '::specificity', pOutputSuperfile  := InsuranceHeader.Files.MasterWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.PostProc_Prefix + version + '::specificity::WUSummary', pSummarySuperfile := InsuranceHeader.Files.MasterWUSummarySF);
		
		// clean input file for the next month's build (so that pre-processing will run and add new data)
		cleanInputFile	:= SEQUENTIAL(
																					Fileservices.StartSuperFileTransaction(),
																					Fileservices.clearsuperfile(idl_header.Files.FILE_IDL_SALT_ITER_BASE,true),
																					Fileservices.FinishSuperFileTransaction()
																				);
		
		run := SEQUENTIAL(slender,addrHier,post0,stats,didRid,chi,segmentation,relatives,fcra,xLinkSpec,xLink,FullDeltaBase,FullDeltahierarchy,FullDeltaBest,FullDeltaBaseKeys,hhid,AncillaryKeys,RemoteLinking,BuildSpecificityKey,cleanInputFile): 
																	SUCCESS(InsuranceHeader.mod_email.SendSuccessEmail(,'InsuranceHeader', ,'PostHeader Builds')), 
																	FAILURE(InsuranceHeader.mod_email.SendFailureEmail(,'InsuranceHeader', failmessage ,'PostHeader Builds'));
		
		// Run Build Process
		RETURN SEQUENTIAL( run , IF(doPromoteToQA, XlinkPromote ,OUTPUT('PromoteToQA Super keys Skipped')));
		
endmacro;
