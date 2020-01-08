IMPORT KEL11 AS KEL;
IMPORT ProfileBooster, Business_Risk_BIP, ProfileBooster.ProfileBoosterV2_KEL, Risk_Indicators, STD;

EXPORT FnTHOR_GetPB11Attributes(DATASET(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
			ProfileBooster.ProfileBoosterV2_KEL.Interface_Options OptionsRaw,
			ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile KEL_Settings = ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile) := FUNCTION
	
	// Append the KEL Permissions Required for Viewing the Data
	Options := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Set_Interface_Options(OptionsRaw, KEL_Settings);

	Common_Functions := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Common_Functions;
	
	RecordsWithLexID := InputData(P_LexID > 0);
	RecordsWithoutLexID := InputData(P_LexID <= 0);
	
	lexidonly := RECORD
		INTEGER7 P_LexID;
	END;
	PLexIDs_DS := PROJECT(RecordsWithLexID, lexidonly);
	PLexIDs := SET(PLexIDs_DS,P_LexID);
	PInputArchiveDateClean:=(INTEGER)OptionsRaw.ArchiveDate;
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
																																																ProfileBoosterV2_KEL.CFG_Compile, 
																																																FALSE);
	STRING8 today := (STRING8)Std.Date.Today();																													
	
	// VehicleAttributesRaw := 	CHOOSEN(KEL.Clean(ProfileBooster.ProfileBoosterV2_KEL.Q_Debugging_Vehicle_Query(PLexIDs,PInputArchiveDateClean,PDPM).res0, TRUE, TRUE, TRUE),100000);	
	// outputFile2 := TRIM('~jfrancis::out::' + today + '_' + thorlib.wuid() + '_PB1_1_VEHICLEHELPER_ATTRS_' + thorlib.wuid());
  // VehicleHelperFinal := VehicleAttributesRaw(vinavin<>'');//PROJECT(VehicleAttributesRaw, TRANSFORM(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutVehiclePB11,SELF := LEFT;));
	// OUTPUT(CHOOSEN(VehicleHelperFinal,100000),,outputFile2, CSV(HEADING(single), QUOTE('"')));

	NonFCRAPB2AttributesRaw := KEL.Clean(ProfileBooster.ProfileBoosterV2_KEL.Q_Non_F_C_R_A_Profile_Booster_V2(PLexIDs,PInputArchiveDateClean,PDPM).res0, TRUE, TRUE, TRUE);	
	// OUTPUT(COUNT(NonFCRAPB2AttributesRaw),named('NonFCRAPB2AttributesRaw_cnt'));
	// OUTPUT(CHOOSEN(NonFCRAPB2AttributesRaw(pl_astvehautocntev<>0),1000),named('NonFCRAPB2AttributesRaw_populated'));		
	PB2AttributesRaw := NonFCRAPB2AttributesRaw;

	// Cast Attributes back to their string values
	PB2AttributesWithLexID := JOIN(RecordsWithLexID, PB2AttributesRaw, LEFT.P_LexID = RIGHT.LexID, 
		TRANSFORM(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutPersonPB11,
			ResultsFound := RIGHT.LexID > 0;
			P_LexIDSeenFlag := IF(ResultsFound,'1','0');
			LexIDNotOnFile := P_LexIDSeenFlag = '0';
			SELF.LexID := LEFT.P_LexID;
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
			SELF := LEFT;
		),LEFT OUTER, KEEP(1)); 

	
	PB2AttributesWithoutLexID := PROJECT(RecordsWithoutLexID,
		TRANSFORM(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutPersonPB11,
			SELF.LexID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PurchNewAmt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PurchTotEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PurchCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PurchNewMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PurchOldMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PurchItemCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PurchAmtAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoCarCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEliteCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoExpCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoLuxuryCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoMakeCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoOrigOwnCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoSUVCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoTruckCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoVanCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAuto2ndFreqMake := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.AstVehAuto2ndFreqMakeCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoFreqMake := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.AstVehAutoFreqMakeCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoNewTypeIndx := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgPriceAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgPriceDiff := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgPriceMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoNewPrice := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgAgeAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgAgeMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgAgeMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgSpanAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoLastAgeAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoLastAgeMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoLastAgeMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoNewMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoTimeOwnSpanAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherATVCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherCamperCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherCommCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherMtrCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherOrigOwnCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherScooterCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherNewMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherNewTypeIndx := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherNewPrice := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherPriceAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherPriceMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherPriceMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgPriceMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF := LEFT)); 	
			
	PB2Attributes := SORT( PB2AttributesWithLexID + PB2AttributesWithoutLexID, G_ProcUID ); 
	// PB2Attributes := PB2AttributesWithLexID; 
	// OUTPUT(CHOOSEN(PB2Attributes,1000),named('PB2Attributes'));
	RETURN PB2Attributes;
END;	