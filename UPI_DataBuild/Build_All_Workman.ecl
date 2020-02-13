﻿/*2019-10-10T16:52:50Z (Hennigar, Jennifer (RIS-BCT))

*/
IMPORT  STD, UPI_DataBuild, HealthcareNoMatchHeader_Ingest,HealthcareNoMatchHeader_InternalLinking,Workman;
EXPORT  Build_All_Workman(

			pVersion
		, pUseProd
		, gcid
		, pLexidThreshold
		, pHistMode
		, gcid_name
		, pBatch_jobID
		, pAppendOption) := functionmacro

  #WORKUNIT('NAME','Customer Record Key Thor Build for GCID='+gcid);

  //  Set Workman Variables
  isDataland      :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.isDataland;
  pMaxNumIter     :=  UPI_DataBuild.proc_Constants.maxNumIters;
  pPrimaryQueue   :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.primaryQueue; // thor44*
	pSecondaryQueue	:=  UPI_DataBuild.proc_Constants.secondaryQueue; // hthor*
  pWuPrefix       :=  UPI_DataBuild.Filenames_V2(pVersion,pUseProd,gcid,pHistMode).WUPrefix;
  pWuSuperfile    :=  UPI_DataBuild.Filenames_V2(pVersion,pUseProd,gcid,pHistMode).MasterWUOutput_SF;
  pEmailTo        :=  UPI_DataBuild.proc_Constants.emailNotify;
  pPollingFreq    :=  UPI_DataBuild.proc_Constants.pollingFreq;

  //  Common Workman ECL Code
  workmanPreamble(STRING runText)  :=  FUNCTION
    workmanPreambleECL  :=  'IMPORT versioncontrol, _control, ut, tools, UPI_DataBuild;' +
                            '\npVersion  				:= \'@version@\';' +
														'\npUseProd	 				:= '+IF(pUseProd,'TRUE','FALSE')+';' +
														'\ngcid		 	 				:= \''+gcid+'\';' +
														'\npLexidThreshold	:= '+pLexidThreshold+';' +
														'\npHistMode				:= \''+pHistMode+'\';'+
														'\ngcid_name				:= \''+gcid_name+'\';'+
														'\npBatchJobID			:= \''+pBatch_JobID+'\';'+
														'\npAppendOption		:= \''+pAppendOption+'\';' + 
                            '\n#WORKUNIT(\'name\',\'UPI_DataBuild '+runText+' \' + pVersion + \' gcid \' + gcid + \' Batch_JobID \' + pBatchJobID);' +
                            '\n#WORKUNIT(\'priority\',\'high\');' +
														'\n#STORED(\'did_add_force\',\'thor\');' +
                            '\n';
														
    RETURN workmanPreambleECL;
  END;

  step1_Text  :=  'NoMatchBuild_' + gcid + '_' + pbatch_jobID;
  step1_ECL   :=  workmanPreamble(step1_Text)+
                      '\nUPI_DataBuild.Build_All_V2(pVersion,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name'+
											',pBatchJobID,pAppendOption).Step1;';

	// workman code should be called from hthor, and then within the code, switch to other clusters if needed	
  pStep1      :=  Workman.mac_WorkMan(
                        step1_ECL       //  pECL
                        ,pVersion           //  pversion
                        ,pPrimaryQueue      //  pcluster - this is thor400*
                        ,//pStartIteration       = '1'
                        ,//pNumMaxIterations     = '1'
                        ,//pNumMinIterations     = ''
                        ,pWuPrefix + 'workunit_history::UPI_DataBuild' + trim(step1_Text) //  pOutputFilename
                        ,pWuSuperfile       //  pOutputSuperfile
                        ,//pIngestSetResults  //  pSetResults
                        ,//pStopCondition        = '\'\''
                        ,//pSetNameCalculations  = '[]'
                        ,step1_Text     //  pBuildName
                        ,//pESP                  = 'WorkMan._Config.LocalEsp'
                        ,pEmailTo           //  pNotifyEmails
                        ,//pFailureEmails        = ''
                        ,//pShouldEmail          = 'true'
                        ,pPollingFreq       //  pPollingFrequency
                        ,//pForceRun             = 'false' 
                        ,//pForceSkip            = 'false' 
                        ,//pCleanupSuper         = 'false'
                        ,//pDebugValues          = 'dataset([],WsWorkunits.Layouts.DebugValues)'
                        ,//pDont_Wait            = 'false'
                        ,//pParallel             = 'false'
                        ,//pCompileOnly          = 'false'
                      );

	// Scrubs_Text:=	 'Scrubs after LexID Append, before CRK Macro Append';
	// Scrubs_ECL :=	 workmanPreamble(Scrubs_Text) +
					// code to call scrubs goes here
					
  Step2_Text :=  'CallingCRKMacro GCID = ' + gcid + ' JobID = ' + pBatch_jobID;
  Step2_ECL  :=  workmanPreamble(Step2_Text) +
                        '\nUPI_DataBuild.Build_all_V2(pVersion,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name'+
												',pBatchJobID,pAppendOption).Step2;';
  pStep2    :=  Workman.mac_WorkMan(
                        Step2_ECL                //  pECL
                        ,pVersion                       //  pversion
                        ,pSecondaryQueue                //  pcluster 
                        ,//pStartIteration       = '1'
                        ,//pMaxNumIter                    //  pNumMaxIterations
                        ,//pNumMinIterations     = ''
                        ,pWuPrefix + 'workunit_history::UPI_DataBuild' + trim(Step2_Text) //  pOutputFilename  :=  
                        ,pWuSuperfile                   //  pOutputSuperfile
                        ,//pIterationSetResults           //  pSetResults
                        ,//pIterationStopCondition        //  pStopCondition
                        ,//pIterationSetNameCalculations  //  pSetNameCalculations
                        ,Step2_Text              //  pBuildName
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
  Step3_Text  := 'NoMatchResults_' + gcid + '_' + pbatch_jobID;
  Step3_ECL   := workmanPreamble(Step3_Text)+
                        '\nUPI_DataBuild.Build_all_V2(pVersion,pUseProd,gcid,pLexidThreshold,pHistMode,gcid_name'+
												',pBatchJobID,pAppendOption).Step3;';
  pStep3     :=  Workman.mac_WorkMan(
                        Step3_ECL   //  pECL
                        ,pVersion       //  pversion
                        ,pPrimaryQueue  //  pcluster - back to thor400*
                        , //  pStartIteration       = '1'											
                        , //  pNumMaxIterations     = '1'
                        , //  pNumMinIterations     = ''
                        ,pWuPrefix + 'workunit_history::UPI_DataBuild' + trim(Step3_Text) //  pOutputFilename
                        ,pWuSuperfile   //  pOutputSuperfile
                        , //  pSetResults           = '[]'
                        , //  pStopCondition        = '\'\''
                        , //  pSetNameCalculations  = '[]'
                        ,Step3_Text //  pBuildName
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
                    		
  allSteps  :=  SEQUENTIAL(
                  pStep1       	//  ingest file from batch, append lexid, create asheader
									// pScrubs				// 	placeholder for scrubs call - assuming will be after lexid append
                  ,pStep2   		//  call CRK Macro
                  ,pStep3		   	//  transform CRK results into output file and update base file, create metrics, despray results and metrics, clean up
                );
                
  RETURN  allSteps;
ENDMACRO;