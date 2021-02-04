﻿IMPORT KEL13 AS KEL;
IMPORT PublicRecords_KEL, Risk_Indicators;

EXPORT FnRoxie_GetPersonAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

	Common_Functions := PublicRecords_KEL.ECL_Functions.Common_Functions;

	RecordsWithLexID := InputData(P_LexID  > 0);
	RecordsWithoutLexID := InputData(P_LexID  <= 0);
	
	LayoutFCRAPersonAttributes := RECORDOF(PublicRecords_KEL.Q_F_C_R_A_Person_Attributes_V1_Dynamic(0, DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII), 0, PublicRecords_KEL.CFG_Compile.Permit__NONE).res0);
	LayoutNonFCRAPersonAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Person_Attributes_V1_Dynamic(0, DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII), 0, PublicRecords_KEL.CFG_Compile.Permit__NONE).res0);
	
	LayoutPersonAttributesRaw := RECORD
		RECORDOF(LayoutNonFCRAPersonAttributes);
		INTEGER3 PL_InqPerLexIDCnt1Y;
		INTEGER3 PL_InqSSNPerLexIDCnt1Y;
		INTEGER3 PL_InqAddrPerLexIDCnt1Y;
		INTEGER3 PL_InqLNamePerLexIDCnt1Y;
		INTEGER3 PL_InqFNamePerLexIDCnt1Y;
		INTEGER3 PL_InqPhonePerLexIDCnt1Y;
		INTEGER3 PL_InqDOBPerLexIDCnt1Y;
		INTEGER3 PL_InqPerLexIDWInpFLSCnt1Y;
		INTEGER3 PL_InqPerLexIDWInpASCnt1Y;
		INTEGER3 PL_InqPerLexIDWInpSDCnt1Y;
		INTEGER3 PL_InqPerLexIDWInpPSCnt1Y;
		INTEGER3 PL_InqPerLexIDWInpFLASCnt1Y;
		INTEGER3 PL_InqPerLexIDWInpFLPSCnt1Y;
		INTEGER3 PL_InqPerLexIDWInpFLAPSCnt1Y;
		string6 PL_AlrtCorrectedFlag;
		string6 PL_AlrtConsStatementFlag;
		string6 PL_AlrtDisputeFlag;
		string6 PL_AlrtSecurityFreezeFlag;
		string6 PL_AlrtSecurityAlertFlag;
		string6 PL_AlrtIDTheftFlag;
	END;	
														
	NonFCRAPersonAttributesRaw := PROJECT(RecordsWithLexID, TRANSFORM({INTEGER G_ProcUID, LayoutPersonAttributesRaw},
		SELF.G_ProcUID := LEFT.G_ProcUID;
		NonFCRAPersonResults := PublicRecords_KEL.Q_Non_F_C_R_A_Person_Attributes_V1_Dynamic(LEFT.P_LexID , DATASET(LEFT), (INTEGER)(LEFT.P_InpClnArchDt[1..8]), Options.KEL_Permissions_Mask, FDCDataset).res0;	
		SELF := NonFCRAPersonResults[1],
		SELF := []));	

	FCRAPersonAttributesRaw := PROJECT(RecordsWithLexID, TRANSFORM({INTEGER G_ProcUID, LayoutPersonAttributesRaw},
		SELF.G_ProcUID := LEFT.G_ProcUID;
		FCRAPersonResults := PublicRecords_KEL.Q_F_C_R_A_Person_Attributes_V1_Dynamic(LEFT.P_LexID , DATASET(LEFT), (INTEGER)(LEFT.P_InpClnArchDt[1..8]), Options.KEL_Permissions_Mask, FDCDataset).res0;	
		SELF := FCRAPersonResults[1],
		SELF.PL_InqPerLexIDCnt1Y := FCRAPersonResults[1].P_L___Inq_Per_Lex_I_D_Cnt1_Y_;
		SELF.PL_InqSSNPerLexIDCnt1Y := FCRAPersonResults[1].P_L___Inq_S_S_N_Per_Lex_I_D_Cnt1_Y_;
		SELF.PL_InqAddrPerLexIDCnt1Y := FCRAPersonResults[1].P_L___Inq_Addr_Per_Lex_I_D_Cnt1_Y_;
		SELF.PL_InqLNamePerLexIDCnt1Y := FCRAPersonResults[1].P_L___Inq_L_Name_Per_Lex_I_D_Cnt1_Y_;
		SELF.PL_InqFNamePerLexIDCnt1Y := FCRAPersonResults[1].P_L___Inq_F_Name_Per_Lex_I_D_Cnt1_Y_;
		SELF.PL_InqPhonePerLexIDCnt1Y := FCRAPersonResults[1].P_L___Inq_Phone_Per_Lex_I_D_Cnt1_Y_;
		SELF.PL_InqDOBPerLexIDCnt1Y := FCRAPersonResults[1].P_L___Inq_D_O_B_Per_Lex_I_D_Cnt1_Y_;
		SELF.PL_InqPerLexIDWInpFLSCnt1Y := FCRAPersonResults[1].P_L___Inq_Per_Lex_I_D_W_Inp_F_L_S_Cnt1_Y_;
		SELF.PL_InqPerLexIDWInpASCnt1Y := FCRAPersonResults[1].P_L___Inq_Per_Lex_I_D_W_Inp_A_S_Cnt1_Y_;
		SELF.PL_InqPerLexIDWInpSDCnt1Y := FCRAPersonResults[1].P_L___Inq_Per_Lex_I_D_W_Inp_S_D_Cnt1_Y_;
		SELF.PL_InqPerLexIDWInpPSCnt1Y := FCRAPersonResults[1].P_L___Inq_Per_Lex_I_D_W_Inp_P_S_Cnt1_Y_;
		SELF.PL_InqPerLexIDWInpFLASCnt1Y := FCRAPersonResults[1].P_L___Inq_Per_Lex_I_D_W_Inp_F_L_A_S_Cnt1_Y_;
		SELF.PL_InqPerLexIDWInpFLPSCnt1Y := FCRAPersonResults[1].P_L___Inq_Per_Lex_I_D_W_Inp_F_L_P_S_Cnt1_Y_;
		SELF.PL_InqPerLexIDWInpFLAPSCnt1Y := FCRAPersonResults[1].P_L___Inq_Per_Lex_I_D_W_Inp_F_L_A_P_S_Cnt1_Y_;
		
		SELF.PL_AlrtCorrectedFlag := FCRAPersonResults[1].P_L___Alrt_Corrected_Flag_;
		SELF.PL_AlrtConsStatementFlag := FCRAPersonResults[1].P_L___Alrt_Cons_Statement_Flag_;
		SELF.PL_AlrtDisputeFlag := FCRAPersonResults[1].P_L___Alrt_Dispute_Flag_;
		SELF.PL_AlrtSecurityFreezeFlag := FCRAPersonResults[1].P_L___Alrt_Security_Freeze_Flag_;
		SELF.PL_AlrtSecurityAlertFlag := FCRAPersonResults[1].P_L___Alrt_Security_Alert_Flag_;
		SELF.PL_AlrtIDTheftFlag := FCRAPersonResults[1].P_L___Alrt_I_D_Theft_Flag_;
		SELF := []));	
		
	PersonAttributesClean := IF(Options.IsFCRA, 
															KEL.Clean(FCRAPersonAttributesRaw, TRUE, TRUE, TRUE),
															KEL.Clean(NonFCRAPersonAttributesRaw, TRUE, TRUE, TRUE));
	
	// Cast Attributes back to their string values
	PersonAttributesWithLexID := JOIN(RecordsWithLexID, PersonAttributesClean, LEFT.G_ProcUID = RIGHT.G_ProcUID AND LEFT.P_LexID  = RIGHT.LexID, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutPerson,
			ResultsFound := RIGHT.LexID > 0;
			P_LexIDSeenFlag := IF(ResultsFound,RIGHT.P_LexIDSeenFlag,'0');
			LexIDNotOnFile := P_LexIDSeenFlag = '0';
			SELF.P_LexIDSeenFlag := P_LexIDSeenFlag;
			SELF.P_LexIDIsDeceasedFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.P_LexIDIsDeceasedFlag);
			SELF.PL_EmrgAge := MAP(LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_EmrgAge,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
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
			// Property
			SELF.PL_AstPropCntEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_AstPropCntEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstPropNewDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_AstPropNewDtListEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);			
			SELF.PL_AstPropOldDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_AstPropOldDtListEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);			
			SELF.PL_AstPropCurrCnt := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_AstPropCurrCnt,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstPropSaleCntEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_AstPropSaleCntEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstPropSaleAmtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_AstPropSaleAmtListEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);			
			SELF.PL_AstPropSaleTotEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_AstPropSaleTotEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstPropSaleDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_AstPropSaleDtListEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);			
			SELF.PL_AstPropSaleNewDtEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_AstPropSaleNewDtEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);			
			SELF.PL_AstPropSaleOldDtEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_AstPropSaleOldDtEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);			
			SELF.PL_AstPropSaleNewMsncEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_AstPropSaleNewMsncEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstPropSaleOldMsncEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_AstPropSaleOldMsncEv,
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
			SELF.PL_DrgArstCnt1Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => RIGHT.PL_DrgArstCnt1Y, 0);
			SELF.PL_DrgArstCnt7Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => RIGHT.PL_DrgArstCnt7Y, 0);
			SELF.PL_DrgArstNewDt1Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_DrgArstNewDt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgArstOldDt1Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_DrgArstOldDt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgArstNewDt7Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_DrgArstNewDt7Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgArstOldDt7Y := MAP(Options.IsFCRA => '',
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
			SELF.PL_CurrAddrCnty := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrCnty,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrGeo := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrGeo,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrLat := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrLat,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrLng := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrLng,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrType := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrType,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrStatus := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrStatus,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_PrevAddrCnty := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_PrevAddrCnty,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_PrevAddrGeo := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_PrevAddrGeo,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_PrevAddrLat := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_PrevAddrLat,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_PrevAddrLng := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_PrevAddrLng,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_PrevAddrType := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_PrevAddrType,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_PrevAddrStatus := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_PrevAddrStatus,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			//Current Address
			SELF.PL_CurrAddrIsVacantFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrIsVacantFlag,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrIsThrowbackFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrIsThrowbackFlag,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrSeasonalType := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrSeasonalType,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrIsDNDFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrIsDNDFlag,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrIsCollegeFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrIsCollegeFlag,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrIsCMRAFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrIsCMRAFlag,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrIsSimpAddrFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrIsSimpAddrFlag,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrIsDropDeliveryFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrIsDropDeliveryFlag,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrIsBusinessFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrIsBusinessFlag,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrIsMultiUnitFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrIsMultiUnitFlag,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_CurrAddrIsAptFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_CurrAddrIsAptFlag,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);

			//Previous Address
			SELF.PL_PrevAddrIsSimpAddrFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_PrevAddrIsSimpAddrFlag,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_PrevAddrIsBusinessFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_PrevAddrIsBusinessFlag,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgJudgCnt7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgJudgCnt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgLTDCnt7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgLTDCnt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgLTDAmtList7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgLTDAmtList7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgLTDDtList7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgLTDDtList7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgLTDNewMsnc7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgLTDNewMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgLTDOldMsnc7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgLTDOldMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgLienCnt7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgLienCnt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			//Suits
			SELF.PL_DrgSuitCnt7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgSuitCnt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgSuitAmtList7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgSuitAmtList7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgSuitAmtTot7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgSuitAmtTot7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgSuitDtList7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgSuitDtList7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgSuitNewMsnc7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgSuitNewMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgSuitOldMsnc7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgSuitOldMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			//OverAllLnJ
			SELF.PL_DrgLnJCnt7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgLnJCnt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgLnJAmtList7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgLnJAmtList7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgLnJDtList7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgLnJDtList7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgLnJNewDt7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgLnJNewDt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgLnJNewMsnc7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgLnJNewMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgLnJOldDt7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_DrgLnJOldDt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_DrgLnJOldMsnc7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => RIGHT.PL_DrgLnJOldMsnc7Y,
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
			SELF.PL_AstPropBusCntEv := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_AstPropBusCntEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstPropBusCurrCnt := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_AstPropBusCurrCnt,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstPropBusCurrWTaxValCnt := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_AstPropBusCurrWTaxValCnt,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstPropBusCurrTaxValList := MAP(Options.IsFCRA => '0',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_AstPropBusCurrTaxValList,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_AstPropBusCurrTaxValTot := MAP(Options.IsFCRA => 0,															
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_AstPropBusCurrTaxValTot,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_UtilCntEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_UtilCntEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_UtilOldDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_UtilOldDtListEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_UtilOldDtEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_UtilOldDtEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_UtilOldMsncEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_UtilOldMsncEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			//Email
			SELF.PL_EmailCntEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_EmailCntEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			//Best PII
			SELF.PL_BestNameFirst := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_BestNameFirst,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_BestNameMid := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_BestNameMid,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_BestNameLast := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_BestNameLast,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_BestSSN := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_BestSSN,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_BestDOB := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_BestDOB,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_BestDOBAge := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								(INTEGER)RIGHT.PL_BestDOBAge);
			//Inquiry
			SELF.PL_SrchCollCnt5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchCollCnt5Y, 0);
			SELF.PL_SrchCollDtList5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchCollDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchCollNewDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchCollNewDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchCollOldDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchCollOldDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchCollNewMsnc5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchCollNewMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchCollOldMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchCollOldMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchCreditHRCnt5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchCreditHRCnt5Y, 0);
			SELF.PL_SrchCreditHRDtList5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchCreditHRDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchCreditHRNewDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchCreditHRNewDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchCreditHROldDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchCreditHROldDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchCreditHRNewMsnc5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchCreditHRNewMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchCreditHROldMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchCreditHROldMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchBankCnt5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchBankCnt5Y, 0);
			SELF.PL_SrchBankDtList5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchBankDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchBankNewDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchBankNewDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchBankOldDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchBankOldDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchBankNewMsnc5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchBankNewMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchBankOldMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchBankOldMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);	
			SELF.PL_SrchAutoCnt5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchAutoCnt5Y, 0);
			SELF.PL_SrchAutoDtList5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchAutoDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchAutoNewDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchAutoNewDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchAutoOldDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchAutoOldDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchAutoNewMsnc5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchAutoNewMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchAutoOldMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchAutoOldMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchMtgeCnt5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchMtgeCnt5Y, 0);
			SELF.PL_SrchMtgeDtList5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchMtgeDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchMtgeNewDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchMtgeNewDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchMtgeOldDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchMtgeOldDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchMtgeNewMsnc5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchMtgeNewMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchMtgeOldMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchMtgeOldMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchUtilCnt5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchUtilCnt5Y, 0);
			SELF.PL_SrchUtilDtList5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchUtilDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchUtilNewDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchUtilNewDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchUtilOldDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchUtilOldDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchUtilNewMsnc5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchUtilNewMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchUtilOldMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchUtilOldMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchPrepayCardCnt5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchPrepayCardCnt5Y, 0);
			SELF.PL_SrchPrepayCardDtList5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchPrepayCardDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchPrepayCardNewDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchPrepayCardNewDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchPrepayCardOldDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchPrepayCardOldDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchPrepayCardNewMsnc5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchPrepayCardNewMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchPrepayCardOldMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchPrepayCardOldMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchCommCnt5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchCommCnt5Y, 0);
			SELF.PL_SrchCommDtList5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchCommDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchCommNewDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchCommNewDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchCommOldDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchCommOldDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchCommNewMsnc5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchCommNewMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchCommOldMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchCommOldMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchStdntLoanCnt5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchStdntLoanCnt5Y, 0);
			SELF.PL_SrchStdntLoanDtList5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchStdntLoanDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchStdntLoanNewDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchStdntLoanNewDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchStdntLoanOldDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchStdntLoanOldDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchStdntLoanNewMsnc5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchStdntLoanNewMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchStdntLoanOldMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchStdntLoanOldMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchRetailPymtCnt5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchRetailPymtCnt5Y, 0);
			SELF.PL_SrchRetailPymtDtList5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchRetailPymtDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchRetailPymtNewDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchRetailPymtNewDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchRetailPymtOldDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchRetailPymtOldDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchRetailPymtNewMsnc5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchRetailPymtNewMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchRetailPymtOldMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchRetailPymtOldMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchQuizProvCnt5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchQuizProvCnt5Y, 0);
			SELF.PL_SrchQuizProvDtList5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchQuizProvDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchQuizProvNewDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchQuizProvNewDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchQuizProvOldDt5Y := MAP(Options.IsFCRA => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchQuizProvOldDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchQuizProvNewMsnc5Y := MAP(Options.IsFCRA => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchQuizProvNewMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchQuizProvOldMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchQuizProvOldMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);			
			//KS6136 Inquiry History ticket			
			SELF.PL_SrchRetailCnt5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchRetailCnt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchRetailDtList5Y := MAP(Options.IsFCRA  => '0',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchRetailDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchRetailNewDt5Y := MAP(Options.IsFCRA  => '0',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchRetailNewDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchRetailOldDt5Y := MAP(Options.IsFCRA  => '0',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchRetailOldDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchRetailNewMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchRetailNewMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchRetailOldMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchRetailOldMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchOtherCnt5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchOtherCnt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchOtherDtList5Y := MAP(Options.IsFCRA  => '0',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchOtherDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchOtherNewDt5Y := MAP(Options.IsFCRA  => '0',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchOtherNewDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchOtherOldDt5Y := MAP(Options.IsFCRA  => '0',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchOtherOldDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchOtherNewMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchOtherNewMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchOtherOldMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchOtherOldMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchCnt5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchCnt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchDtList5Y := MAP(Options.IsFCRA  => '0',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchNewDt5Y := MAP(Options.IsFCRA  => '0',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchNewDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchOldDt5Y := MAP(Options.IsFCRA  => '0',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_SrchOldDt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_SrchNewMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchNewMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchOldMsnc5Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchOldMsnc5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			// NonFCRA Velocity Inquiries
			SELF.PL_SrchPerLexIDCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchPerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchSSNPerLexIDCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchSSNPerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchAddrPerLexIDCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchAddrPerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchLNamePerLexIDCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchLNamePerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchFNamePerLexIDCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchFNamePerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchPhonePerLexIDCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchPhonePerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchDOBPerLexIDCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchDOBPerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchEmailPerLexIDCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchEmailPerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchPerCurrAddrCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchPerCurrAddrCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchLexIDPerCurrAddrCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchLexIDPerCurrAddrCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchLNamePerCurrAddrCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchLNamePerCurrAddrCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchSSNPerCurrAddrCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchSSNPerCurrAddrCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			// NonFCRA Inquiry PII Corroboration
			SELF.PL_SrchPerLexIDWInpFLSCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchPerLexIDWInpFLSCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchPerLexIDWInpASCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchPerLexIDWInpASCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchPerLexIDWInpSDCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchPerLexIDWInpSDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchPerLexIDWInpPSCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchPerLexIDWInpPSCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchPerLexIDWInpFLASCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchPerLexIDWInpFLASCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchPerLexIDWInpFLPSCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchPerLexIDWInpFLPSCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_SrchPerLexIDWInpFLAPSCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_SrchPerLexIDWInpFLAPSCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			// FCRA Velocity Inquiries
			SELF.PL_InqPerLexIDCnt1Y := MAP(NOT Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqSSNPerLexIDCnt1Y := MAP(NOT Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_InqSSNPerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqAddrPerLexIDCnt1Y := MAP(NOT Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_InqAddrPerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqLNamePerLexIDCnt1Y := MAP(NOT Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_InqLNamePerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqFNamePerLexIDCnt1Y := MAP(NOT Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_InqFNamePerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqPhonePerLexIDCnt1Y := MAP(NOT Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_InqPhonePerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqDOBPerLexIDCnt1Y := MAP(NOT Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_InqDOBPerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			
			// FCRA Inquiry PII Corroboration
			SELF.PL_InqPerLexIDWInpFLSCnt1Y := MAP(NOT Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDWInpFLSCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqPerLexIDWInpASCnt1Y := MAP(NOT Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDWInpASCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqPerLexIDWInpSDCnt1Y := MAP(NOT Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDWInpSDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqPerLexIDWInpPSCnt1Y := MAP(NOT Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDWInpPSCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqPerLexIDWInpFLASCnt1Y := MAP(NOT Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDWInpFLASCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqPerLexIDWInpFLPSCnt1Y := MAP(NOT Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDWInpFLPSCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqPerLexIDWInpFLAPSCnt1Y := MAP(NOT Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDWInpFLAPSCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			// Accidents
			SELF.PL_AccCntEv := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_AccCntEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);			
			SELF.PL_AccFlagEv := MAP(Options.IsFCRA => '0',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_AccFlagEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_AccDtListEv := MAP(Options.IsFCRA => '0',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_AccDtListEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_AccNewDtEv := MAP(Options.IsFCRA  => '0',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_AccNewDtEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);			
			SELF.PL_AccNewMsncEv := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_AccNewMsncEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AccDmgAmtListEv := MAP(Options.IsFCRA => '0',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.PL_AccDmgAmtListEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_AccDmgTotEv := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_AccDmgTotEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AccNewDmgAmtEv := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_AccNewDmgAmtEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AccCnt1Y := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.PL_AccCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			//Short Term Lending
			SELF.PL_STLCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_STLCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_STLCnt2Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_STLCnt2Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_STLCnt5Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_STLCnt5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_STLDtList5Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_STLDtList5Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);						
			//Overall Derog
			SELF.PL_DrgCnt7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgCnt7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgDtList7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgCnt7Y = 0 => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								Common_Functions.roll_list(SORT(RIGHT.CrimList + RIGHT.BankoList + RIGHT.LnJ7YList + RIGHT.LTD7YList,OriginalFilingDate), OriginalFilingDate, '|'));
			SELF.PL_DrgOldMsnc7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgOldMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgNewMsnc7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgNewMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);				
			SELF.P_LexIDCategory := MAP(Options.IsFCRA  => '',
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.P_LexIDCategory,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);				
			SELF.PL_HHID := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (integer)RIGHT.PL_HHID,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);				
			SELF.PL_HHMmbrCnt := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (integer)RIGHT.PL_HHMmbrCnt,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_HHMmbrBureauOnlyCnt := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (integer)RIGHT.PL_HHMmbrBureauOnlyCnt,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);				
			SELF.PL_HHMmbrAge18uCnt := MAP(Options.IsFCRA  => 0,
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (integer)RIGHT.PL_HHMmbrAge18uCnt,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);

			//Person Source Verification
			/*SELF.PL_VerSrcCntEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_VerSrcCntEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_VerSrcListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_VerSrcListEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_VerSrcEmrgDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_VerSrcEmrgDtListEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_VerSrcLastDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_VerSrcLastDtListEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
      SELF.PL_VerSrcOldDtEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_VerSrcOldDtEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_VerSrcNewDtEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_VerSrcNewDtEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.P_LexIDRstdOnlyFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.P_LexIDRstdOnlyFlag, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);*/			
			SELF.PL_AlrtCorrectedFlag := MAP(NOT Options.IsFCRA => '0',
																				LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,	
																				(string)RIGHT.PL_AlrtCorrectedFlag);
			SELF.PL_AlrtConsStatementFlag := MAP(NOT Options.IsFCRA => '0',
																				LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,	
																				(string)RIGHT.PL_AlrtConsStatementFlag);
			SELF.PL_AlrtDisputeFlag := MAP(NOT Options.IsFCRA => '0',
																				LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,	
																				(string)RIGHT.PL_AlrtDisputeFlag);
			SELF.PL_AlrtSecurityFreezeFlag := MAP(NOT Options.IsFCRA => '0',
																				LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,	
																				(string)RIGHT.PL_AlrtSecurityFreezeFlag);
			SELF.PL_AlrtSecurityAlertFlag := MAP(NOT Options.IsFCRA => '0',
																				LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,	
																				(string)RIGHT.PL_AlrtSecurityAlertFlag);
			SELF.PL_AlrtIDTheftFlag := MAP(NOT Options.IsFCRA => '0',
																				LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,	
																				(string)RIGHT.PL_AlrtIDTheftFlag);	
								
								
			SELF := LEFT;
		),LEFT OUTER, KEEP(1)); 

	
	PersonAttributesWithoutLexID := PROJECT(RecordsWithoutLexID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutPerson,
			SELF.P_LexIDSeenFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;			
			SELF.P_LexIDIsDeceasedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_EmrgAge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;			
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
			// Property
			SELF.PL_AstPropCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstPropNewDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;			
			SELF.PL_AstPropOldDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;	
			SELF.PL_AstPropCurrCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstPropSaleCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstPropSaleAmtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.PL_AstPropSaleTotEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstPropSaleDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;			
			SELF.PL_AstPropSaleNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AstPropSaleOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.PL_AstPropSaleNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstPropSaleOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
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
			//SELF.PL_CurrAddrLocID := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_PrevAddrFull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			//SELF.PL_PrevAddrLocID := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrCnty := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrGeo := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrLat := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrLng := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrType := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrStatus := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_PrevAddrCnty := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_PrevAddrGeo := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_PrevAddrLat := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_PrevAddrLng := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_PrevAddrType := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_PrevAddrStatus := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			//Current Address
			SELF.PL_CurrAddrIsVacantFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrIsThrowbackFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrSeasonalType := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrIsDNDFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrIsCollegeFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrIsCMRAFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrIsSimpAddrFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrIsDropDeliveryFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrIsBusinessFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrIsMultiUnitFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_CurrAddrIsAptFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;

			//Previous Address
			SELF.PL_PrevAddrIsSimpAddrFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_PrevAddrIsBusinessFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgJudgCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgLTDCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgLTDAmtList7Y:= PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgLTDDtList7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgLTDNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgLTDOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgLienCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			//Suits
			SELF.PL_DrgSuitCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgSuitAmtList7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgSuitAmtTot7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgSuitDtList7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgSuitNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgSuitOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			//OverAllLnJ
			SELF.PL_DrgLnJCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgLnJAmtList7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgLnJDtList7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgLnJNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgLnJNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgLnJOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgLnJOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
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
			SELF.PL_AstPropBusCntEv := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);;
			SELF.PL_AstPropBusCurrCnt := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);;
			SELF.PL_AstPropBusCurrWTaxValCnt := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_AstPropBusCurrTaxValList := IF(Options.IsFCRA,'0',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_AstPropBusCurrTaxValTot := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			//Utility
			SELF.PL_UtilCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_UtilOldDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_UtilOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_UtilOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			//Email
			SELF.PL_EmailCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			//Best PII
			SELF.PL_BestNameFirst := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_BestNameMid := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_BestNameLast := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_BestSSN := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_BestDOB := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_BESTDOBAge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			// Inquiry
			SELF.PL_SrchCollCnt5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchCollDtList5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchCollNewDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchCollOldDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchCollNewMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchCollOldMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchCreditHRCnt5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchCreditHRDtList5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchCreditHRNewDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchCreditHROldDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchCreditHRNewMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchCreditHROldMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);			
			SELF.PL_SrchBankCnt5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchBankDtList5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchBankNewDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchBankOldDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchBankNewMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchBankOldMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchAutoCnt5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchAutoDtList5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchAutoNewDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchAutoOldDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchAutoNewMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchAutoOldMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchMtgeCnt5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchMtgeDtList5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchMtgeNewDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchMtgeOldDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchMtgeNewMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchMtgeOldMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchUtilCnt5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchUtilDtList5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchUtilNewDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchUtilOldDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchUtilNewMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchUtilOldMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchPrepayCardCnt5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchPrepayCardDtList5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchPrepayCardNewDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchPrepayCardOldDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchPrepayCardNewMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchPrepayCardOldMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchCommCnt5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchCommDtList5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchCommNewDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchCommOldDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchCommNewMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchCommOldMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchStdntLoanCnt5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchStdntLoanDtList5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchStdntLoanNewDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchStdntLoanOldDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchStdntLoanNewMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchStdntLoanOldMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchRetailPymtCnt5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchRetailPymtDtList5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchRetailPymtNewDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchRetailPymtOldDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchRetailPymtNewMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchRetailPymtOldMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchQuizProvCnt5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchQuizProvDtList5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchQuizProvNewDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchQuizProvOldDt5Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchQuizProvNewMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchQuizProvOldMsnc5Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchRetailCnt5Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchRetailDtList5Y := IF(Options.IsFCRA, '', PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchRetailNewDt5Y := IF(Options.IsFCRA, '', PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchRetailOldDt5Y := IF(Options.IsFCRA, '', PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchRetailNewMsnc5Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchRetailOldMsnc5Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchOtherCnt5Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchOtherDtList5Y := IF(Options.IsFCRA, '', PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchOtherNewDt5Y := IF(Options.IsFCRA, '', PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchOtherOldDt5Y := IF(Options.IsFCRA, '', PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchOtherNewMsnc5Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchOtherOldMsnc5Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchCnt5Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchDtList5Y := IF(Options.IsFCRA, '', PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchNewDt5Y := IF(Options.IsFCRA, '', PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchOldDt5Y := IF(Options.IsFCRA, '', PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_SrchNewMsnc5Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchOldMsnc5Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			// Inquiry Velocity NonFCRA
			SELF.PL_SrchPerLexIDCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchSSNPerLexIDCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchAddrPerLexIDCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchLNamePerLexIDCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchFNamePerLexIDCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchPhonePerLexIDCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchDOBPerLexIDCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchEmailPerLexIDCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchPerCurrAddrCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchLexIDPerCurrAddrCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchLNamePerCurrAddrCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchSSNPerCurrAddrCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			// Inquiry PII Corroboration NonFCRA
			SELF.PL_SrchPerLexIDWInpFLSCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchPerLexIDWInpASCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchPerLexIDWInpSDCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchPerLexIDWInpPSCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchPerLexIDWInpFLASCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchPerLexIDWInpFLPSCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_SrchPerLexIDWInpFLAPSCnt1Y := IF(Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			// Inquiry Velocity FCRA
			SELF.PL_InqPerLexIDCnt1Y := IF(NOT Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_InqSSNPerLexIDCnt1Y := IF(NOT Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_InqAddrPerLexIDCnt1Y := IF(NOT Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_InqLNamePerLexIDCnt1Y := IF(NOT Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_InqFNamePerLexIDCnt1Y := IF(NOT Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_InqPhonePerLexIDCnt1Y := IF(NOT Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_InqDOBPerLexIDCnt1Y := IF(NOT Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			// Inquiry PII Corroboration FCRA
			SELF.PL_InqPerLexIDWInpFLSCnt1Y := IF(NOT Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_InqPerLexIDWInpASCnt1Y := IF(NOT Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_InqPerLexIDWInpSDCnt1Y := IF(NOT Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_InqPerLexIDWInpPSCnt1Y := IF(NOT Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_InqPerLexIDWInpFLASCnt1Y := IF(NOT Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_InqPerLexIDWInpFLPSCnt1Y := IF(NOT Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_InqPerLexIDWInpFLAPSCnt1Y := IF(NOT Options.IsFCRA, 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			//Accidents
			SELF.PL_AccCntEv := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_AccFlagEv := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_AccDtListEv := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_AccNewDtEv := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_AccNewMsncEv := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_AccDmgAmtListEv := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_AccDmgTotEv := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_AccNewDmgAmtEv := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_AccCnt1Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			//Overall Derog
			SELF.PL_DrgCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgDtList7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_DrgOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_DrgNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			//Short Term Lending
			SELF.PL_STLCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_STLCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_STLCnt5Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_STLDtList5Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.P_LexIDCategory := IF(Options.IsFCRA,'',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);				
			SELF.PL_HHID := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);				
			SELF.PL_HHMmbrCnt := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.PL_HHMmbrBureauOnlyCnt := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);				
			SELF.PL_HHMmbrAge18uCnt := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);

			//Person Source Verification
			/*SELF.PL_VerSrcCntEv := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);				
			SELF.PL_VerSrcListEv := IF(Options.IsFCRA,'',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);				
			SELF.PL_VerSrcEmrgDtListEv := IF(Options.IsFCRA,'',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);				
			SELF.PL_VerSrcLastDtListEv := IF(Options.IsFCRA,'',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);				
			SELF.PL_VerSrcOldDtEv := IF(Options.IsFCRA,'',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);				
			SELF.PL_VerSrcNewDtEv := IF(Options.IsFCRA,'',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);				
			SELF.P_LexIDRstdOnlyFlag := IF(Options.IsFCRA,'',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);*/	
			SELF.PL_AlrtCorrectedFlag := IF(NOT Options.IsFCRA, '0',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_AlrtConsStatementFlag := IF(NOT Options.IsFCRA, '0',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_AlrtDisputeFlag := IF(NOT Options.IsFCRA , '0',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_AlrtSecurityFreezeFlag := IF(NOT Options.IsFCRA , '0',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_AlrtSecurityAlertFlag := IF(NOT Options.IsFCRA , '0',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.PL_AlrtIDTheftFlag := IF(NOT Options.IsFCRA , '0',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);

			SELF := LEFT)); 	
			

	
	PersonAttributes := SORT( PersonAttributesWithLexID + PersonAttributesWithoutLexID, G_ProcUID ); 
	RETURN PersonAttributes;
END;
