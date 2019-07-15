import idl_header, insuranceheader_preprocess, InsuranceHeader_PostProcess;

export proc_build(pversion = 'InsuranceHeaderBuild',pIterStart = 1) := functionmacro;
		version := pversion;
		iterStart := pIterStart;
		numIters := InsuranceHeader.proc_Constants.numIters - iterStart + 1;
		cluster			:= InsuranceHeader.proc_Constants.cluster2;
		pollingFreq	:= InsuranceHeader.proc_Constants.pollingFreq;
		emailList := InsuranceHeader.proc_Constants.emailList;
		stopCondition := InsuranceHeader.proc_Constants.stopCondition;
		
		// set to TRUE for debugging generated ECL
		outECL := InsuranceHeader.proc_Constants.outECL;

		#workunit('name','Prod InsuranceHeader Build');
	
		headerECL := 'IMPORT InsuranceHeader;\niteration := \'@iteration@\';\npversion  := \'@version@\';\n#OPTION(\'multiplePersistInstances\',FALSE);\n#workunit(\'name\',\'InsuranceHeader.proc_header \' + pversion + \' iter \' + iteration);\n InsuranceHeader.proc_header(pversion, iteration);\n';
		headerBuild := wk_ut.mac_ChainWuids(headerECL, iterStart, numIters, version,, cluster, pOutputEcl := outECL, pUniqueOutput := 'header', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.Build_Prefix + version + '::header', pOutputSuperfile  := InsuranceHeader.Files.BuildWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.Build_Prefix + version + '::header::WUSummary', pSummarySuperfile := InsuranceHeader.Files.BuildWUSummarySF);
		
		headerLastIter := wk_ut.mac_ChainWuids(headerECL, numIters+1, 1, version,, cluster, pOutputEcl := outECL, pUniqueOutput := 'header', pNotifyEmails := emailList, pPollingFrequency := pollingFreq, pOutputFilename := InsuranceHeader.Files.Build_Prefix + version + '::header', pOutputSuperfile  := InsuranceHeader.Files.BuildWUOutputSF, pSummaryFilename  := InsuranceHeader.Files.Build_Prefix + version + '::header::WUSummary', pSummarySuperfile := InsuranceHeader.Files.BuildWUSummarySF);
		mtchCnt := DATASET('~thor_data400::base::insuranceheader::' + InsuranceHeader_Salt_T46.Config.Infix + '::linkStats',{string stat,unsigned countgroup},THOR)(stat = 'matchesPerformed')[1].countgroup;
		// Run Build Process
		run := sequential(headerBuild,IFF(mtchCnt > stopCondition,headerLastIter,OUTPUT('Only ' + numIters + ' iterations needed'))/*,post*/) : 
																													SUCCESS(InsuranceHeader.mod_email.SendSuccessEmail(,'InsuranceHeader')), 
																													FAILURE(InsuranceHeader.mod_email.SendFailureEmail(,'InsuranceHeader', failmessage));
		
		return run;
		
endmacro;