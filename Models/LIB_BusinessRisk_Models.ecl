﻿
// This MODULE EXPORTs all of our BusinessRisk model calls.  By doing this, each library 
// can request a specific module and thus only those models are compiled.

IMPORT Business_Risk_BIP, Models, Risk_Indicators, RiskView, RiskWise;

// Including these blank defaults for retrieving the sets of Valid Models without having 
// to pass in Business Shell or Arguments. This way when creating a new model we only need 
// to update one section of the code to plug the model in (Models.LIB_BusinessRisk_Models)
blankBusShell  := GROUP(DATASET([], Business_Risk_BIP.Layouts.Shell), Seq);
blankArguments := MODULE(Models.BR_LIBIN) END;
blankBocaShell := GROUP(DATASET([], Risk_Indicators.Layout_Boca_Shell), Seq);
blankiid       := GROUP(DATASET([],Risk_Indicators.Layout_Output), Seq);
blankips       := DATASET([],riskwise.Layout_IP2O);


EXPORT LIB_BusinessRisk_Models(
											GROUPED DATASET(Business_Risk_BIP.Layouts.Shell) busShell = blankBusShell,		
											Models.BR_LIBIN arguments = blankArguments,
											GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) bocaShell = blankBocaShell,
                      GROUPED DATASET(Risk_Indicators.Layout_Output) iid = blankiid,
                      DATASET(riskwise.Layout_IP2O) ips = blankips,
                      unsigned1 DPPA=0, unsigned1 GLB=0,
                      string DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
                      string DataPermission=risk_indicators.iid_constants.default_DataPermission
																							) := INLINE MODULE

	SHARED modelName				:= StringLib.StringToUpperCase(arguments.modelName);
	SHARED customInputs			:= arguments.Custom_Inputs; // not used
	
	// Model Validation -- Use this when trying to validate a new model through the LNSmallBusiness.SmallBusiness_BIP_Service.
	EXPORT TurnOnValidation := FALSE; // When TRUE allows for Layout_Debug to be OUTPUT from SmallBusiness_BIP_Service
	// EXPORT TurnOnValidation := TRUE; // When TRUE allows for Layout_Debug to be OUTPUT from SmallBusiness_BIP_Service

	
	
	 EXPORT ValidatingModel := Models.BBFM1906_1_0(bocaShell,busShell); // Change this to the model you are trying to validate	

	// The calcIndex function returns the 'billing_index' given the report_option
	// value. billing_index is needed by batch.  it is passed to the ESP logging
	// server which performs a calculation to determine the actual report option.
	// This confusion is all caused by legacy logging code.
	SHARED calcIndex (UNSIGNED2 ourIndex) := ourIndex + 70; 
	
	/* *****************************************************************************
   *                  STEPS WHEN ADDING A NEW BusinessRisk Model                 *
   *******************************************************************************
   * 1.) Add the new model to the set of BusinessRisk_Models                     *
   *      calcIndex() should be set with the desired report_option of the model  *
   *      calcIndex will return the actual 'billing_index' which batch needs     *   
   * 2.) Add the new model to the BusinessRisk_Models                                      *
   ***************************************************************************** */
			
	EXPORT BusinessRisk_Models := 
			DATASET([ // Model Name    |  Output Name  |  Model Index  | Model Type
								//       v       |       v       |       v       |    v
									{'SBBM1601_0_0', 'SBBM1601_0_0', calcIndex( 46), '0-999'}, //blended
									{'SBOM1601_0_0', 'SBOM1601_0_0', calcIndex( 47), '0-999'}, //not blended
									// We don't think the above 2 models are actually being used or reported to anyone except here.
									// FCRA uses logger which requires the calcIndex. For future (nonFCRA) models, we don't need to use calcIndex(). We can use the same value
									// that is housed in ESP.
									{'SLBB1702_0_2', 'SLBB1702_0_2', 5, '0-999'}, //blended
                  {'SLBO1702_0_2', 'SLBO1702_0_2', 6, '0-999'}, //not blended
									{'SLBB1809_0_0', 'SLBB1809_0_0', 7, '0-999'}, //blended
									{'SLBO1809_0_0', 'SLBO1809_0_0', 8, '0-999'}, //not blended
                  //V101 attributes is 9
                  {'BBFM1808_1_0', 'BBFM1808_1_0', 10, '0-999'}, //blended 
                  {'BOFM1812_1_0', 'BOFM1812_1_0', 11, '0-999'}, //not blended, business only
                  {'BBFM1811_1_0', 'BBFM1811_1_0', 12, '0-999'}, //blended  
                  {'BBFM1903_1_0', 'BBFM1903_1_0', 13, '0-999'}, //blended  
                  {'BBFM1906_1_0', 'BBFM1906_1_0', 16, '0-999'}, //blended  
								// ------------------- FAKE MODELS - STATIC SCORE AND REASON CODES ------------------
									{'SBBM9999_9'  , 'SBBM9999_9'  , 0             , '0-999'},
									{'SBOM9999_9'  , 'SBOM9999_9'  , 0             , '0-999'}
								// ----------------------------------------------------------------------------------
							 ], RiskView.Layouts.Model_Constants);
	
	// If validation is enabled, only compile that model, else compile all SmallBusinessModels Models
	#if(TurnOnValidation)
	EXPORT SmallBusinessModels := ValidatingModel;
	#else
	EXPORT SmallBusinessModels := CASE(modelName,
											// -------------------------------- FLAGSHIP MODELS ---------------------------------
											'SBBM1601_0_0' => UNGROUP(Models.SBBM1601_0_0(busShell, bocaShell)),
											'SBOM1601_0_0' => UNGROUP(Models.SBOM1601_0_0(busShell)),
											'SLBB1702_0_2' => UNGROUP(Models.SLBB1702_0_2(busShell, bocaShell)),
											'SLBB1809_0_0' => UNGROUP(Models.SLBB1809_0_0(busShell, bocaShell)),
											'SLBO1702_0_2' => UNGROUP(Models.SLBO1702_0_2(busShell)),
											'SLBO1809_0_0' => UNGROUP(Models.SLBO1809_0_0(busShell)),
											// ----------------------------------------------------------------------------------
											// --------------------------------- CUSTOM MODELS ----------------------------------
                      'BBFM1808_1_0' => UNGROUP(Models.BBFM1808_1_0(bocaShell,busShell)),
                      'BOFM1812_1_0' => UNGROUP(Models.BOFM1812_1_0(busShell)),
                      'BBFM1811_1_0' => UNGROUP(Models.BBFM1811_1_0(bocaShell,iid,'',ips,false,DPPA,GLB,DataRestriction,DataPermission,'',busShell,54)),
                      'BBFM1903_1_0' => UNGROUP(Models.BBFM1903_1_0(bocaShell,busShell)),
                      'BBFM1906_1_0' => UNGROUP(Models.BBFM1906_1_0(bocaShell,busShell)),											
											// ----------------------------------------------------------------------------------
											// ------------------- FAKE MODELS - STATIC SCORE AND REASON CODES ------------------
											'SBBM9999_9' => UNGROUP(Models.FAKE_1_0(busShell, 'BR')),
											'SBOM9999_9' => UNGROUP(Models.FAKE_1_0(busShell, 'BR')),
											
											// ----------------------------------------------------------------------------------
											/* default */  DATASET([], Models.Layout_ModelOut));
	#end
END;
