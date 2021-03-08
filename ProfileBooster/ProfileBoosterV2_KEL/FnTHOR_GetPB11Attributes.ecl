IMPORT KEL12 AS KEL;
IMPORT ProfileBooster, Business_Risk_BIP, ProfileBooster.ProfileBoosterV2_KEL, Risk_Indicators, STD;

EXPORT FnTHOR_GetPB11Attributes(DATASET(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
			ProfileBooster.ProfileBoosterV2_KEL.Interface_Options OptionsRaw,
			ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile KEL_Settings = ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile) := FUNCTION
	
	// Append the KEL Permissions Required for Viewing the Data
	Options := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Set_Interface_Options(OptionsRaw, KEL_Settings);

	// Common_Functions := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Common_Functions;
	
	RecordsWithLexID := DISTRIBUTE(InputData(P_LexID > 0),P_LexID);
	RecordsWithoutLexID := DISTRIBUTE(InputData(P_LexID <= 0),P_LexID);
	
	UNSIGNED8 PDPM := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(Options.Data_Restriction_Mask, 
																																																Options.Data_Permission_Mask, 
																																																Options.GLBAPurpose, 
																																																Options.DPPAPurpose, 
																																																FALSE,//isFCRA
																																																TRUE,//isMarketing 
																																																FALSE,//AllowDNBDMI
																																																FALSE, //OverrideExperianRestriction
																																																'', //PermissiblePurpose, 
																																																'',// IndustryClass ??DRMKT
																																																KEL_Settings,//ProfileBoosterV2_KEL.CFG_Compile, 
																																																FALSE);
																																																
	mod_transforms := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Transforms;
	
	LexIDAttributesInput := PROJECT(RecordsWithLexID, mod_transforms.xfm_LexIDAttributesInput(LEFT, Options.KEL_Permissions_Mask),LOCAL);
	
	PB2AttributesRaw := ProfileBooster.ProfileBoosterV2_KEL.RQ_Non_F_C_R_A_Profile_Booster_V2(LexIDAttributesInput, KEL_Settings).Res0;
   																													 
	PB2AttributesRawCleaned := DISTRIBUTE(KEL.Clean(PB2AttributesRaw, TRUE, TRUE, TRUE),LexID);		
	
	// Cast Attributes back to their string values
	PB2AttributesWithLexID := JOIN(RecordsWithLexID, PB2AttributesRawCleaned, LEFT.P_LexID = RIGHT.LexID, 
		TRANSFORM(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutPersonPB11,
			ResultsFound := RIGHT.LexID > 0;
			P_LexIDSeenFlag := IF(ResultsFound,'1','0');
			LexIDNotOnFile := P_LexIDSeenFlag = '0';
			SELF.LexID := LEFT.P_LexID;
			SELF.G_ProcUID := RIGHT.__queryid;
			SELF.P_InpAcct := LEFT.P_InpAcct;
			SELF.PurchNewAmt := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_PurchNewAmt, 0);
			SELF.PurchTotEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_PurchTotEv, 0);
			SELF.PurchCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_PurchCntEv, 0);
			SELF.PurchNewMsnc := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_PurchNewAgeMonths, 0);
			SELF.PurchOldMsnc := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_PurchOldAgeMonths, 0);
			SELF.PurchItemCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_PurchItemCntEv, 0);
			SELF.PurchAmtAvg := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_PurchAmtAvg, 0);
			SELF.PurchAge := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_PurchAge, 0);
			SELF.PurchDOB := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, 
								ResultsFound => (STRING)RIGHT.PL_PurchDOB, '');
			SELF.PurchMaritalStatus := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, 
								ResultsFound => (STRING)RIGHT.PL_PurchMaritalStatus, '');
			SELF.PurchGender := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, 
								ResultsFound => (STRING)RIGHT.PL_PurchGender, '');
			SELF.AstVehAutoCarCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoCarCntEv, 0);
			SELF.AstVehAutoCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoCntEv, 0);
			SELF.AstVehAutoEliteCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoEliteCntEv, 0);
			SELF.AstVehAutoExpCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoExpCntEv, 0);
			SELF.AstVehAutoLuxuryCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoLuxuryCntEv, 0);
			SELF.AstVehAutoMakeCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoMakeCntEv, 0);
			SELF.AstVehAutoOrigOwnCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoOrigOwnCntEv, 0);
			SELF.AstVehAutoSUVCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoSUVCntEv, 0);
			SELF.AstVehAutoTruckCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoTruckCntEv, 0);
			SELF.AstVehAutoVanCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoVanCntEv, 0);
			SELF.AstVehAuto2ndFreqMake := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, 
								ResultsFound => (STRING36)RIGHT.PL_AstVehAuto2ndFreqMake, '');
			SELF.AstVehAuto2ndFreqMakeCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAuto2ndFreqMakeCntEv, 0);
			SELF.AstVehAutoFreqMake := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, 
								ResultsFound => (STRING36)RIGHT.PL_AstVehAutoFreqMake, '');
			SELF.AstVehAutoFreqMakeCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoFreqMakeCntEv, 0);
			SELF.AstVehAutoNewTypeIndx := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoNewTypeIndx, 0);
			SELF.AstVehAutoEmrgPriceAvg := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoEmrgPriceAvg, 0);
			SELF.AstVehAutoEmrgPriceDiff := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoEmrgPriceDiff, 0);
			SELF.AstVehAutoEmrgPriceMax := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoEmrgPriceMax, 0);
			SELF.AstVehAutoNewPrice := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoNewPrice, 0);
			SELF.AstVehAutoEmrgAgeAvg := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoEmrgAgeAvg, 0);
			SELF.AstVehAutoEmrgAgeMax := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoEmrgAgeMax, 0);
			SELF.AstVehAutoEmrgAgeMin := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoEmrgAgeMin, 0);
			SELF.AstVehAutoEmrgSpanAvg := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoEmrgSpanAvg, 0);
			SELF.AstVehAutoLastAgeAvg := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoLastAgeAvg, 0);
			SELF.AstVehAutoLastAgeMax := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoLastAgeMax, 0);
			SELF.AstVehAutoLastAgeMin := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoLastAgeMin, 0);
			SELF.AstVehAutoNewMsnc := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoNewMsnc, 0);
			SELF.AstVehAutoTimeOwnSpanAvg := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoTimeOwnSpanAvg, 0);
			SELF.AstVehOtherATVCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehOtherATVCntEv, 0);
			SELF.AstVehOtherCamperCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehOtherCamperCntEv, 0);
			SELF.AstVehOtherCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehOtherCntEv, 0);
			SELF.AstVehOtherCommCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehOtherCommCntEv, 0);
			SELF.AstVehOtherMtrCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehOtherMtrCntEv, 0);
			SELF.AstVehOtherOrigOwnCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehOtherOrigOwnCntEv, 0);
			SELF.AstVehOtherScooterCntEv := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehOtherScooterCntEv, 0);
			SELF.AstVehOtherNewMsnc := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehOtherNewMsnc, 0);
			SELF.AstVehOtherNewTypeIndx := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehOtherNewTypeIndx, 0);
			SELF.AstVehOtherNewPrice := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehOtherNewPrice, 0);
			SELF.AstVehOtherPriceAvg := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehOtherPriceAvg, 0);
			SELF.AstVehOtherPriceMax := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehOtherPriceMax, 0);
			SELF.AstVehOtherPriceMin := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehOtherPriceMin, 0);
			SELF.AstVehAutoEmrgPriceMin := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER3)RIGHT.PL_AstVehAutoEmrgPriceMin, 0);
      SELF.PL_PurchMinDate := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER4)RIGHT.PL_PurchMinDate, 0);
      SELF.PL_PurchMaxDate := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER4)RIGHT.PL_PurchMaxDate, 0);
      SELF.PL_VehicleMinDate := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER4)RIGHT.PL_VehicleMinDate, 0);
      SELF.PL_VehicleMaxDate := MAP(
								LexIDNotOnFile => ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER4)RIGHT.PL_VehicleMaxDate, 0);
      SELF := LEFT;
		),LEFT OUTER, KEEP(1), LOCAL); 
      	
   	PB2AttributesWithoutLexID := PROJECT(RecordsWithoutLexID, mod_transforms.xfm_MissingInputData(LEFT), LOCAL );
   			
   	// PB2Attributes := SORT( PB2AttributesWithLexID + PB2AttributesWithoutLexID, G_ProcUID ); 
   	PB2Attributes := PB2AttributesWithLexID + PB2AttributesWithoutLexID;

		//DEBUGGING
		OUTPUT(CHOOSEN(LexIDAttributesInput,100), NAMED('LexIDAttributesInput_100'));
		// OUTPUT(COUNT(LexIDAttributesInput), NAMED('LexIDAttributesInput_cnt'));
   	OUTPUT(CHOOSEN(PB2AttributesRaw,100), NAMED('PB2AttributesRaw_100'));
   	// OUTPUT(CHONT(PB2AttributesRaw), NAMED('PB2AttributesRaw_cnt'));
   	// OUTPUT(COUNT(PB2Attributes), NAMED('PB2Attributes_cnt'));
   	OUTPUT(CHOOSEN(PB2AttributesRawCleaned,100), NAMED('PB2AttributesRawCleaned_100'));
   
   	RETURN PB2Attributes;

END;	