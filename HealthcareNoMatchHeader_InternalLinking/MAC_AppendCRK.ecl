IMPORT  STD, HealthcareNoMatchHeader_Ingest,wk_ut;
EXPORT  MAC_AppendCRK(
    	pSrc
    , pVersion
    , pBase
    , pAsHeader
)	:=	FUNCTIONMACRO

  #WORKUNIT('NAME','Healthcare NoMatch Customer Record Key for SRC='+pSrc);

  //  Set Workman Variables
  pStartIter      :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.startIter;
  pNumIter        :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.numIters;
  pPrimaryQueue   :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.primaryQueue;
  pOutECL         :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.outECL;
  pWuPrefix       :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).WUPrefix;
  pWuSuperfile    :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).MasterWUOutput_SF;
  pEmailTo        :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.emailNotify;
  pPollingFreq    :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.pollingFreq;
  // pStopCondition  :=  ['MatchesPerformed','< TRIM(REALFORMAT((COUNT(pBase)+COUNT(pAsHeader))*HealthcareNoMatchHeader_InternalLinking.proc_Constants.stopThreshold,10,0),ALL)'];
  pStopCondition  :=  ['MatchesPerformed','< 1000000'];

  //  Common Workman ECL Code
  workmanPreamble(STRING runText)  :=  FUNCTION
    workmanPreambleECL  :=  'IMPORT HealthcareNoMatchHeader_InternalLinking,HealthcareNoMatchHeader_Ingest;' +
                            '\npSrc := \''+pSrc+'\';' +
                            '\npVersion  := \'@version@\';' +
                            '\npIteration := \'@iteration@\';' +
                            '\n#WORKUNIT(\'name\',\'HealthcareNoMatchHeader_InternalLinking '+runText+' \' + pVersion + \' Src \' + pSrc + \' iter \' + pIteration);' +
                            // '\n#WORKUNIT(\'priority\',\'high\');' +
                            '\n';
    RETURN workmanPreambleECL;
  END;

  // One Ingest and Specificities Iteration
  runIngest_Text  :=  'NoMatchIngest';
  runIngest_ECL   :=  workmanPreamble(runIngest_Text)+
                        '\nHealthcareNoMatchHeader_InternalLinking.proc_build_all(pSrc,pVersion,pIteration'+
                        ',doIngest:=TRUE'+
                        ',doSpecificities:=TRUE'+
                        ',doInternalGetBase:=TRUE'+
                        ',doInternal:=FALSE'+
                        ',doAppendCRK:=FALSE'+
                        ').All;';
  pRunIngest      :=  wk_ut.mac_ChainWuids(runIngest_ECL, 1, 1, pVersion, [], pPrimaryQueue
                        ,pOutputEcl := pOutECL
                        ,pUniqueOutput := runIngest_Text
                        ,pNotifyEmails := pEmailTo
                        ,pPollingFrequency := pPollingFreq
                        ,pOutputFilename := pWuPrefix + '@version@' + '_@iteration@::WUInfo_' + runIngest_Text
                        ,pOutputSuperfile := pWuSuperfile
                      );

  // Internal Linking Iterations
  runIteration_Text :=  'InternalLinking';
  runIteration_ECL  :=  workmanPreamble(runIteration_Text) +
                        '\nHealthcareNoMatchHeader_InternalLinking.proc_build_all(pSrc,pVersion,pIteration'+
                        ',doIngest:=FALSE'+
                        ',doSpecificities:=FALSE'+
                        ',doInternalGetBase:=FALSE'+
                        ',doInternal:=TRUE'+
                        ',doAppendCRK:=FALSE'+
                        ').All;';
  pRunIterations    :=  wk_ut.mac_ChainWuids(runIteration_ECL, pStartIter, pNumIter, pVersion
                          ,['PreClusterCount','PostClusterCount','MatchesPerformed'], pPrimaryQueue
                          ,pOutputEcl := pOutECL
                          ,pUniqueOutput := runIteration_Text
                          ,pNotifyEmails := pEmailTo
                          ,pPollingFrequency := pPollingFreq
                          ,pOutputFilename := pWuPrefix + '@version@' + '_@iteration@::WUInfo_' + runIteration_Text
                          ,pOutputSuperfile := pWuSuperfile
                          // ,pSetStopCondition :=  pStopCondition
                        );

  //  One Append Customer Record Key Iteration
  runAppendCRK_Text  := 'AppendCustomerRecordKey';
  runAppendCRK_ECL   := workmanPreamble(runAppendCRK_Text)+
                        '\nHealthcareNoMatchHeader_InternalLinking.proc_build_all(pSrc,pVersion,pIteration'+
                        ',doIngest:=FALSE'+
                        ',doSpecificities:=FALSE'+
                        ',doInternalGetBase:=FALSE'+
                        ',doInternal:=FALSE'+
                        ',doAppendCRK:=TRUE'+
                        ').All;';
  pRunAppendCRK     :=  wk_ut.mac_ChainWuids(runAppendCRK_ECL, 1, 1, pVersion, [], pPrimaryQueue
                          ,pOutputEcl := pOutECL
                          ,pUniqueOutput := runAppendCRK_Text
                          ,pNotifyEmails := pEmailTo
                          ,pPollingFrequency := pPollingFreq
                          ,pOutputFilename := pWuPrefix + '@version@' + '_@iteration@::WUInfo_' + runAppendCRK_Text
                          ,pOutputSuperfile := pWuSuperfile
                        );
                        
    //  Build Prep
  pCreateTempFiles  :=  SEQUENTIAL(
                          OUTPUT(pBase,,HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Input.BaseTemp,COMPRESSED,OVERWRITE), // Create Temporary Base file.  This is the deafult base file for the build.
                          OUTPUT(pAsHeader,,HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Input.AsHeaderTemp,COMPRESSED,OVERWRITE) // Create Temporary AsHeader file.  This is the deafult AsHeader file for the build.
                        );
    //  Build Cleanup
  pDeleteTempFiles  :=  SEQUENTIAL(
                          STD.File.DeleteLogicalFile(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Input.BaseTemp),
                          STD.File.DeleteLogicalFile(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Input.AsHeaderTemp)
                        );
                        
  allSteps  :=  SEQUENTIAL(
                  pCreateTempFiles  //  Make Base and Header files available for Workman
                  ,pRunIngest       //  Ingest
                  ,pRunIterations   //  Linking Iterations
                  ,pRunAppendCRK    //  Append Customer Record Key
                  ,pDeleteTempFiles //  Cleanup
                );
                
  RETURN  allSteps;
ENDMACRO;

