// Master process attributes for consumer header incremental key build to add new entities and link correction
EXPORT Proc_Master(in_version,
                   useCluster,
									 useClusterFCRA,
                   in_startIter = proc_Constants.startIter,	// start iteration (used for internal linking)
									 in_numIters = proc_Constants.numIters,		// number of iterations (used for internal linking)
									 doGetBocaIncrementalRawFile = FALSE,     // get Boca raw file (incremental)
									 IsFullInc = FALSE,                       // set to TRUE to use FUll build new records and incremental corrections 
									 doIngest = FALSE,                        // ingest data
									 doNewOnlyBase = FALSE,                   // build new only base									 
									 doInternalMicroMode = FALSE,            // micro mode internal linking
									 doExistingBase = FALSE ,                 // update Existing DID Base 
									 doUpdateIncBase = FALSE,               // update incremental base file
									 doAddrHierarchy =FALSE,              //  Build address hierarchy 
									 doUpdateBest =FALSE,                //  Update best base 
									 doXlinkKeyBuild = FALSE ,             // external linking incremental key build
									 doFCRA = FALSE,											// FCRA base file, key, and addr rank key
									 doPromoteToQA = FALSE                // promote incremental keys to QA super keys 
									 ) := FUNCTIONMACRO
	
	IMPORT InsuranceHeader_Incremental, wk_ut,InsuranceHeader_Incremental_Best;
	
	version			:= in_version; // version to assign to this build
	startIter 	:= in_startIter; // start iteration (used for internal linking only)
	numIters		:= in_numIters;  // number of iterations (used for internal linking only)
	pollingFreq	:= InsuranceHeader_Incremental.Proc_Constants.pollingFreq; // how often to check on job status (in minutes)
	emailTo			:= InsuranceHeader_Incremental.Proc_Constants.emailNotify; // these e-mail addresses will receive all process notifications
	wuPrefix		:= InsuranceHeader_Incremental.Filenames.Prefix_Workman;  // prefix for individual workunit output file
	wuSuperfile := InsuranceHeader_Incremental.Filenames.MasterWorkmanOutputSF; // general data on each workunit output into a logical file under this superfile
	
	createSuperFiles := InsuranceHeader_Incremental.Superfiles.createSuperFiles();
	outECL := FALSE;
	
	// get incremental raw file
	runGetBocaIncrementalRawFile_Text		 := 'GetBocaIncrementalRawFile';
	runGetBocaIncrementalRawFile_ECL 	   := 'IMPORT Header_AVB;' +
	                                        '\npversion  := \'@version@\';' +
																					'\n#workunit(\'name\',\'Header_AVB GetBocaIncrementalRawFile \' + pversion);' +
																					'\n#workunit(\'priority\',\'high\');' +
																					'\nHeader_AVB.proc_outputfile(FALSE,TRUE);\n';
														
	runGetBocaIncrementalRawFile := wk_ut.mac_ChainWuids(runGetBocaIncrementalRawFile_ECL, 1, 1, version,, usecluster, pOutputEcl := outECL,
																											 pUniqueOutput := runGetBocaIncrementalRawFile_Text,
																											 pNotifyEmails := emailTo,
																											 pPollingFrequency := pollingFreq,
																											 pOutputFilename := wuPrefix + '@version@::WUInfo_' + runGetBocaIncrementalRawFile_Text,
																											 pOutputSuperfile := wuSuperfile);
																											 
  // ingest data
	runIngest_Text		 			 := 'Ingest';
	runIngest_ECL 	   			 := 'IMPORT InsuranceHeader_Incremental;' +
															'\npversion  := \'@version@\';' +
															'\n#workunit(\'name\',\'InsuranceHeader_Incremental Ingest \' + pversion);' +
															'\n#workunit(\'priority\',\'high\');' +
															'\nInsuranceHeader_Incremental.Proc_Ingest(pversion,' + IF(IsFullInc , 'TRUE','FALSE') +' );\n';
														
	runIngest	 			 := wk_ut.mac_ChainWuids(runIngest_ECL, 1, 1, version,, usecluster, pOutputEcl := outECL,
																					 pUniqueOutput := runIngest_Text,
																					 pNotifyEmails := emailTo,
																					 pPollingFrequency := pollingFreq,
																					 pOutputFilename := wuPrefix + '@version@::WUInfo_' + runIngest_Text,
																					 pOutputSuperfile := wuSuperfile);
	
		// build "new only" base
	runNewOnlyBase_Text		 			 := 'NewOnlyBase';
	runNewOnlyBase_ECL 	   			 := 'IMPORT InsuranceHeader_Incremental;' +
																	'\npversion  := \'@version@\';' +
																	'\n#workunit(\'name\',\'InsuranceHeader_Incremental NewOnlyBase \' + pversion);' +
																	'\n#workunit(\'priority\',\'high\');' +
																	'\nInsuranceHeader_Incremental.Proc_NewOnlyBase(pversion,TRUE);\n';
														
	runNewOnlyBase	 := wk_ut.mac_ChainWuids(runNewOnlyBase_ECL, 1, 1, version,, usecluster, pOutputEcl := outECL,
																					 pUniqueOutput := runNewOnlyBase_Text,
																					 pNotifyEmails := emailTo,
																					 pPollingFrequency := pollingFreq,
																					 pOutputFilename := wuPrefix + '@version@::WUInfo_' + runNewOnlyBase_Text,
																					 pOutputSuperfile := wuSuperfile);
		
	// internal linking iterations
	runInternalMicroMode_Text					 := 'InternalMicroMode';
	runInternalMicroMode_ECL 					 := 'IMPORT InsuranceHeader_Incremental;' +
																				'\npiteration := \'@iteration@\';' +
																				'\npversion  := \'@version@\';' +
																				'\n#workunit(\'name\',\'InsuranceHeader_Incremental InternalMicroMode \' + pversion + \' iter \' + piteration);' +
																				'\n#workunit(\'priority\',\'high\');' +
																				'\nInsuranceHeader_Incremental.Proc_InternalLinking(piteration, pversion).runIter;\n';
	
	runInternalMicroMode 			 := wk_ut.mac_ChainWuids(runInternalMicroMode_ECL, startIter, numIters, version,
	                                                   [],
																										 usecluster, pOutputEcl := outECL,
																										 pUniqueOutput := runInternalMicroMode_Text,
																										 pNotifyEmails := emailTo,
																										 pPollingFrequency := pollingFreq,
																										 pOutputFilename := wuPrefix + '@version@_@iteration@::WUInfo_' + runInternalMicroMode_Text,
																										 pOutputSuperfile := wuSuperfile);
	// build "Existing" base
	
	runExistingIncBase_Text		 			  := 'ExistingIncBase';
	runExistingIncBase_ECL 	   			 := 'IMPORT InsuranceHeader_Incremental;' +
																					'\npversion  := \'@version@\';' +
																					'\n#workunit(\'name\',\'InsuranceHeader_Incremental ExistingIncBase \' + pversion);' +
																					'\n#workunit(\'priority\',\'high\');' +
																					'\nInsuranceHeader_Incremental.Proc_ExistingBase(pversion);\n';
														
	runExistingIncBase    	 := wk_ut.mac_ChainWuids(runExistingIncBase_ECL, 1, 1, version,, usecluster, pOutputEcl := outECL,
																								 pUniqueOutput := runExistingIncBase_Text,
																								 pNotifyEmails := emailTo,
																								 pPollingFrequency := pollingFreq,
																								 pOutputFilename := wuPrefix + '@version@::WUInfo_' + runExistingIncBase_Text,
																								 pOutputSuperfile := wuSuperfile);
	
	// update incremental base file
	runUpdateIncBase_Text		 			 := 'UpdateIncBase';
	runUpdateIncBase_ECL 	   			 := 'IMPORT InsuranceHeader_Incremental;' +
																					'\npversion  := \'@version@\';' +
																					'\n#workunit(\'name\',\'InsuranceHeader_Incremental UpdateIncBase \' + pversion);' +
																					'\n#workunit(\'priority\',\'high\');' +
																					'\nInsuranceHeader_Incremental.Proc_UpdateIncBase(pversion);\n';
														
	runUpdateIncBase    	 := wk_ut.mac_ChainWuids(runUpdateIncBase_ECL, 1, 1, version,, usecluster, pOutputEcl := outECL,
																								 pUniqueOutput := runUpdateIncBase_Text,
																								 pNotifyEmails := emailTo,
																								 pPollingFrequency := pollingFreq,
																								 pOutputFilename := wuPrefix + '@version@::WUInfo_' + runUpdateIncBase_Text,
																								 pOutputSuperfile := wuSuperfile);
																								 
	// Update address hierarchy 
	
	runUpdateAddrHierarchy_Text		 			 := 'UpdateAddressHierarchy';
	runUpdateAddrHierarchy_ECL 	   			 := 'IMPORT InsuranceHeader_Incremental;' +
																					'\npversion  := \'@version@\';' +
																					'\n#workunit(\'name\',\'InsuranceHeader_Incremental UpdateAddressHierarchy \' + pversion);' +
																					'\n#workunit(\'priority\',\'high\');' +
																					'\nInsuranceHeader_Incremental_Best.Proc_addrHier(pversion).run;\n';
														
	runAddrHierarchy    	 := wk_ut.mac_ChainWuids(runUpdateAddrHierarchy_ECL, 1, 1, version,, usecluster, pOutputEcl := outECL,
																								 pUniqueOutput := runUpdateAddrHierarchy_Text,
																								 pNotifyEmails := emailTo,
																								 pPollingFrequency := pollingFreq,
																								 pOutputFilename := wuPrefix + '@version@::WUInfo_' + runUpdateAddrHierarchy_Text,
																								 pOutputSuperfile := wuSuperfile);
																								 
	// Build Best Base 
	
		runUpdateBest_Text		 			 := 'UpdateBest';
	runUpdateBest_ECL 	   			 := 'IMPORT InsuranceHeader_Incremental;' +
																					'\npversion  := \'@version@\';' +
																					'\n#workunit(\'name\',\'InsuranceHeader_Incremental UpdateBest \' + pversion);' +
																					'\n#workunit(\'priority\',\'high\');' +
																					'\nInsuranceHeader_Incremental_Best.Proc_Base(pversion).run;\n';
														
	runUpdateBest    	 := wk_ut.mac_ChainWuids(runUpdateBest_ECL, 1, 1, version,, usecluster, pOutputEcl := outECL,
																								 pUniqueOutput := runUpdateBest_Text,
																								 pNotifyEmails := emailTo,
																								 pPollingFrequency := pollingFreq,
																								 pOutputFilename := wuPrefix + '@version@::WUInfo_' + runUpdateBest_Text,
																								 pOutputSuperfile := wuSuperfile);
																								 
	// External linking key build
	runXlinkKeyBuild_Text		 			 := 'XlinkKeyBuild';
	runXlinkKeyBuild_ECL 	   			 := 'IMPORT InsuranceHeader_Incremental;' +
	                                  '\npversion  := \'@version@\';' +
																		'\n#workunit(\'name\',\'InsuranceHeader_Incremental XlinkKeyBuild \' + pversion);' +
																		'\n#workunit(\'priority\',\'high\');' +
																		'\nInsuranceHeader_Incremental.Proc_XlinkKeyBuild(pversion);\n';
														
	runXlinkKeyBuild		 := wk_ut.mac_ChainWuids(runXlinkKeyBuild_ECL, 1, 1, version,, usecluster, pOutputEcl := outECL,
																							 pUniqueOutput := runXlinkKeyBuild_Text,
																							 pNotifyEmails := emailTo,
																							 pPollingFrequency := pollingFreq,
																							 pOutputFilename := wuPrefix + '@version@::WUInfo_' + runXlinkKeyBuild_Text,
																							 pOutputSuperfile := wuSuperfile);
																							 
 	// FCRA build
	runFCRA_Text		 			 := 'FCRABuild';
	runFCRA_ECL 	   			 := 'IMPORT InsuranceHeader_Incremental_Best;' +
	                                  '\npversion  := \'@version@\';' +
																		'\n#workunit(\'name\',\'InsuranceHeader_Incremental FCRA Build \' + pversion);' +
																		'\n#workunit(\'priority\',\'high\');' +
																		'\nInsuranceHeader_Incremental_Best.proc_FCRA_master(pversion);\n';
														
	runFCRA		 := wk_ut.mac_ChainWuids(runFCRA_ECL, 1, 1, version,, useClusterFCRA, pOutputEcl := outECL,
																							 pUniqueOutput := runFCRA_Text,
																							 pNotifyEmails := emailTo,
																							 pPollingFrequency := pollingFreq,
																							 pOutputFilename := wuPrefix + '@version@::WUInfo_' + runFCRA_Text,
																							 pOutputSuperfile := wuSuperfile);
	
	// promote to QA super
	
	runPromoteToQA_Text		         := 'PromoteToQA';
  runPromoteToQA_ECL 	   	       := 'IMPORT InsuranceHeader_Incremental;' +
	                                   '\npversion  := \'@version@\';' +
				                             '\n#workunit(\'name\',\'InsuranceHeader_Incremental promoteToQA\' + pversion);' +
				                             '\n#workunit(\'priority\',\'high\');' +
				                             '\nInsuranceHeader_Incremental.Proc_PromoteToQA(pversion);\n';
														
  runPromoteToQA		      := wk_ut.mac_ChainWuids(runPromoteToQA_ECL, 1, 1, version,, usecluster, pOutputEcl := outECL,
					                                        pUniqueOutput := runPromoteToQA_Text,
					                                        pNotifyEmails := emailTo,
					                                        pPollingFrequency := pollingFreq,
					                                        pOutputFilename := wuPrefix + '@version@::WUInfo_' + runPromoteToQA_Text,
					                                        pOutputSuperfile := wuSuperfile);
					 
	
	// full process (switches can be used to control whether individual pieces run)
	sequentialSteps := SEQUENTIAL(
	                              createSuperFiles,
																IFF(doGetBocaIncrementalRawFile, runGetBocaIncrementalRawFile, OUTPUT('Get Raw Boca Incremental File Skipped')),
															 IFF(doIngest, runIngest, OUTPUT('Ingest Skipped')),
																IFF(doNewOnlyBase, runNewOnlyBase, OUTPUT('New Only Base Build Skipped')),
                IFF(doInternalMicroMode, runInternalMicroMode, OUTPUT('Micro Mode Internal Linking Skipped')),
																IFF(doExistingBase,runExistingIncBase, OUTPUT('Existing Base Build Skipped')),
																IFF(doUpdateIncBase, runUpdateIncBase, OUTPUT('Update Incremental Base File Skipped')),
                IFF(doAddrHierarchy, runAddrHierarchy, OUTPUT('AddrHierarchy Build Skipped')),
                IFF(doUpdateBest, runUpdateBest, OUTPUT('Best Build Skipped')),
								        IFF(doXlinkKeyBuild, runXlinkKeyBuild, OUTPUT('Xlink Key Build Skipped')),
														IFF(doFCRA, runFCRA, OUTPUT('FCRA Build Skipped')),
																IFF(doPromoteToQA, runPromoteToQA, OUTPUT('PromoteToQA Super keys Skipped'))	
																);
																
	RETURN sequentialSteps;
	
ENDMACRO;
