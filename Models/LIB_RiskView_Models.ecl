// This MODULE EXPORTs all of our model calls.  By doing this, each library can request a specific module and thus only those models are compiled.

IMPORT Models, Risk_Indicators, RiskView;

// Including these blank defaults for retrieving the sets of Valid Models without having to pass in Boca Shell or Arguments
// This way when creating a new model we only need to update one section of the code to plug the model in (Models.LIB_RiskView_Models)
blankShell := GROUP(DATASET([], Risk_Indicators.Layout_Boca_Shell), Seq);
blankArguments := MODULE(Models.RV_LIBIN)
									END;

EXPORT LIB_RiskView_Models (
											GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) BocaShell = blankShell,
											Models.RV_LIBIN arguments = blankArguments
																							) := INLINE MODULE

	SHARED modelName				:= StringLib.StringToUpperCase(arguments.modelName);
	SHARED intendedPurpose	:= StringLib.StringToUpperCase(arguments.IntendedPurpose);
	SHARED lexIDOnlyOnInput := arguments.LexIDOnlyOnInput;
	SHARED isCalifornia			:= arguments.isCalifornia;
	SHARED preScreenOptOut	:= arguments.preScreenOptOut;
	SHARED returnCode				:= arguments.returnCode;
	SHARED payFrequency			:= arguments.payFrequency;
	SHARED customInputs			:= arguments.Custom_Inputs;
	shared isPreScreenPurpose := StringLib.StringToUpperCase(intendedPurpose) = 'PRESCREENING';
	
	/* Model Validation -- Use this when trying to validate a new model through the RiskView.Search_Service */
 EXPORT TurnOnValidation := FALSE; // When TRUE allows for Layout_Debug to be OUTPUT in the Search_Service
	 // EXPORT TurnOnValidation := TRUE; // When TRUE allows for Layout_Debug to be OUTPUT in the RiskView.Search_Service
	
	
	EXPORT ValidatingModel := Models.RVA1811_1_0(BocaShell,FALSE); // Change this to the model you are tring to validate
	
	
	// Version 4.0
	EXPORT V40Models := CASE(modelName,
											// -------------------------------- FLAGSHIP MODELS ---------------------------------
											'RVR1103_0' => UNGROUP(Models.RVR1103_0_0(BocaShell, isCalifornia, preScreenOptOut)),
											'RVG1103_0' => UNGROUP(Models.RVG1103_0_0(BocaShell, isCalifornia, preScreenOptOut)),
											'RVA1104_0' => UNGROUP(Models.RVA1104_0_0(BocaShell, isCalifornia, preScreenOptOut)),
											'RVP1104_0' => UNGROUP(Models.RVP1104_0_0(BocaShell, isCalifornia, preScreenOptOut)),
											'RVT1104_0' => UNGROUP(Models.RVT1104_0_0(BocaShell, isCalifornia, preScreenOptOut)),
											'RVB1104_0' => UNGROUP(Models.RVB1104_0_0(BocaShell, isCalifornia, preScreenOptOut)),
											// ----------------------------------------------------------------------------------
											// --------------------------------- CUSTOM MODELS ----------------------------------
											'RVC1112_0' => UNGROUP(Models.RVC1112_0_0(BocaShell, isCalifornia, preScreenOptOut)),
											'RVR1104_3' => UNGROUP(Models.RVR1104_3_0(BocaShell, isCalifornia, preScreenOptOut)),
											'RVT1104_1' => UNGROUP(Models.RVT1104_1_0(BocaShell, isCalifornia, preScreenOptOut)),
											'RVG1106_1' => UNGROUP(Models.RVG1106_1_0(BocaShell, isCalifornia, preScreenOptOut)),
											'RVD1110_1' => UNGROUP(Models.RVD1110_1_0(BocaShell, isCalifornia, preScreenOptOut)),
											'RVR1104_2' => UNGROUP(Models.RVR1104_2_0(BocaShell, isCalifornia, preScreenOptOut)),
											'RVG1201_1' => UNGROUP(Models.RVG1201_1_0(BocaShell, isCalifornia, preScreenOptOut)),
											'RVT1204_1' => UNGROUP(Models.RVT1204_1(BocaShell, isCalifornia)),
											'RVT1210_1' => UNGROUP(Models.RVT1210_1_0(BocaShell, isCalifornia, preScreenOptOut)),
											'RVR1303_1' => UNGROUP(Models.RVR1303_1_0(BocaShell, isCalifornia)),
											// ----------------------------------------------------------------------------------
																		 DATASET([], Models.Layout_ModelOut));
	
	// Version 4.1
	EXPORT V41Models := CASE(modelName,
											// -------------------------------- FLAGSHIP MODELS ---------------------------------  
											//              There are no Flagship V4.1 Models, only Custom V4.1
											// ----------------------------------------------------------------------------------
											// --------------------------------- CUSTOM MODELS ----------------------------------
											'RVC1210_1' => UNGROUP(Models.RVC1210_1_0(BocaShell, isCalifornia, preScreenOptOut, returnCode, payFrequency)),
											'RVT1212_1' => UNGROUP(Models.RVT1212_1_0(BocaShell, isCalifornia)),
											'RVG1302_1' => UNGROUP(Models.RVG1302_1_0(BocaShell, isCalifornia)),
											'RVA1304_1' => UNGROUP(Models.RVA1304_1_0(BocaShell, isCalifornia)),
											'RVA1304_2' => UNGROUP(Models.RVA1304_2_0(BocaShell, isCalifornia)),
											'RVG1304_1' => UNGROUP(Models.RVG1304_1_0(BocaShell, isCalifornia)),
											'RVG1304_2' => UNGROUP(Models.RVG1304_2_0(BocaShell, isCalifornia)),
											'RVA1306_1' => UNGROUP(Models.RVA1306_1_0(BocaShell, isCalifornia)),
											'RVA1305_1' => UNGROUP(Models.RVA1305_1_0(BocaShell, isCalifornia, FALSE)),
											'RVA1305_9' => UNGROUP(Models.RVA1305_1_0(BocaShell, isCalifornia, TRUE)),
											'RVA1309_1' => UNGROUP(Models.RVA1309_1_0(BocaShell, isCalifornia)),
											'RVA1310_1' => UNGROUP(Models.RVA1310_1_0(BocaShell, isCalifornia)),
											'RVA1310_2' => UNGROUP(Models.RVA1310_2_0(BocaShell, isCalifornia)),
											'RVA1310_3' => UNGROUP(Models.RVA1310_3_0(BocaShell, isCalifornia)),
											'RVT1307_3' => UNGROUP(Models.RVT1307_3_0(BocaShell, isCalifornia, TRUE)),
											'RVA1311_1' => UNGROUP(Models.RVA1311_1_0(BocaShell, isCalifornia)),
											'RVA1311_2' => UNGROUP(Models.RVA1311_2_0(BocaShell, isCalifornia)),
											'RVA1311_3' => UNGROUP(Models.RVA1311_3_0(BocaShell, isCalifornia)),
											'RVG1401_1' => UNGROUP(Models.RVG1401_1_0(BocaShell, isCalifornia)),
											'RVG1401_2' => UNGROUP(Models.RVG1401_2_0(BocaShell, isCalifornia)),
											// ----------------------------------------------------------------------------------
																		 DATASET([], Models.Layout_ModelOut));

	// Version 5.0
	SHARED MType_A := 'Auto';
	SHARED MType_B := 'BankCard';
	SHARED MType_G := 'ShortTermLending';
	SHARED MType_T := 'Telecom';
	SHARED MType_S := 'CrossIndustry';
	SHARED MType_D := 'Digital';
  
	// calcIndex returns the 'billing_index' given the report_option value.
	// billing_index is needed by batch.  it is passed to the ESP logging server
	// which performs a calculation to determine the actual report option.
	// this confusion is all cause by legacy logging code.
	SHARED calcIndex (UNSIGNED2 ourIndex) := ourIndex + 70; 
	
	/* *****************************************************************************
   *                  STEPS WHEN ADDING A NEW VERSION 5 MODEL                    *
   *******************************************************************************
   * 1.) Add the new model to the set of ValidV50Models                          *
   *      calcIndex() should be set with the desired report_option of the model  *
   *      calcIndex will return the actuall 'billing_index' which batch needs    *
   * 2.) Add the new model to the V50Models                                      *
   ***************************************************************************** */


/*
FCRA Logger is used for Batch and XML. For FCRA we need to use the calcIndex(which adds 70).
As the Logger does this code:
if( modelIdentifier >= 100 ){
		position = (modelIdentifier % 100) + 30; 
By us adding 70 in ECL, the logger will convert it to be the same value that ESP has and the value
that is sent INTO calcindex for ECL.
*/

	EXPORT ValidV50Models := DATASET([// Model Name |    Output Name     | Model Index   | Model Type
                                    //     v      |         v          |    v          |    v
																  {'RVS1706_0', MType_S+'RVS1706_0', calcIndex( 39), '0-999', 0}, //RV Crossindustry Flaghips
																			{'RVA1503_0', MType_A+'RVA1503_0', calcIndex( 40), '0-999', 0},
																			{'RVB1503_0', MType_B+'RVB1503_0', calcIndex( 41), '0-999', 0},
																			{'RVG1502_0', MType_G+'RVG1502_0', calcIndex( 42), '0-999', 0},
																			{'RVT1503_0', MType_T+'RVT1503_0', calcIndex( 43), '0-999', 0},
																		  {'RVA1504_1', MType_A+'RVA1504_1', calcIndex( 44), '0-999', 0},
																		  {'RVA1504_2', MType_A+'RVA1504_2', calcIndex( 45), '0-999', 0},
																			{'RVG1601_1', MType_G+'RVG1601_1', calcIndex( 46), '0-999', 0},
																			{'RVT1601_1', MType_T+'RVT1601_1', calcIndex( 47), '0-999', 0},
																			{'RVA1603_1', MType_A+'RVA1603_1', calcIndex( 48), '0-999', 0},
																			//Note - MLA1608_0 uses 2 billing indexes below (offsets 49 and 52)
																			{'RVG1511_1', MType_G+'RVG1511_1', calcIndex( 50), '0-999', 0},
																			{'RVG1605_1', MType_G+'RVG1605_1', calcIndex( 51), '0-999', 0},
																			{'MLA1608_0', 'MLA1608_0', calcIndex( 52), '', calcIndex( 49)}, //Military Lending Act (Equifax gateway)
																			//place hold for #53 between #52 and #54 ( as I just realized now #53 doesn’t exist.)
																			{'RVA1607_1', MType_A+'RVA1607_1', calcIndex( 54), '0-999', 0},
																			{'RVP1605_1', MType_G+'RVP1605_1', calcIndex( 55), '0-999', 0},
																		  {'RVA1605_1', MType_A+'RVA1605_1', calcIndex( 56), '0-999', 0},
																			{'RVA1601_1', MType_A+'RVA1601_1', calcIndex( 57), '0-999', 0}, //Harley
																			{'RVT1608_1', MType_T+'RVT1608_1', calcIndex( 58), '0-999', 0}, //T-Mobil - RVT1608_1
																			{'RVT1608_2', MType_T+'RVT1608_2', calcIndex( 59), '0-999', 0}, //T-Mobil - RVT1608_2
																			{'RVC1602_1', MType_G+'RVC1602_1', calcIndex( 60), '0-999', 0}, //OutSource
																			{'RVG1702_1', MType_G+'RVG1702_1', calcIndex( 61), '0-999', 0}, //Kinecta
																			{'RVG1705_1', MType_G+'RVG1705_1', calcIndex( 62), '0-999', 0}, //Telecheck Gaming
																			{'RVC1609_1', MType_G+'RVC1609_1', calcIndex( 63), '0-999', 0}, //TJR
																			{'RVB1610_1', MType_B+'RVB1610_1', calcIndex( 64), '0-999', 0}, //USAA
																			{'RVG1706_1', MType_G+'RVG1706_1', calcIndex( 65), '0-999', 0}, //Telecheck nonGaming
																			{'RVA1611_1', MType_A+'RVA1611_1', calcIndex( 66), '0-999', 0}, //Ford Motor Credit
																			{'RVA1611_2', MType_A+'RVA1611_2', calcIndex( 67), '0-999', 0}, //Ford Motor Credit
																			{'RVG1610_1', MType_G+'RVG1610_1', calcIndex( 68), '0-999', 0}, //ACCESS Model
																			{'RVP1702_1', MType_G+'RVP1702_1', calcIndex( 69), '0-999', 0}, //DM Services
																			{'RVG1802_1', MType_G+'RVG1802_1', calcIndex( 70), '0-999', 0}, //Direct Financial
																			{'RVD1801_1', MType_D+'RVD1801_1', calcIndex( 71), '0-999', 0}, //Digital
																			{'RVA1811_1', MType_A+'RVA1811_1', calcIndex( 72), '0-999', 0}, //Cresent
																			
																			
																		// ------------------- FAKE MODELS - STATIC SCORE AND REASON CODES ------------------
																			{'RVA9999_9', MType_A+'RVA9999_9', 0, '0-999', 0},
																			{'RVB9999_9', MType_B+'RVB9999_9', 0, '0-999', 0},
																			{'RVG9999_9', MType_G+'RVG9999_9', 0, '0-999', 0},
																			{'RVT9999_9', MType_T+'RVT9999_9', 0, '0-999', 0}
																		// ----------------------------------------------------------------------------------
																	 ], RiskView.Layouts.Model_Constants);
	
	// If validation is enabled, only compile that model, else compile all V5.0 Models
	#if(TurnOnValidation)
	EXPORT V50Models := ValidatingModel;
	#else
	EXPORT V50Models := CASE(modelName,
											// -------------------------------- FLAGSHIP MODELS ---------------------------------
											'RVA1503_0' => UNGROUP(Models.RVA1503_0_0(BocaShell, lexIDOnlyOnInput)),
											'RVB1503_0' => UNGROUP(Models.RVB1503_0_0(BocaShell, lexIDOnlyOnInput)),
											'RVG1502_0' => UNGROUP(Models.RVG1502_0_0(BocaShell, lexIDOnlyOnInput)),
											'RVT1503_0' => UNGROUP(Models.RVT1503_0_0(BocaShell, lexIDOnlyOnInput)),
											// ----------------------------------------------------------------------------------
											// --------------------------------- CUSTOM MODELS ----------------------------------
											'RVA1504_1' => UNGROUP(Models.RVA1504_1_0(BocaShell, lexIDOnlyOnInput)),
											'RVA1504_2' => UNGROUP(Models.RVA1504_2_0(BocaShell, lexIDOnlyOnInput)),
											'RVA1603_1' => UNGROUP(Models.RVA1603_1_0(BocaShell, lexIDOnlyOnInput)),
											'RVG1601_1' => UNGROUP(Models.RVG1601_1_0(BocaShell, customInputs)),
											'RVT1601_1' => UNGROUP(Models.RVT1601_1_0(BocaShell, lexIDOnlyOnInput)),
											'RVG1511_1' => UNGROUP(Models.RVG1511_1_0(BocaShell, lexIDOnlyOnInput)),
											'RVP1605_1' => UNGROUP(Models.RVP1605_1_0(BocaShell)),
											'RVG1605_1' => UNGROUP(Models.RVG1605_1_0(BocaShell)),
											'RVA1607_1' => UNGROUP(Models.RVA1607_1_0(BocaShell)),
											'RVA1605_1' => UNGROUP(Models.RVA1605_1_0(BocaShell)),
											'RVT1608_2' => UNGROUP(Models.RVT1608_2(BocaShell)),
											'RVT1608_1' => UNGROUP(Models.RVT1608_1_0(BocaShell)),
											'RVA1601_1' => UNGROUP(Models.RVA1601_1_0(BocaShell)),
											'RVC1602_1' => UNGROUP(Models.RVC1602_1_0(BocaShell, customInputs)),
											'RVC1609_1' => UNGROUP(Models.RVC1609_1_0(BocaShell)),
											'RVG1702_1' => UNGROUP(Models.RVG1702_1_0(BocaShell)),
											'RVG1705_1' => UNGROUP(Models.RVG1705_1_0(BocaShell)),
											'RVB1610_1' => UNGROUP(Models.RVB1610_1_0(BocaShell)),
											'RVG1706_1' => UNGROUP(Models.RVG1706_1_0(BocaShell)),		
											'RVA1611_1' => UNGROUP(Models.RVA1611_1_0(BocaShell, isPreScreenPurpose)),	
											'RVA1611_2' => UNGROUP(Models.RVA1611_2_0(BocaShell, isPreScreenPurpose)),	
											//'RVS1706_0' => UNGROUP(Models.RVS1706_0_0(BocaShell)),	
											'RVS1706_0' => UNGROUP(Models.RVS1706_0_2(BocaShell)),	
											'RVG1610_1' => UNGROUP(Models.RVG1610_1_0(BocaShell)),	
											'RVP1702_1' => UNGROUP(Models.RVP1702_1_0(BocaShell)),	
											'RVG1802_1' => UNGROUP(Models.RVG1802_1_0(BocaShell)),	
											'RVD1801_1' => UNGROUP(Models.RVD1801_1_0(BocaShell)),	
											'RVA1811_1' => UNGROUP(Models.RVA1811_1_0(BocaShell, isPreScreenPurpose)),	
											// ----------------------------------------------------------------------------------
											// ------------------- FAKE MODELS - STATIC SCORE AND REASON CODES ------------------
											'RVA9999_9' => UNGROUP(Models.FAKE_0_0(BocaShell, 'RV50')),
											'RVB9999_9' => UNGROUP(Models.FAKE_0_0(BocaShell, 'RV50')),
											'RVG9999_9' => UNGROUP(Models.FAKE_0_0(BocaShell, 'RV50')),
											'RVT9999_9' => UNGROUP(Models.FAKE_0_0(BocaShell, 'RV50')),
											
											// ----------------------------------------------------------------------------------
																		 DATASET([], Models.Layout_ModelOut));
	#end
END;