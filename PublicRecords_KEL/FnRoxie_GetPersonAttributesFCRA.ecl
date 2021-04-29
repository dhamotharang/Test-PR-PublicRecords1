			IMPORT KEL13 AS KEL;
IMPORT PublicRecords_KEL, Risk_Indicators;

EXPORT FnRoxie_GetPersonAttributesFCRA( DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION
			
	Common_Functions := PublicRecords_KEL.ECL_Functions.Common_Functions;

	RecordsWithLexID := InputData(P_LexID  > 0);
	RecordsWithoutLexID := InputData(P_LexID  <= 0);
	

	LayoutPersonAttributesRaw := RECORD
		PublicRecords_KEL.KEL_Queries_MAS_FCRA.L_Compile.F_C_R_A_Person_Attributes_V1_Dynamic_Res0_Layout;
	END;	
	

	PersonAttributesRaw := NOCOMBINE(JOIN(RecordsWithLexID, FDCDataset,
		LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM({INTEGER G_ProcUID, LayoutPersonAttributesRaw},
			SELF.G_ProcUID := LEFT.G_ProcUID;
			FCRAPersonResults := PublicRecords_KEL.KEL_Queries_MAS_FCRA.Q_F_C_R_A_Person_Attributes_V1_Dynamic(LEFT.P_LexID , DATASET(LEFT), (INTEGER)(LEFT.P_InpClnArchDt[1..8]), Options.KEL_Permissions_Mask, DATASET(RIGHT)).res0;	
			SELF := FCRAPersonResults[1],
			SELF := []),
		LEFT OUTER, ATMOST(100), KEEP(1)));													

	PersonAttributesClean := KEL.Clean(PersonAttributesRaw, TRUE, TRUE, TRUE);
	
	// Cast Attributes back to their string values
	PersonAttributesWithLexID := JOIN(RecordsWithLexID, PersonAttributesClean, LEFT.G_ProcUID = RIGHT.G_ProcUID AND LEFT.P_LexID  = RIGHT.LexID, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutPerson,
			self.PL_PrescreenOptOutFlag := left.PL_PrescreenOptOutFlag;
			self.PI_BestDataAppended := left.PI_BestDataAppended;
			self.PL_BestNameAppendFlag := left.PL_BestNameAppendFlag;
			self.PL_BestSSNAppendFlag := left.PL_BestSSNAppendFlag;
			self.PL_BestAddrAppendFlag := left.PL_BestAddrAppendFlag;
			self.PL_BestDOBAppendFlag := left.PL_BestDOBAppendFlag;
			self.PL_BestPhoneAppendFlag := left.PL_BestPhoneAppendFlag;
			ResultsFound := RIGHT.LexID > 0;
			P_LexIDSeenFlag := IF(ResultsFound,RIGHT.P_LexIDSeenFlag,'0');
			LexIDNotOnFile := P_LexIDSeenFlag = '0';
			SELF.P_LexIDSeenFlag := P_LexIDSeenFlag;
			SELF.P_SubjAppliedInCAFlag  := Options.CaliforniaInPerson;//only true in FCRA, always false for nonFCRA
			SELF.P_LexIDIsDeceasedFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.P_LexIDIsDeceasedFlag);
			SELF.PL_EmrgAge := MAP(LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_EmrgAge,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
		
			SELF.PL_AstVehAirCntEv :=  MAP(			
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, 
								ResultsFound => (INTEGER)RIGHT.PL_AstVehAirCntEv, 0);
			SELF.PL_AstVehAirEmrgDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_AstVehAirCntEv = 0 => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								(STRING)RIGHT.PL_AstVehAirEmrgDtListEv);       
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
								(STRING)RIGHT.PL_AstVehWtrEmrgDtListEv);  
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
								RIGHT.PL_DrgBkCnt1Y > 0 => (STRING)RIGHT.PL_DrgBkDtList1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkDtList7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt7Y > 0 => (STRING)RIGHT.PL_DrgBkDtList7Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkDtList10Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt10Y > 0 => (STRING)RIGHT.PL_DrgBkDtList10Y, 
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
								RIGHT.PL_DrgBkCnt1Y > 0 => (STRING)RIGHT.PL_DrgBkChList1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkChList7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt7Y > 0 => (STRING)RIGHT.PL_DrgBkChList7Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkChList10Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt10Y > 0 => (STRING)RIGHT.PL_DrgBkChList10Y, 
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
								RIGHT.PL_DrgBkCnt1Y > 0 => (STRING)RIGHT.PL_DrgBkDispList1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkDispList7Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt7Y > 0 => (STRING)RIGHT.PL_DrgBkDispList7Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkDispList10Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt10Y > 0 => (STRING)RIGHT.PL_DrgBkDispList10Y, 
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
								RIGHT.PL_DrgBkCnt1Y > 0 => (STRING)RIGHT.PL_DrgBkTypeList1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkTypeList7Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt7Y > 0 => (STRING)RIGHT.PL_DrgBkTypeList7Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkTypeList10Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt10Y > 0 => (STRING)RIGHT.PL_DrgBkTypeList10Y, 
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
								(STRING)RIGHT.PL_ProfLicIssueDtListEv);  
			SELF.PL_ProfLicExpDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_ProfLicFlagEv = '0' => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								(STRING)RIGHT.PL_ProfLicExpDtListEv); 
			SELF.PL_ProfLicIndxByLicListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_ProfLicFlagEv = '0' => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								(STRING)RIGHT.PL_ProfLicIndxByLicListEv);
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
	
			// FCRA Velocity Inquiries
			SELF.PL_InqPerLexIDCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								 ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqSSNPerLexIDCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								 ResultsFound => (INTEGER)RIGHT.PL_InqSSNPerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqAddrPerLexIDCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								 ResultsFound => (INTEGER)RIGHT.PL_InqAddrPerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqLNamePerLexIDCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								 ResultsFound => (INTEGER)RIGHT.PL_InqLNamePerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqFNamePerLexIDCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								 ResultsFound => (INTEGER)RIGHT.PL_InqFNamePerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqPhonePerLexIDCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								 ResultsFound => (INTEGER)RIGHT.PL_InqPhonePerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqDOBPerLexIDCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								 ResultsFound => (INTEGER)RIGHT.PL_InqDOBPerLexIDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			
			// FCRA Inquiry PII Corroboration
			SELF.PL_InqPerLexIDWInpFLSCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								 ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDWInpFLSCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqPerLexIDWInpASCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								 ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDWInpASCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqPerLexIDWInpSDCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								 ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDWInpSDCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqPerLexIDWInpPSCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								 ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDWInpPSCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqPerLexIDWInpFLASCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								 ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDWInpFLASCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqPerLexIDWInpFLPSCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								 ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDWInpFLPSCnt1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_InqPerLexIDWInpFLAPSCnt1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								 ResultsFound => (INTEGER)RIGHT.PL_InqPerLexIDWInpFLAPSCnt1Y, 
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
								(Common_Functions.roll_list(SORT(RIGHT.CrimList + RIGHT.BankoList + RIGHT.LnJ7YList + RIGHT.LTD7YList,OriginalFilingDate), OriginalFilingDate, '|')));
			SELF.PL_DrgOldMsnc7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgOldMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_DrgNewMsnc7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_DrgNewMsnc7Y,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);				
	
			//Person Source Verification
			SELF.PL_VerSrcCntEv := MAP(
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
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_AlrtCorrectedFlag := MAP(
																				LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,	
																				(string)RIGHT.PL_AlrtCorrectedFlag);
			SELF.PL_AlrtConsStatementFlag := MAP(
																				LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,	
																				(string)RIGHT.PL_AlrtConsStatementFlag);
			SELF.PL_AlrtDisputeFlag := MAP(
																				LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,	
																				(string)RIGHT.PL_AlrtDisputeFlag);
			SELF.PL_AlrtSecurityFreezeFlag := MAP(
																				LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,	
																				(string)RIGHT.PL_AlrtSecurityFreezeFlag);
			SELF.PL_AlrtSecurityAlertFlag := MAP(
																				LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,	
																				(string)RIGHT.PL_AlrtSecurityAlertFlag);
			SELF.PL_AlrtIDTheftFlag := MAP(
																				LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,	
																				(string)RIGHT.PL_AlrtIDTheftFlag);	
			
     SELF.PL_VerNameFirstSrcCntEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_VerNameFirstSrcCntEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_VerNameFirstSrcListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_VerNameFirstSrcListEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_VerNameFirstSrcEmrgDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_VerNameFirstSrcEmrgDtListEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_VerNameFirstSrcLastDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_VerNameFirstSrcLastDtListEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);				
			SELF.PL_VerSSNSrcCntEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_VerSSNSrcCntEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_VerSSNSrcListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_VerSSNSrcListEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_VerSSNSrcEmrgDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_VerSSNSrcEmrgDtListEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_VerSSNSrcLastDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => RIGHT.PL_VerSSNSrcLastDtListEv, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);	
			SELF.PL_AstPropFlagEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_AstPropFlagEv,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_AstPropCurrFlag := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_AstPropCurrFlag,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_AstPropOwnershipIndx := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_AstPropOwnershipIndx,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_AstPropCurrWMktValCnt := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_AstPropCurrWMktValCnt,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstPropCurrMktValList := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_AstPropCurrMktValList,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_AstPropCurrWTaxValCnt := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_AstPropCurrWTaxValCnt,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstPropCurrTaxValList := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_AstPropCurrTaxValList,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_AstPropCurrTaxValTot := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_AstPropCurrTaxValTot,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstPropCurrWAVMValCnt := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_AstPropCurrWAVMValCnt,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstPropCurrAVMValList := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								ResultsFound => (STRING)RIGHT.PL_AstPropCurrAVMValList,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.PL_AstPropCurrAVMValTot := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_AstPropCurrAVMValTot,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.PL_AstPropCurrAVMValAvg := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,
								ResultsFound => (INTEGER)RIGHT.PL_AstPropCurrAVMValAvg,
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);								
								
			SELF := LEFT;
			self := [];
		),LEFT OUTER, KEEP(1)); 

	
	PersonAttributesWithoutLexID := PROJECT(RecordsWithoutLexID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutPerson,
			SELF.P_LexIDSeenFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.P_SubjAppliedInCAFlag  := Options.CaliforniaInPerson;//only true in FCRA, always false for nonFCRA
			SELF.P_LexIDIsDeceasedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_EmrgAge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;			
	
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
			// Inquiry Velocity FCRA
			SELF.PL_InqPerLexIDCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_InqSSNPerLexIDCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_InqAddrPerLexIDCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_InqLNamePerLexIDCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_InqFNamePerLexIDCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_InqPhonePerLexIDCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_InqDOBPerLexIDCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			// Inquiry PII Corroboration FCRA
			SELF.PL_InqPerLexIDWInpFLSCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_InqPerLexIDWInpASCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_InqPerLexIDWInpSDCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_InqPerLexIDWInpPSCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_InqPerLexIDWInpFLASCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_InqPerLexIDWInpFLPSCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_InqPerLexIDWInpFLAPSCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		
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
		

			//Person Source Verification
			SELF.PL_VerSrcCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;				
			SELF.PL_VerSrcListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;				
			SELF.PL_VerSrcEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;				
			SELF.PL_VerSrcLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;				
			SELF.PL_VerSrcOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;				
			SELF.PL_VerSrcNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;				
			SELF.P_LexIDRstdOnlyFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AlrtCorrectedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AlrtConsStatementFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AlrtDisputeFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AlrtSecurityFreezeFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AlrtSecurityAlertFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AlrtIDTheftFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			
			SELF.PL_VerNameFirstSrcCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;				
			SELF.PL_VerNameFirstSrcListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;				
			SELF.PL_VerNameFirstSrcEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;				
			SELF.PL_VerNameFirstSrcLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;	
			
			SELF.PL_VerSSNSrcCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;				
			SELF.PL_VerSSNSrcListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;				
			SELF.PL_VerSSNSrcEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;				
			SELF.PL_VerSSNSrcLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			
			SELF.PL_AstPropFlagEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AstPropCurrFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AstPropOwnershipIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AstPropCurrWMktValCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstPropCurrMktValList := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AstPropCurrWTaxValCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstPropCurrTaxValList := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AstPropCurrTaxValTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstPropCurrWAVMValCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstPropCurrAVMValList := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PL_AstPropCurrAVMValTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PL_AstPropCurrAVMValAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF := LEFT,
			SElf := [])); 	
			

	
	PersonAttributes := SORT( PersonAttributesWithLexID + PersonAttributesWithoutLexID, G_ProcUID ); 


	RETURN PersonAttributes;
END;
