import insuranceheader,insuranceheader_postprocess, idl_header, LinkingTools;
import InsuranceHeader_Strata;

// Preprocess
export proc_stats(string iter) := module

		shared String8 strataVersion := thorlib.wuid()[2..9];

		shared hdr := IDL_Header.Files.DS_IDL_POLICY_HEADER_BASE;
		shared father := IDL_Header.Files.DS_IDL_POLICY_HEADER_FATHER;
		shared bocahdr := IDL_Header.Files.DS_BOCA_HEADER_BASE;
		
		// Generate Stats
		// Segmentation
		//export segmentation_tab := output(InsuranceHeader_PostProcess.fn_ADLSegmentation(hdr).tab, named('IDLSegmentation'));
		shared segmentation := InsuranceHeader_PostProcess.fn_ADLSegmentation(hdr).tab;
		export segmentation_tab := output(segmentation, named('IDLSegmentation'));
				
		// Segmentation File
		// shared coreCheckFile		 := idl_header.files.FILE_IDL_STATS + thorlib.wuid() + '_Core_Check';
		shared coreCheckFile		 := idl_header.files.FILE_IDL_STATS + iter + '_Core_Check';
		export segmentation_core := output(InsuranceHeader_PostProcess.fn_ADLSegmentation(hdr).core_check,, coreCheckFile, overwrite, compressed);
		export updateSegmentationSF := InsuranceHeader_PostProcess.files.updateSegmentationSuperFiles(coreCheckFile);		
		
		// Cluster distribution by source - Boca v/s Insurance
		shared didDist0 := InsuranceHeader_PostProcess.mod_didcount(hdr, bocahdr).allCount;
		export didDist := output(didDist0, named('ClusterDistributionBySource'));
		
		// Cluster health indicator (moved to proc_chi_master)
		// export chi := InsuranceHeader_PostProcess.fn_chi(hdr,iter);
		
		// New Information provided by insurance records
		newInfo0 := InsuranceHeader_PostProcess.mod_adl_vs_idl(hdr, bocahdr).doAll;
		export newInfo := output(newInfo0, named('NewInformationByInsRecords'));
		
		// Pollution Stats
		// shared pollutionstats01 := InsuranceHeader_PostProcess.pollutionstats(hdr).pollution_stats;
		// shared pollutionstats02 := InsuranceHeader_PostProcess.pollutionstats(hdr).dob_ssn_table;
		// export pollutionstats1 := output(pollutionstats01, named('POLLUTION_STATS_BY_DID'));
		// export pollutionstats2 := output(pollutionstats02, named('DOB_SSN_TABLE'));
		
		// Distribution Stats
		shared core_dist 				:= distribute(InsuranceHeader_PostProcess.corecheck(ind = 'CORE'), did);
		shared core_hdr 					:= join(hdr, core_dist, left.did = right.did, transform(recordof(left), self := left));
		shared states 						:= InsuranceHeader_PostProcess.distribution_stats(core_hdr).state_table;
		shared states_and_ages 	:= InsuranceHeader_PostProcess.distribution_stats(core_hdr).state_age_table;
		export dist_states 			:= output(states, named('DistributeByStates'));
		export dist_states_age 	:= output(states_and_ages, named('DistributeByStatesAndDOB'));

		//generate InsuranceHeader-data-CoreFieldCount-stats
		strata_states := project(states, InsuranceHeader_Strata.layouts.layout_CoreFieldCount);
		t1 := InsuranceHeader_Strata.CoreFieldCount(strata_states, strataVersion);
	
		//generate InsuranceHeader-data-DOBbyAge-stats
		strata_states_and_ages := project(states_and_ages, InsuranceHeader_Strata.layouts.layout_DOBbyAge);
		t2 := InsuranceHeader_Strata.DOBbyAge(strata_states_and_ages, strataVersion);
		
		//generate InsuranceHeader.proc_stats.segmentation_tab
		strata_segmentation := project(segmentation, InsuranceHeader_Strata.layouts.layout_Segmentation);
		t3 := InsuranceHeader_Strata.Segmentation(strata_segmentation, strataVersion);
	
		//generate InsuranceHeader-data-LexIDBySource-stats (moved to proc_salt)
		// strata_didDist0 := project(didDist0, InsuranceHeader_Strata.layouts.layout_LexIDBySource);
		// t4 := InsuranceHeader_Strata.LexIDBySource(strata_didDist0, strataVersion);
		
		//generate InsuranceHeader-data-SourceCount-stats (moved to ingest)
		// t5 :=  InsuranceHeader_PostProcess.loadStrata_SourceCount(idl_header.header_ins, strataVersion);
		
		//generate id persistence stats
		t6 := LinkingTools.PersistenceStats(hdr,father,rid,did);
		persistence_stats := PARALLEL(OUTPUT(t6.recordDS,named('record_persistence')),OUTPUT(t6.clusterDS,named('cluster_persistence')));
		
		//generate executive dashboard stats
		exec_dashboard := InsuranceHeader_PostProcess.executive_dashboard_stats(iter[..6]).email_executive_dashboard;
		
		strata_load := parallel(t1, t2, t3);
		//export run := sequential(segmentation_tab, segmentation_core, updateSegmentationSF, didDist, newInfo, dist_states, dist_states_age);
		export run := sequential(segmentation_tab, segmentation_core, updateSegmentationSF, didDist,newInfo, dist_states, dist_states_age, strata_load, persistence_stats,exec_dashboard) : 
																SUCCESS(InsuranceHeader.mod_email.SendSuccessEmail(,'InsuranceHeader', , 'HeaderStats')), 
																FAILURE(InsuranceHeader.mod_email.SendFailureEmail(,'InsuranceHeader', failmessage, 'HeaderStats'));

end;