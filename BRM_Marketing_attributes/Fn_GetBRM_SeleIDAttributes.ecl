IMPORT PublicRecords_KEL,BRM_Marketing_attributes;
IMPORT KEL11 AS KEL;

Export Fn_GetBRM_SeleIDAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION
			
	RecordsWithSeleID := InputData(B_LexIDLegal > 0);
	RecordsWithoutSeleID := InputData(B_LexIDLegal <= 0);
		
BusinessSeleIDAttributesRaw := KEL.Clean(BRM_Marketing_Attributes.BusinessSeleAttributes_Function(RecordsWithSeleID, RepInput, FDCDataset, Options), TRUE, TRUE, TRUE);
	
	BusinessAttributesWithSeleID := JOIN(RecordsWithSeleID, BusinessSeleIDAttributesRaw, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID, 
		TRANSFORM(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.LayoutBusinessSeleID,
			ResultsFound := RIGHT.B_LexIDLegal > 0 AND RIGHT.B_LexIDLegalSeenFlag = '1';
			//Sos		
			SELF.BE_SOSOldMsncEv := IF(ResultsFound, RIGHT.BE_SOSOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_SOSStateCntEv := IF(ResultsFound, RIGHT.BE_SOSStateCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_SOSDomStatusIndxEv := IF(ResultsFound, RIGHT.BE_SOSDomStatusIndxEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
					//UCC Attributes
			SELF.BE_UCCCntEv := IF(ResultsFound, RIGHT.BE_UCCCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorCntEv := IF(ResultsFound, RIGHT.BE_UCCDebtorCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorOldMsncEv := IF(ResultsFound, RIGHT.BE_UCCDebtorOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorNewMsncEv := IF(ResultsFound, RIGHT.BE_UCCDebtorNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCActvCnt := IF(ResultsFound, RIGHT.BE_UCCActvCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorTermCntEv := IF(ResultsFound, RIGHT.BE_UCCDebtorTermCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorOtherCntEv := IF(ResultsFound, RIGHT.BE_UCCDebtorOtherCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorTermNewMsncEv := IF(ResultsFound, RIGHT.BE_UCCDebtorTermNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCCreditorCntEv := IF(ResultsFound, RIGHT.BE_UCCCreditorCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			//Asset
			SELF.BE_AstVehAirCntEv := IF(ResultsFound, RIGHT.BE_AstVehAirCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehWtrCntEv := IF(ResultsFound, RIGHT.BE_AstVehWtrCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehAutoCnt2Y := IF(ResultsFound, RIGHT.BE_AstVehAutoCnt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehAutoPersCnt2Y := IF(ResultsFound, RIGHT.BE_AstVehAutoPersCnt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehAutoCommCnt2Y := IF(ResultsFound, RIGHT.BE_AstVehAutoCommCnt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehAutoOtherCnt2Y := IF(ResultsFound, RIGHT.BE_AstVehAutoOtherCnt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehAutoEmrgNewMsncEv := IF(ResultsFound, RIGHT.BE_AstVehAutoEmrgNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			//property
			SELF.BE_AstPropCntEv := IF(ResultsFound, RIGHT.BE_AstPropCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropCurrCnt := IF(ResultsFound, RIGHT.BE_AstPropCurrCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropOldMsncEv := IF(ResultsFound, RIGHT.BE_AstPropOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropNewMsncEv := IF(ResultsFound, RIGHT.BE_AstPropNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropCurrValTot := IF(ResultsFound, RIGHT.BE_AstPropCurrValTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropCurrLotSizeTot := IF(ResultsFound, RIGHT.BE_AstPropCurrLotSizeTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropCurrBldgSizeTot := IF(ResultsFound, RIGHT.BE_AstPropCurrBldgSizeTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);					
			//best bii sele
			SELF.BE_BestName := IF(ResultsFound, RIGHT.BE_BestName, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrSt := IF(ResultsFound, RIGHT.BE_BestAddrSt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrCity := IF(ResultsFound, RIGHT.BE_BestAddrCity, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrState := IF(ResultsFound, RIGHT.BE_BestAddrState, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrZip := IF(ResultsFound, RIGHT.BE_BestAddrZip, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestTIN := IF(ResultsFound, RIGHT.BE_BestTIN, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestPhone := IF(ResultsFound, RIGHT.BE_BestPhone, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_URLFlag := IF(ResultsFound, (STRING)RIGHT.BE_URLFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_AssocExecEmailFlag2Y := IF(ResultsFound, RIGHT.BE_AssocExecEmailFlag2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			
			SELF.BE_BestAddrSrcOldMsncEv := IF(ResultsFound, (INTEGER)RIGHT.BE_BestAddrSrcOldMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT); 
			SELF.BE_BestAddrBldgType := IF(ResultsFound, (STRING)RIGHT.BE_BestAddrBldgType,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			// SELF.BE_BestAddrIsOwnedFlag := IF(ResultsFound, (STRING)RIGHT.BE_BestAddrIsOwnedFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			// SELF.BE_BestAddrNewTaxValEv := IF(ResultsFound, RIGHT.BE_BestAddrNewTaxValEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT); 
			// SELF.BE_BestAddrLotSize := IF(ResultsFound, RIGHT.BE_BestAddrLotSize,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			// SELF.BE_BestAddrBldgSize := IF(ResultsFound, RIGHT.BE_BestAddrBldgSize,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			//Derogs
			SELF.BE_DrgGovDebarredFlagEv := IF(ResultsFound, RIGHT.BE_DrgGovDebarredFlagEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgFlag7Y := IF(ResultsFound, RIGHT.BE_DrgFlag7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgBkCnt10Y := IF(ResultsFound, RIGHT.BE_DrgBkCnt10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgBkNewMsnc10Y := IF(ResultsFound, RIGHT.BE_DrgBkNewMsnc10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgBkNewChType10Y := IF(ResultsFound, RIGHT.BE_DrgBkNewChType10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienCnt7Y := IF(ResultsFound, RIGHT.BE_DrgLienCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLienNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgCnt7Y := IF(ResultsFound, RIGHT.BE_DrgJudgCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgJudgNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLTDCnt7Y := IF(ResultsFound, RIGHT.BE_DrgLTDCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
    	SELF.BE_DrgLTDNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLTDNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
		//B2B
			SELF.BE_B2BActvCnt := IF(ResultsFound, RIGHT.BE_B2BActvCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvCarrCnt := IF(ResultsFound, RIGHT.BE_B2BActvCarrCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvFltCnt := IF(ResultsFound, RIGHT.BE_B2BActvFltCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvMatCnt := IF(ResultsFound, RIGHT.BE_B2BActvMatCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOpsCnt := IF(ResultsFound, RIGHT.BE_B2BActvOpsCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOthCnt := IF(ResultsFound, RIGHT.BE_B2BActvOthCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_B2BActvBalTot := IF(ResultsFound,RIGHT.BE_B2BActvBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);			
			SELF.BE_B2BActvCarrBalTot := IF(ResultsFound,RIGHT.BE_B2BActvCarrBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvFltBalTot := IF(ResultsFound,RIGHT.BE_B2BActvFltBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvMatBalTot := IF(ResultsFound,RIGHT.BE_B2BActvMatBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOpsBalTot := IF(ResultsFound,RIGHT.BE_B2BActvOpsBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOthBalTot := IF(ResultsFound,RIGHT.BE_B2BActvOthBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvCarrBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvCarrBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvFltBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvFltBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvMatBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvMatBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvOpsBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvOpsBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvOthBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvOthBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvWorstPerfIndx := IF(ResultsFound,(STRING)RIGHT.BE_B2BActvWorstPerfIndx,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BWorstPerfIndx2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BWorstPerfIndx2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			//assoc
			SELF.BE_AssocCntEv := IF(ResultsFound,RIGHT.BE_AssocCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocCnt2Y := IF(ResultsFound,RIGHT.BE_AssocCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocExecCntEv := IF(ResultsFound,RIGHT.BE_AssocExecCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocExecCnt2Y := IF(ResultsFound,RIGHT.BE_AssocExecCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocNexecCntEv := IF(ResultsFound,RIGHT.BE_AssocNexecCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocNexecCnt2Y := IF(ResultsFound,RIGHT.BE_AssocNexecCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocAgeAvg2Y := IF(ResultsFound,RIGHT.BE_AssocAgeAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecAgeAvg2Y := IF(ResultsFound,RIGHT.BE_AssocExecAgeAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecAgeAvg2Y := IF(ResultsFound,RIGHT.BE_AssocNexecAgeAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocWEduCollCnt2Y := IF(ResultsFound,RIGHT.BE_AssocWEduCollCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecWEduCollCnt2Y := IF(ResultsFound,RIGHT.BE_AssocExecWEduCollCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecWEduCollCnt2Y := IF(ResultsFound,RIGHT.BE_AssocNexecWEduCollCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocEmrgMsncAvg2Y := IF(ResultsFound,RIGHT.BE_AssocEmrgMsncAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecEmrgMsncAvg2Y := IF(ResultsFound,RIGHT.BE_AssocExecEmrgMsncAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecEmrgMsncAvg2Y := IF(ResultsFound,RIGHT.BE_AssocNexecEmrgMsncAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocWDrgCnt2Y := IF(ResultsFound,RIGHT.BE_AssocWDrgCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecWDrgCnt2Y := IF(ResultsFound,RIGHT.BE_AssocExecWDrgCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecWDrgCnt2Y := IF(ResultsFound,RIGHT.BE_AssocNexecWDrgCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocBusCntAvg2Y := IF(ResultsFound,RIGHT.BE_AssocBusCntAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecBusCntAvg2Y := IF(ResultsFound,RIGHT.BE_AssocExecBusCntAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecBusCntAvg2Y := IF(ResultsFound,RIGHT.BE_AssocNexecBusCntAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);			
			//Firmographics	
			SELF.BE_BusSICCode1 := IF(ResultsFound,RIGHT.BE_BusSICCode1,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 
			SELF.BE_BusSICCode1Desc := IF(ResultsFound,RIGHT.BE_BusSICCode1Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode2 := IF(ResultsFound,RIGHT.BE_BusSICCode2,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode2Desc := IF(ResultsFound,RIGHT.BE_BusSICCode2Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode3 := IF(ResultsFound,RIGHT.BE_BusSICCode3,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode3Desc := IF(ResultsFound,RIGHT.BE_BusSICCode3Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode4 := IF(ResultsFound,RIGHT.BE_BusSICCode4,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode4Desc := IF(ResultsFound,RIGHT.BE_BusSICCode4Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusNAICSCode1 := IF(ResultsFound,RIGHT.BE_BusNAICSCode1,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusNAICSCode1Desc := IF(ResultsFound,RIGHT.BE_BusNAICSCode1Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusNAICSCode2 := IF(ResultsFound,RIGHT.BE_BusNAICSCode2,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusNAICSCode2Desc := IF(ResultsFound,RIGHT.BE_BusNAICSCode2Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusNAICSCode3 := IF(ResultsFound,RIGHT.BE_BusNAICSCode3,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusNAICSCode3Desc := IF(ResultsFound,RIGHT.BE_BusNAICSCode3Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 
			SELF.BE_BusNAICSCode4 := IF(ResultsFound,RIGHT.BE_BusNAICSCode4,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 
			SELF.BE_BusNAICSCode4Desc := IF(ResultsFound,RIGHT.BE_BusNAICSCode4Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 
			SELF.BE_BusEmplCountCurr := IF(ResultsFound,RIGHT.BE_BusEmplCountCurr,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);    		
			SELF.BE_BusAnnualSalesCurr := IF(ResultsFound,RIGHT.BE_BusAnnualSalesCurr,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);    		
			//Flag Attributes		
			SELF.BE_BusIsNonProfitFlag := IF(ResultsFound,RIGHT.BE_BusIsNonProfitFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 		
			SELF.BE_BusIsFranchiseFlag := IF(ResultsFound,RIGHT.BE_BusIsFranchiseFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 		
			SELF.BE_BusOffers401kFlag := IF(ResultsFound,RIGHT.BE_BusOffers401kFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 		
			SELF.BE_BusHasNewLocationFlag1Y := IF(ResultsFound,RIGHT.BE_BusHasNewLocationFlag1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 		
			SELF.BE_BusLocActvCnt := IF(ResultsFound,RIGHT.BE_BusLocActvCnt,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT); 		
			//Ownership Attributes		
			SELF.BE_BusInferFemaleOwnedFlag := IF(ResultsFound,RIGHT.BE_BusInferFemaleOwnedFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_BusInferFamilyOwnedFlag := IF(ResultsFound,RIGHT.BE_BusInferFamilyOwnedFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_BusIsFemaleOwnedFlag := IF(ResultsFound,RIGHT.BE_BusIsFemaleOwnedFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_BusIsMinorityOwnedFlag := IF(ResultsFound,RIGHT.BE_BusIsMinorityOwnedFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);						
			SELF.BE_BusIsResidentialFlag := IF(ResultsFound, (STRING)RIGHT.BE_BusIsResidentialFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_DBANameCnt2Y := IF(ResultsFound, RIGHT.BE_DBANameCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);			
			//verification
			SELF.BE_VerSrcCntEv := IF(ResultsFound,RIGHT.BE_VerSrcCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerSrcOldMsncEv :=  IF(ResultsFound,RIGHT.BE_VerSrcOldMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerSrcNewMsncEv :=  IF(ResultsFound,RIGHT.BE_VerSrcNewMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerSrcRptNewBusFlag :=  IF(ResultsFound,RIGHT.BE_VerSrcRptNewBusFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcCredCntEv := IF(ResultsFound,RIGHT.BE_VerSrcCredCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerSrcBureauFlag := IF(ResultsFound,RIGHT.BE_VerSrcBureauFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcBureauOldMsncEv := IF(ResultsFound,RIGHT.BE_VerSrcBureauOldMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AddrPOBoxFlag := IF(ResultsFound,(STRING)RIGHT.BE_AddrPOBoxFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerNameFlag := IF(ResultsFound,(STRING)RIGHT.BE_VerNameFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerAddrFlag := IF(ResultsFound,(STRING)RIGHT.BE_VerAddrFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerAddrSrcOldMsncEv := IF(ResultsFound,RIGHT.BE_VerAddrSrcOldMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerTINFlag := IF(ResultsFound,(STRING)RIGHT.BE_VerTINFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerTINSrcOldMsncEv := IF(ResultsFound,RIGHT.BE_VerTINSrcOldMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerPhoneFlag := IF(ResultsFound,(STRING)RIGHT.BE_VerPhoneFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerPhoneSrcOldMsncEv := IF(ResultsFound,RIGHT.BE_VerPhoneSrcOldMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF :=LEFT;
			SELF := [];
		),LEFT OUTER, KEEP(1));
		
			// Assign special values to records with no SeleID
	BusinessAttributesWithoutSeleID := PROJECT(RecordsWithoutSeleID,
		TRANSFORM(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.LayoutBusinessSeleID,
			// Attributes from NonFCRABusinessSeleIDAttributesV1 KEL query
			//Tradeline Attributes
			SELF.BE_B2BActvCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvCarrCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvFltCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvMatCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOpsCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOthCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvCarrBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvFltBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvMatBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOpsBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOthBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvCarrBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvFltBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvMatBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvOpsBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvOthBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvWorstPerfIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BWorstPerfIndx2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			//Assets
			SELF.BE_AstVehAirCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehWtrCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehAutoCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehAutoPersCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehAutoCommCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehAutoOtherCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehAutoEmrgNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;	
			//Property
			SELF.BE_AstPropCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropCurrCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropCurrValTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropCurrLotSizeTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropCurrBldgSizeTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;					
			//SOS Build Date//			
			SELF.BE_SOSOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_SOSStateCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_SOSDomStatusIndxEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			//best bii sele
			SELF.BE_BestName := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrSt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrCity := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrState := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrZip := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestTIN := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestPhone := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_URLFlag := (STRING)PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;			
			SELF.BE_AssocExecEmailFlag2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrSrcOldMsncEv := (INTEGER)PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT; 
			SELF.BE_BestAddrBldgType := (STRING)PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrIsOwnedFlag :='0';
			SELF.BE_BestAddrNewTaxValEv :=0; 
			SELF.BE_BestAddrLotSize :=0;
			SELF.BE_BestAddrBldgSize :=0;					
			//Derogs			
			SELF.BE_DrgGovDebarredFlagEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLTDCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLTDNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkNewMsnc10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkNewChType10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgFlag7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;			
			SELF.BE_DrgLienNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_DrgJudgCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			//UCC Attributes	
			SELF.BE_UCCCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCActvCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorTermCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorOtherCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorTermNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCCreditorCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;	
			//assoc
			SELF.BE_AssocCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocExecCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocExecCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocNexecCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocNexecCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocAgeAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecAgeAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecAgeAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocWEduCollCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecWEduCollCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecWEduCollCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocEmrgMsncAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecEmrgMsncAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecEmrgMsncAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocWDrgCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecWDrgCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecWDrgCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocBusCntAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecBusCntAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecBusCntAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;			
			//Firmographics	
			SELF.BE_BusSICCode1 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BusSICCode1Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode2 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode2Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode3 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode3Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode4 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode4Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusNAICSCode1 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusNAICSCode1Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusNAICSCode2 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusNAICSCode2Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusNAICSCode3 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusNAICSCode3Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BusNAICSCode4 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BusNAICSCode4Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BusEmplCountCurr := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;    		
			SELF.BE_BusAnnualSalesCurr := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;    		
			//Flag Attributes		
			SELF.BE_BusIsNonProfitFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			SELF.BE_BusIsFranchiseFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			SELF.BE_BusOffers401kFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			SELF.BE_BusHasNewLocationFlag1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			SELF.BE_BusLocActvCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT; 		
			//Ownership Attributes		
			SELF.BE_BusInferFemaleOwnedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_BusInferFamilyOwnedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_BusIsFemaleOwnedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_BusIsMinorityOwnedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_BusIsResidentialFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DBANameCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;			
			//verification
			SELF.BE_VerSrcCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerSrcOldMsncEv :=  PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerSrcNewMsncEv :=  PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerSrcRptNewBusFlag :=  PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcCredCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerSrcBureauFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcBureauOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AddrPOBoxFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerNameFlag := (STRING)PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerAddrFlag := (STRING)PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerAddrSrcOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerTINFlag := (STRING)PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerTINSrcOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerPhoneFlag := (STRING)PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerPhoneSrcOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;				
			SELF := LEFT;
			SELF := [];
			));

	BusinessSeleIDAttributes := SORT(BusinessAttributesWithSeleID + BusinessAttributesWithoutSeleID, G_ProcBusUID);
	RETURN BusinessSeleIDAttributes;
END;	

