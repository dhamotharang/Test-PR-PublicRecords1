IMPORT PublicRecords_KEL,BRM_Marketing_attributes;
IMPORT KEL11 AS KEL;

Export Fn_GetBRM_SeleIDAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION
			
	RecordsWithSeleID := InputData((INTEGER7)B_LexIDLegal > 0);
	RecordsWithoutSeleID := InputData((INTEGER7)B_LexIDLegal <= 0);
		
	BusinessSeleIDAttributesRaw := KEL.Clean(BRM_Marketing_Attributes.BusinessSeleAttributes_Function(RecordsWithSeleID, RepInput, FDCDataset, Options), TRUE, TRUE, TRUE);
	
//to turn on any unsued attributes again just un comment them in graph and below.
	
	BusinessAttributesWithSeleID := JOIN(RecordsWithSeleID, BusinessSeleIDAttributesRaw, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID, 
		TRANSFORM(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.LayoutBusinessSeleID,
			ResultsFound := (INTEGER7)RIGHT.B_LexIDLegal > 0 AND RIGHT.B_LexIDLegalSeenFlag = '1';
			//Sos		
			SELF.BE_SOSOldMsncEv := IF(ResultsFound, (STRING8)RIGHT.BE_SOSOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_SOSStateCntEv := IF(ResultsFound, (STRING8)RIGHT.BE_SOSStateCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_SOSDomStatusIndxEv := IF(ResultsFound, (STRING16)RIGHT.BE_SOSDomStatusIndxEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			//UCC Attributes
			SELF.BE_UCCCntEv := IF(ResultsFound, (STRING8)RIGHT.BE_UCCCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_UCCDebtorCntEv := IF(ResultsFound, (STRING8)RIGHT.BE_UCCDebtorCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_UCCDebtorOldMsncEv := IF(ResultsFound, (STRING8)RIGHT.BE_UCCDebtorOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_UCCDebtorNewMsncEv := IF(ResultsFound, (STRING8)RIGHT.BE_UCCDebtorNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_UCCActvCnt := IF(ResultsFound, (STRING8)RIGHT.BE_UCCActvCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_UCCDebtorTermCntEv := IF(ResultsFound, (STRING8)RIGHT.BE_UCCDebtorTermCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_UCCDebtorOtherCntEv := IF(ResultsFound, (STRING8)RIGHT.BE_UCCDebtorOtherCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_UCCDebtorTermNewMsncEv := IF(ResultsFound, (STRING8)RIGHT.BE_UCCDebtorTermNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_UCCCreditorCntEv := IF(ResultsFound, (STRING8)RIGHT.BE_UCCCreditorCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			//Asset
			SELF.BE_AstVehAirCntEv := IF(ResultsFound, (STRING8)RIGHT.BE_AstVehAirCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_AstVehWtrCntEv := IF(ResultsFound, (STRING8)RIGHT.BE_AstVehWtrCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			// SELF.BE_AstVehAutoCnt2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AstVehAutoCnt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			// SELF.BE_AstVehAutoPersCnt2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AstVehAutoPersCnt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			// SELF.BE_AstVehAutoCommCnt2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AstVehAutoCommCnt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			// SELF.BE_AstVehAutoOtherCnt2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AstVehAutoOtherCnt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			// SELF.BE_AstVehAutoEmrgNewMsncEv := IF(ResultsFound, (STRING8)RIGHT.BE_AstVehAutoEmrgNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			//property
			SELF.BE_AstPropCntEv := IF(ResultsFound, (STRING8)RIGHT.BE_AstPropCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_AstPropCurrCnt := IF(ResultsFound, (STRING8)RIGHT.BE_AstPropCurrCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_AstPropOldMsncEv := IF(ResultsFound, (STRING8)RIGHT.BE_AstPropOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_AstPropNewMsncEv := IF(ResultsFound, (STRING8)RIGHT.BE_AstPropNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_AstPropCurrValTot := IF(ResultsFound, (STRING11)RIGHT.BE_AstPropCurrValTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_AstPropCurrLotSizeTot := IF(ResultsFound, (STRING11)RIGHT.BE_AstPropCurrLotSizeTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_AstPropCurrBldgSizeTot := IF(ResultsFound, (STRING11)RIGHT.BE_AstPropCurrBldgSizeTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);					
			//best bii sele
			SELF.BE_BestName := IF(ResultsFound, (STRING120)RIGHT.BE_BestName, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrSt := IF(ResultsFound, (STRING120)RIGHT.BE_BestAddrSt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrCity := IF(ResultsFound, (STRING50)RIGHT.BE_BestAddrCity, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrState := IF(ResultsFound, (STRING25)RIGHT.BE_BestAddrState, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrZip := IF(ResultsFound, (STRING10)RIGHT.BE_BestAddrZip, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestTIN := IF(ResultsFound, (STRING10)RIGHT.BE_BestTIN, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestPhone := IF(ResultsFound, (STRING16)RIGHT.BE_BestPhone, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_URLFlag := IF(ResultsFound, (STRING6)RIGHT.BE_URLFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_AssocExecEmailFlag2Y := IF(ResultsFound, (STRING6)RIGHT.BE_AssocExecEmailFlag2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			
			SELF.BE_BestAddrSrcOldMsncEv := IF(ResultsFound, (STRING8)RIGHT.BE_BestAddrSrcOldMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 
			SELF.BE_BestAddrBldgType := IF(ResultsFound, (STRING6)RIGHT.BE_BestAddrBldgType,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrIsOwnedFlag := IF(ResultsFound, (STRING6)RIGHT.BE_BestAddrIsOwnedFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrNewTaxValEv := IF(ResultsFound, (STRING20)RIGHT.BE_BestAddrNewTaxValEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 
			SELF.BE_BestAddrLotSize := IF(ResultsFound, (STRING20)RIGHT.BE_BestAddrLotSize,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrBldgSize := IF(ResultsFound, (STRING20)RIGHT.BE_BestAddrBldgSize,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			//Derogs
			SELF.BE_DrgGovDebarredFlagEv := IF(ResultsFound, (STRING6)RIGHT.BE_DrgGovDebarredFlagEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgFlag7Y := IF(ResultsFound, (STRING6)RIGHT.BE_DrgFlag7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgBkCnt10Y := IF(ResultsFound, (STRING8)RIGHT.BE_DrgBkCnt10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgBkNewMsnc10Y := IF(ResultsFound, (STRING8)RIGHT.BE_DrgBkNewMsnc10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgBkNewChType10Y := IF(ResultsFound, (STRING6)RIGHT.BE_DrgBkNewChType10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienCnt7Y := IF(ResultsFound, (STRING8)RIGHT.BE_DrgLienCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienNewMsnc7Y := IF(ResultsFound, (STRING8)RIGHT.BE_DrgLienNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgJudgCnt7Y := IF(ResultsFound, (STRING8)RIGHT.BE_DrgJudgCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgJudgNewMsnc7Y := IF(ResultsFound, (STRING8)RIGHT.BE_DrgJudgNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLTDCnt7Y := IF(ResultsFound, (STRING8)RIGHT.BE_DrgLTDCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
    	SELF.BE_DrgLTDNewMsnc7Y := IF(ResultsFound, (STRING8)RIGHT.BE_DrgLTDNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
		 //B2B
			SELF.BE_B2BActvCnt := IF(ResultsFound, (STRING8)RIGHT.BE_B2BActvCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvCarrCnt := IF(ResultsFound, (STRING8)RIGHT.BE_B2BActvCarrCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvFltCnt := IF(ResultsFound, (STRING8)RIGHT.BE_B2BActvFltCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvMatCnt := IF(ResultsFound, (STRING8)RIGHT.BE_B2BActvMatCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvOpsCnt := IF(ResultsFound, (STRING8)RIGHT.BE_B2BActvOpsCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvOthCnt := IF(ResultsFound, (STRING8)RIGHT.BE_B2BActvOthCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_B2BActvBalTot := IF(ResultsFound, (STRING11)RIGHT.BE_B2BActvBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_B2BActvCarrBalTot := IF(ResultsFound, (STRING11)RIGHT.BE_B2BActvCarrBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvFltBalTot := IF(ResultsFound, (STRING11)RIGHT.BE_B2BActvFltBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvMatBalTot := IF(ResultsFound, (STRING11)RIGHT.BE_B2BActvMatBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvOpsBalTot := IF(ResultsFound, (STRING11)RIGHT.BE_B2BActvOpsBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvOthBalTot := IF(ResultsFound, (STRING11)RIGHT.BE_B2BActvOthBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvBalTotRnge := IF(ResultsFound, (STRING6)RIGHT.BE_B2BActvBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvCarrBalTotRnge := IF(ResultsFound, (STRING6)RIGHT.BE_B2BActvCarrBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvFltBalTotRnge := IF(ResultsFound, (STRING6)RIGHT.BE_B2BActvFltBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvMatBalTotRnge := IF(ResultsFound, (STRING6)RIGHT.BE_B2BActvMatBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvOpsBalTotRnge := IF(ResultsFound, (STRING6)RIGHT.BE_B2BActvOpsBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvOthBalTotRnge := IF(ResultsFound, (STRING6)RIGHT.BE_B2BActvOthBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvWorstPerfIndx := IF(ResultsFound, (STRING)RIGHT.BE_B2BActvWorstPerfIndx,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BWorstPerfIndx2Y := IF(ResultsFound, (STRING)RIGHT.BE_B2BWorstPerfIndx2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			//assoc
			SELF.BE_AssocCntEv := IF(ResultsFound, (STRING8)RIGHT.BE_AssocCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			// SELF.BE_AssocCnt2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_AssocExecCntEv := IF(ResultsFound, (STRING8)RIGHT.BE_AssocExecCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			// SELF.BE_AssocExecCnt2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocExecCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_AssocNexecCntEv := IF(ResultsFound, (STRING8)RIGHT.BE_AssocNexecCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			// SELF.BE_AssocNexecCnt2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocNexecCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			// SELF.BE_AssocAgeAvg2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocAgeAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_AssocExecAgeAvg2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocExecAgeAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_AssocNexecAgeAvg2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocNexecAgeAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_AssocWEduCollCnt2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocWEduCollCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_AssocExecWEduCollCnt2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocExecWEduCollCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_AssocNexecWEduCollCnt2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocNexecWEduCollCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_AssocEmrgMsncAvg2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocEmrgMsncAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_AssocExecEmrgMsncAvg2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocExecEmrgMsncAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_AssocNexecEmrgMsncAvg2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocNexecEmrgMsncAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_AssocWDrgCnt2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocWDrgCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_AssocExecWDrgCnt2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocExecWDrgCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_AssocNexecWDrgCnt2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocNexecWDrgCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_AssocBusCntAvg2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocBusCntAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_AssocExecBusCntAvg2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocExecBusCntAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_AssocNexecBusCntAvg2Y := IF(ResultsFound, (STRING8)RIGHT.BE_AssocNexecBusCntAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			//Firmographics	
			SELF.BE_BusSICCode1 := IF(ResultsFound, (STRING6)RIGHT.BE_BusSICCode1,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 
			SELF.BE_BusSICCode1Desc := IF(ResultsFound, (STRING150)RIGHT.BE_BusSICCode1Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode2 := IF(ResultsFound, (STRING6)RIGHT.BE_BusSICCode2,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode2Desc := IF(ResultsFound, (STRING150)RIGHT.BE_BusSICCode2Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode3 := IF(ResultsFound, (STRING6)RIGHT.BE_BusSICCode3,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode3Desc := IF(ResultsFound, (STRING150)RIGHT.BE_BusSICCode3Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode4 := IF(ResultsFound, (STRING6)RIGHT.BE_BusSICCode4,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode4Desc := IF(ResultsFound, (STRING150)RIGHT.BE_BusSICCode4Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusNAICSCode1 := IF(ResultsFound, (STRING6)RIGHT.BE_BusNAICSCode1,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusNAICSCode1Desc := IF(ResultsFound, (STRING150)RIGHT.BE_BusNAICSCode1Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusNAICSCode2 := IF(ResultsFound, (STRING6)RIGHT.BE_BusNAICSCode2,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusNAICSCode2Desc := IF(ResultsFound, (STRING150)RIGHT.BE_BusNAICSCode2Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusNAICSCode3 := IF(ResultsFound, (STRING6)RIGHT.BE_BusNAICSCode3,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusNAICSCode3Desc := IF(ResultsFound, (STRING150)RIGHT.BE_BusNAICSCode3Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 
			SELF.BE_BusNAICSCode4 := IF(ResultsFound, (STRING6)RIGHT.BE_BusNAICSCode4,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 
			SELF.BE_BusNAICSCode4Desc := IF(ResultsFound, (STRING150)RIGHT.BE_BusNAICSCode4Desc,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 
			SELF.BE_BusEmplCountCurr := IF(ResultsFound, (STRING8)RIGHT.BE_BusEmplCountCurr,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);    		
			SELF.BE_BusAnnualSalesCurr := IF(ResultsFound, (STRING16)RIGHT.BE_BusAnnualSalesCurr,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);    		
			//Flag Attributes		
			SELF.BE_BusIsNonProfitFlag := IF(ResultsFound, (STRING6)RIGHT.BE_BusIsNonProfitFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 		
			SELF.BE_BusIsFranchiseFlag := IF(ResultsFound, (STRING6)RIGHT.BE_BusIsFranchiseFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 		
			SELF.BE_BusOffers401kFlag := IF(ResultsFound, (STRING6)RIGHT.BE_BusOffers401kFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 		
			SELF.BE_BusHasNewLocationFlag1Y := IF(ResultsFound, (STRING6)RIGHT.BE_BusHasNewLocationFlag1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 		
			SELF.BE_BusLocActvCnt := IF(ResultsFound, (STRING8)RIGHT.BE_BusLocActvCnt,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 		
			//Ownership Attributes		
			SELF.BE_BusInferFemaleOwnedFlag := IF(ResultsFound, (STRING6)RIGHT.BE_BusInferFemaleOwnedFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			// SELF.BE_BusInferFamilyOwnedFlag := IF(ResultsFound, (STRING6)RIGHT.BE_BusInferFamilyOwnedFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_BusIsFemaleOwnedFlag := IF(ResultsFound, (STRING6)RIGHT.BE_BusIsFemaleOwnedFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_BusIsMinorityOwnedFlag := IF(ResultsFound, (STRING6)RIGHT.BE_BusIsMinorityOwnedFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);						
			// SELF.BE_BusIsResidentialFlag := IF(ResultsFound, (STRING6)RIGHT.BE_BusIsResidentialFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_DBANameCnt2Y := IF(ResultsFound, (STRING8)RIGHT.BE_DBANameCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			//verification
			SELF.BE_VerSrcCntEv := IF(ResultsFound, (STRING20)RIGHT.BE_VerSrcCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcOldMsncEv :=  IF(ResultsFound, (STRING20)RIGHT.BE_VerSrcOldMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcNewMsncEv :=  IF(ResultsFound, (STRING20)RIGHT.BE_VerSrcNewMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcRptNewBusFlag :=  IF(ResultsFound, (STRING6)RIGHT.BE_VerSrcRptNewBusFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcCredCntEv := IF(ResultsFound, (STRING20)RIGHT.BE_VerSrcCredCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcBureauFlag := IF(ResultsFound, (STRING6)RIGHT.BE_VerSrcBureauFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcBureauOldMsncEv := IF(ResultsFound, (STRING20)RIGHT.BE_VerSrcBureauOldMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_AddrPOBoxFlag := IF(ResultsFound, (STRING6)RIGHT.BE_AddrPOBoxFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerNameFlag := IF(ResultsFound, (STRING6)RIGHT.BE_VerNameFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerAddrFlag := IF(ResultsFound, (STRING6)RIGHT.BE_VerAddrFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerAddrSrcOldMsncEv := IF(ResultsFound, (STRING20)RIGHT.BE_VerAddrSrcOldMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerTINFlag := IF(ResultsFound, (STRING6)RIGHT.BE_VerTINFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerTINSrcOldMsncEv := IF(ResultsFound, (STRING20)RIGHT.BE_VerTINSrcOldMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerPhoneFlag := IF(ResultsFound, (STRING6)RIGHT.BE_VerPhoneFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerPhoneSrcOldMsncEv := IF(ResultsFound, (STRING20)RIGHT.BE_VerPhoneSrcOldMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF := LEFT;
			SELF := [];
		),LEFT OUTER, KEEP(1));
		
			// Assign special values to records with no SeleID
	BusinessAttributesWithoutSeleID := PROJECT(RecordsWithoutSeleID,
		TRANSFORM(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.LayoutBusinessSeleID,
			//Tradeline Attributes
			SELF.BE_B2BActvCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvCarrCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvFltCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvMatCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvOpsCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvOthCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvCarrBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvFltBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvMatBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvOpsBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvOthBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvCarrBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvFltBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvMatBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvOpsBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvOthBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvWorstPerfIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BWorstPerfIndx2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			//Assets
			SELF.BE_AstVehAirCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_AstVehWtrCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			// SELF.BE_AstVehAutoCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			// SELF.BE_AstVehAutoPersCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			// SELF.BE_AstVehAutoCommCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			// SELF.BE_AstVehAutoOtherCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			// SELF.BE_AstVehAutoEmrgNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;	
			//Property
			SELF.BE_AstPropCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_AstPropCurrCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_AstPropOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_AstPropNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_AstPropCurrValTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_AstPropCurrLotSizeTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_AstPropCurrBldgSizeTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;					
			//SOS 		
			SELF.BE_SOSOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_SOSStateCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_SOSDomStatusIndxEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			//best bii sele
			SELF.BE_BestName := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrSt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrCity := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrState := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrZip := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestTIN := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestPhone := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_URLFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;			
			SELF.BE_AssocExecEmailFlag2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrSrcOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BestAddrBldgType := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrIsOwnedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrNewTaxValEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BestAddrLotSize := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrBldgSize := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;					
			//Derogs			
			SELF.BE_DrgGovDebarredFlagEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLTDCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLTDNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgBkCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgBkNewMsnc10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgBkNewChType10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgFlag7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;			
			SELF.BE_DrgLienNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_DrgJudgCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgJudgNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			//UCC Attributes	
			SELF.BE_UCCCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_UCCDebtorCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_UCCDebtorOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_UCCDebtorNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_UCCActvCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_UCCDebtorTermCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_UCCDebtorOtherCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_UCCDebtorTermNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_UCCCreditorCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;	
			//assoc
			SELF.BE_AssocCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			// SELF.BE_AssocCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_AssocExecCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			// SELF.BE_AssocExecCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_AssocNexecCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			// SELF.BE_AssocNexecCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			// SELF.BE_AssocAgeAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_AssocExecAgeAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_AssocNexecAgeAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_AssocWEduCollCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_AssocExecWEduCollCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_AssocNexecWEduCollCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_AssocEmrgMsncAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_AssocExecEmrgMsncAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_AssocNexecEmrgMsncAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_AssocWDrgCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_AssocExecWDrgCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_AssocNexecWDrgCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_AssocBusCntAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_AssocExecBusCntAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_AssocNexecBusCntAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;			
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
			SELF.BE_BusEmplCountCurr := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;    		
			SELF.BE_BusAnnualSalesCurr := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;    		
			//Flag Attributes		
			SELF.BE_BusIsNonProfitFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			SELF.BE_BusIsFranchiseFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			SELF.BE_BusOffers401kFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			SELF.BE_BusHasNewLocationFlag1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			SELF.BE_BusLocActvCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			//Ownership Attributes		
			SELF.BE_BusInferFemaleOwnedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_BusInferFamilyOwnedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_BusIsFemaleOwnedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_BusIsMinorityOwnedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			// SELF.BE_BusIsResidentialFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DBANameCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;			
			//verification
			SELF.BE_VerSrcCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcOldMsncEv :=  PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcNewMsncEv :=  PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcRptNewBusFlag :=  PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcCredCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcBureauFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcBureauOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_AddrPOBoxFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerNameFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerAddrFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerAddrSrcOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerTINFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerTINSrcOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerPhoneFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerPhoneSrcOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;				
			SELF := LEFT;
			SELF := [];
			));

	BusinessSeleIDAttributes := SORT(BusinessAttributesWithSeleID + BusinessAttributesWithoutSeleID, G_ProcBusUID);
	RETURN BusinessSeleIDAttributes;
END;	

