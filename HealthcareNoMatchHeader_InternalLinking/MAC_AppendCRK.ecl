IMPORT  STD, HealthcareNoMatchHeader_Ingest,HealthcareNoMatchHeader_InternalLinking,Workman;
EXPORT  MAC_AppendCRK(
    	pSrc            //  Source code for Customer ex. UUID
    , pVersion        //  Build Version ex. (STRING)STD.Date.Today();
    , pBase           //  Base File (Usually output from previous build
    , pAsHeader       //  New AsHeader file to be ingested and linked
)	:=	FUNCTIONMACRO

  #WORKUNIT('NAME','Healthcare NoMatch Customer Record Key for SRC='+pSrc);

  //  Set Workman Variables
  isDataland      :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.isDataland;
  pMaxNumIter     :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.maxNumIters;
  pPrimaryQueue   :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.primaryQueue;
  pWuPrefix       :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).WUPrefix;
  pWuSuperfile    :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).MasterWUOutput_SF;
  pEmailTo        :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.emailNotify;
  pPollingFreq    :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.pollingFreq;

  //  Common Workman ECL Code
  workmanPreamble(STRING runText)  :=  FUNCTION
    workmanPreambleECL  :=  'IMPORT HealthcareNoMatchHeader_InternalLinking,HealthcareNoMatchHeader_Ingest;' +
                            '\npSrc := \''+pSrc+'\';' +
                            '\npVersion  := \'@version@\';' +
                            '\npIteration := \'@iteration@\';' +
                            '\n#WORKUNIT(\'name\',\'HealthcareNoMatchHeader '+runText+' \' + pVersion + \' Src \' + pSrc + \' iter \' + pIteration);' +
                            IF(isDataland,'','\n#WORKUNIT(\'priority\',\'high\');') +
                            '\n';
    RETURN workmanPreambleECL;
  END;

  // One Ingest and Specificities Iteration

  pIngestSetResults :=  [ 'CountOld UpdateStatsXtab[1].cnt_old'
                          ,'CountUnchanged UpdateStatsXtab[1].cnt_unchanged'
                          ,'CountUpdated UpdateStatsXtab[1].cnt_updated'
                          ,'CountNew UpdateStatsXtab[1].cnt_new'
                          ,'PercentTotalOld UpdateStatsXtab[1].pct_tot_old'
                          ,'PercentTotalUnchanged UpdateStatsXtab[1].pct_tot_unchanged'
                          ,'PercentTotalUpdated UpdateStatsXtab[1].pct_tot_updated'
                          ,'PercentTotalNew UpdateStatsXtab[1].pct_tot_new'
                          ,'PercentIngestUnchanged UpdateStatsXtab[1].pct_ingest_unchanged'
                          ,'PercentIngestUpdated UpdateStatsXtab[1].pct_ingest_updated'
                          ,'PercentIngestNew UpdateStatsXtab[1].pct_ingest_new'
                        ];
  runIngest_Text  :=  'NoMatchIngest';
  runIngest_ECL   :=  workmanPreamble(runIngest_Text)+
                      '\nHealthcareNoMatchHeader_InternalLinking.proc_build_all(pSrc,pVersion,pIteration'+
                      ',doIngest:=TRUE'+
                      ',doSpecificities:=TRUE'+
                      ',doInternalGetBase:=TRUE'+
                      ',doInternal:=FALSE'+
                      ',doAppendCRK:=FALSE'+
                      ').All;';
  pRunIngest      :=  Workman.mac_WorkMan(
                        runIngest_ECL       //  pECL
                        ,pVersion           //  pversion
                        ,pPrimaryQueue      //  pcluster
                        , //  pStartIteration       = '1'
                        , //  pNumMaxIterations     = '1'
                        , //  pNumMinIterations     = ''
                        ,pWuPrefix + 'workunit_history::HealthcareNotMatchHeader.iterations.' + trim(runIngest_Text) //  pOutputFilename
                        ,pWuSuperfile       //  pOutputSuperfile
                        ,pIngestSetResults  //  pSetResults
                        , //  pStopCondition        = '\'\''
                        , //  pSetNameCalculations  = '[]'
                        ,runIngest_Text     //  pBuildName
                        , //  pESP                  = 'WorkMan._Config.LocalEsp'
                        ,pEmailTo           //  pNotifyEmails
                        , //  pFailureEmails        = ''
                        , //  pShouldEmail          = 'true'
                        ,pPollingFreq       //  pPollingFrequency
                        , //  pForceRun             = 'false' 
                        , //  pForceSkip            = 'false' 
                        , //  pCleanupSuper         = 'false'
                        , //  pDebugValues          = 'dataset([],WsWorkunits.Layouts.DebugValues)'
                        , //  pDont_Wait            = 'false'
                        , //  pParallel             = 'false'
                        , //  pCompileOnly          = 'false'
                      );

  // Internal Linking Iterations
  pIterationSetResults          :=  [ 'PreClusterCount PreClusterCount.nomatch_id'        
                                      ,'PostClusterCount PostClusterCount.nomatch_id'       
                                      ,'MatchesPerformed'      
                                      ,'BasicMatchesPerformed'
                                      ,'SlicesPerformed'
                                    ];
  pIterationStopCondition       :=  '(PostClusterCount / PreClusterCount * 100.0) > (99.9)';
  pIterationSetNameCalculations :=  ['Convergence_PCT','Convergence_Threshold'];
  runIteration_Text :=  'InternalLinking';
  runIteration_ECL  :=  workmanPreamble(runIteration_Text) +
                        '\nHealthcareNoMatchHeader_InternalLinking.proc_build_all(pSrc,pVersion,pIteration'+
                        ',doIngest:=FALSE'+
                        ',doSpecificities:=FALSE'+
                        ',doInternalGetBase:=FALSE'+
                        ',doInternal:=TRUE'+
                        ',doAppendCRK:=FALSE'+
                        ').All;';
  pRunIterations    :=  Workman.mac_WorkMan(
                        runIteration_ECL                //  pECL
                        ,pVersion                       //  pversion
                        ,pPrimaryQueue                  //  pcluster
                        , //  pStartIteration       = '1'
                        ,pMaxNumIter                    //  pNumMaxIterations
                        , //  pNumMinIterations     = ''
                        ,pWuPrefix + 'workunit_history::HealthcareNotMatchHeader.iterations.' + trim(runIteration_Text) //  pOutputFilename  :=  
                        ,pWuSuperfile                   //  pOutputSuperfile
                        ,pIterationSetResults           //  pSetResults
                        ,pIterationStopCondition        //  pStopCondition
                        ,pIterationSetNameCalculations  //  pSetNameCalculations
                        ,runIteration_Text              //  pBuildName
                        , //  pESP                  = 'WorkMan._Config.LocalEsp'
                        ,pEmailTo                       //  pNotifyEmails
                        , //  pFailureEmails        = ''
                        , //  pShouldEmail          = 'true'
                        ,pPollingFreq                   //  pPollingFrequency
                        , //  pForceRun             = 'false' 
                        , //  pForceSkip            = 'false' 
                        , //  pCleanupSuper         = 'false'
                        , //  pDebugValues          = 'dataset([],WsWorkunits.Layouts.DebugValues)'
                        , //  pDont_Wait            = 'false'
                        , //  pParallel             = 'false'
                        , //  pCompileOnly          = 'false'
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
  pRunAppendCRK     :=  Workman.mac_WorkMan(
                        runAppendCRK_ECL   //  pECL
                        ,pVersion       //  pversion
                        ,pPrimaryQueue  //  pcluster
                        , //  pStartIteration       = '1'
                        , //  pNumMaxIterations     = '1'
                        , //  pNumMinIterations     = ''
                        ,pWuPrefix + 'workunit_history::HealthcareNotMatchHeader.iterations.' + trim(runAppendCRK_Text) //  pOutputFilename
                        ,pWuSuperfile   //  pOutputSuperfile
                        , //  pSetResults           = '[]'
                        , //  pStopCondition        = '\'\''
                        , //  pSetNameCalculations  = '[]'
                        ,runAppendCRK_Text //  pBuildName
                        , //  pESP                  = 'WorkMan._Config.LocalEsp'
                        ,pEmailTo       //  pNotifyEmails
                        , //  pFailureEmails        = ''
                        , //  pShouldEmail          = 'true'
                        ,pPollingFreq   //  pPollingFrequency
                        , //  pForceRun             = 'false' 
                        , //  pForceSkip            = 'false' 
                        , //  pCleanupSuper         = 'false'
                        , //  pDebugValues          = 'dataset([],WsWorkunits.Layouts.DebugValues)'
                        , //  pDont_Wait            = 'false'
                        , //  pParallel             = 'false'
                        , //  pCompileOnly          = 'false'
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

