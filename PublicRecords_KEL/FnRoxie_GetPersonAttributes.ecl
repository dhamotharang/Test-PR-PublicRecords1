IMPORT KEL13 AS KEL;
IMPORT PublicRecords_KEL, Risk_Indicators;

EXPORT FnRoxie_GetPersonAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

	Common_Functions := PublicRecords_KEL.ECL_Functions.Common_Functions;

	RecordsWithLexID := InputData(P_LexID  > 0);
	RecordsWithoutLexID := InputData(P_LexID  <= 0);
	
	LayoutFCRAPersonAttributes := RECORDOF(PublicRecords_KEL.Q_F_C_R_A_Person_Attributes_V1(0, DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII), 0, PublicRecords_KEL.CFG_Compile.Permit__NONE).res0);
	LayoutNonFCRAPersonAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Person_Attributes_V1(0, DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII), 0, PublicRecords_KEL.CFG_Compile.Permit__NONE).res0);
	
	NonFCRAPersonAttributesRaw := PROJECT(RecordsWithLexID, TRANSFORM({INTEGER G_ProcUID, LayoutNonFCRAPersonAttributes},
		SELF.G_ProcUID := LEFT.G_ProcUID;
		NonFCRAPersonResults := PublicRecords_KEL.Q_Non_F_C_R_A_Person_Attributes_V1(LEFT.P_LexID , DATASET(LEFT), (INTEGER)(LEFT.P_InpClnArchDt[1..8]), Options.KEL_Permissions_Mask, FDCDataset).res0;	
		SELF := NonFCRAPersonResults[1]));	

	FCRAPersonAttributesRaw := PROJECT(RecordsWithLexID, TRANSFORM({INTEGER G_ProcUID, LayoutNonFCRAPersonAttributes},
		SELF.G_ProcUID := LEFT.G_ProcUID;
		FCRAPersonResults := PublicRecords_KEL.Q_F_C_R_A_Person_Attributes_V1(LEFT.P_LexID , DATASET(LEFT), (INTEGER)(LEFT.P_InpClnArchDt[1..8]), Options.KEL_Permissions_Mask, FDCDataset).res0;	
		SELF := FCRAPersonResults[1],
		SELF := []));	
		
	PersonAttributesClean := IF(Options.IsFCRA, 
															KEL.Clean(FCRAPersonAttributesRaw, TRUE, TRUE, TRUE),
															KEL.Clean(NonFCRAPersonAttributesRaw, TRUE, TRUE, TRUE));
	
	
	// Cast Attributes back to their string values
	PersonAttributesWithLexID := JOIN(RecordsWithLexID, PersonAttributesClean, LEFT.G_ProcUID = RIGHT.G_ProcUID AND LEFT.P_LexID  = RIGHT.LexID, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutPerson,
			SELF.G_BuildDrgCrimDt := Risk_Indicators.get_Build_date('doc_build_version');
			SELF.G_BuildAstVehAutoDt := Risk_Indicators.get_Build_date('vehicle_build_version');	
			SELF.G_BuildAstVehAirDt := Risk_Indicators.get_Build_date('faa_build_version');
			SELF.G_BuildAstVehWtrDt := Risk_Indicators.get_Build_date('watercraft_build_version');
			SELF.G_BuildAstPropDt := Risk_Indicators.get_Build_date('Property_Build_Version');
			SELF.G_BuildEduDt := Risk_Indicators.get_Build_date('asl_build_version');			
			ResultsFound := RIGHT.LexID > 0;
			P_LexIDSeenFlag := IF(ResultsFound,RIGHT.P_LexIDSeenFlag,'0');
			LexIDNotOnFile := P_LexIDSeenFlag = '0';
			SELF.P_LexIDSeenFlag := P_LexIDSeenFlag;
			SELF.PL_AstVehAutoCntEv := MAP(
								Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER)RIGHT.PL_AstVehAutoCntEv, 0);
			SELF.PL_AstVehAutoEmrgDtListEv := MAP(
								Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_AstVehAutoCntEv = 0 => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								Common_Functions.roll_list(SORT(RIGHT.PL_AstVehAutoEmrgDtListEv, VehicleFirstSeenDate), VehicleFirstSeenDate,'|'));         
			SELF.PL_AstVehAutoLastDtListEv := MAP(
								Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, 																										 
								RIGHT.PL_AstVehAutoCntEv = 0 => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								Common_Functions.roll_list(SORT(RIGHT.PL_AstVehAutoLastDtListEv, VehicleLastSeenDate), VehicleLastSeenDate,'|'));
			SELF.PL_AstVehAutoCnt10Y := MAP(
								Options.IsFCRA 	=> 0, 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 																				
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_AstVehAutoCnt10Y, 0);
			SELF.PL_AstVehAutoCnt2Y := MAP(
								Options.IsFCRA 	=> 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 																								
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_AstVehAutoCnt2Y, 0);
			SELF.PL_AstVehAutoEmrgNewDtEv := MAP(
								Options.IsFCRA 	=> '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,																			
								ResultsFound => RIGHT.PL_AstVehAutoEmrgNewDtEv,PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);			
			SELF.PL_AstVehAutoEmrgOldDtEv := MAP(
								Options.IsFCRA 	=> '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_AstVehAutoEmrgOldDtEv,PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);			
			SELF.PL_AstVehAutoEmrgNewMsncEv := MAP(Options.IsFCRA 	=> 0, 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND (INTEGER)RIGHT.PL_AstVehAutoCntEv > 0 => (INTEGER)RIGHT.PL_AstVehAutoEmrgNewMsncEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
     SELF.PL_AstVehAutoEmrgOldMsncEv := MAP(Options.IsFCRA 	=> 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND (INTEGER)RIGHT.PL_AstVehAutoCntEv > 0 => (INTEGER)RIGHT.PL_AstVehAutoEmrgOldMsncEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstVehAirCntEv :=  MAP(			
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER)RIGHT.PL_AstVehAirCntEv, 0);
			SELF.PL_AstVehAirEmrgDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_AstVehAirCntEv = 0 => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								Common_Functions.roll_list(SORT(RIGHT.PL_AstVehAirEmrgDtListEv, AircraftFirstSeenDate), AircraftFirstSeenDate,'|'));         
			SELF.PL_AstVehAirEmrgNewDtEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,																			
								ResultsFound => RIGHT.PL_AstVehAirEmrgNewDtEv,PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);			
			SELF.PL_AstVehAirEmrgOldDtEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_AstVehAirEmrgOldDtEv,PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);				
			SELF.PL_AstVehAirEmrgNewMsncEv := MAP(		
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								(INTEGER)RIGHT.PL_AstVehAirCntEv > 0 => (INTEGER)RIGHT.PL_AstVehAirEmrgNewMsncEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstVehAirEmrgOldMsncEv := MAP(																											 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								(INTEGER)RIGHT.PL_AstVehAirCntEv > 0 => (INTEGER)RIGHT.PL_AstVehAirEmrgOldMsncEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstVehWtrCntEv :=  MAP(			
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER)RIGHT.PL_AstVehWtrCntEv, 0);
			SELF.PL_AstVehWtrEmrgDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_AstVehWtrCntEv = 0 => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								Common_Functions.roll_list(SORT(RIGHT.PL_AstVehWtrEmrgDtListEv, WatercraftFirstSeenDate), WatercraftFirstSeenDate,'|'));         
			SELF.PL_AstVehWtrEmrgNewDtEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,																			
								ResultsFound => RIGHT.PL_AstVehWtrEmrgNewDtEv,PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);			
			SELF.PL_AstVehWtrEmrgOldDtEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_AstVehWtrEmrgOldDtEv,PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);				
			SELF.PL_AstVehWtrEmrgNewMsncEv := MAP(		
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								RIGHT.PL_AstVehWtrCntEv > 0 => (INTEGER)RIGHT.PL_AstVehWtrEmrgNewMsncEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstVehWtrEmrgOldMsncEv := MAP(																											 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								RIGHT.PL_AstVehWtrCntEv > 0 => (INTEGER)RIGHT.PL_AstVehWtrEmrgOldMsncEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgCrimFelCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimFelCnt1Y);
			SELF.PL_DrgCrimFelCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimFelCnt7Y);
			SELF.PL_DrgCrimFelNewDt1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgCrimFelNewDt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgCrimFelOldDt1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgCrimFelOldDt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND); 
			SELF.PL_DrgCrimFelNewDt7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgCrimFelNewDt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND); 
			SELF.PL_DrgCrimFelOldDt7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgCrimFelOldDt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgCrimFelNewMsnc1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgCrimFelNewMsnc1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgCrimFelOldMsnc1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgCrimFelOldMsnc1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgCrimFelNewMsnc7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgCrimFelNewMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT); 
			SELF.PL_DrgCrimFelOldMsnc7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgCrimFelOldMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgCrimNfelCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimNfelCnt1Y);
			SELF.PL_DrgCrimNfelCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimNfelCnt7Y);
			SELF.PL_DrgCrimNfelNewDt1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgCrimNfelNewDt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgCrimNfelOldDt1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgCrimNfelOldDt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgCrimNfelNewDt7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgCrimNfelNewDt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgCrimNfelOldDt7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgCrimNfelOldDt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgCrimNfelNewMsnc1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgCrimNfelNewMsnc1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgCrimNfelOldMsnc1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgCrimNfelOldMsnc1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgCrimNfelNewMsnc7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgCrimNfelNewMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgCrimNfelOldMsnc7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgCrimNfelOldMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			// Arrest fields are NonFCRA only			
			SELF.PL_DrgArstCnt1Y := MAP(Options.IsFCRA 			=> 0,
															LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
                              NOT Options.IsFCRA AND ResultsFound => RIGHT.PL_DrgArstCnt1Y, 0);
			SELF.PL_DrgArstCnt7Y := MAP(Options.IsFCRA 		=> 0,
															LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
															NOT Options.IsFCRA AND ResultsFound => RIGHT.PL_DrgArstCnt7Y, 0);
			SELF.PL_DrgArstNewDt1Y := MAP(Options.IsFCRA  		=> '',
															LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
															NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_DrgArstNewDt1Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgArstOldDt1Y := MAP(Options.IsFCRA 		=> '',
															LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
															NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_DrgArstOldDt1Y, 
                                                                  PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgArstNewDt7Y := MAP(Options.IsFCRA 		=> '',
															LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
															NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_DrgArstNewDt7Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgArstOldDt7Y := MAP(Options.IsFCRA  		=> '',
															LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
															NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_DrgArstOldDt7Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
      SELF.PL_DrgArstNewMsnc1Y := MAP(Options.IsFCRA => 0,
															LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
															NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_DrgArstNewMsnc1Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgArstOldMsnc1Y := MAP(Options.IsFCRA  => 0,
															LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
															NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_DrgArstOldMsnc1Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgArstNewMsnc7Y := MAP(Options.IsFCRA 	=> 0,
															LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
															NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_DrgArstNewMsnc7Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgArstOldMsnc7Y := MAP(Options.IsFCRA 	=> 0,
															LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
															NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_DrgArstOldMsnc7Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgCrimCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,RIGHT.PL_DrgCrimCnt1Y);
			SELF.PL_DrgCrimCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,RIGHT.PL_DrgCrimCnt7Y);
			SELF.PL_DrgCrimNewDt1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgCrimNewDt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgCrimOldDt1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgCrimOldDt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgCrimNewDt7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgCrimNewDt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgCrimOldDt7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgCrimOldDt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgCrimNewMsnc1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgCrimNewMsnc1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgCrimOldMsnc1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgCrimOldMsnc1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgCrimNewMsnc7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgCrimNewMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgCrimOldMsnc7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgCrimOldMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgCrimSeverityIndx7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgCrimSeverityIndx7Y,
								'0 - 0');
			SELF.PL_DrgCrimBehaviorIndx7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgCrimBehaviorIndx7Y,
								'0');
			//Bankruptcy	
			SELF.G_BuildDrgBkDt := Risk_Indicators.get_Build_date('bankruptcy_daily'); 		
			SELF.PL_DrgBkCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkCnt1Y); 
			SELF.PL_DrgBkCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,RIGHT.PL_DrgBkCnt7Y);
			SELF.PL_DrgBkCnt10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,RIGHT.PL_DrgBkCnt10Y);
			SELF.PL_DrgBkDtList1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt1Y > 0 => Common_Functions.roll_list(RIGHT.PL_DrgBkDtList1Y, BankruptcyDate, '|'),
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkDtList7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt7Y > 0 => Common_Functions.roll_list(RIGHT.PL_DrgBkDtList7Y, BankruptcyDate, '|'),
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkDtList10Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt10Y > 0 => Common_Functions.roll_list(RIGHT.PL_DrgBkDtList10Y, BankruptcyDate, '|'),
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkNewDt1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgBkNewDt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkNewDt7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgBkNewDt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkNewDt10Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgBkNewDt10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkOldDt1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgBkOldDt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkOldDt7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound =>(STRING)RIGHT.PL_DrgBkOldDt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkOldDt10Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_DrgBkOldDt10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkNewMsnc1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkNewMsnc1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkNewMsnc7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkNewMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkNewMsnc10Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkNewMsnc10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkOldMsnc1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkOldMsnc1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkOldMsnc7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkOldMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkOldMsnc10Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkOldMsnc10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkChList1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt1Y > 0 => Common_Functions.roll_list(RIGHT.PL_DrgBkChList1Y, OriginalChapter, '|'),
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkChList7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt7Y > 0 => Common_Functions.roll_list(RIGHT.PL_DrgBkChList7Y, OriginalChapter, '|'),
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkChList10Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt10Y > 0 => Common_Functions.roll_list(RIGHT.PL_DrgBkChList10Y, OriginalChapter, '|'),
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkNewChType1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound =>(STRING)RIGHT.PL_DrgBkNewChType1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkNewChType7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound =>(STRING)RIGHT.PL_DrgBkNewChType7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkNewChType10Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound =>(STRING)RIGHT.PL_DrgBkNewChType10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkCh7Cnt1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound =>(INTEGER)RIGHT.PL_DrgBkCh7Cnt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkCh7Cnt7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkCh7Cnt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkCh7Cnt10Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound =>(INTEGER)RIGHT.PL_DrgBkCh7Cnt10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkCh13Cnt1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkCh13Cnt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkCh13Cnt7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound =>(INTEGER)RIGHT.PL_DrgBkCh13Cnt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkCh13Cnt10Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkCh13Cnt10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);			
			SELF.PL_DrgBkUpdtNewDt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgBkUpdtNewDt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);	
			SELF.PL_DrgBkUpdtNewDt7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgBkUpdtNewDt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);	
			SELF.PL_DrgBkUpdtNewDt10Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgBkUpdtNewDt10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);	
			SELF.PL_DrgBkUpdtNewMsnc1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkUpdtNewMsnc1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);	
			SELF.PL_DrgBkUpdtNewMsnc7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkUpdtNewMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);	
			SELF.PL_DrgBkUpdtNewMsnc10Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkUpdtNewMsnc10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);	
			SELF.PL_DrgBkDispList1Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt1Y > 0 => Common_Functions.roll_list(RIGHT.PL_DrgBkDispList1Y, Disposition, '|'),
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkDispList7Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt7Y > 0 => Common_Functions.roll_list(RIGHT.PL_DrgBkDispList7Y, Disposition, '|'),
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkDispList10Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt10Y > 0 => Common_Functions.roll_list(RIGHT.PL_DrgBkDispList10Y, Disposition, '|'),
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkNewDispType1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgBkNewDispType1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkNewDispType7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgBkNewDispType7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkNewDispType10Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgBkNewDispType10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkNewDispDt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgBkNewDispDt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkNewDispDt7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgBkNewDispDt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkNewDispDt10Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgBkNewDispDt10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkNewDispMsnc1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkNewDispMsnc1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkNewDispMsnc7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkNewDispMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkNewDispMsnc10Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgBkNewDispMsnc10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkDispCnt1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgBkDispCnt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkDispCnt7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgBkDispCnt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkDispCnt10Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgBkDispCnt10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkDsmsCnt1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgBkDsmsCnt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkDsmsCnt7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgBkDsmsCnt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkDsmsCnt10Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgBkDsmsCnt10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkDschCnt1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgBkDschCnt1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkDschCnt7Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgBkDschCnt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkDschCnt10Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgBkDschCnt10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgBkTypeList1Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt1Y > 0 => Common_Functions.roll_list(RIGHT.PL_DrgBkTypeList1Y, FilingType, '|'),
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkTypeList7Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt7Y > 0 => Common_Functions.roll_list(RIGHT.PL_DrgBkTypeList7Y, FilingType, '|'),
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkTypeList10Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt10Y > 0 => Common_Functions.roll_list(RIGHT.PL_DrgBkTypeList10Y, FilingType, '|'),
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgBkBusFlag1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgBkBusFlag1Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.PL_DrgBkBusFlag7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgBkBusFlag7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.PL_DrgBkBusFlag10Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgBkBusFlag10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.PL_DrgBkSeverityIndx10Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgBkSeverityIndx10Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			//ProfessionalLicense
			SELF.G_BuildProfLicDt := Risk_Indicators.get_Build_date('proflic_build_version');
			SELF.PL_ProfLicFlagEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_ProfLicFlagEv);
			SELF.PL_ProfLicIssueDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_ProfLicFlagEv = '0' => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								Common_Functions.roll_list(SORT(RIGHT.PL_ProfLicIssueDtListEv, MaxIssueDate), MaxIssueDate, '|'));
			SELF.PL_ProfLicExpDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_ProfLicFlagEv = '0' => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								Common_Functions.roll_list(SORT(RIGHT.PL_ProfLicExpDtListEv, MaxExpireDate), MaxExpireDate, '|'));
			SELF.PL_ProfLicIndxByLicListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_ProfLicFlagEv = '0' => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								Common_Functions.roll_list(SORT(RIGHT.PL_ProfLicIndxByLicListEv, LicenseCategory), LicenseCategory, '|'));
			SELF.PL_ProfLicActvFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_ProfLicFlagEv = '0' => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								RIGHT.PL_ProfLicActvFlag);
			SELF.PL_ProfLicActvNewIssueDt := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_ProfLicActvNewIssueDt,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);	
			SELF.PL_ProfLicActvNewExpDt := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_ProfLicActvNewExpDt,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_ProfLicActvNewType := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_ProfLicActvNewType,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_ProfLicActvNewTitleType := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_ProfLicActvNewTitleType,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_ProfLicActvNewIndx := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_ProfLicActvNewIndx,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_ProfLicActvNewSrcType := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_ProfLicActvNewSrcType,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
						//Best PII
			SELF.PL_CurrAddrFull := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrFull,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			// SELF.PL_CurrAddrLocID := MAP(
								// LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								// ResultsFound => (STRING)RIGHT.PL_CurrAddrLocID,
								// PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_PrevAddrFull := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_PrevAddrFull,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			// SELF.PL_PrevAddrLocID := MAP(
								// LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								// ResultsFound => (STRING)RIGHT.PL_PrevAddrLocID,
								// PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.PL_DrgJudgCnt7Y := MAP(		
							LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,		
							ResultsFound => RIGHT.PL_DrgJudgCnt7Y,		
							PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);		
			SELF.PL_DrgLTDCnt7Y := MAP(		
							LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,		
							ResultsFound => RIGHT.PL_DrgLTDCnt7Y,		
							PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);		
			SELF.PL_DrgLienCnt7Y := MAP(		
							LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,		
							ResultsFound => RIGHT.PL_DrgLienCnt7Y,		
							PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);		
			//Education		
			SELF.PL_EduRecFlagEv := MAP(		
													LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,		
													ResultsFound => (STRING)RIGHT.PL_EduRecFlagEv,		
													PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.PL_EduSrcListEv := MAP(		
													LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,		
													ResultsFound => (STRING)RIGHT.PL_EduSrcListEv,		
													PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.PL_EduHSRecFlagEv := MAP(		
													LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,		
													ResultsFound => (STRING)RIGHT.PL_EduHSRecFlagEv,		
													PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.PL_EduCollRecFlagEv := MAP(		
													LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,		
													ResultsFound => (STRING)RIGHT.PL_EduCollRecFlagEv,		
													PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.PL_EduCollSrcEmrgDtListEv := MAP(		
													LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,		
													ResultsFound => (STRING)RIGHT.PL_EduCollSrcEmrgDtListEv,		
													PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.PL_EduCollSrcLastDtListEv := MAP(		
													LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,		
													ResultsFound => (STRING)RIGHT.PL_EduCollSrcLastDtListEv,		
													PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.PL_EduCollSrcNewRecOldDtEv := MAP(		
													LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,		
													ResultsFound => (STRING)RIGHT.PL_EduCollSrcNewRecOldDtEv,		
													PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.PL_EduCollSrcNewRecNewDtEv := MAP(		
													LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,		
													ResultsFound => (STRING)RIGHT.PL_EduCollSrcNewRecNewDtEv,		
													PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.PL_EduCollSrcNewRecOldMsncEv := MAP(		
													LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,		
													ResultsFound => (INTEGER)RIGHT.PL_EduCollSrcNewRecOldMsncEv,		
													PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);		
			SELF.PL_EduCollSrcNewRecNewMsncEv := MAP(		
													LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,		
													ResultsFound => (INTEGER)RIGHT.PL_EduCollSrcNewRecNewMsncEv,		
													PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);		
			SELF.PL_EduCollRecSpanEv := MAP(		
													LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,		
													ResultsFound => (INTEGER)RIGHT.PL_EduCollRecSpanEv,		
													PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);								
			SELF := LEFT;		
			),LEFT OUTER, KEEP(1)); 
	
	PersonAttributesWithoutLexID := PROJECT(RecordsWithoutLexID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutPerson,
			SELF.G_BuildDrgCrimDt := Risk_Indicators.get_Build_date('doc_build_version');
			SELF.G_BuildAstVehAutoDt := Risk_Indicators.get_Build_date('vehicle_build_version');
			SELF.G_BuildAstVehAirDt := Risk_Indicators.get_Build_date('faa_build_version');
			SELF.G_BuildAstVehWtrDt := Risk_Indicators.get_Build_date('watercraft_build_version');
			SELF.G_BuildAstPropDt := Risk_Indicators.get_Build_date('Property_Build_Version');
			SELF.G_BuildEduDt := Risk_Indicators.get_Build_date('asl_build_version');		
			SELF.P_LexIDSeenFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;			
			SELF.PL_AstVehAutoCntEv := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_AstVehAutoEmrgDtListEv := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_AstVehAutoLastDtListEv := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_AstVehAutoCnt10Y := IF(Options.IsFCRA, 0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_AstVehAutoCnt2Y := IF(Options.IsFCRA, 0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_AstVehAutoEmrgNewDtEv := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.PL_AstVehAutoEmrgOldDtEv := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_AstVehAutoEmrgNewMsncEv := IF(Options.IsFCRA, 0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_AstVehAutoEmrgOldMsncEv := IF(Options.IsFCRA, 0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_AstVehAirCntEv :=  PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstVehAirEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;  																					
			SELF.PL_AstVehAirEmrgNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			SELF.PL_AstVehAirEmrgOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AstVehAirEmrgNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstVehAirEmrgOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstVehWtrCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstVehWtrEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;  																					
			SELF.PL_AstVehWtrEmrgNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			SELF.PL_AstVehWtrEmrgOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AstVehWtrEmrgNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstVehWtrEmrgOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimFelCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimFelCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimFelNewDt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgCrimFelOldDt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.PL_DrgCrimFelNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.PL_DrgCrimFelOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgCrimFelNewMsnc1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimFelOldMsnc1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimFelNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimFelOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimNfelCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimNfelCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimNfelNewDt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgCrimNfelOldDt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgCrimNfelNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgCrimNfelOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgCrimNfelNewMsnc1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimNfelOldMsnc1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimNfelNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimNfelOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			// Arrest fields are nonFCRA only
			SELF.PL_DrgArstCnt1Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_DrgArstCnt7Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_DrgArstNewDt1Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_DrgArstOldDt1Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_DrgArstNewDt7Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_DrgArstOldDt7Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_DrgArstNewMsnc1Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_DrgArstOldMsnc1Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_DrgArstNewMsnc7Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_DrgArstOldMsnc7Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_DrgCrimCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimNewDt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgCrimOldDt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgCrimNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgCrimOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgCrimNewMsnc1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimOldMsnc1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgCrimSeverityIndx7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgCrimBehaviorIndx7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			//Bankruptcy			
			SELF.G_BuildDrgBkDt := Risk_Indicators.get_Build_date('bankruptcy_daily');
			SELF.PL_DrgBkCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkDtList1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkDtList7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkDtList10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkNewDt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkNewDt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkOldDt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkOldDt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkNewMsnc1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkNewMsnc10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkOldMsnc1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkOldMsnc10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkChList1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkChList7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkChList10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkNewChType1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkNewChType7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkNewChType10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkCh7Cnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkCh7Cnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkCh7Cnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkCh13Cnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkCh13Cnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkCh13Cnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkUpdtNewDt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkUpdtNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkUpdtNewDt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkUpdtNewMsnc1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkUpdtNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkUpdtNewMsnc10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkDispList1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkDispList7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkDispList10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkNewDispType1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkNewDispType7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkNewDispType10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkNewDispDt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkNewDispDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkNewDispDt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkNewDispMsnc1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkNewDispMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkNewDispMsnc10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkDispCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkDispCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkDispCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkDsmsCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkDsmsCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkDsmsCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkDschCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkDschCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkDschCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgBkTypeList1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkTypeList7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkTypeList10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkBusFlag1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkBusFlag7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkBusFlag10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgBkSeverityIndx10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			//ProfessionalLicense
			SELF.G_BuildProfLicDt := Risk_Indicators.get_Build_date('proflic_build_version');
			SELF.PL_ProfLicFlagEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_ProfLicIssueDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_ProfLicExpDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_ProfLicIndxByLicListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_ProfLicActvFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_ProfLicActvNewIssueDt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_ProfLicActvNewExpDt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_ProfLicActvNewType := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_ProfLicActvNewTitleType := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_ProfLicActvNewIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_ProfLicActvNewSrcType := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
						//Best PII
			SELF.PL_CurrAddrFull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			// SELF.PL_CurrAddrLocID := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_PrevAddrFull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			// SELF.PL_PrevAddrLocID := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgJudgCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.PL_DrgLTDCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.PL_DrgLienCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			//Education		
			SELF.PL_EduRecFlagEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.PL_EduSrcListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.PL_EduHSRecFlagEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.PL_EduCollRecFlagEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.PL_EduCollSrcEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.PL_EduCollSrcLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.PL_EduCollSrcNewRecOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.PL_EduCollSrcNewRecNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.PL_EduCollSrcNewRecOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.PL_EduCollSrcNewRecNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.PL_EduCollRecSpanEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;			
			SELF := LEFT)); 
			
	PersonAttributes := SORT( PersonAttributesWithLexID + PersonAttributesWithoutLexID, G_ProcUID ); 
	
	RETURN PersonAttributes;
END;
