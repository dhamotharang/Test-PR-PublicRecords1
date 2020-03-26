IMPORT  STD, HealthcareNoMatchHeader_Ingest,HealthcareNoMatchHeader_InternalLinking,Workman;
EXPORT  MAC_AppendCRK(
    	pSrc            //  Source code for Customer ex. UUID
    , pVersion        //  Build Version ex. (STRING)STD.Date.Today();
    , pBaseName       //  Base File (Usually output from previous build
    , pAsHeaderName   //  New AsHeader file to be ingested and linked
    
    // Email List for Workman Notifications
    , pWorkmanEmailTo = 'HealthcareNoMatchHeader_InternalLinking.proc_Constants.emailNotify'

    // Ingest
    , doIngest    = TRUE // perform full ingest process (ingest incremental and non-incremental sources into existing base file)
   
    // Internal Linking
    , doInternalLinking  = TRUE // perform internal linking
	
    // Append CRK
    , doAppendCRK = TRUE // Append CRK to Internal Linking Base File
)	:=	FUNCTIONMACRO

  wuName  :=  'Healthcare NoMatch Customer Record Key for SRC='+pSrc;
  #WORKUNIT('NAME',wuName);
  isRunning :=  HealthcareNoMatchHeader_InternalLinking.Proc_CRKRunningCheck(wuName);

  //  Set Workman Variables
  isDataland      :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.isDataland;
  pMaxNumIter     :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.maxNumIters;
  pPrimaryQueue   :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.primaryQueue;
  pWuPrefix       :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).WUPrefix;
  pWuIterations   :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).WUIterations;
  pWuSuperfile    :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).MasterWUOutput_SF;
  pEmailTo        :=  pWorkmanEmailTo;
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
                        ,pWuPrefix + pWuIterations + trim(runIngest_Text) //  pOutputFilename
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
                          ,pWuPrefix + pWuIterations + trim(runIteration_Text) //  pOutputFilename  :=  
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
  pAppendCRKSetResults  :=  [ 'Source Stats[3].val1'
                              ,'SourceName Stats[4].val1'
                              ,'TotalRecordCount Stats[6].val1'
                              ,'TotalLexIDsAppended Stats[7].val1'
                              ,'TotalMinors Stats[8].val1'
                              ,'TotalSingletons Stats[9].val1'
                              ,'TotalSingletonsWithNoLexID Stats[10].val1'
                              ,'TotalSingletonsWithLexID Stats[11].val1'
                              ,'TotalRecordsWithNoLexIDInALexIDCluster Stats[12].val1'
                              ,'TotalNonSingletonClusters Stats[14].val1'
                              ,'ClustersWithNoLexID Stats[16].val1'
                              ,'ClustersWithUniqueLexID Stats[17].val1'
                              ,'ClustersWithMultipleNoMatchIDs Stats[18].val1'
                              ,'ClustersWithMultipleLexIDs Stats[22].val1'
                              ,'ClustersWithMultipleNames Stats[23].val1'
                              ,'ClustersWithMultipleDOBs Stats[24].val1'
                              ,'ClustersWithMultipleAddresses Stats[25].val1'
                            ];
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
                          ,pWuPrefix + pWuIterations + trim(runAppendCRK_Text) //  pOutputFilename
                          ,pWuSuperfile   //  pOutputSuperfile
                          ,pAppendCRKSetResults //  pSetResults
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
                          IF(pBaseName='', // If Basefile name is blank then create an empty basefile
                            OUTPUT(DATASET([],HealthcareNoMatchHeader_InternalLinking.Layout_Header),,HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Input.BaseTemp,THOR,OVERWRITE),
                            IF(pBaseName<>HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Input.BaseTemp,
                              STD.File.Copy(pBaseName,tools.Constants('').Groupname,HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Input.BaseTemp,,,,,TRUE,,,TRUE)
                            )
                          ),
                          IF(pAsHeaderName<>HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Input.AsHeaderTemp,
                            STD.File.Copy(pAsHeaderName,tools.Constants('').Groupname,HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Input.AsHeaderTemp,,,,,TRUE,,,TRUE)
                          )
                        );
    //  Build Cleanup
  pDeleteTempFiles  :=  SEQUENTIAL(
                          STD.File.DeleteLogicalFile(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Input.BaseTemp),
                          STD.File.DeleteLogicalFile(HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Input.AsHeaderTemp)
                        );
                        
	alreadyRunningFail := OUTPUT('MAC_AppendCRK process is already running for SRC='+pSrc);
                        
  allSteps  :=  IFF(isRunning,
                  alreadyRunningFail,
                  SEQUENTIAL(
                    IFF(doIngest, SEQUENTIAL(pCreateTempFiles,pRunIngest,pDeleteTempFiles), OUTPUT('Ingest Skipped.'))                           //  Ingest
                    ,IFF(doInternalLinking, pRunIterations, OUTPUT('Internal Linking Build Skipped.'))     //  Linking Iterations
                    ,IFF(doAppendCRK, pRunAppendCRK, OUTPUT('Append Customer Record Key Skipped.')) //  Append Customer Record Key
                  )
                );
                
  RETURN  allSteps;
ENDMACRO;
