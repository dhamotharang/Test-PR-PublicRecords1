IMPORT _CONTROL, Seed_FIles, STD, RoxieKeyBuild;
EXPORT proc_build_InstantId(STRING filedate
                           ,BOOLEAN isDatalandBuild = FALSE
                           ,BOOLEAN pIsTesting = FALSE
                           ,STRING  pServer = _Control.IPAddress.bctlpedata12
                           ,STRING  pDir = '/data/hds_2/InstantIdAndAnalyticsTestSeed/'    
                           ,STRING  pGroupName = STD.System.Thorlib.Group()
                          ) := FUNCTION

	//Spray input files
	spray_infiles	:= Seed_Files.Proc_InstantID_Spray(filedate,pIsTesting,pServer,pDir,pGroupName);
	
	//Build keys
	build_keys := Seed_Files.Proc_InstantID_Keys(filedate,isDatalandBuild);

	//update DOPs
	Email_Recipients := 'TestSeed_ScoringQA@lexisnexisrisk.com, HPCCOperations@lexisnexis.com';
	update_dops	:= RoxieKeyBuild.updateversion('TestseedKeys',filedate,Email_Recipients,,'N');

	//Email
	SHARED email_list := 'TestSeed_ScoringQA@lexisnexisrisk.com, HPCCOperations@lexisnexis.com';
	
  SucessSubject := 'SUCCESS: TestSeedKeys Build ' + filedate + ' Completed on ' + _Control.ThisEnvironment.Name;
  FailureSubject := 'FAILURE: TestSeedKeys Seed Build ' + filedate + ' failed on ' + _Control.ThisEnvironment.Name;
  SuccessBody := 'TestSeedKeys Build ' + filedate + ' Completed and is ready for Cert Roxie deployment.';
  // Added dev messages, because teh _Control.ThisEnvironment.Name - always returns ProdThor if the
  // _Control.ThisEnvironment is defined which is misleading
  SucessSubjectDev := 'SUCCESS: TestSeedKeys Build ' + filedate + ' Completed on dataland';
  FailureSubjectDev := 'FAILURE: TestSeedKeys Seed Build ' + filedate + ' failed on dataland';
  SuccessBodyDev := 'TestSeedKeys Build ' + filedate + ' Completed and is ready for Dev Roxie deployment.';

  build_all_dev := 
    SEQUENTIAL(spray_infiles,build_keys): SUCCESS(fileservices.sendemail(email_list,SucessSubjectDev,SuccessBodyDev)),
                                          FAILURE(fileservices.sendemail(email_list,FailureSubjectDev,workunit + '\n' + failmessage));
  build_all_Prod := 
    SEQUENTIAL(spray_infiles,
                  build_keys,
                  update_dops) : SUCCESS(fileservices.sendemail(email_list,SucessSubject,SuccessBody)),
                                 FAILURE(fileservices.sendemail(email_list,FailureSubject,workunit + '\n' + failmessage));
											
  RETURN  IF(isDatalandBuild,
             build_all_dev,
             build_all_prod);
	
END;	