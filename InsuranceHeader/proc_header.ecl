import wk_ut, idl_header, insuranceheader_preprocess, InsuranceHeader_PostProcess, InsuranceHeader_Salt_T46, InsuranceHeader_PreProcess;

export proc_header(pversion = 'InsuranceHeaderSalt', pIter = 1) := functionmacro;
		version := pversion + '_iter_' + (STRING) pIter;
		iter := pIter;
		cluster			:= InsuranceHeader.proc_Constants.cluster;
		pollingFreq	:= InsuranceHeader.proc_Constants.pollingFreq;
		emailList := InsuranceHeader.proc_Constants.emailList;
		
		// set to TRUE for debugging generated ECL
		outECL := InsuranceHeader.proc_Constants.outECL;
					
			// Pre Process
			// First iteration will ingest new data and produce stats
			// Other iterations will only pass through the prior iterations SALT output
		pre0_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_preprocess \' + pversion);\n InsuranceHeader.proc_preprocess_Master(pversion);\n';
		pre0 := wk_ut.mac_ChainWuids(pre0_ECL, iter, 1, version,, cluster, pOutputEcl := outECL, pUniqueOutput := 'preProcess', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.Build_Prefix + version + '::preprocess', pOutputSuperfile  := InsuranceHeader.Files.BuildWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.Build_Prefix + version + '::preprocess::WUSummary', pSummarySuperfile := InsuranceHeader.Files.BuildWUSummarySF);
																						

		// Salt Iterations
		salt_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_salt \' + pversion);\n InsuranceHeader.proc_salt_Master(pversion);\n';	
		salt1 := wk_ut.mac_ChainWuids(salt_ECL, iter, 1, version,, cluster, pOutputEcl := outECL, pUniqueOutput := 'salt', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.Build_Prefix + version + '::salt', pOutputSuperfile  := InsuranceHeader.Files.BuildWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.Build_Prefix + version + '::salt::WUSummary', pSummarySuperfile := InsuranceHeader.Files.BuildWUSummarySF);
		
		
		// Clean Did2Rid and Addback files
		
		cleanFiles_ECL := 'IMPORT InsuranceHeader;\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_cleanFiles \' + pversion);\n InsuranceHeader.proc_cleanFiles_Master(pversion);\n';
		cleanFiles := wk_ut.mac_ChainWuids(cleanFiles_ECL, iter, 1, version,, cluster, pOutputEcl := outECL, pUniqueOutput := 'cleanFiles', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.Build_Prefix + version + '::cleanFiles', pOutputSuperfile := InsuranceHeader.Files.BuildWUOutputSF, pSummaryFilename := InsuranceHeader.Files.Build_Prefix + version + '::cleanFiles::WUSummary', pSummarySuperfile := InsuranceHeader.Files.BuildWUSummarySF);

														
		// Generate samples for review process 
		// export reviewSamples := InsuranceHeader.proc_buildsample(timeStamp).run;

		// Run Build Process
		run := sequential(pre0, salt1, cleanFiles) : 
																													SUCCESS(InsuranceHeader.mod_email.SendSuccessEmail(,'InsuranceHeader')), 
																													FAILURE(InsuranceHeader.mod_email.SendFailureEmail(,'InsuranceHeader', failmessage));
																													
		return run;
		
endmacro;