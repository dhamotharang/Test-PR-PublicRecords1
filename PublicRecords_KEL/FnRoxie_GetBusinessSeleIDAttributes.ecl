﻿// IMPORT $.^.Risk_Indicators, $.^.PublicRecords_KEL;
IMPORT Risk_Indicators, PublicRecords_KEL, STD;
IMPORT KEL13 AS KEL;

EXPORT FnRoxie_GetBusinessSeleIDAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

	Common_Functions := PublicRecords_KEL.ECL_Functions.Common_Functions;

	RecordsWithSeleID := InputData(B_LexIDLegal > 0);
	RecordsWithoutSeleID := InputData(B_LexIDLegal <= 0);
	
LayoutBIIAndPII := RECORD
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII InputData;
		DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput;
	END;
	
	LayoutBusinessSeleIDAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic(
																	0, // UltID
																	0, // OrgID
																	0, // SeleID
																	DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII), 
																	DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII), 
																	0, // ArchiveDate
																	PublicRecords_KEL.CFG_Compile.Permit__NONE).res0); //DPM	
																	
	BusinessSeleAttributesInput := DENORMALIZE(RecordsWithSeleID, RepInput, 
		LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,  GROUP,
		TRANSFORM(LayoutBIIAndPII, 
			SELF.RepInput := ROWS(RIGHT),
			SELF.InputData := LEFT));
					
	// BusinessSeleAttributes_Results := NOCOMBINE(JOIN(BusinessSeleAttributesInput, FDCDataset,//think we need FDCDataset(repnumber != 6) - repnumber needed for batch
		// LEFT.InputData.G_ProcBusUID = RIGHT.G_ProcBusUID,
		// TRANSFORM({INTEGER G_ProcBusUID, LayoutBusinessSeleIDAttributes},
			// SELF.G_ProcBusUID := LEFT.InputData.G_ProcBusUID;
			// NonFCRABusinessSeleIDResults := PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic(
				// LEFT.InputData.B_LexIDUlt,
				// LEFT.InputData.B_LexIDOrg,
				// LEFT.InputData.B_LexIDLegal,
				// LEFT.RepInput,
				// DATASET(LEFT.InputData),
				// (INTEGER)LEFT.InputData.B_InpClnArchDt[1..8],
				// Options.KEL_Permissions_Mask, 
				// DATASET(RIGHT)).res0;
			// SELF := NonFCRABusinessSeleIDResults[1]), 
		// LEFT OUTER, ATMOST(100), KEEP(1)));


	BusinessSeleAttributes_Results := NOCOMBINE(PROJECT(BusinessSeleAttributesInput, TRANSFORM({INTEGER G_ProcBusUID, LayoutBusinessSeleIDAttributes},
		SELF.G_ProcBusUID := LEFT.InputData.G_ProcBusUID;
		NonFCRABusinessSeleIDResults := PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic(
				LEFT.InputData.B_LexIDUlt,
				LEFT.InputData.B_LexIDOrg,
				LEFT.InputData.B_LexIDLegal,
				LEFT.RepInput,
				DATASET(LEFT.InputData),
				(INTEGER)LEFT.InputData.B_InpClnArchDt[1..8],
				Options.KEL_Permissions_Mask, 
				FDCDataset).res0;
		SELF := NonFCRABusinessSeleIDResults[1])));

	BusinessSeleIDAttributesRaw := KEL.Clean(BusinessSeleAttributes_Results, true, true, true);

	LayoutBusinessSeleIDNoDatesAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_No_Dates_Attributes_V1_Dynamic(
																	0, // UltID
																	0, // OrgID
																	0, // SeleID
																	0, // ArchiveDate
																	PublicRecords_KEL.CFG_Compile.Permit__NONE).res0); //DPM	

	BusinessSeleAttributes_NoDates_Results := IF(Options.OutputMasterResults,
		NOCOMBINE(PROJECT(InputData, TRANSFORM({INTEGER G_ProcBusUID, LayoutBusinessSeleIDNoDatesAttributes},
			SELF.G_ProcBusUID := LEFT.G_ProcBusUID;
			NonFCRABusinessSeleIDResults := PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_No_Dates_Attributes_V1_Dynamic(
				LEFT.B_LexIDUlt,
				LEFT.B_LexIDOrg,
				LEFT.B_LexIDLegal, 				
				STD.Date.Today(), 
				Options.KEL_Permissions_Mask, 				
				FDCDataset).res0;
			SELF := NonFCRABusinessSeleIDResults[1]))),
		DATASET([],{INTEGER G_ProcBusUID, LayoutBusinessSeleIDNoDatesAttributes}));
	
	BusinessSeleIDNoDatesAttributesRaw := KEL.Clean(BusinessSeleAttributes_NoDates_Results, TRUE, TRUE, TRUE);
	
	BusinessAttributesWithSeleID := JOIN(RecordsWithSeleID, BusinessSeleIDAttributesRaw, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutBusinessSeleID,
			ResultsFound := RIGHT.B_LexIDLegal > 0 AND RIGHT.B_LexIDLegalSeenFlag = '1';
			SELF.B_LexIDLegalSeenFlag := IF(ResultsFound, RIGHT.B_LexIDLegalSeenFlag, '0');
			SELF.BE_VerSrcListEv := IF(ResultsFound, RIGHT.BE_VerSrcListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcCntEv := IF(ResultsFound, RIGHT.BE_VerSrcCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerSrcEmrgDtListEv := IF(ResultsFound, RIGHT.BE_VerSrcEmrgDtListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcLastDtListEv := IF(ResultsFound, RIGHT.BE_VerSrcLastDtListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcOldDtEv := IF(ResultsFound, RIGHT.BE_VerSrcOldDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcNewDtEv := IF(ResultsFound, RIGHT.BE_VerSrcNewDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcOldMsncEv := IF(ResultsFound, RIGHT.BE_VerSrcOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerSrcNewMsncEv := IF(ResultsFound, RIGHT.BE_VerSrcNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerSrcRptNewBusFlag := IF(ResultsFound, RIGHT.BE_VerSrcRptNewBusFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcCredCntEv := IF(ResultsFound, RIGHT.BE_VerSrcCredCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerSrcBureauFlag := IF(ResultsFound, RIGHT.BE_VerSrcBureauFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcBureauOldDtEv := IF(ResultsFound, RIGHT.BE_VerSrcBureauOldDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerSrcBureauOldMsncEv := IF(ResultsFound, RIGHT.BE_VerSrcBureauOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DBANameCnt2Y := IF(ResultsFound, RIGHT.BE_DBANameCnt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AddrPOBoxFlag := IF(ResultsFound, (STRING)RIGHT.BE_AddrPOBoxFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_URLFlag := IF(ResultsFound, (STRING)RIGHT.BE_URLFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_VerNameFlag := IF(ResultsFound, (STRING)RIGHT.BE_VerNameFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerNameSrcListEv := IF(ResultsFound, RIGHT.BE_VerNameSrcListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerNameSrcCntEv := IF(ResultsFound, RIGHT.BE_VerNameSrcCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerNameSrcEmrgDtListEv := IF(ResultsFound, RIGHT.BE_VerNameSrcEmrgDtListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerNameSrcLastDtListEv := IF(ResultsFound, RIGHT.BE_VerNameSrcLastDtListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerNameSrcOldDtEv := IF(ResultsFound, RIGHT.BE_VerNameSrcOldDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerNameSrcNewDtEv := IF(ResultsFound, RIGHT.BE_VerNameSrcNewDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerNameSrcOldMsncEv := IF(ResultsFound, RIGHT.BE_VerNameSrcOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerNameSrcNewMsncEv := IF(ResultsFound, RIGHT.BE_VerNameSrcNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerAddrFlag := IF(ResultsFound, (STRING)RIGHT.BE_VerAddrFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerAddrSrcListEv := IF(ResultsFound, RIGHT.BE_VerAddrSrcListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerAddrSrcCntEv := IF(ResultsFound, RIGHT.BE_VerAddrSrcCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerAddrSrcEmrgDtListEv := IF(ResultsFound, RIGHT.BE_VerAddrSrcEmrgDtListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerAddrSrcLastDtListEv := IF(ResultsFound, RIGHT.BE_VerAddrSrcLastDtListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerAddrSrcOldDtEv := IF(ResultsFound, RIGHT.BE_VerAddrSrcOldDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerAddrSrcNewDtEv := IF(ResultsFound, RIGHT.BE_VerAddrSrcNewDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerAddrSrcOldMsncEv := IF(ResultsFound, RIGHT.BE_VerAddrSrcOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerAddrSrcNewMsncEv := IF(ResultsFound, RIGHT.BE_VerAddrSrcNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerAddrSrcDtSpanEv := IF(ResultsFound, RIGHT.BE_VerAddrSrcDtSpanEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerTINFlag := IF(ResultsFound, (STRING)RIGHT.BE_VerTINFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerTINSrcListEv := IF(ResultsFound, RIGHT.BE_VerTINSrcListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerTINSrcCntEv := IF(ResultsFound, RIGHT.BE_VerTINSrcCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerTINSrcEmrgDtListEv := IF(ResultsFound, RIGHT.BE_VerTINSrcEmrgDtListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerTINSrcLastDtListEv := IF(ResultsFound, RIGHT.BE_VerTINSrcLastDtListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerTINSrcOldDtEv := IF(ResultsFound, RIGHT.BE_VerTINSrcOldDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerTINSrcNewDtEv := IF(ResultsFound, RIGHT.BE_VerTINSrcNewDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerTINSrcOldMsncEv := IF(ResultsFound, RIGHT.BE_VerTINSrcOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerTINSrcNewMsncEv := IF(ResultsFound, RIGHT.BE_VerTINSrcNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerPhoneFlag := IF(ResultsFound, (STRING)RIGHT.BE_VerPhoneFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerPhoneSrcListEv := IF(ResultsFound, RIGHT.BE_VerPhoneSrcListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerPhoneSrcCntEv := IF(ResultsFound, RIGHT.BE_VerPhoneSrcCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerPhoneSrcEmrgDtListEv := IF(ResultsFound, RIGHT.BE_VerPhoneSrcEmrgDtListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerPhoneSrcLastDtListEv := IF(ResultsFound, RIGHT.BE_VerPhoneSrcLastDtListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerPhoneSrcOldDtEv := IF(ResultsFound, RIGHT.BE_VerPhoneSrcOldDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerPhoneSrcNewDtEv := IF(ResultsFound, RIGHT.BE_VerPhoneSrcNewDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_VerPhoneSrcOldMsncEv := IF(ResultsFound, RIGHT.BE_VerPhoneSrcOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_VerPhoneSrcNewMsncEv := IF(ResultsFound, RIGHT.BE_VerPhoneSrcNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			//Tradeline Attributes		
			SELF.BE_B2BCntEv := IF(ResultsFound, RIGHT.BE_B2BCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BCnt2Y := IF(ResultsFound, RIGHT.BE_B2BCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BCarrCnt2Y := IF(ResultsFound, RIGHT.BE_B2BCarrCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BFltCnt2Y := IF(ResultsFound, RIGHT.BE_B2BFltCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BMatCnt2Y := IF(ResultsFound, RIGHT.BE_B2BMatCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOpsCnt2Y := IF(ResultsFound, RIGHT.BE_B2BOpsCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOthCnt2Y := IF(ResultsFound, RIGHT.BE_B2BOthCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BCarrPct2Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BCarrPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BFltPct2Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BFltPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BMatPct2Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BMatPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOpsPct2Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BOpsPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOthPct2Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BOthPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOldDtEv := IF(ResultsFound,(STRING)RIGHT.BE_B2BOldDtEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BOldMsncEv := IF(ResultsFound,RIGHT.BE_B2BOldMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOldDt2Y := IF(ResultsFound,RIGHT.BE_B2BOldDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BNewDt2Y := IF(ResultsFound,RIGHT.BE_B2BNewDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BOldMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BOldMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BNewMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BNewMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvCnt := IF(ResultsFound, RIGHT.BE_B2BActvCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvCarrCnt := IF(ResultsFound, RIGHT.BE_B2BActvCarrCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvFltCnt := IF(ResultsFound, RIGHT.BE_B2BActvFltCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvMatCnt := IF(ResultsFound, RIGHT.BE_B2BActvMatCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOpsCnt := IF(ResultsFound, RIGHT.BE_B2BActvOpsCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOthCnt := IF(ResultsFound, RIGHT.BE_B2BActvOthCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvCarrPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvCarrPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvFltPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvFltPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvMatPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvMatPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOpsPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvOpsPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOthPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvOthPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_B2BActvCntA1Y := IF(ResultsFound, RIGHT.BE_B2BActvCntA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);	
			SELF.BE_B2BActvCarrCntA1Y := IF(ResultsFound, RIGHT.BE_B2BActvCarrCntA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);	
			SELF.BE_B2BActvFltCntA1Y := IF(ResultsFound, RIGHT.BE_B2BActvFltCntA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);	
			SELF.BE_B2BActvMatCntA1Y := IF(ResultsFound, RIGHT.BE_B2BActvMatCntA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);	
			SELF.BE_B2BActvOpsCntA1Y := IF(ResultsFound, RIGHT.BE_B2BActvOpsCntA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);	
			SELF.BE_B2BActvOthCntA1Y := IF(ResultsFound, RIGHT.BE_B2BActvOthCntA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);	
			SELF.BE_B2BActvCntGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvCntGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_B2BActvCarrCntGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvCarrCntGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_B2BActvFltCntGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvFltCntGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_B2BActvMatCntGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvMatCntGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_B2BActvOpsCntGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvOpsCntGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_B2BActvOthCntGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvOthCntGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_B2BActvBalTot := IF(ResultsFound,RIGHT.BE_B2BActvBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvCarrBalTot := IF(ResultsFound,RIGHT.BE_B2BActvCarrBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvFltBalTot := IF(ResultsFound,RIGHT.BE_B2BActvFltBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvMatBalTot := IF(ResultsFound,RIGHT.BE_B2BActvMatBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOpsBalTot := IF(ResultsFound,RIGHT.BE_B2BActvOpsBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOthBalTot := IF(ResultsFound,RIGHT.BE_B2BActvOthBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvCarrBalTotPct := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvCarrBalTotPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvFltBalPct := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvFltBalPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvMatBalPct := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvMatBalPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOpsBalPct := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvOpsBalPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOthBalPct := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvOthBalPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT); 
			SELF.BE_B2BActvBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvCarrBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvCarrBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvFltBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvFltBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvMatBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvMatBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvOpsBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvOpsBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvOthBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvOthBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvBalAvg := IF(ResultsFound,RIGHT.BE_B2BActvBalAvg,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvCarrBalAvg := IF(ResultsFound,RIGHT.BE_B2BActvCarrBalAvg,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvFltBalAvg := IF(ResultsFound,RIGHT.BE_B2BActvFltBalAvg,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvMatBalAvg := IF(ResultsFound,RIGHT.BE_B2BActvMatBalAvg,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOpsBalAvg := IF(ResultsFound,RIGHT.BE_B2BActvOpsBalAvg,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOthBalAvg := IF(ResultsFound,RIGHT.BE_B2BActvOthBalAvg,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvBalTotA1Y := IF(ResultsFound,RIGHT.BE_B2BActvBalTotA1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvCarrBalTotA1Y := IF(ResultsFound,RIGHT.BE_B2BActvCarrBalTotA1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvFltBalTotA1Y := IF(ResultsFound,RIGHT.BE_B2BActvFltBalTotA1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvMatBalTotA1Y := IF(ResultsFound,RIGHT.BE_B2BActvMatBalTotA1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOpsBalTotA1Y := IF(ResultsFound,RIGHT.BE_B2BActvOpsBalTotA1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOthBalTotA1Y := IF(ResultsFound,RIGHT.BE_B2BActvOthBalTotA1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvBalTotGrow1Y := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvBalTotGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvCarrBalTotGrow1Y := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvCarrBalTotGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvFltBalTotGrow1Y := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvFltBalTotGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvMatBalTotGrow1Y := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvMatBalTotGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOpsBalTotGrow1Y := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvOpsBalTotGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvOthBalTotGrow1Y := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvOthBalTotGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActvBalTotGrowIndx1Y := IF(ResultsFound,RIGHT.BE_B2BActvBalTotGrowIndx1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvCarrBalTotGrowIndx1Y := IF(ResultsFound,RIGHT.BE_B2BActvCarrBalTotGrowIndx1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvFltBalTotGrowIndx1Y := IF(ResultsFound,RIGHT.BE_B2BActvFltBalTotGrowIndx1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvMatBalTotGrowIndx1Y := IF(ResultsFound,RIGHT.BE_B2BActvMatBalTotGrowIndx1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvOpsBalTotGrowIndx1Y := IF(ResultsFound,RIGHT.BE_B2BActvOpsBalTotGrowIndx1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvOthBalTotGrowIndx1Y := IF(ResultsFound,RIGHT.BE_B2BActvOthBalTotGrowIndx1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BBalMax2Y := IF(ResultsFound,(INTEGER)RIGHT.BE_B2BBalMax2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BCarrBalMax2Y := IF(ResultsFound,(INTEGER)RIGHT.BE_B2BCarrBalMax2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BFltBalMax2Y := IF(ResultsFound,(INTEGER)RIGHT.BE_B2BFltBalMax2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BMatBalMax2Y := IF(ResultsFound,(INTEGER)RIGHT.BE_B2BMatBalMax2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOpsBalMax2Y := IF(ResultsFound,(INTEGER)RIGHT.BE_B2BOpsBalMax2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOthBalMax2Y := IF(ResultsFound,(INTEGER)RIGHT.BE_B2BOthBalMax2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BBalMaxDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BBalMaxDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BCarrBalMaxDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BCarrBalMaxDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BFltBalMaxDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BFltBalMaxDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BMatBalMaxDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BMatBalMaxDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BOpsBalMaxDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BOpsBalMaxDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BOthBalMaxDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BOthBalMaxDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BBalMaxMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BBalMaxMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BCarrBalMaxMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BCarrBalMaxMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BFltBalMaxMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BFltBalMaxMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BMatBalMaxMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BMatBalMaxMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOpsBalMaxMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BOpsBalMaxMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOthBalMaxMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BOthBalMaxMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BBalMaxSegType2Y := IF(ResultsFound,RIGHT.BE_B2BBalMaxSegType2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvWorstPerfIndx := IF(ResultsFound,(STRING)RIGHT.BE_B2BActvWorstPerfIndx,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvCarrWorstPerfIndx := IF(ResultsFound,(STRING)RIGHT.BE_B2BActvCarrWorstPerfIndx, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvFltWorstPerfIndx := IF(ResultsFound,(STRING)RIGHT.BE_B2BActvFltWorstPerfIndx, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvMatWorstPerfIndx := IF(ResultsFound,(STRING)RIGHT.BE_B2BActvMatWorstPerfIndx, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvOpsWorstPerfIndx := IF(ResultsFound,(STRING)RIGHT.BE_B2BActvOpsWorstPerfIndx, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActvOthWorstPerfIndx := IF(ResultsFound,(STRING)RIGHT.BE_B2BActvOthWorstPerfIndx, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BActv1pDpdCnt := IF(ResultsFound, RIGHT.BE_B2BActv1pDpdCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv31pDpdCnt := IF(ResultsFound, RIGHT.BE_B2BActv31pDpdCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv61pDpdCnt := IF(ResultsFound, RIGHT.BE_B2BActv61pDpdCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv91pDpdCnt := IF(ResultsFound, RIGHT.BE_B2BActv91pDpdCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv1pDpdPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv1pDpdPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv31pDpdPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv31pDpdPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv61pDpdPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv61pDpdPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv91pDpdPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv91pDpdPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv1pDpdBalTot := IF(ResultsFound, RIGHT.BE_B2BActv1pDpdBalTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv31pDpdBalTot := IF(ResultsFound, RIGHT.BE_B2BActv31pDpdBalTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv61pDpdBalTot := IF(ResultsFound, RIGHT.BE_B2BActv61pDpdBalTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv91pDpdBalTot := IF(ResultsFound, RIGHT.BE_B2BActv91pDpdBalTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv1pDpdBalTotPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv1pDpdBalTotPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv31pDpdBalTotPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv31pDpdBalTotPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv61pDpdBalTotPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv61pDpdBalTotPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv91pDpdBalTotPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv91pDpdBalTotPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv1pDpdBalTotA1Y := IF(ResultsFound, RIGHT.BE_B2BActv1pDpdBalTotA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv31pDpdBalTotA1Y := IF(ResultsFound, RIGHT.BE_B2BActv31pDpdBalTotA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv61pDpdBalTotA1Y := IF(ResultsFound, RIGHT.BE_B2BActv61pDpdBalTotA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv91pDpdBalTotA1Y := IF(ResultsFound, RIGHT.BE_B2BActv91pDpdBalTotA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv1pDpdBalTotGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv1pDpdBalTotGrow1Y, 4), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv31pDpdBalTotGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv31pDpdBalTotGrow1Y, 4), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv61pDpdBalTotGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv61pDpdBalTotGrow1Y, 4), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BActv91pDpdBalTotGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv91pDpdBalTotGrow1Y, 4), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);  
			SELF.BE_B2BWorstPerfIndx2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BWorstPerfIndx2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BCarrWorstPerfIndx2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BCarrWorstPerfIndx2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BFltWorstPerfIndx2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BFltWorstPerfIndx2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BMatWorstPerfIndx2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BMatWorstPerfIndx2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BOpsWorstPerfIndx2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BOpsWorstPerfIndx2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BOthWorstPerfIndx2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BOthWorstPerfIndx2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BWorstPerfDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BWorstPerfDt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BCarrWorstPerfDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BCarrWorstPerfDt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BFltWorstPerfDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BFltWorstPerfDt2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BMatWorstPerfDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BMatWorstPerfDt2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BOpsWorstPerfDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BOpsWorstPerfDt2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BOthWorstPerfDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BOthWorstPerfDt2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BWorstPerfMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BWorstPerfMsnc2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BCarrWorstPerfMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BCarrWorstPerfMsnc2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BFltWorstPerfMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BFltWorstPerfMsnc2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BMatWorstPerfMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BMatWorstPerfMsnc2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOpsWorstPerfMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BOpsWorstPerfMsnc2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOthWorstPerfMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BOthWorstPerfMsnc2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BCnt24Mc := IF(ResultsFound, RIGHT.BE_B2BCnt24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BCarrCnt24Mc := IF(ResultsFound, RIGHT.BE_B2BCarrCnt24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BFltCnt24Mc := IF(ResultsFound, RIGHT.BE_B2BFltCnt24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BMatCnt24Mc := IF(ResultsFound, RIGHT.BE_B2BMatCnt24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOpsCnt24Mc := IF(ResultsFound, RIGHT.BE_B2BOpsCnt24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOthCnt24Mc := IF(ResultsFound, RIGHT.BE_B2BOthCnt24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BRecFlagByMonStr24Mc := IF(ResultsFound, RIGHT.BE_B2BRecFlagByMonStr24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BCarrRecFlagByMonStr24Mc := IF(ResultsFound, RIGHT.BE_B2BCarrRecFlagByMonStr24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BFltRecFlagByMonStr24Mc := IF(ResultsFound, RIGHT.BE_B2BFltRecFlagByMonStr24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BMatRecFlagByMonStr24Mc := IF(ResultsFound, RIGHT.BE_B2BMatRecFlagByMonStr24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BOpsRecFlagByMonStr24Mc := IF(ResultsFound, RIGHT.BE_B2BOpsRecFlagByMonStr24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BOthRecFlagByMonStr24Mc := IF(ResultsFound, RIGHT.BE_B2BOthRecFlagByMonStr24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_B2BRecFlagByMonSum24Mc := IF(ResultsFound, RIGHT.BE_B2BRecFlagByMonSum24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BCarrRecFlagByMonSum24Mc := IF(ResultsFound, RIGHT.BE_B2BCarrRecFlagByMonSum24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BFltRecFlagByMonSum24Mc := IF(ResultsFound, RIGHT.BE_B2BFltRecFlagByMonSum24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BMatRecFlagByMonSum24Mc := IF(ResultsFound, RIGHT.BE_B2BMatRecFlagByMonSum24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOpsRecFlagByMonSum24Mc := IF(ResultsFound, RIGHT.BE_B2BOpsRecFlagByMonSum24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BOthRecFlagByMonSum24Mc := IF(ResultsFound, RIGHT.BE_B2BOthRecFlagByMonSum24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_B2BBalVol24Mc := IF(ResultsFound, ROUND(RIGHT.BE_B2BBalVol24Mc, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT); 
			SELF.BE_B2BCarrBalVol24Mc := IF(ResultsFound, ROUND(RIGHT.BE_B2BCarrBalVol24Mc, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT); 
			SELF.BE_B2BFltBalVol24Mc := IF(ResultsFound, ROUND(RIGHT.BE_B2BFltBalVol24Mc, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT); 
			SELF.BE_B2BMatBalVol24Mc := IF(ResultsFound, ROUND(RIGHT.BE_B2BMatBalVol24Mc, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT); 
			SELF.BE_B2BOpsBalVol24Mc := IF(ResultsFound, ROUND(RIGHT.BE_B2BOpsBalVol24Mc, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT); 
			SELF.BE_B2BOthBalVol24Mc := IF(ResultsFound, ROUND(RIGHT.BE_B2BOthBalVol24Mc, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT); 
			// Asset Vehicle
			SELF.BE_AstVehAirCntEv := IF(ResultsFound, RIGHT.BE_AstVehAirCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehWtrCntEv := IF(ResultsFound, RIGHT.BE_AstVehWtrCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehAutoCntEv := IF(ResultsFound, RIGHT.BE_AstVehAutoCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehAutoCnt2Y := IF(ResultsFound, RIGHT.BE_AstVehAutoCnt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehAutoPersCnt2Y := IF(ResultsFound, RIGHT.BE_AstVehAutoPersCnt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehAutoCommCnt2Y := IF(ResultsFound, RIGHT.BE_AstVehAutoCommCnt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehAutoOtherCnt2Y := IF(ResultsFound, RIGHT.BE_AstVehAutoOtherCnt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehAutoValTot2Y := IF(ResultsFound, RIGHT.BE_AstVehAutoValTot2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehAutoEmrgNewMsncEv := IF(ResultsFound, RIGHT.BE_AstVehAutoEmrgNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AstVehAutoEmrgNewDtEv := IF(ResultsFound, RIGHT.BE_AstVehAutoEmrgNewDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			// Asset Property		
			SELF.BE_AstPropCntEv := IF(ResultsFound, RIGHT.BE_AstPropCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropStateCntEv := IF(ResultsFound, RIGHT.BE_AstPropStateCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropCurrCnt := IF(ResultsFound, RIGHT.BE_AstPropCurrCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropCurrStateCnt := IF(ResultsFound, RIGHT.BE_AstPropCurrStateCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropOldDtEv := IF(ResultsFound, RIGHT.BE_AstPropOldDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_AstPropOldMsncEv := IF(ResultsFound, RIGHT.BE_AstPropOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropNewDtEv := IF(ResultsFound, RIGHT.BE_AstPropNewDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_AstPropNewMsncEv := IF(ResultsFound, RIGHT.BE_AstPropNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropCurrTaxValTot := IF(ResultsFound, RIGHT.BE_AstPropCurrTaxValTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropCurrMktValTot := IF(ResultsFound, RIGHT.BE_AstPropCurrMktValTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropCurrValTot := IF(ResultsFound, RIGHT.BE_AstPropCurrValTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropCurrLotSizeTot := IF(ResultsFound, RIGHT.BE_AstPropCurrLotSizeTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropCurrBldgSizeTot := IF(ResultsFound, RIGHT.BE_AstPropCurrBldgSizeTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AstPropIndxEv := IF(ResultsFound, (STRING)RIGHT.BE_AstPropIndxEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);            		
			// Bankruptcy
			SELF.BE_DrgBkCnt1Y := IF(ResultsFound, RIGHT.BE_DrgBkCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgBkCnt7Y := IF(ResultsFound, RIGHT.BE_DrgBkCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgBkCnt10Y := IF(ResultsFound, RIGHT.BE_DrgBkCnt10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgBkOldDt10Y := IF(ResultsFound, RIGHT.BE_DrgBkOldDt10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgBkOldMsnc10Y := IF(ResultsFound, RIGHT.BE_DrgBkOldMsnc10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgBkNewDt10Y := IF(ResultsFound, RIGHT.BE_DrgBkNewDt10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgBkNewMsnc10Y := IF(ResultsFound, RIGHT.BE_DrgBkNewMsnc10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgBkUpdtNewDt10Y := IF(ResultsFound, RIGHT.BE_DrgBkUpdtNewDt10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgBkUpdtNewMsnc10Y := IF(ResultsFound, (INTEGER)RIGHT.BE_DrgBkUpdtNewMsnc10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgBkDispCnt10Y := IF(ResultsFound, RIGHT.BE_DrgBkDispCnt10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgBkDschCnt10Y := IF(ResultsFound, RIGHT.BE_DrgBkDschCnt10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgBkDsmsCnt10Y := IF(ResultsFound, RIGHT.BE_DrgBkDsmsCnt10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgBkNewDispType10Y := IF(ResultsFound, RIGHT.BE_DrgBkNewDispType10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgBkCh7Cnt10Y := IF(ResultsFound, RIGHT.BE_DrgBkCh7Cnt10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgBkCh11Cnt10Y := IF(ResultsFound, RIGHT.BE_DrgBkCh11Cnt10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgBkCh13Cnt10Y := IF(ResultsFound, RIGHT.BE_DrgBkCh13Cnt10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgBkNewChType10Y := IF(ResultsFound, RIGHT.BE_DrgBkNewChType10Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			//Sos Build Date//			
			SELF.BE_SOSCntEv := IF(ResultsFound, RIGHT.BE_SOSCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_SOSNewDtEv := IF(ResultsFound, RIGHT.BE_SOSNewDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_SOSOldDtEv := IF(ResultsFound, RIGHT.BE_SOSOldDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_SOSNewMsncEv := IF(ResultsFound, RIGHT.BE_SOSNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_SOSOldMsncEv := IF(ResultsFound, RIGHT.BE_SOSOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_SOSStateCntEv := IF(ResultsFound, RIGHT.BE_SOSStateCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_SOSDomCntEv := IF(ResultsFound, RIGHT.BE_SOSDomCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_SOSDomNewDtEv := IF(ResultsFound, RIGHT.BE_SOSDomNewDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_SOSDomOldDtEv := IF(ResultsFound, RIGHT.BE_SOSDomOldDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_SOSDomNewMsncEv := IF(ResultsFound, RIGHT.BE_SOSDomNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_SOSDomOldMsncEv := IF(ResultsFound, RIGHT.BE_SOSDomOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_SOSFrgnCntEv := IF(ResultsFound, RIGHT.BE_SOSFrgnCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_SOSFrgnNewDtEv := IF(ResultsFound, RIGHT.BE_SOSFrgnNewDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_SOSFrgnOldDtEv := IF(ResultsFound, RIGHT.BE_SOSFrgnOldDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_SOSFrgnNewMsncEv := IF(ResultsFound, RIGHT.BE_SOSFrgnNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_SOSFrgnOldMsncEv := IF(ResultsFound, RIGHT.BE_SOSFrgnOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_SOSDomStatusIndxEv := IF(ResultsFound, RIGHT.BE_SOSDomStatusIndxEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			//best bii sele
			SELF.BE_BestName := IF(ResultsFound, RIGHT.BE_BestName, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			// SELF.BE_BestAddrLocID := IF(ResultsFound, RIGHT.BE_BestAddrLocID, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_BestAddrSt := IF(ResultsFound, RIGHT.BE_BestAddrSt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrCity := IF(ResultsFound, RIGHT.BE_BestAddrCity, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrCityPost := IF(ResultsFound, RIGHT.BE_BestAddrCityPost, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrState := IF(ResultsFound, RIGHT.BE_BestAddrState, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrZip := IF(ResultsFound, RIGHT.BE_BestAddrZip, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestTIN := IF(ResultsFound, RIGHT.BE_BestTIN, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestPhone := IF(ResultsFound, RIGHT.BE_BestPhone, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			//LeinJudgment Build Date//			
			SELF.BE_DrgGovDebarredFlagEv := IF(ResultsFound, RIGHT.BE_DrgGovDebarredFlagEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLTDCnt1Y := IF(ResultsFound, RIGHT.BE_DrgLTDCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLTDCnt7Y := IF(ResultsFound, RIGHT.BE_DrgLTDCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLTDAmtTot7Y := IF(ResultsFound, RIGHT.BE_DrgLTDAmtTot7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLTDAmtAvg7Y := IF(ResultsFound, RIGHT.BE_DrgLTDAmtAvg7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLTDNewDt7Y := IF(ResultsFound, RIGHT.BE_DrgLTDNewDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLTDOldDt7Y := IF(ResultsFound, RIGHT.BE_DrgLTDOldDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLTDNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLTDNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLTDOldMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLTDOldMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT)	;	
					//UCC Attributes
			SELF.BE_UCCCntEv := IF(ResultsFound, RIGHT.BE_UCCCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorCntEv := IF(ResultsFound, RIGHT.BE_UCCDebtorCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorOldDtEv := IF(ResultsFound, RIGHT.BE_UCCDebtorOldDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_UCCDebtorOldMsncEv := IF(ResultsFound, RIGHT.BE_UCCDebtorOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorNewDtEv := IF(ResultsFound, RIGHT.BE_UCCDebtorNewDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_UCCDebtorNewMsncEv := IF(ResultsFound, RIGHT.BE_UCCDebtorNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCActvCnt := IF(ResultsFound, RIGHT.BE_UCCActvCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorActvCnt := IF(ResultsFound, RIGHT.BE_UCCDebtorActvCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorTermCntEv := IF(ResultsFound, RIGHT.BE_UCCDebtorTermCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorOtherCntEv := IF(ResultsFound, RIGHT.BE_UCCDebtorOtherCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorActvPct := IF(ResultsFound, RIGHT.BE_UCCDebtorActvPct, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorTermPctEv := IF(ResultsFound, ROUND(RIGHT.BE_UCCDebtorTermPctEv,2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorOtherPctEv := IF(ResultsFound, ROUND(RIGHT.BE_UCCDebtorOtherPctEv,2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCDebtorTermNewDtEv := IF(ResultsFound, RIGHT.BE_UCCDebtorTermNewDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_UCCDebtorTermNewMsncEv := IF(ResultsFound, RIGHT.BE_UCCDebtorTermNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCCreditorCntEv := IF(ResultsFound, RIGHT.BE_UCCCreditorCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_UCCRoleIndxEv := IF(ResultsFound, RIGHT.BE_UCCRoleIndxEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_UCCActvRoleIndx := IF(ResultsFound, RIGHT.BE_UCCActvRoleIndx, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			//Overall Liens
			SELF.BE_DrgLienCnt1Y := IF(ResultsFound, RIGHT.BE_DrgLienCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienCnt7Y := IF(ResultsFound, RIGHT.BE_DrgLienCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienAmtTot7Y := IF(ResultsFound, RIGHT.BE_DrgLienAmtTot7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienAmtAvg7Y := IF(ResultsFound, RIGHT.BE_DrgLienAmtAvg7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienOldDt7Y := IF(ResultsFound, RIGHT.BE_DrgLienOldDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienOldMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLienOldMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienNewDt7Y := IF(ResultsFound, RIGHT.BE_DrgLienNewDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLienNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxCnt7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxAmtTot7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxAmtTot7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxOldDt7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxOldDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienTaxOldMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxOldMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxNewDt7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxNewDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienTaxNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxFedCnt7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxFedCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxFedAmtTot7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxFedAmtTot7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxFedOldDt7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxFedOldDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienTaxFedOldMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxFedOldMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxFedNewDt7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxFedNewDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienTaxFedNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxFedNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxStateCnt7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxStateCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxStateAmtTot7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxStateAmtTot7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxStateOldDt7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxStateOldDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienTaxStateOldMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxStateOldMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxStateNewDt7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxStateNewDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienTaxStateNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxStateNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxOtherCnt7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxOtherCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxOtherAmtTot7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxOtherAmtTot7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxOtherOldDt7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxOtherOldDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienTaxOtherOldMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxOtherOldMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienTaxOtherNewDt7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxOtherNewDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienTaxOtherNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLienTaxOtherNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienOtherCnt7Y := IF(ResultsFound, RIGHT.BE_DrgLienOtherCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienOtherAmtTot7Y := IF(ResultsFound, RIGHT.BE_DrgLienOtherAmtTot7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienOtherNewDt7Y := IF(ResultsFound, RIGHT.BE_DrgLienOtherNewDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienOtherOldDt7Y := IF(ResultsFound, RIGHT.BE_DrgLienOtherOldDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienOtherNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLienOtherNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLienOtherOldMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLienOtherOldMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			//OverAll Judgment
			SELF.BE_DrgJudgCnt1Y := IF(ResultsFound, RIGHT.BE_DrgJudgCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgCnt7Y := IF(ResultsFound, RIGHT.BE_DrgJudgCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgAmtTot7Y := IF(ResultsFound, RIGHT.BE_DrgJudgAmtTot7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgAmtAvg7Y := IF(ResultsFound, RIGHT.BE_DrgJudgAmtAvg7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgOldDt7Y := IF(ResultsFound, RIGHT.BE_DrgJudgOldDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgJudgOldMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgJudgOldMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgNewDt7Y := IF(ResultsFound, RIGHT.BE_DrgJudgNewDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgJudgNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgJudgNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgCivCrtCnt7Y := IF(ResultsFound, RIGHT.BE_DrgJudgCivCrtCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgCivCrtAmtTot7Y := IF(ResultsFound, RIGHT.BE_DrgJudgCivCrtAmtTot7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgCivCrtOldDt7Y := IF(ResultsFound, RIGHT.BE_DrgJudgCivCrtOldDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgJudgCivCrtOldMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgJudgCivCrtOldMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgCivCrtNewDt7Y := IF(ResultsFound, RIGHT.BE_DrgJudgCivCrtNewDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgJudgCivCrtNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgJudgCivCrtNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgSmClaimCnt7Y := IF(ResultsFound, RIGHT.BE_DrgJudgSmClaimCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgSmClaimAmtTot7Y := IF(ResultsFound, RIGHT.BE_DrgJudgSmClaimAmtTot7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgSmClaimOldDt7Y := IF(ResultsFound, RIGHT.BE_DrgJudgSmClaimOldDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgJudgSmClaimOldMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgJudgSmClaimOldMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgSmClaimNewDt7Y := IF(ResultsFound, RIGHT.BE_DrgJudgSmClaimNewDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgJudgSmClaimNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgJudgSmClaimNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgFrclCnt7Y := IF(ResultsFound, RIGHT.BE_DrgJudgFrclCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgFrclAmtTot7Y := IF(ResultsFound, RIGHT.BE_DrgJudgFrclAmtTot7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgFrclOldDt7Y := IF(ResultsFound, RIGHT.BE_DrgJudgFrclOldDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgJudgFrclOldMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgJudgFrclOldMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgJudgFrclNewDt7Y := IF(ResultsFound, RIGHT.BE_DrgJudgFrclNewDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgJudgFrclNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgJudgFrclNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			//overAll LienJudgment Attributes
			SELF.BE_DrgLnJCnt1Y := IF(ResultsFound, RIGHT.BE_DrgLnJCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLnJCnt7Y := IF(ResultsFound, RIGHT.BE_DrgLnJCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLnJAmtTot7Y := IF(ResultsFound, RIGHT.BE_DrgLnJAmtTot7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLnJAmtAvg7Y := IF(ResultsFound, RIGHT.BE_DrgLnJAmtAvg7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLnJNewDt7Y := IF(ResultsFound, RIGHT.BE_DrgLnJNewDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLnJOldDt7Y := IF(ResultsFound, RIGHT.BE_DrgLnJOldDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLnJNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLnJNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgLnJOldMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgLnJOldMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			//Suits Attributes
			SELF.BE_DrgSuitCnt7Y := IF(ResultsFound, RIGHT.BE_DrgSuitCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgSuitAmtTot7Y := IF(ResultsFound, RIGHT.BE_DrgSuitAmtTot7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgSuitOldDt7Y := IF(ResultsFound, RIGHT.BE_DrgSuitOldDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgSuitOldMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgSuitOldMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgSuitNewDt7Y := IF(ResultsFound, RIGHT.BE_DrgSuitNewDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgSuitNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgSuitNewMsnc7Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			//LienJudgment Type Attributes
			SELF.BE_DrgJudgNewType7Y := IF(ResultsFound, RIGHT.BE_DrgJudgNewType7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgLienNewType7Y := IF(ResultsFound, RIGHT.BE_DrgLienNewType7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			//Business OverAll Drg Attributes
			SELF.BE_DrgCnt1Y := IF(ResultsFound, RIGHT.BE_DrgCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgCnt7Y := IF(ResultsFound, RIGHT.BE_DrgCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgFlag7Y := IF(ResultsFound, RIGHT.BE_DrgFlag7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgNewDt7Y := IF(ResultsFound, RIGHT.BE_DrgNewDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgNewMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgNewMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_DrgOldDt7Y := IF(ResultsFound, RIGHT.BE_DrgOldDt7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_DrgOldMsnc7Y := IF(ResultsFound, RIGHT.BE_DrgOldMsnc7Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);			
			//Firmographics
			SELF.BE_BusSICCode1 := IF(ResultsFound, RIGHT.BE_BusSICCode1, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA); 
			SELF.BE_BusSICCode1Desc := IF(ResultsFound, RIGHT.BE_BusSICCode1Desc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode1GroupDesc := IF(ResultsFound, RIGHT.BE_BusSICCode1GroupDesc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode2 := IF(ResultsFound, RIGHT.BE_BusSICCode2, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode2Desc := IF(ResultsFound, RIGHT.BE_BusSICCode2Desc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode2GroupDesc := IF(ResultsFound, RIGHT.BE_BusSICCode2GroupDesc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode3 := IF(ResultsFound, RIGHT.BE_BusSICCode3, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode3Desc := IF(ResultsFound, RIGHT.BE_BusSICCode3Desc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode3GroupDesc := IF(ResultsFound, RIGHT.BE_BusSICCode3GroupDesc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode4 := IF(ResultsFound, RIGHT.BE_BusSICCode4, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode4Desc := IF(ResultsFound, RIGHT.BE_BusSICCode4Desc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusSICCode4GroupDesc := IF(ResultsFound, RIGHT.BE_BusSICCode4GroupDesc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusNAICSCode1 := IF(ResultsFound, RIGHT.BE_BusNAICSCode1, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_BusNAICSCode1Desc := IF(ResultsFound, RIGHT.BE_BusNAICSCode1Desc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_BusNAICSCode1GroupDesc := IF(ResultsFound, RIGHT.BE_BusNAICSCode1GroupDesc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_BusNAICSCode2 := IF(ResultsFound, RIGHT.BE_BusNAICSCode2, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_BusNAICSCode2Desc := IF(ResultsFound, RIGHT.BE_BusNAICSCode2Desc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_BusNAICSCode2GroupDesc := IF(ResultsFound, RIGHT.BE_BusNAICSCode2GroupDesc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_BusNAICSCode3 := IF(ResultsFound, RIGHT.BE_BusNAICSCode3, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_BusNAICSCode3Desc := IF(ResultsFound, RIGHT.BE_BusNAICSCode3Desc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_BusNAICSCode3GroupDesc := IF(ResultsFound, RIGHT.BE_BusNAICSCode3GroupDesc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_BusNAICSCode4 := IF(ResultsFound, RIGHT.BE_BusNAICSCode4, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_BusNAICSCode4Desc := IF(ResultsFound, RIGHT.BE_BusNAICSCode4Desc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_BusNAICSCode4GroupDesc := IF(ResultsFound, RIGHT.BE_BusNAICSCode4GroupDesc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);			
			SELF.BE_BusEmplCountCurr := IF(ResultsFound, RIGHT.BE_BusEmplCountCurr, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_BusEmplCountCurrRnge := IF(ResultsFound, (STRING)RIGHT.BE_BusEmplCountCurrRnge, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);    		
			SELF.BE_BusAnnualSalesCurr := IF(ResultsFound, RIGHT.BE_BusAnnualSalesCurr, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);    		
			SELF.BE_BusAnnualSalesCurrRnge := IF(ResultsFound, RIGHT.BE_BusAnnualSalesCurrRnge, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);                		
			//Flag Attributes    		
			SELF.BE_BusIsNonProfitFlag := IF(ResultsFound, RIGHT.BE_BusIsNonProfitFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);            		
			SELF.BE_BusIsFranchiseFlag := IF(ResultsFound, RIGHT.BE_BusIsFranchiseFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);            		
			SELF.BE_BusOffers401kFlag := IF(ResultsFound, RIGHT.BE_BusOffers401kFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);            		
			SELF.BE_BusHasNewLocationFlag1Y := IF(ResultsFound, RIGHT.BE_BusHasNewLocationFlag1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);            		
			SELF.BE_BusLocActvCnt := IF(ResultsFound, RIGHT.BE_BusLocActvCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);            		
			SELF.BE_BusIsSBEFlag := IF(ResultsFound, RIGHT.BE_BusIsSBEFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);            		
			//Ownership Attributes		
			SELF.BE_BusInferFemaleOwnedFlag  := IF(ResultsFound, RIGHT.BE_BusInferFemaleOwnedFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_BusInferFamilyOwnedFlag   := IF(ResultsFound, RIGHT.BE_BusInferFamilyOwnedFlag,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_BusIsFemaleOwnedFlag   := IF(ResultsFound, RIGHT.BE_BusIsFemaleOwnedFlag ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_BusIsMinorityOwnedFlag   := IF(ResultsFound, RIGHT.BE_BusIsMinorityOwnedFlag ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);		
			SELF.BE_BusIsPublicFlag   := IF(ResultsFound, RIGHT.BE_BusIsPublicFlag ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
				//assoc Attributes
			SELF.BE_AssocCntEv := IF(ResultsFound, RIGHT.BE_AssocCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocCnt2Y := IF(ResultsFound, RIGHT.BE_AssocCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocPct2Y := IF(ResultsFound, RIGHT.BE_AssocPct2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocExecCntEv := IF(ResultsFound, RIGHT.BE_AssocExecCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocExecCnt2Y := IF(ResultsFound, RIGHT.BE_AssocExecCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocExecPct2Y := IF(ResultsFound, RIGHT.BE_AssocExecPct2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocNexecCntEv := IF(ResultsFound, RIGHT.BE_AssocNexecCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocNexecCnt2Y := IF(ResultsFound, RIGHT.BE_AssocNexecCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocNexecPct2Y := IF(ResultsFound, RIGHT.BE_AssocNexecPct2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_AssocEmailFlag2Y := IF(ResultsFound, RIGHT.BE_AssocEmailFlag2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_AssocExecEmailFlag2Y := IF(ResultsFound, RIGHT.BE_AssocExecEmailFlag2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_AssocNexecEmailFlag2Y := IF(ResultsFound, RIGHT.BE_AssocNexecEmailFlag2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_AssocAgeAvg2Y := IF(ResultsFound, RIGHT.BE_AssocAgeAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecAgeAvg2Y := IF(ResultsFound, RIGHT.BE_AssocExecAgeAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecAgeAvg2Y := IF(ResultsFound, RIGHT.BE_AssocNexecAgeAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocWEduCollCnt2Y := IF(ResultsFound, RIGHT.BE_AssocWEduCollCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecWEduCollCnt2Y := IF(ResultsFound, RIGHT.BE_AssocExecWEduCollCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecWEduCollCnt2Y := IF(ResultsFound, RIGHT.BE_AssocNexecWEduCollCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocWDrgCrimFelCnt2Y := IF(ResultsFound, RIGHT.BE_AssocWDrgCrimFelCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecWDrgCrimFelCnt2Y := IF(ResultsFound, RIGHT.BE_AssocExecWDrgCrimFelCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecWDrgCrimFelCnt2Y := IF(ResultsFound, RIGHT.BE_AssocNexecWDrgCrimFelCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocWDrgCrimCnt2Y := IF(ResultsFound, RIGHT.BE_AssocWDrgCrimCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecWDrgCrimCnt2Y := IF(ResultsFound, RIGHT.BE_AssocExecWDrgCrimCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecWDrgCrimCnt2Y := IF(ResultsFound, RIGHT.BE_AssocNexecWDrgCrimCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocWDrgBkCnt2Y := IF(ResultsFound, RIGHT.BE_AssocWDrgBkCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecWDrgBkCnt2Y := IF(ResultsFound, RIGHT.BE_AssocExecWDrgBkCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecWDrgBkCnt2Y := IF(ResultsFound, RIGHT.BE_AssocNexecWDrgBkCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocEmrgMsncAvg2Y := IF(ResultsFound, RIGHT.BE_AssocEmrgMsncAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecEmrgMsncAvg2Y := IF(ResultsFound, RIGHT.BE_AssocExecEmrgMsncAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecEmrgMsncAvg2Y := IF(ResultsFound, RIGHT.BE_AssocNexecEmrgMsncAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecFemaleCnt2Y := IF(ResultsFound, RIGHT.BE_AssocExecFemaleCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecFemalePct2Y := IF(ResultsFound, RIGHT.BE_AssocExecFemalePct2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecRelatedCnt2Y := IF(ResultsFound, RIGHT.BE_AssocExecRelatedCnt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecRelatedPct2Y := IF(ResultsFound, RIGHT.BE_AssocExecRelatedPct2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);            		
			SELF.BE_AssocWDrgJudgCnt2Y := IF(ResultsFound, RIGHT.BE_AssocWDrgJudgCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecWDrgJudgCnt2Y := IF(ResultsFound, RIGHT.BE_AssocExecWDrgJudgCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecWDrgJudgCnt2Y := IF(ResultsFound, RIGHT.BE_AssocNexecWDrgJudgCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocWDrgLTDCnt2Y := IF(ResultsFound, RIGHT.BE_AssocWDrgLTDCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecWDrgLTDCnt2Y := IF(ResultsFound, RIGHT.BE_AssocExecWDrgLTDCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecWDrgLTDCnt2Y := IF(ResultsFound, RIGHT.BE_AssocNexecWDrgLTDCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocWDrgLienCnt2Y := IF(ResultsFound, RIGHT.BE_AssocWDrgLienCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecWDrgLienCnt2Y := IF(ResultsFound, RIGHT.BE_AssocExecWDrgLienCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecWDrgLienCnt2Y := IF(ResultsFound, RIGHT.BE_AssocNexecWDrgLienCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);        		
			SELF.BE_AssocWDrgCnt2Y := IF(ResultsFound, RIGHT.BE_AssocWDrgCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecWDrgCnt2Y := IF(ResultsFound, RIGHT.BE_AssocExecWDrgCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecWDrgCnt2Y := IF(ResultsFound, RIGHT.BE_AssocNexecWDrgCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocBusCntAvg2Y := IF(ResultsFound, RIGHT.BE_AssocBusCntAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocExecBusCntAvg2Y := IF(ResultsFound, RIGHT.BE_AssocExecBusCntAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_AssocNexecBusCntAvg2Y := IF(ResultsFound, RIGHT.BE_AssocNexecBusCntAvg2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);  
			
			//BestAddress
			SELF.BE_BestAddrSeenFlag := IF(ResultsFound, (STRING)RIGHT.BE_BestAddrSeenFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);	
			SELF.BE_BestAddrSrcListEv := IF(ResultsFound, RIGHT.BE_BestAddrSrcListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrSrcCntEv := IF(ResultsFound, RIGHT.BE_BestAddrSrcCntEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.BE_BestAddrSrcEmrgDtListEv := IF(ResultsFound, RIGHT.BE_BestAddrSrcEmrgDtListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);	
			SELF.BE_BestAddrSrcLastDtListEv := IF(ResultsFound, RIGHT.BE_BestAddrSrcLastDtListEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);	
			SELF.BE_BestAddrSrcOldDtEv := IF(ResultsFound, RIGHT.BE_BestAddrSrcOldDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);	
			SELF.BE_BestAddrSrcNewDtEv := IF(ResultsFound, RIGHT.BE_BestAddrSrcNewDtEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);	
			SELF.BE_BestAddrSrcOldMsncEv := IF(ResultsFound, (INTEGER)RIGHT.BE_BestAddrSrcOldMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);	
			SELF.BE_BestAddrSrcNewMsncEv := IF(ResultsFound, (INTEGER)RIGHT.BE_BestAddrSrcNewMsncEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_BestAddrIsResidentialFlag := IF(ResultsFound, (STRING)RIGHT.BE_BestAddrIsResidentialFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BusIsResidentialFlag := IF(ResultsFound, (STRING)RIGHT.BE_BusIsResidentialFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrBldgIsMultiUnitFlag := IF(ResultsFound, (STRING)RIGHT.BE_BestAddrBldgIsMultiUnitFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrBldgType := IF(ResultsFound, (STRING)RIGHT.BE_BestAddrBldgType, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrIsPOBoxFlag := IF(ResultsFound, (STRING)RIGHT.BE_BestAddrIsPOBoxFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrIsVacantFlag := IF(ResultsFound, (STRING)RIGHT.BE_BestAddrIsVacantFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrIsOwnedFlag := IF(ResultsFound, (STRING)RIGHT.BE_BestAddrIsOwnedFlag, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrNewMktValEv := IF(ResultsFound, (INTEGER)RIGHT.BE_BestAddrNewMktValEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_BestAddrNewTaxValEv := IF(ResultsFound, (INTEGER)RIGHT.BE_BestAddrNewTaxValEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_BestAddrNewMktValYrEv := IF(ResultsFound, (STRING)RIGHT.BE_BestAddrNewMktValYrEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrNewTaxValYrEv := IF(ResultsFound, (STRING)RIGHT.BE_BestAddrNewTaxValYrEv, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.BE_BestAddrLotSize := IF(ResultsFound, (INTEGER)RIGHT.BE_BestAddrLotSize, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.BE_BestAddrBldgSize := IF(ResultsFound, (INTEGER)RIGHT.BE_BestAddrBldgSize, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			
			SELF := LEFT,
			SELF := [];
		),LEFT OUTER, KEEP(1));

	BusinessAttributesNoDatesWithSeleID := IF(Options.OutputMasterResults,
		JOIN(BusinessAttributesWithSeleID, BusinessSeleIDNoDatesAttributesRaw, LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID, 
			TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutBusinessSeleID,
				ResultsFound := RIGHT.B_LexIDLegal > 0;
				// If we didn't find any records when searching without an archive date, then the SeleID only exists on restricted sources, and we set B_LexIDLegalRstdOnlyFlag to 1.
				SELF.B_LexIDLegalRstdOnlyFlag := IF(ResultsFound, RIGHT.B_LexIDLegalRstdOnlyFlag, '1'); 
				SELF := LEFT;
			),LEFT OUTER, KEEP(1)),
		BusinessAttributesWithSeleID);
	
	// Assign special values to records with no SeleID
	BusinessAttributesWithoutSeleID := PROJECT(RecordsWithoutSeleID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutBusinessSeleID,
			// Attributes from NonFCRABusinessSeleIDAttributesV1 KEL query
			SELF.B_LexIDLegalSeenFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerSrcEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcLastDtListEv :=  PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcOldDtEv :=  PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcNewDtEv :=  PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcOldMsncEv :=  PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerSrcNewMsncEv :=  PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerSrcRptNewBusFlag :=  PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcCredCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerSrcBureauFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcBureauOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerSrcBureauOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DBANameCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AddrPOBoxFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_URLFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;			
			SELF.BE_VerNameFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerNameSrcListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerNameSrcCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerNameSrcEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerNameSrcLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerNameSrcOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerNameSrcNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerNameSrcOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerNameSrcNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerAddrFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerAddrSrcListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerAddrSrcCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerAddrSrcEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerAddrSrcLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerAddrSrcOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerAddrSrcNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerAddrSrcOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerAddrSrcNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerAddrSrcDtSpanEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerTINFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerTINSrcListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerTINSrcCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerTINSrcEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerTINSrcLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerTINSrcOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerTINSrcNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerTINSrcOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerTINSrcNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerPhoneFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerPhoneSrcListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerPhoneSrcCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerPhoneSrcEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerPhoneSrcLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerPhoneSrcOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerPhoneSrcNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_VerPhoneSrcOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_VerPhoneSrcNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			//Tradeline Attributes No ID
			SELF.BE_B2BCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BCarrCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BFltCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BMatCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOpsCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOthCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BCarrPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BFltPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BMatPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOpsPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOthPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;	
			SELF.BE_B2BOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOldDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BNewDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BOldMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BNewMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvCarrCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvFltCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvMatCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOpsCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOthCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvCarrPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvFltPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvMatPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOpsPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOthPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;	
			SELF.BE_B2BActvCntA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvCarrCntA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvFltCntA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvMatCntA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOpsCntA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOthCntA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvCntGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvCarrCntGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvFltCntGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvMatCntGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOpsCntGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOthCntGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvCarrBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvFltBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvMatBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOpsBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOthBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvCarrBalTotPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvFltBalPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvMatBalPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOpsBalPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOthBalPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvCarrBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvFltBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvMatBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvOpsBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvOthBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvBalAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvCarrBalAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvFltBalAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvMatBalAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOpsBalAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOthBalAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvCarrBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvFltBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvMatBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOpsBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOthBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvCarrBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvFltBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvMatBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOpsBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvOthBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActvBalTotGrowIndx1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvCarrBalTotGrowIndx1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvFltBalTotGrowIndx1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvMatBalTotGrowIndx1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvOpsBalTotGrowIndx1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvOthBalTotGrowIndx1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BBalMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BCarrBalMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BFltBalMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BMatBalMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOpsBalMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOthBalMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BBalMaxDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BCarrBalMaxDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BFltBalMaxDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BMatBalMaxDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BOpsBalMaxDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BOthBalMaxDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BBalMaxMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BCarrBalMaxMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BFltBalMaxMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BMatBalMaxMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOpsBalMaxMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOthBalMaxMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BBalMaxSegType2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvWorstPerfIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvCarrWorstPerfIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvFltWorstPerfIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvMatWorstPerfIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvOpsWorstPerfIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActvOthWorstPerfIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BActv1pDpdCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv31pDpdCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv61pDpdCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv91pDpdCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv1pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv31pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv61pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv91pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv1pDpdBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv31pDpdBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv61pDpdBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv91pDpdBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv1pDpdBalTotPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv31pDpdBalTotPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv61pDpdBalTotPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv91pDpdBalTotPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv1pDpdBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv31pDpdBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv61pDpdBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv91pDpdBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv1pDpdBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv31pDpdBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv61pDpdBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BActv91pDpdBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BWorstPerfIndx2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BCarrWorstPerfIndx2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BFltWorstPerfIndx2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BMatWorstPerfIndx2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BOpsWorstPerfIndx2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BOthWorstPerfIndx2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BWorstPerfDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BCarrWorstPerfDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BFltWorstPerfDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BMatWorstPerfDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BOpsWorstPerfDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BOthWorstPerfDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BWorstPerfMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BCarrWorstPerfMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BFltWorstPerfMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BMatWorstPerfMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOpsWorstPerfMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOthWorstPerfMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BCnt24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BCarrCnt24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BFltCnt24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BMatCnt24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOpsCnt24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOthCnt24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BRecFlagByMonStr24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BCarrRecFlagByMonStr24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BFltRecFlagByMonStr24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BMatRecFlagByMonStr24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BOpsRecFlagByMonStr24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BOthRecFlagByMonStr24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_B2BRecFlagByMonSum24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BCarrRecFlagByMonSum24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BFltRecFlagByMonSum24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BMatRecFlagByMonSum24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOpsRecFlagByMonSum24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOthRecFlagByMonSum24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BBalVol24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BCarrBalVol24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BFltBalVol24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BMatBalVol24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOpsBalVol24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_B2BOthBalVol24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			// Asset Vehicle			
			SELF.BE_AstVehAirCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehWtrCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehAutoCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehAutoCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehAutoPersCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehAutoCommCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehAutoOtherCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehAutoValTot2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehAutoEmrgNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AstVehAutoEmrgNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			// Asset Property		
			SELF.BE_AstPropCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropStateCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropCurrCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropCurrStateCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_AstPropOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_AstPropNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropCurrTaxValTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropCurrMktValTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropCurrValTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropCurrLotSizeTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropCurrBldgSizeTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AstPropIndxEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;            		
			// Bankruptcy
			SELF.BE_DrgBkCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkOldDt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgBkOldMsnc10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkNewDt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgBkNewMsnc10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkUpdtNewDt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgBkUpdtNewMsnc10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkDispCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkDschCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkDsmsCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkNewDispType10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgBkCh7Cnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkCh11Cnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkCh13Cnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgBkNewChType10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			//SOS Build Date//			
			SELF.BE_SOSCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_SOSNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_SOSOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_SOSNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_SOSOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_SOSStateCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_SOSDomCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_SOSDomNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_SOSDomOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_SOSDomNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_SOSDomOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_SOSFrgnCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_SOSFrgnNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_SOSFrgnOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_SOSFrgnNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_SOSFrgnOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_SOSDomStatusIndxEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			//best bii sele
			SELF.BE_BestName := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			// SELF.BE_BestAddrLocID := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_BestAddrSt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrCity := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrCityPost := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrState := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrZip := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestTIN := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestPhone := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			//LeinJudgment Build Date//			
			SELF.BE_DrgGovDebarredFlagEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLTDCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLTDCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLTDAmtTot7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLTDAmtAvg7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLTDNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLTDOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLTDNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLTDOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			//UCC Attributes	
			SELF.BE_UCCCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_UCCDebtorOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_UCCDebtorNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCActvCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorActvCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorTermCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorOtherCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorActvPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorTermPctEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorOtherPctEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCDebtorTermNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_UCCDebtorTermNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCCreditorCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_UCCRoleIndxEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_UCCActvRoleIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			//Overall Liens
			SELF.BE_DrgLienCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienAmtTot7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienAmtAvg7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxAmtTot7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienTaxOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienTaxNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxFedCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxFedAmtTot7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxFedOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienTaxFedOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxFedNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienTaxFedNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxStateCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxStateAmtTot7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxStateOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienTaxStateOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxStateNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienTaxStateNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxOtherCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxOtherAmtTot7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxOtherOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienTaxOtherOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienTaxOtherNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienTaxOtherNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienOtherCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienOtherAmtTot7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienOtherNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienOtherOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienOtherNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLienOtherOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			//OverAll Judgment
			SELF.BE_DrgJudgCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgAmtTot7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgAmtAvg7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgJudgOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgJudgNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgCivCrtCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgCivCrtAmtTot7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgCivCrtOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgJudgCivCrtOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgCivCrtNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgJudgCivCrtNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgSmClaimCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgSmClaimAmtTot7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgSmClaimOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgJudgSmClaimOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgSmClaimNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgJudgSmClaimNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgFrclCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgFrclAmtTot7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgFrclOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgJudgFrclOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgJudgFrclNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgJudgFrclNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			//OverAll LienJudgment Attributes
			SELF.BE_DrgLnJCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLnJCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLnJAmtTot7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLnJAmtAvg7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLnJNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLnJOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLnJNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgLnJOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			//Suits Attributes
			SELF.BE_DrgSuitCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgSuitAmtTot7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgSuitOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgSuitOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgSuitNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgSuitNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			//LienJudgment Type Attributes
			SELF.BE_DrgJudgNewType7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgLienNewType7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			//Business OverAll Drg Attributes
			SELF.BE_DrgCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgFlag7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgNewDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgNewMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_DrgOldDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_DrgOldMsnc7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			// Attribute from NonFCRABusinessSeleIDNoDatesAttributesV1 KEL query
			SELF.B_LexIDLegalRstdOnlyFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			//Firmographics
			SELF.BE_BusSICCode1 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BusSICCode1Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode1GroupDesc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode2 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode2Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode2GroupDesc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode3 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode3Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode3GroupDesc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode4 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode4Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusSICCode4GroupDesc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusNAICSCode1 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusNAICSCode1Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusNAICSCode1GroupDesc :=PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusNAICSCode2 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusNAICSCode2Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusNAICSCode2GroupDesc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusNAICSCode3 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusNAICSCode3Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BusNAICSCode3GroupDesc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BusNAICSCode4 := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BusNAICSCode4Desc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BusNAICSCode4GroupDesc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusEmplCountCurr := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;    		
			SELF.BE_BusEmplCountCurrRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;    		
			SELF.BE_BusAnnualSalesCurr := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;    		
			SELF.BE_BusAnnualSalesCurrRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;    		
			//Flag Attributes		
			SELF.BE_BusIsNonProfitFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			SELF.BE_BusIsFranchiseFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			SELF.BE_BusOffers401kFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			SELF.BE_BusHasNewLocationFlag1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 		
			SELF.BE_BusLocActvCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT; 		
			SELF.BE_BusIsSBEFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			//Ownership Attributes		
			SELF.BE_BusInferFemaleOwnedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_BusInferFamilyOwnedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_BusIsFemaleOwnedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_BusIsMinorityOwnedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		
			SELF.BE_BusIsPublicFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;			
			//assoc attributes
			SELF.BE_AssocCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocExecCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocExecCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocExecPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocNexecCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocNexecCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocNexecPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_AssocEmailFlag2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_AssocExecEmailFlag2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_AssocNexecEmailFlag2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_AssocAgeAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecAgeAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecAgeAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocWEduCollCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecWEduCollCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecWEduCollCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocWDrgCrimFelCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecWDrgCrimFelCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecWDrgCrimFelCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocWDrgCrimCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecWDrgCrimCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecWDrgCrimCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocWDrgBkCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecWDrgBkCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecWDrgBkCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocEmrgMsncAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecEmrgMsncAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecEmrgMsncAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecFemaleCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecFemalePct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecRelatedCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecRelatedPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;            		
			SELF.BE_AssocWDrgJudgCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecWDrgJudgCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecWDrgJudgCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocWDrgLTDCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecWDrgLTDCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecWDrgLTDCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocWDrgLienCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecWDrgLienCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecWDrgLienCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;        		
			SELF.BE_AssocWDrgCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecWDrgCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecWDrgCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocBusCntAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocExecBusCntAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
			SELF.BE_AssocNexecBusCntAvg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;			
			
			//BestAddress
			SELF.BE_BestAddrSeenFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BestAddrSrcListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BestAddrSrcCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT; 
			SELF.BE_BestAddrSrcEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BestAddrSrcLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BestAddrSrcOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BestAddrSrcNewDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.BE_BestAddrSrcOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT; 
			SELF.BE_BestAddrSrcNewMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT; 
			SELF.BE_BestAddrIsResidentialFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BusIsResidentialFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrBldgIsMultiUnitFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrBldgType := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrIsPOBoxFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrIsVacantFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrIsOwnedFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrNewMktValEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_BestAddrNewTaxValEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT; 
			SELF.BE_BestAddrNewMktValYrEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrNewTaxValYrEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BE_BestAddrLotSize := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BE_BestAddrBldgSize := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF := LEFT));
			
	BusinessSeleIDAttributes := SORT(BusinessAttributesNoDatesWithSeleID + BusinessAttributesWithoutSeleID, G_ProcBusUID);
	
	RETURN BusinessSeleIDAttributes;
END;	

