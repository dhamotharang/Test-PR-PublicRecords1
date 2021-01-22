IMPORT  STD, UPI_DataBuild__old, HealthcareNoMatchHeader_Ingest,HealthcareNoMatchHeader_InternalLinking,Workman;

EXPORT Cleanup_NoSave_Files_Workman(pAsOfDate):= functionmacro

  #WORKUNIT('NAME','NoSave File CleanUp For Customer Record Key');

  //  Set Workman Variables
  isDataland      :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.isDataland;
  pMaxNumIter     :=  UPI_DataBuild__old.proc_Constants.maxNumIters;
  pPrimaryQueue   :=  HealthcareNoMatchHeader_InternalLinking.proc_Constants.primaryQueue; // thor44*
	pSecondaryQueue	:=  UPI_DataBuild__old.proc_Constants.secondaryQueue; // hthor*
  pWuPrefix       :=  UPI_DataBuild__old.Filenames_V2(pVersion,pUseProd,gcid,pHistMode).WUPrefix;
  pWuSuperfile    :=  UPI_DataBuild__old.Filenames_V2(pVersion,pUseProd,gcid,pHistMode).MasterWUOutput_SF;
  pEmailTo        :=  UPI_DataBuild__old.proc_Constants.emailNotify;
  pPollingFreq    :=  UPI_DataBuild__old.proc_Constants.pollingFreq;

  //  Common Workman ECL Code
  workmanPreamble(STRING runText)  :=  FUNCTION
    workmanPreambleECL  :=  'IMPORT versioncontrol, _control, ut, tools, UPI_DataBuild__old;' +
		
                            '\npAsOfDate 				:= \''+pAsOfDate+'\';' +		
                            '\n#WORKUNIT(\'name\',\'UPI_DataBuild '+runText+' \' + \' Cleanup Files for NoSave Customers \' );' +
                            '\n#WORKUNIT(\'priority\',\'high\');' +
                            '\n';
														
    RETURN workmanPreambleECL;
  END;

  step1_Text  :=  'CleanUp_NoSave_Files';
  step1_ECL   :=  workmanPreamble(step1_Text)+
                      '\nUPI_DataBuild__old.Cleanup_NoSave_All(pAsOfDate).step1';

	// workman code should be called from hthor, and then within the code, switch to other clusters if needed	
  pStep1      :=  Workman.mac_WorkMan(
                        step1_ECL       //  pECL
                        ,pAsOfDate	
                        ,pSecondaryQueue      //  pcluster - this is hthor
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

  Step2_Text :=  'Cleanup_NoSave_Linking_Files';
  Step2_ECL  :=  workmanPreamble(Step2_Text) +
                        '\nUPI_DataBuild__old.Cleanup_NoSave_All(pAsOfDate).Step2;';
  pStep2    :=  Workman.mac_WorkMan(
                        Step2_ECL                //  pECL
                        ,pAsOfDate                       //  pversion
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
  allSteps  :=  SEQUENTIAL(
                  pStep1       	//  clean up input, processed, base, asheader, temp header, to batch, metrics
                  ,pStep2   		//  clean up linking files
                );
                
  RETURN  allSteps;
ENDMACRO;