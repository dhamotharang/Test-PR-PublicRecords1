IMPORT BusinessInstantID20_Services, BusinessCredit_Services, Business_Risk_BIP, LNSmallBusiness, Risk_Indicators;

//Creating this module to help diminish the crowdedness in fn_getModels and for adjusting 
//Boca Shell configurations based on Business Shell version & models being requested
EXPORT modSetBocaShellConfigurations() := MODULE


  //Boca Shell options
  //including some Boca Shell options, but do feel free to add others if they are 
  //needed for any future model being implemented in BIID2.0
  SHARED UNSIGNED bsOption1 := Risk_Indicators.iid_constants.BSOptions.RetainInputDID;
  SHARED UNSIGNED bsOption2 := Risk_Indicators.iid_constants.BSOptions.IncludeDoNotMail;
  SHARED UNSIGNED bsOption3 := Risk_Indicators.iid_constants.BSOptions.IncludeFraudVelocity;
  SHARED UNSIGNED bsOption4 := Risk_Indicators.iid_constants.BSOptions.IncludeHHIDSummary;
  SHARED UNSIGNED bsOption5 := Risk_Indicators.iid_constants.BSOptions.RunThreatMetrix;
  SHARED UNSIGNED bsOption6 := Risk_Indicators.iid_constants.BSOptions.TurnOffTumblings;
  SHARED UNSIGNED bsOption7 := Risk_Indicators.iid_constants.BSOptions.UseIngestDate;
  SHARED UNSIGNED bsOption8 := Risk_Indicators.iid_constants.BSOptions.UseIngestDate;


  //default Boca Shell options in fn_getModels for BII2.0 
  SHARED UNSIGNED defaultBocaShellOptionsBII20 := bsOption1+ 
                                                  bsOption3+
                                                  bsOption6;

  //models that may be requested
  SHARED STRING modelName1 := BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM_NSBFEWITHEXP; //BBFM1903_1_0 
  SHARED STRING modelName2 := BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM;              //BBFM1808_1_0
  SHARED STRING modelName3 := BusinessCredit_Services.Constants.BBFM1906_1_0;                    //BBFM1906_1_0
  SHARED STRING modelName4 := 'TEST_MOD_1_0';                                                    //Fake model for unit testing. Can be included in BIID20ModelsSet for testing
  

  
  //represents all models currently implemented in BIID2.0
  //any new model should be added to this set and referenced in 
  //the helper function setBocaShellOptions based on their priority 
  SHARED SET OF STRING BIID20ModelsSet := [modelName1, 
                                           modelName2,
                                           modelName3];



  //helper function to set the Boca Shell version based on the model(s) requested and/or Business Shell version
  EXPORT setBocaShellVersion(DATASET(LNSmallBusiness.Layouts.ModelNameRec) modelsRequested, UNSIGNED1 businessShellVersion) := FUNCTION

    bocaShellVersion := MAP(EXISTS(modelsRequested(ModelName = BIID20ModelsSet[1] OR ModelName = BIID20ModelsSet[2] OR ModelName = BIID20ModelsSet[3])) => 54,                                
                            businessShellVersion = Business_Risk_BIP.Constants.BusShellVersion_v22 => 51, 
                            50);
    
    // OUTPUT(modelsRequested, NAMED('modelsRequestedVersion'));                          
    // OUTPUT(bocaShellVersion, NAMED('bocaShellVersion')); 

    RETURN bocaShellVersion; 
                 
  END;
  
  
  
  //helper function to set the Boca Shell options based on the model(s) requested 
  EXPORT setBocaShellOptions(DATASET(LNSmallBusiness.Layouts.ModelNameRec) modelsRequested) := FUNCTION
  
    setBocaShellOptions := MAP(EXISTS(modelsRequested(ModelName = BIID20ModelsSet[1])) => bsOption1+
                                                                                          bsOption2+
                                                                                          bsOption3+
                                                                                          bsOption4,
                                                                                
                               defaultBocaShellOptionsBII20);

    // OUTPUT(modelsRequested, NAMED('modelsRequestedOptions'));                          
    // OUTPUT(setBocaShellOptions, NAMED('setBocaShellOptions'));  

    RETURN setBocaShellOptions; 

  END;
  
  
  //debugging options
  // EXPORT defaultBocaShellOptionsBII20;
  // EXPORT businessShellVersion;
  // EXPORT BIID20ModelsSet;
  
END;
