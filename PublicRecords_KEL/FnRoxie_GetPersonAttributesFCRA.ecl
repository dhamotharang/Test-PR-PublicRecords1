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
			SELF.P_LexIDCategory := IF(ResultsFound, RIGHT.P_LexIDCategory, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);			
			SELF.P_SubjAppliedInCAFlag  := Options.CaliforniaInPerson;//only true in FCRA, always false for nonFCRA
			SELF.P_LexIDIsDeceasedFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.P_LexIDIsDeceasedFlag);
			SELF.PL_EmrgAge := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_EmrgAge);
			SELF.PL_AstVehAirCntEv :=  IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstVehAirCntEv);
			SELF.PL_AstVehAirEmrgDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_AstVehAirCntEv = 0 => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								RIGHT.PL_AstVehAirEmrgDtListEv);       
			SELF.PL_AstVehAirEmrgNewDtEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AstVehAirEmrgNewDtEv);			
			SELF.PL_AstVehAirEmrgOldDtEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AstVehAirEmrgOldDtEv);				
			SELF.PL_AstVehAirEmrgNewMsncEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstVehAirEmrgNewMsncEv);
			SELF.PL_AstVehAirEmrgOldMsncEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstVehAirEmrgOldMsncEv);
			SELF.PL_AstVehWtrCntEv :=  IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstVehWtrCntEv);
			SELF.PL_AstVehWtrEmrgDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_AstVehWtrCntEv = 0 => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								RIGHT.PL_AstVehWtrEmrgDtListEv);  
			SELF.PL_AstVehWtrEmrgNewDtEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AstVehWtrEmrgNewDtEv);			
			SELF.PL_AstVehWtrEmrgOldDtEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AstVehWtrEmrgOldDtEv);				
			SELF.PL_AstVehWtrEmrgNewMsncEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstVehWtrEmrgNewMsncEv);
			SELF.PL_AstVehWtrEmrgOldMsncEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstVehWtrEmrgOldMsncEv);
			// Property
			SELF.PL_AstPropCntEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstPropCntEv);
			SELF.PL_AstPropNewDtListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AstPropNewDtListEv);
			SELF.PL_AstPropOldDtListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AstPropOldDtListEv);
			SELF.PL_AstPropCurrCnt := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstPropCurrCnt);
			SELF.PL_AstPropSaleCntEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstPropSaleCntEv);
			SELF.PL_AstPropSaleAmtListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AstPropSaleAmtListEv);
			SELF.PL_AstPropSaleTotEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstPropSaleTotEv);
			SELF.PL_AstPropSaleDtListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AstPropSaleDtListEv);
			SELF.PL_AstPropSaleNewDtEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AstPropSaleNewDtEv);
			SELF.PL_AstPropSaleOldDtEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AstPropSaleOldDtEv);
			SELF.PL_AstPropSaleNewMsncEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstPropSaleNewMsncEv);
			SELF.PL_AstPropSaleOldMsncEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstPropSaleOldMsncEv);
			SELF.PL_DrgCrimFelCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimFelCnt1Y);
			SELF.PL_DrgCrimFelCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimFelCnt7Y);
			SELF.PL_DrgCrimFelNewDt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgCrimFelNewDt1Y);
			SELF.PL_DrgCrimFelOldDt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgCrimFelOldDt1Y); 
			SELF.PL_DrgCrimFelNewDt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgCrimFelNewDt7Y); 
			SELF.PL_DrgCrimFelOldDt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgCrimFelOldDt7Y);
			SELF.PL_DrgCrimFelNewMsnc1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimFelNewMsnc1Y);
			SELF.PL_DrgCrimFelOldMsnc1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimFelOldMsnc1Y);
			SELF.PL_DrgCrimFelNewMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimFelNewMsnc7Y); 
			SELF.PL_DrgCrimFelOldMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimFelOldMsnc7Y);
			SELF.PL_DrgCrimNfelCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimNfelCnt1Y);
			SELF.PL_DrgCrimNfelCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimNfelCnt7Y);
			SELF.PL_DrgCrimNfelNewDt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgCrimNfelNewDt1Y);
			SELF.PL_DrgCrimNfelOldDt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgCrimNfelOldDt1Y);
			SELF.PL_DrgCrimNfelNewDt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgCrimNfelNewDt7Y);
			SELF.PL_DrgCrimNfelOldDt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgCrimNfelOldDt7Y);
			SELF.PL_DrgCrimNfelNewMsnc1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimNfelNewMsnc1Y);
			SELF.PL_DrgCrimNfelOldMsnc1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimNfelOldMsnc1Y);
			SELF.PL_DrgCrimNfelNewMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimNfelNewMsnc7Y);
			SELF.PL_DrgCrimNfelOldMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimNfelOldMsnc7Y);
			SELF.PL_DrgCrimCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimCnt1Y);
			SELF.PL_DrgCrimCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimCnt7Y);
			SELF.PL_DrgCrimNewDt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgCrimNewDt1Y);
			SELF.PL_DrgCrimOldDt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgCrimOldDt1Y);
			SELF.PL_DrgCrimNewDt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgCrimNewDt7Y);
			SELF.PL_DrgCrimOldDt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgCrimOldDt7Y);
			SELF.PL_DrgCrimNewMsnc1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimNewMsnc1Y);
			SELF.PL_DrgCrimOldMsnc1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimOldMsnc1Y);
			SELF.PL_DrgCrimNewMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimNewMsnc7Y);
			SELF.PL_DrgCrimOldMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCrimOldMsnc7Y);
			SELF.PL_DrgCrimSeverityIndx7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgCrimSeverityIndx7Y);
			SELF.PL_DrgCrimBehaviorIndx7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgCrimBehaviorIndx7Y);
			//Bankruptcy	
			SELF.PL_DrgBkCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkCnt1Y); 
			SELF.PL_DrgBkCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkCnt7Y);
			SELF.PL_DrgBkCnt10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkCnt10Y);
			SELF.PL_DrgBkDtList1Y := MAP( 
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt1Y > 0 => RIGHT.PL_DrgBkDtList1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkDtList7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt7Y > 0 => RIGHT.PL_DrgBkDtList7Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkDtList10Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt10Y > 0 => RIGHT.PL_DrgBkDtList10Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND); 
			SELF.PL_DrgBkNewDt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkNewDt1Y);
			SELF.PL_DrgBkNewDt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkNewDt7Y );
			SELF.PL_DrgBkNewDt10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkNewDt10Y);
			SELF.PL_DrgBkOldDt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkOldDt1Y);
			SELF.PL_DrgBkOldDt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkOldDt7Y);
			SELF.PL_DrgBkOldDt10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkOldDt10Y);
			SELF.PL_DrgBkNewMsnc1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkNewMsnc1Y);
			SELF.PL_DrgBkNewMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkNewMsnc7Y);
			SELF.PL_DrgBkNewMsnc10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkNewMsnc10Y);
			SELF.PL_DrgBkOldMsnc1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkOldMsnc1Y);
			SELF.PL_DrgBkOldMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkOldMsnc7Y);
			SELF.PL_DrgBkOldMsnc10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkOldMsnc10Y);
			SELF.PL_DrgBkChList1Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt1Y > 0 => RIGHT.PL_DrgBkChList1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkChList7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt7Y > 0 => RIGHT.PL_DrgBkChList7Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkChList10Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt10Y > 0 => RIGHT.PL_DrgBkChList10Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkNewChType1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkNewChType1Y);
			SELF.PL_DrgBkNewChType7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkNewChType7Y);
			SELF.PL_DrgBkNewChType10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkNewChType10Y);
			SELF.PL_DrgBkCh7Cnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkCh7Cnt1Y);
			SELF.PL_DrgBkCh7Cnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkCh7Cnt7Y);
			SELF.PL_DrgBkCh7Cnt10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkCh7Cnt10Y);
			SELF.PL_DrgBkCh13Cnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkCh13Cnt1Y);
			SELF.PL_DrgBkCh13Cnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkCh13Cnt7Y);
			SELF.PL_DrgBkCh13Cnt10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkCh13Cnt10Y);
			SELF.PL_DrgBkUpdtNewDt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkUpdtNewDt1Y);
			SELF.PL_DrgBkUpdtNewDt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkUpdtNewDt7Y);
			SELF.PL_DrgBkUpdtNewDt10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkUpdtNewDt10Y);
			SELF.PL_DrgBkUpdtNewMsnc1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, (INTEGER)RIGHT.PL_DrgBkUpdtNewMsnc1Y);
			SELF.PL_DrgBkUpdtNewMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, (INTEGER)RIGHT.PL_DrgBkUpdtNewMsnc7Y);
			SELF.PL_DrgBkUpdtNewMsnc10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, (INTEGER)RIGHT.PL_DrgBkUpdtNewMsnc10Y);	
			SELF.PL_DrgBkDispList1Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt1Y > 0 => RIGHT.PL_DrgBkDispList1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkDispList7Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt7Y > 0 => RIGHT.PL_DrgBkDispList7Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkDispList10Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt10Y > 0 => RIGHT.PL_DrgBkDispList10Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkNewDispType1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkNewDispType1Y);
			SELF.PL_DrgBkNewDispType7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkNewDispType7Y);
			SELF.PL_DrgBkNewDispType10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkNewDispType10Y);
			SELF.PL_DrgBkNewDispDt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkNewDispDt1Y);
			SELF.PL_DrgBkNewDispDt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkNewDispDt7Y);
			SELF.PL_DrgBkNewDispDt10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkNewDispDt10Y);
			SELF.PL_DrgBkNewDispMsnc1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, (INTEGER)RIGHT.PL_DrgBkNewDispMsnc1Y);
			SELF.PL_DrgBkNewDispMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, (INTEGER)RIGHT.PL_DrgBkNewDispMsnc7Y);
			SELF.PL_DrgBkNewDispMsnc10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, (INTEGER)RIGHT.PL_DrgBkNewDispMsnc10Y);
			SELF.PL_DrgBkDispCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkDispCnt1Y);
			SELF.PL_DrgBkDispCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkDispCnt7Y);
			SELF.PL_DrgBkDispCnt10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkDispCnt10Y);
			SELF.PL_DrgBkDsmsCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkDsmsCnt1Y);
			SELF.PL_DrgBkDsmsCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkDsmsCnt7Y);
			SELF.PL_DrgBkDsmsCnt10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkDsmsCnt10Y);
			SELF.PL_DrgBkDschCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkDschCnt1Y);
			SELF.PL_DrgBkDschCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkDschCnt7Y);
			SELF.PL_DrgBkDschCnt10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgBkDschCnt10Y);
			SELF.PL_DrgBkTypeList1Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt1Y > 0 => RIGHT.PL_DrgBkTypeList1Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkTypeList7Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt7Y > 0 => RIGHT.PL_DrgBkTypeList7Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkTypeList10Y :=  MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgBkCnt10Y > 0 => RIGHT.PL_DrgBkTypeList10Y, 
								PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);  
			SELF.PL_DrgBkBusFlag1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkBusFlag1Y);
			SELF.PL_DrgBkBusFlag7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkBusFlag7Y);
			SELF.PL_DrgBkBusFlag10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkBusFlag10Y);
			SELF.PL_DrgBkSeverityIndx10Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgBkSeverityIndx10Y);
			//ProfessionalLicense
			SELF.PL_ProfLicFlagEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_ProfLicFlagEv);
			SELF.PL_ProfLicIssueDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_ProfLicFlagEv = '0' => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								RIGHT.PL_ProfLicIssueDtListEv);  
			SELF.PL_ProfLicExpDtListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_ProfLicFlagEv = '0' => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								RIGHT.PL_ProfLicExpDtListEv); 
			SELF.PL_ProfLicIndxByLicListEv := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_ProfLicFlagEv = '0' => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								RIGHT.PL_ProfLicIndxByLicListEv);
			SELF.PL_ProfLicActvFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_ProfLicActvFlag);
			SELF.PL_ProfLicActvNewIssueDt := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_ProfLicActvNewIssueDt);
			SELF.PL_ProfLicActvNewExpDt := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_ProfLicActvNewExpDt);
			SELF.PL_ProfLicActvNewType := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_ProfLicActvNewType);
			SELF.PL_ProfLicActvNewTitleType := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_ProfLicActvNewTitleType);
			SELF.PL_ProfLicActvNewIndx := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_ProfLicActvNewIndx);
			SELF.PL_ProfLicActvNewSrcType := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_ProfLicActvNewSrcType);
			//Best PII
			SELF.PL_CurrAddrFull := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_CurrAddrFull);
			// SELF.PL_CurrAddrLocID := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_CurrAddrLocID);
			SELF.PL_PrevAddrFull := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_PrevAddrFull);
			// SELF.PL_PrevAddrLocID := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_PrevAddrLocID);
			SELF.PL_CurrAddrCnty := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_CurrAddrCnty);
			SELF.PL_CurrAddrGeo := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_CurrAddrGeo);
			SELF.PL_CurrAddrLat := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_CurrAddrLat);
			SELF.PL_CurrAddrLng := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_CurrAddrLng);
			SELF.PL_CurrAddrType := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_CurrAddrType);
			SELF.PL_CurrAddrStatus := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_CurrAddrStatus);
			SELF.PL_PrevAddrCnty := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_PrevAddrCnty);
			SELF.PL_PrevAddrGeo := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_PrevAddrGeo);
			SELF.PL_PrevAddrLat := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_PrevAddrLat);
			SELF.PL_PrevAddrLng := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_PrevAddrLng);
			SELF.PL_PrevAddrType := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_PrevAddrType);
			SELF.PL_PrevAddrStatus := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_PrevAddrStatus);
			//Current Address
			SELF.PL_CurrAddrIsVacantFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_CurrAddrIsVacantFlag);
			SELF.PL_CurrAddrIsThrowbackFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_CurrAddrIsThrowbackFlag);
			SELF.PL_CurrAddrSeasonalType := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_CurrAddrSeasonalType);
			SELF.PL_CurrAddrIsDNDFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_CurrAddrIsDNDFlag);
			SELF.PL_CurrAddrIsCollegeFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_CurrAddrIsCollegeFlag);
			SELF.PL_CurrAddrIsCMRAFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_CurrAddrIsCMRAFlag);
			SELF.PL_CurrAddrIsSimpAddrFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_CurrAddrIsSimpAddrFlag);
			SELF.PL_CurrAddrIsDropDeliveryFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_CurrAddrIsDropDeliveryFlag);
			SELF.PL_CurrAddrIsBusinessFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_CurrAddrIsBusinessFlag);
			SELF.PL_CurrAddrIsMultiUnitFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_CurrAddrIsMultiUnitFlag);
			SELF.PL_CurrAddrIsAptFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_CurrAddrIsAptFlag);
			//Previous Address
			SELF.PL_PrevAddrIsSimpAddrFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_PrevAddrIsSimpAddrFlag);
			SELF.PL_PrevAddrIsBusinessFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_PrevAddrIsBusinessFlag);
			SELF.PL_DrgJudgCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgJudgCnt7Y);
			SELF.PL_DrgLTDCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgLTDCnt7Y);
			SELF.PL_DrgLTDAmtList7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgLTDAmtList7Y);
			SELF.PL_DrgLTDDtList7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgLTDDtList7Y);
			SELF.PL_DrgLTDNewMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgLTDNewMsnc7Y);
			SELF.PL_DrgLTDOldMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgLTDOldMsnc7Y);
			SELF.PL_DrgLienCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgLienCnt7Y);
			//Suits
			SELF.PL_DrgSuitCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgSuitCnt7Y);
			SELF.PL_DrgSuitAmtList7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgSuitAmtList7Y);
			SELF.PL_DrgSuitAmtTot7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgSuitAmtTot7Y);
			SELF.PL_DrgSuitDtList7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgSuitDtList7Y);
			SELF.PL_DrgSuitNewMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgSuitNewMsnc7Y);
			SELF.PL_DrgSuitOldMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgSuitOldMsnc7Y);
			//OverAllLnJ
			SELF.PL_DrgLnJCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgLnJCnt7Y);
			SELF.PL_DrgLnJAmtList7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgLnJAmtList7Y);
			SELF.PL_DrgLnJDtList7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgLnJDtList7Y);
			SELF.PL_DrgLnJNewDt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgLnJNewDt7Y);
			SELF.PL_DrgLnJNewMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgLnJNewMsnc7Y);
			SELF.PL_DrgLnJOldDt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_DrgLnJOldDt7Y);
			SELF.PL_DrgLnJOldMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgLnJOldMsnc7Y);
			//Education
			SELF.PL_EduRecFlagEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_EduRecFlagEv);
			SELF.PL_EduSrcListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_EduSrcListEv);
			SELF.PL_EduHSRecFlagEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_EduHSRecFlagEv);
			SELF.PL_EduCollRecFlagEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_EduCollRecFlagEv);
			SELF.PL_EduCollSrcEmrgDtListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_EduCollSrcEmrgDtListEv);
			SELF.PL_EduCollSrcLastDtListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_EduCollSrcLastDtListEv);
			SELF.PL_EduCollSrcNewRecOldDtEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_EduCollSrcNewRecOldDtEv);
			SELF.PL_EduCollSrcNewRecNewDtEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_EduCollSrcNewRecNewDtEv);
			SELF.PL_EduCollSrcNewRecOldMsncEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, (INTEGER)RIGHT.PL_EduCollSrcNewRecOldMsncEv);
			SELF.PL_EduCollSrcNewRecNewMsncEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, (INTEGER)RIGHT.PL_EduCollSrcNewRecNewMsncEv);
			SELF.PL_EduCollRecSpanEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, (INTEGER)RIGHT.PL_EduCollRecSpanEv);
			//Email
			SELF.PL_EmailCntEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_EmailCntEv);
			//Best PII
			SELF.PL_BestNameFirst := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_BestNameFirst);
			SELF.PL_BestNameMid := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_BestNameMid);
			SELF.PL_BestNameLast := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_BestNameLast);
			SELF.PL_BestSSN := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_BestSSN);
			SELF.PL_BestDOB := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_BestDOB);
			SELF.PL_BestDOBAge := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_BestDOBAge);
			// FCRA Velocity Inquiries
			SELF.PL_InqPerLexIDCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_InqPerLexIDCnt1Y);
			SELF.PL_InqSSNPerLexIDCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_InqSSNPerLexIDCnt1Y);
			SELF.PL_InqAddrPerLexIDCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_InqAddrPerLexIDCnt1Y);
			SELF.PL_InqLNamePerLexIDCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_InqLNamePerLexIDCnt1Y);
			SELF.PL_InqFNamePerLexIDCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_InqFNamePerLexIDCnt1Y);
			SELF.PL_InqPhonePerLexIDCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_InqPhonePerLexIDCnt1Y);
			SELF.PL_InqDOBPerLexIDCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_InqDOBPerLexIDCnt1Y);
			// FCRA Inquiry PII Corroboration
			SELF.PL_InqPerLexIDWInpFLSCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_InqPerLexIDWInpFLSCnt1Y);
			SELF.PL_InqPerLexIDWInpASCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_InqPerLexIDWInpASCnt1Y);
			SELF.PL_InqPerLexIDWInpSDCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_InqPerLexIDWInpSDCnt1Y);
			SELF.PL_InqPerLexIDWInpPSCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_InqPerLexIDWInpPSCnt1Y);
			SELF.PL_InqPerLexIDWInpFLASCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_InqPerLexIDWInpFLASCnt1Y);
			SELF.PL_InqPerLexIDWInpFLPSCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_InqPerLexIDWInpFLPSCnt1Y);
			SELF.PL_InqPerLexIDWInpFLAPSCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_InqPerLexIDWInpFLAPSCnt1Y);
			//Short Term Lending
			SELF.PL_STLCnt1Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_STLCnt1Y);
			SELF.PL_STLCnt2Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_STLCnt2Y);
			SELF.PL_STLCnt5Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_STLCnt5Y);
			SELF.PL_STLDtList5Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_STLDtList5Y);
			//Overall Derog
			SELF.PL_DrgCnt7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgCnt7Y);
			SELF.PL_DrgDtList7Y := MAP(
								LexIDNotOnFile => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
								RIGHT.PL_DrgCnt7Y = 0 => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
								(Common_Functions.roll_list(SORT(RIGHT.CrimList + RIGHT.BankoList + RIGHT.LnJ7YList + RIGHT.LTD7YList,OriginalFilingDate), OriginalFilingDate, '|')));
			SELF.PL_DrgOldMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgOldMsnc7Y);
			SELF.PL_DrgNewMsnc7Y := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_DrgNewMsnc7Y);
			//Person Source Verification
			SELF.PL_VerSrcCntEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_VerSrcCntEv);
			SELF.PL_VerSrcListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_VerSrcListEv);
			SELF.PL_VerSrcEmrgDtListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_VerSrcEmrgDtListEv);
			SELF.PL_VerSrcLastDtListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_VerSrcLastDtListEv);
			SELF.PL_VerSrcOldDtEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_VerSrcOldDtEv);
			SELF.PL_VerSrcNewDtEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_VerSrcNewDtEv);
			SELF.P_LexIDRstdOnlyFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.P_LexIDRstdOnlyFlag);
			SELF.PL_AlrtCorrectedFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AlrtCorrectedFlag);
			SELF.PL_AlrtConsStatementFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AlrtConsStatementFlag);
			SELF.PL_AlrtDisputeFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AlrtDisputeFlag);
			SELF.PL_AlrtSecurityFreezeFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AlrtSecurityFreezeFlag);
			SELF.PL_AlrtSecurityAlertFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AlrtSecurityAlertFlag);
			SELF.PL_AlrtIDTheftFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AlrtIDTheftFlag);
			SELF.PL_VerNameFirstSrcCntEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_VerNameFirstSrcCntEv);
			SELF.PL_VerNameFirstSrcListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_VerNameFirstSrcListEv);
			SELF.PL_VerNameFirstSrcEmrgDtListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_VerNameFirstSrcEmrgDtListEv);
			SELF.PL_VerNameFirstSrcLastDtListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_VerNameFirstSrcLastDtListEv);
			SELF.PL_VerNameLastSrcCntEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,(INTEGER)RIGHT.PL_VerNameLastSrcCntEv);								
			SELF.PL_VerNameLastSrcListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,RIGHT.PL_VerNameLastSrcListEv); 
			SELF.PL_VerNameLastSrcEmrgDtListEv := IF(LexIDNotOnFile,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,RIGHT.PL_VerNameLastSrcEmrgDtListEv); 
			SELF.PL_VerNameLastSrcLastDtListEv := IF(LexIDNotOnFile , PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,RIGHT.PL_VerNameLastSrcLastDtListEv);
			SELF.PL_VerSSNSrcCntEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_VerSSNSrcCntEv);
			SELF.PL_VerSSNSrcListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_VerSSNSrcListEv);
			SELF.PL_VerSSNSrcEmrgDtListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_VerSSNSrcEmrgDtListEv);
			SELF.PL_VerSSNSrcLastDtListEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_VerSSNSrcLastDtListEv);
			SELF.PL_AstPropFlagEv := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_AstPropFlagEv);
			SELF.PL_AstPropCurrFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_AstPropCurrFlag);
			SELF.PL_AstPropOwnershipIndx := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_AstPropOwnershipIndx);
			SELF.PL_AstPropCurrWMktValCnt := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstPropCurrWMktValCnt);
			SELF.PL_AstPropCurrMktValList := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AstPropCurrMktValList);
			SELF.PL_AstPropCurrWTaxValCnt := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstPropCurrWTaxValCnt);
			SELF.PL_AstPropCurrTaxValList := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AstPropCurrTaxValList);
			SELF.PL_AstPropCurrTaxValTot := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstPropCurrTaxValTot);
			SELF.PL_AstPropCurrWAVMValCnt := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstPropCurrWAVMValCnt);
			SELF.PL_AstPropCurrAVMValList := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, RIGHT.PL_AstPropCurrAVMValList);
			SELF.PL_AstPropCurrAVMValTot := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstPropCurrAVMValTot);
			SELF.PL_AstPropCurrAVMValAvg := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, RIGHT.PL_AstPropCurrAVMValAvg);
			SELF.PL_VerSSNLookupFlag := IF(LexIDNotOnFile, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, (STRING)RIGHT.PL_VerSSNLookupFlag);

			SELF := LEFT;
			self := [];
		),LEFT OUTER, KEEP(1)); 

	
	PersonAttributesWithoutLexID := PROJECT(RecordsWithoutLexID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutPerson,
			SELF.P_LexIDSeenFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;	
			SELF.P_LexIDCategory := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
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
			SELF.PL_VerNameLastSrcCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;				
			SELF.PL_VerNameLastSrcListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;				
			SELF.PL_VerNameLastSrcEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;				
			SELF.PL_VerNameLastSrcLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
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
			SELF.PL_VerSSNLookupFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;

			SELF := LEFT,
			SElf := [])); 	
	
	PersonAttributes := SORT( PersonAttributesWithLexID + PersonAttributesWithoutLexID, G_ProcUID ); 


	RETURN PersonAttributes;
END;
