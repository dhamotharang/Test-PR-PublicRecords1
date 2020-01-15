﻿IMPORT WsWorkunits;

// Master process attribute for ELERT (External Linking Error and Recall Testing)
// Each step can be run or skipped using Boolean flags provided as arguments (steps skipped by default)
EXPORT macMaster(
  sInVersion,
  sRerunID                          = '', 
  iNumSamples                       = 10000, // Number of samples per profile
  iExpireTime                       = 30,  //How long until files are removed from the cluster
  sSamplesFileName                  = '', //Fill this in if you have your own set of samples to run 
  bBaseline                         = FALSE, //If this is FALSE you will automatically skip the NEW call even if set to true
  ssConstantValue                   = ['\'\'','\'qa\''],//This changes the keys being pulled in, used to compare builds
  sProfile                          = 'BizLinkFull_ELERT.modProfiles.dProfiles',//Your profile to use in the run
  ssIdAppendThorCall                = ['BizLinkFull_ELERT.modCallFunctions.fCallWrapperIdAppendThor','BizLinkFull_ELERT.modCallFunctions.fCallWrapperIdAppendThor'],//The macros you are calling, used to compare different modules
  ssIdAppendRoxieCall               = ['BizLinkFull_ELERT.modCallFunctions.fCallWrapperIdAppendRoxie','BizLinkFull_ELERT.modCallFunctions.fCallWrapperIdAppendRoxie'],//The macros you are calling, used to compare different modules
  ssIdFunctionsCall                 = ['BizLinkFull_ELERT.modCallFunctions.fCallWrapperIdFunctions','BizLinkFull_ELERT.modCallFunctions.fCallWrapperIdFunctions'],//The macros you are calling, used to compare different modules
  ssMMFCall      					          = ['BizLinkFull_ELERT.modCallFunctions.fCallWrapperMMF','BizLinkFull_ELERT.modCallFunctions.fCallWrapperMMF'],//The macros you are calling, used to compare different modules
  sHyperLinkProfile                 = 'BizLinkFull_ELERT.modHyperlinkProfiles.dProfiles',//Your hyperlink profiles
  sPrimaryQueue                     = BizLinkFull_ELERT.modConstants.sPrimaryQueue,
  sSecondaryQueue                   = BizLinkFull_ELERT.modConstants.sSecondaryQueue,
  bOutECLIn                         = BizLinkFull_ELERT.modConstants.bOutECL,
  //ADD Other options here!!! 
  dDebugInput1                      = '',
  dDebugInput2                      = '',
  sInPrefix                         = '',
  bIsTest                           = false,
  sEmailTo                          = '',
  bUseForeignData                   = BizLinkFull_ELERT.modConstants.bUseForeignFiles,
  iExternalSamples2Pull             = BizLinkFull_ELERT.modConstants.iDefaultSamples4External,
  bRunProdVsLocal                   = false,
	bIsStatsProxidLevel								= true, //change to false to generate stats at sele level

  //ADD Steps here
  bDoGenerateSamples                   = FALSE,//Generate the samples to run through
  bRunTestsOrig                        = FALSE, //Run the samples through the different tests
  bRunTestsNew                         = FALSE, //Run the samples through the different tests
  bGenerateStats                       = FALSE
  ) := FUNCTIONMACRO
 
  IMPORT wk_ut AS pkgWorkUnit;
  sVersion                          := sInVersion; // version to assign to this build
  sPollingFreq                      := BizLinkFull_ELERT.modConstants.sPollingFreq;  // how often to check on job status
  sEmailList                        := if(sEmailTo = '', BizLinkFull_ELERT.modConstants.sEmailNotify, sEmailTo);  // these e-mail addresses will receive all process notifications
  sWuPrefix                         := BizLinkFull_ELERT.modFilenames(sInPrefix).sPrefixMasterWUOutput;   // prefix for individual WORKUNIT output file
  sWuSuperfile                      := BizLinkFull_ELERT.modFilenames(sInPrefix).kMasterWUOutput_SF.current; // general data on each WORKUNIT output into a logical file under this superfile
 
 
  // set to TRUE for debugging generated ECL (will not run anything- just generates ECL!)
  bOutECL :=  bOutECLIn;
 
  // ensure all required superfiles exist
  aCreateSFilesGeneral    := BizLinkFull_ELERT.modSuperfiles(sInPrefix).fCreateSuperFiles();
  //Generate the samples to run through
  sRunGenerateSamples_Text          := 'GenerateSamples';
  sRunGenerateSamples_ECL           :='\n#OPTION(\'multiplePersistInstances\',FALSE);' +
                                      '\nIMPORT BizLinkFull_ELERT, WsWorkunits;' +
                                      '\nsVersion  := \'@version@\';' +
                                      '\ndProfile           := ' + sProfile + ';' +
                                      '\niNumSamples  := '+ iNumSamples + ';' +
                                      '\niExpireTime := ' + iExpireTime + ';' + 
                                      '\nsSamplesFileName := \'' + sSamplesFileName + '\';' +     
                                      '\nsEmailTo := \'' + sEmailList + '\';' +     
                                      '\nsInPrefix := \'' + sInPrefix + '\';' + 
																			'\ndSamples := BizLinkFull_ELERT.modFiles(sInPrefix).dSamples;' +
                                      '\n#WORKUNIT(\'name\',\'BizLinkFull_ELERT Generate Samples \' + sVersion);' +
																			'\nBizLinkFull_ELERT.macAnalyzeSamples(dSamples, dProfile, sVersion); //makes csvStats available\n' +
                                      '\nSEQUENTIAL(\n' +
	                                    'BizLinkFull_ELERT.modGetSamples2(dProfile,sVersion,iNumSamples,iExpireTime,sSamplesFileName,sInPrefix,'+bUseForeignData+','+iExternalSamples2Pull+').aBuildSamples,\n' +
	                                    'BizLinkFull_ELERT.modCsv.EmailAsCSV(csvStats,\'BizLinkFull_ELERT_Stats_\'+sVersion+\'\',sEmailTo,\'BIP ELERT Sample Gathering For \'+sVersion+\' Has Finished\',\'\')\n' +
                                      ');\n';
  aRunGenerateSamples               := pkgWorkUnit.mac_ChainWuids(sRunGenerateSamples_ECL, 1, 1, sVersion,, sPrimaryQueue, pOutputEcl := bOutECL,
                                      pUniqueOutput := sRunGenerateSamples_Text,
                                      pNotifyEmails := sEmailList,
                                      pPollingFrequency := sPollingFreq,
                                      pOutputFilename := sWuPrefix + '@version@' + sRerunID + '::WUInfo_' + sRunGenerateSamples_Text,
                                      pOutputSuperfile := sWuSuperfile,
                                      pInDebug := dDebugInput1);
  
  
  //Run the samples through the different tests first is our desginated "Orig" run
  dDebugForOrig := map(bRunProdVsLocal => '', 
                       dDebugInput2 != '' => dDebugInput2,
                       dDebugInput1);
  sRunTestsOrig_Text          := 'RunTestsOrig';
  sRunTestsOrig_ECL           := 'IMPORT BizLinkFull_ELERT;' +
                                      '\nsVersion           := \'@version@\';' +
                                      '\ndProfile           := ' + sProfile + ';' +
                                      '\nsMode              := \'ORIG\';' +
                                      '\nsConstantValue     := ' + ssConstantValue[1] +';' +
                                      '\nsInPrefix := \'' + sInPrefix + '\';' +    
                                      '\nfIdAppendThorFunction     := ' + ssIdAppendThorCall[1] +';' +
                                      '\nfIdAppendRoxieFunction     := ' + ssIdAppendRoxieCall[1] +';' +
                                      '\nfIdFunctionsFunction     := ' + ssIdFunctionsCall[1] +';' +
																			'\nfMmfFunction     := ' + ssMMFCall[1] +';' +
                                      '\niExpireTime       := ' + iExpireTime + ';' + 
                                      '\ndHyperLinkProfile     := ' + sHyperLinkProfile +';' +
                                      '\nbRunBaseline           := ' + IF(bBaseline,'TRUE','FALSE') + ';' +
                                      '\n#OPTION(\'multiplePersistInstances\',FALSE);' +
                                      '\n#OPTION(\'remoteKeyedLookup\', false);' +
                                      '\n#WORKUNIT(\'name\',\'BizLinkFull_ELERT Run Orig Tests \' + sVersion);' +
                                      '\nBizLinkFull_ELERT.macRunTests(dProfile,BizLinkFull_ELERT.modFiles(sInPrefix).dSamples,sVersion,sMode,sConstantValue,fIdAppendThorFunction,fIdAppendRoxieFunction,fIdFunctionsFunction,fMmfFunction, iExpireTime, sInPrefix);';
                                      //'\nBizLinkFull_ELERT.modGenerateStatistics(sVersion,dProfile,iExpireTime,dHyperLinkProfile,bRunBaseline,sMode).baseDetailed;\n';
  aRunTestsOrig               := pkgWorkUnit.mac_ChainWuids(sRunTestsOrig_ECL, 1, 1, sVersion,, sPrimaryQueue, pOutputEcl := bOutECL,
                                      pUniqueOutput := sRunTestsOrig_Text,
                                      pNotifyEmails := sEmailList,
                                      pPollingFrequency := sPollingFreq,
                                      pOutputFilename := sWuPrefix + '@version@' + sRerunID + '::WUInfo_' + sRunTestsOrig_Text,
                                      pOutputSuperfile := sWuSuperfile,
                                      pInDebug := dDebugForOrig);
 
  //Second is our desginated "New" run
  sRunTestsNew_Text           := 'RunTestsNew';
  sRunTestsNew_ECL           := 'IMPORT BizLinkFull_ELERT;' +
                                      '\nsVersion           := \'@version@\';' +
                                      '\ndProfile           := ' + sProfile + ';' +
                                      '\nsMode              := \'NEW\';' +
                                      '\nsConstantValue     := ' + ssConstantValue[2] +';' +
                                      '\nsInPrefix := \'' + sInPrefix + '\';' +    
                                      '\nfIdAppendThorFunction     := ' + ssIdAppendThorCall[2] +';' +
                                      '\nfIdAppendRoxieFunction     := ' + ssIdAppendRoxieCall[2] +';' +
                                      '\nfIdFunctionsFunction     := ' + ssIdFunctionsCall[2] +';' +
																			'\nfMmfFunction     := ' + ssMMFCall[2] +';' +
                                      '\niExpireTime       := ' + iExpireTime + ';' + 
                                      '\ndHyperLinkProfile     := ' + sHyperLinkProfile +';' +
                                      '\nbRunBaseline           := ' + IF(bBaseline,'TRUE','FALSE') + ';' +
                                      '\n#OPTION(\'multiplePersistInstances\',FALSE);' +
                                      '\n#OPTION(\'remoteKeyedLookup\', false);' +
                                      '\n#WORKUNIT(\'name\',\'BizLinkFull_ELERT Run New Tests \' + sVersion);' +
                                      '\nBizLinkFull_ELERT.macRunTests(dProfile,BizLinkFull_ELERT.modFiles(sInPrefix).dSamples,sVersion,sMode,sConstantValue,fIdAppendThorFunction,fIdAppendRoxieFunction,fIdFunctionsFunction,fMmfFunction, iExpireTime, sInPrefix);';
                                      // '\nBizLinkFull_ELERT.modGenerateStatistics(sVersion,dProfile,iExpireTime,dHyperLinkProfile,bRunBaseline,sMode).baseDetailed;\n';
  aRunTestsNew               := pkgWorkUnit.mac_ChainWuids(sRunTestsNew_ECL, 1, 1, sVersion,, sPrimaryQueue, pOutputEcl := bOutECL,
                                      pUniqueOutput := sRunTestsNew_Text,
                                      pNotifyEmails := sEmailList,
                                      pPollingFrequency := sPollingFreq,
                                      pOutputFilename := sWuPrefix + '@version@' + sRerunID + '::WUInfo_' + sRunTestsNew_Text,
                                      pOutputSuperfile := sWuSuperfile,
                                      pInDebug := dDebugInput1);
  //Generate the samples to run through
  sRunGenerateStats_Text          := 'GenerateStatistics';
  sRunGenerateStats_ECL           := 'IMPORT BizLinkFull_ELERT;' +
                                      '\nsVersion  := \'@version@\';' +
                                      '\ndProfile           := ' + sProfile + ';' +
                                      '\niExpireTime := ' + iExpireTime + ';' + 
                                      '\nsInPrefix := \'' + sInPrefix + '\';' +    
                                      '\ndHyperLinkProfile     := ' + sHyperLinkProfile +';' +
                                      '\nbRunBaseline           := ' + IF(bBaseline,'TRUE','FALSE') + ';' +
                                      '\nsMode           := \'\';' +  
                                      '\nsEmailTo := \'' + sEmailList + '\';' +    
									  '\nbStatsProxidLevel := ' + IF(bIsStatsProxidLevel,'TRUE','FALSE') + ';' +
                                      '\n#OPTION(\'multiplePersistInstances\',FALSE);' +
                                      '\n#OPTION(\'remoteKeyedLookup\', false);' +
                                      '\n#WORKUNIT(\'name\',\'BizLinkFull_ELERT Generate Statistics \' + sVersion);' +
                                      '\nBizLinkFull_ELERT.modGenerateStatistics(sVersion,sInPrefix,sEmailTo,dProfile,iExpireTime,dHyperLinkProfile,bRunBaseline,sMode,bStatsProxidLevel).fGenerateStatistics();\n';
  aRunGenerateStats               := pkgWorkUnit.mac_ChainWuids(sRunGenerateStats_ECL, 1, 1, sVersion,, sPrimaryQueue, pOutputEcl := bOutECL,
                                      pUniqueOutput := sRunGenerateStats_Text,
                                      pNotifyEmails := sEmailList,
                                      pPollingFrequency := sPollingFreq,
                                      pOutputFilename := sWuPrefix + '@version@' + sRerunID + '::WUInfo_' + sRunGenerateStats_Text,
                                      pOutputSuperfile := sWuSuperfile,
                                      pInDebug := dDebugInput1);
// full process (switches can be used to control whether individual pieces run)
   aSequentialSteps := SEQUENTIAL(
// Build Prep
    PARALLEL(
      aCreateSFilesGeneral
    ),
// Ingest
    // output(aRunGenerateSamples)
    IFF(bDoGenerateSamples, aRunGenerateSamples, OUTPUT('Generate Samples Skipped')),
    IFF(bRunTestsOrig, aRunTestsOrig, OUTPUT('Test Orig Samples Skipped')),
    IFF(bRunTestsNew AND bBaseline=FALSE, aRunTestsNew, OUTPUT('Test New Samples Skipped')),
    IFF(bGenerateStats, aRunGenerateStats, OUTPUT('Generate Statistics Skipped'))//,
   
  );
 
  testEcl := parallel(
    IFF(bIsTest, output(sRunGenerateSamples_ECL, named('run_samples_ecl')), OUTPUT('Generate Samples Test Skipped')),
    IFF(bIsTest, output(sRunTestsOrig_ECL, named('orig_run_ecl')), OUTPUT('Test Orig Samples Test Skipped')),
    IFF(bIsTest, output(sRunTestsNew_ECL, named('new_run_ecl')), OUTPUT('Test New Samples Test Skipped')),
    IFF(bIsTest, output(sRunGenerateStats_ECL, named('stats_ecl')), OUTPUT('Generate Statistics Test Skipped'))
  );

  RETURN when(aSequentialSteps, testEcl);
 
ENDMACRO;