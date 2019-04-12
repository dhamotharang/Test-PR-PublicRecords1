IMPORT $.^.Risk_Indicators;
IMPORT KEL011 AS KEL;
EXPORT FnRoxie_GetBusinessSeleIDAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

	Common_Functions := PublicRecords_KEL.ECL_Functions.Common_Functions;

	RecordsWithSeleID := InputData(LexIDBusLegalEntityAppend > 0);
	RecordsWithoutSeleID := InputData(LexIDBusLegalEntityAppend <= 0);

	LayoutBusinessSeleIDAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1(0,0,0,0,0).res0);
	LayoutBusinessSeleIDNoDatesAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_No_Dates_Attributes_V1(0,0,0,0).res0);
	
	BusinessSeleIDAttributesRaw := KEL.Clean(PROJECT(RecordsWithSeleID, TRANSFORM({INTEGER BusInputUIDAppend, LayoutBusinessSeleIDAttributes},
		SELF.BusInputUIDAppend := LEFT.BusInputUIDAppend;
		NonFCRABusinessSeleIDResults := PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1(
				LEFT.LexIDBusExtendedFamilyAppend,
				LEFT.LexIDBusLegalFamilyAppend,
				LEFT.LexIDBusLegalEntityAppend,
				(INTEGER)LEFT.BusInputArchiveDateClean[1..8],
				Options.KEL_Permissions_Mask, 
				FDCDataset).res0;
		SELF := NonFCRABusinessSeleIDResults[1])), TRUE, TRUE, TRUE);

	BusinessSeleIDNoDatesAttributesRaw := KEL.Clean(IF(Options.OutputMasterResults,
		PROJECT(RecordsWithSeleID, TRANSFORM({INTEGER BusInputUIDAppend, LayoutBusinessSeleIDNoDatesAttributes},
			SELF.BusInputUIDAppend := LEFT.BusInputUIDAppend;
			NonFCRABusinessSeleIDResults := PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_No_Dates_Attributes_V1(
				LEFT.LexIDBusExtendedFamilyAppend,
				LEFT.LexIDBusLegalFamilyAppend,
				LEFT.LexIDBusLegalEntityAppend,
				Options.KEL_Permissions_Mask, 
				FDCDataset).res0;
			SELF := NonFCRABusinessSeleIDResults[1])),
		DATASET([],{INTEGER BusInputUIDAppend, LayoutBusinessSeleIDNoDatesAttributes})), TRUE, TRUE, TRUE);
	
	BusinessAttributesWithSeleID := JOIN(RecordsWithSeleID, BusinessSeleIDAttributesRaw, LEFT.BusInputUIDAppend = RIGHT.BusInputUIDAppend, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutBusinessSeleID,
			ResultsFound := RIGHT.LexIDBusLegalEntityAppend > 0 AND RIGHT.LexIDBusLegalEntitySeen = '1';
			SELF.BusHeaderHistoryBuild := Risk_Indicators.get_build_date('bip_build_version');
			SELF.LexIDBusLegalEntitySeen := IF(ResultsFound, RIGHT.LexIDBusLegalEntitySeen, '0');
			SrcVerBusLegalEntityList_Sorted := SORT(RIGHT.SrcVerBusLegalEntityList, SourceDateFirstSeen = 0, SourceDateFirstSeen, SourceDateLastSeen = 0, SourceDateLastSeen, TranslatedSourceCode);
			SELF.SrcVerBusLegalEntityList := IF(ResultsFound, PublicRecords_KEL.ECL_Functions.Common_Functions.roll_list(SrcVerBusLegalEntityList_Sorted, TranslatedSourceCode, '|'), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.OldestDtSrcVerBusLegalEntityList := IF(ResultsFound, PublicRecords_KEL.ECL_Functions.Common_Functions.roll_list(SrcVerBusLegalEntityList_Sorted, SourceDateFirstSeen, '|'), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.NewestDtSrcVerBusLegalEntityList := IF(ResultsFound, PublicRecords_KEL.ECL_Functions.Common_Functions.roll_list(SrcVerBusLegalEntityList_Sorted, SourceDateLastSeen, '|'), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			//Tradeline Attributes		
			SELF.B2bHistoryBuild := Risk_Indicators.get_Build_date('cortera_build_version');
			SELF.B2bTLCntEv := IF(ResultsFound, RIGHT.B2bTLCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bTLCnt2Y := IF(ResultsFound, RIGHT.B2bTLCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bTLInCarrCnt2Y := IF(ResultsFound, RIGHT.B2bTLInCarrCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bTLInFltCnt2Y := IF(ResultsFound, RIGHT.B2bTLInFltCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bTLInMatCnt2Y := IF(ResultsFound, RIGHT.B2bTLInMatCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bTLInOpsCnt2Y := IF(ResultsFound, RIGHT.B2bTLInOpsCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bTLInOthCnt2Y := IF(ResultsFound, RIGHT.B2bTLInOthCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bTLInCarrPct2Y := IF(ResultsFound, ROUND(RIGHT.B2bTLInCarrPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bTLInFltPct2Y := IF(ResultsFound, ROUND(RIGHT.B2bTLInFltPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bTLInMatPct2Y := IF(ResultsFound, ROUND(RIGHT.B2bTLInMatPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bTLInOpsPct2Y := IF(ResultsFound, ROUND(RIGHT.B2bTLInOpsPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bTLInOthPct2Y := IF(ResultsFound, ROUND(RIGHT.B2bTLInOthPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bOldestTLDtEv := IF(ResultsFound,(STRING)RIGHT.B2bOldestTLDtEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.B2bOldestTLMsinceEv := IF(ResultsFound,RIGHT.B2bOldestTLMsinceEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bOldestTLDt2Y := IF(ResultsFound,RIGHT.B2bOldestTLDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.B2bNewestTLDt2Y := IF(ResultsFound,RIGHT.B2bNewestTLDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.B2bOldestTLMsince2Y := IF(ResultsFound,RIGHT.B2bOldestTLMsince2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bNewestTLMsince2Y := IF(ResultsFound,RIGHT.B2bNewestTLMsince2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLCnt := IF(ResultsFound, RIGHT.B2bActvTLCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLInCarrCnt := IF(ResultsFound, RIGHT.B2bActvTLInCarrCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLInFltCnt := IF(ResultsFound, RIGHT.B2bActvTLInFltCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLInMatCnt := IF(ResultsFound, RIGHT.B2bActvTLInMatCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLInOpsCnt := IF(ResultsFound, RIGHT.B2bActvTLInOpsCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLInOthCnt := IF(ResultsFound, RIGHT.B2bActvTLInOthCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLInCarrPct := IF(ResultsFound, ROUND(RIGHT.B2bActvTLInCarrPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLInFltPct := IF(ResultsFound, ROUND(RIGHT.B2bActvTLInFltPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLInMatPct := IF(ResultsFound, ROUND(RIGHT.B2bActvTLInMatPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLInOpsPct := IF(ResultsFound, ROUND(RIGHT.B2bActvTLInOpsPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLInOthPct := IF(ResultsFound, ROUND(RIGHT.B2bActvTLInOthPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.B2bActvTLCntArch1Y := IF(ResultsFound, RIGHT.B2bActvTLCntArch1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);	
			SELF.B2bActvTLInCarrCntArch1Y := IF(ResultsFound, RIGHT.B2bActvTLInCarrCntArch1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);	
			SELF.B2bActvTLInFltCntArch1Y := IF(ResultsFound, RIGHT.B2bActvTLInFltCntArch1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);	
			SELF.B2bActvTLInMatCntArch1Y := IF(ResultsFound, RIGHT.B2bActvTLInMatCntArch1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);	
			SELF.B2bActvTLInOpsCntArch1Y := IF(ResultsFound, RIGHT.B2bActvTLInOpsCntArch1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);	
			SELF.B2bActvTLInOthCntArch1Y := IF(ResultsFound, RIGHT.B2bActvTLInOthCntArch1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);	
			SELF.B2bActvTLCntGrow1Y := IF(ResultsFound, ROUND(RIGHT.B2bActvTLCntGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.B2bActvTLCntInCarrGrow1Y := IF(ResultsFound, ROUND(RIGHT.B2bActvTLCntInCarrGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.B2bActvTLCntInFltGrow1Y := IF(ResultsFound, ROUND(RIGHT.B2bActvTLCntInFltGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.B2bActvTLCntInMatGrow1Y := IF(ResultsFound, ROUND(RIGHT.B2bActvTLCntInMatGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.B2bActvTLCntInOpsGrow1Y := IF(ResultsFound, ROUND(RIGHT.B2bActvTLCntInOpsGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.B2bActvTLCntInOthGrow1Y := IF(ResultsFound, ROUND(RIGHT.B2bActvTLCntInOthGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);		
			SELF.B2bActvTLBalTot := IF(ResultsFound,RIGHT.B2bActvTLBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLBalInCarrTot := IF(ResultsFound,RIGHT.B2bActvTLBalInCarrTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLBalInFltTot := IF(ResultsFound,RIGHT.B2bActvTLBalInFltTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLBalInMatTot := IF(ResultsFound,RIGHT.B2bActvTLBalInMatTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLBalInOpsTot := IF(ResultsFound,RIGHT.B2bActvTLBalInOpsTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLBalInOthTot := IF(ResultsFound,RIGHT.B2bActvTLBalInOthTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLBalInCarrPct := IF(ResultsFound,ROUND(RIGHT.B2bActvTLBalInCarrPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLBalInFltPct := IF(ResultsFound,ROUND(RIGHT.B2bActvTLBalInFltPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLBalInMatPct := IF(ResultsFound,ROUND(RIGHT.B2bActvTLBalInMatPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLBalInOpsPct := IF(ResultsFound,ROUND(RIGHT.B2bActvTLBalInOpsPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.B2bActvTLBalInOthPct := IF(ResultsFound,ROUND(RIGHT.B2bActvTLBalInOthPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
//SELF.B2bActvTLBalTotBin := RIGHT.B2bActvTLBalTotBin
//SELF.B2bActvTLBalInCarrTotBin := RIGHT.B2bActvTLBalInCarrTotBin
//SELF.B2bActvTLBalInFltTotBin := RIGHT.B2bActvTLBalInFltTotBin
//SELF.B2bActvTLBalInMatTotBin := RIGHT.B2bActvTLBalInMatTotBin
//SELF.B2bActvTLBalInOpsTotBin := RIGHT.B2bActvTLBalInOpsTotBin
//SELF.B2bActvTLBalInOthTotBin := RIGHT.B2bActvTLBalInOthTotBin
//SELF.B2bActvTLBalAvg := RIGHT.B2bActvTLBalAvg
//SELF.B2bActvTLBalInCarrAvg := RIGHT.B2bActvTLBalInCarrAvg
//SELF.B2bActvTLBalInFltAvg := RIGHT.B2bActvTLBalInFltAvg
//SELF.B2bActvTLBalInMatAvg := RIGHT.B2bActvTLBalInMatAvg
//SELF.B2bActvTLBalInOpsAvg := RIGHT.B2bActvTLBalInOpsAvg
//SELF.B2bActvTLBalInOthAvg := RIGHT.B2bActvTLBalInOthAvg
//SELF.B2bActvTLBalArch1Y := RIGHT.B2bActvTLBalArch1Y
//SELF.B2bActvTLBalInCarrArch1Y := RIGHT.B2bActvTLBalInCarrArch1Y
//SELF.B2bActvTLBalInFltArch1Y := RIGHT.B2bActvTLBalInFltArch1Y
//SELF.B2bActvTLBalInMatArch1Y := RIGHT.B2bActvTLBalInMatArch1Y
//SELF.B2bActvTLBalInOpsArch1Y := RIGHT.B2bActvTLBalInOpsArch1Y
//SELF.B2bActvTLBalInOthArch1Y := RIGHT.B2bActvTLBalInOthArch1Y
//SELF.B2bActvTLBalGrow1Y := RIGHT.B2bActvTLBalGrow1Y
//SELF.B2bActvTLBalInCarrGrow1Y := RIGHT.B2bActvTLBalInCarrGrow1Y
//SELF.B2bActvTLBalInFltGrow1Y := RIGHT.B2bActvTLBalInFltGrow1Y
//SELF.B2bActvTLBalInMatGrow1Y := RIGHT.B2bActvTLBalInMatGrow1Y
//SELF.B2bActvTLBalInOpsGrow1Y := RIGHT.B2bActvTLBalInOpsGrow1Y
//SELF.B2bActvTLBalInOthGrow1Y := RIGHT.B2bActvTLBalInOthGrow1Y
//SELF.tvTLBalGrowIndex1Y := RIGHT.tvTLBalGrowIndex1Y
//SELF.B2bActvTLBalInCarrGrowIndex1Y := RIGHT.B2bActvTLBalInCarrGrowIndex1Y
//SELF.B2bActvTLBalInFltGrowIndex1Y := RIGHT.B2bActvTLBalInFltGrowIndex1Y
//SELF.B2bActvTLBalInMatGrowIndex1Y := RIGHT.B2bActvTLBalInMatGrowIndex1Y
//SELF.B2bActvTLBalInOpsGrowIndex1Y := RIGHT.B2bActvTLBalInOpsGrowIndex1Y
//SELF.B2bActvTLBalInOthGrowIndex1Y := RIGHT.B2bActvTLBalInOthGrowIndex1Y
//SELF.B2bTLBalMax2Y := RIGHT.B2bTLBalMax2Y
//SELF.B2bTLBalInCarrMax2Y := RIGHT.B2bTLBalInCarrMax2Y
//SELF.B2bTLBalInFltMax2Y := RIGHT.B2bTLBalInFltMax2Y
//SELF.B2bTLBalInMatMax2Y := RIGHT.B2bTLBalInMatMax2Y
//SELF.B2bTLBalInOpsMax2Y := RIGHT.B2bTLBalInOpsMax2Y
//SELF.B2bTLBalInOthMax2Y := RIGHT.B2bTLBalInOthMax2Y
//SELF.B2bMaxTLBalDt2Y := RIGHT.B2bMaxTLBalDt2Y
//SELF.B2bMaxTLBalInCarrDt2Y := RIGHT.B2bMaxTLBalInCarrDt2Y
//SELF.B2bMaxTLBalInFltDt2Y := RIGHT.B2bMaxTLBalInFltDt2Y
//SELF.B2bMaxTLBalInMatDt2Y := RIGHT.B2bMaxTLBalInMatDt2Y
//SELF.B2bMaxTLBalInOpsDt2Y := RIGHT.B2bMaxTLBalInOpsDt2Y
//SELF.B2bMaxTLBalInOthDt2Y := RIGHT.B2bMaxTLBalInOthDt2Y
//SELF.B2bMaxTLBalMsince2Y := RIGHT.B2bMaxTLBalMsince2Y
//SELF.B2bMaxTLBalInCarrMsince2Y := RIGHT.B2bMaxTLBalInCarrMsince2Y
//SELF.B2bMaxTLBalInFltMsince2Y := RIGHT.B2bMaxTLBalInFltMsince2Y
//SELF.B2bMaxTLBalInMatMsince2Y := RIGHT.B2bMaxTLBalInMatMsince2Y
//SELF.B2bMaxTLBalInOpsMsince2Y := RIGHT.B2bMaxTLBalInOpsMsince2Y
//SELF.B2bMaxTLBalInOthMsince2Y := RIGHT.B2bMaxTLBalInOthMsince2Y
//SELF.B2bTLWMaxBalSeg2Y := RIGHT.B2bTLWMaxBalSeg2Y
//SELF.B2bActvTLWorstPerfIndex := RIGHT.B2bActvTLWorstPerfIndex
//SELF.B2bActvTLWorstPerfInCarrIndex := RIGHT.B2bActvTLWorstPerfInCarrIndex
//SELF.B2bActvTLWorstPerfInFltIndex := RIGHT.B2bActvTLWorstPerfInFltIndex
//SELF.B2bActvTLWorstPerfInMatIndex := RIGHT.B2bActvTLWorstPerfInMatIndex
//SELF.B2bActvTLWorstPerfInOpsIndex := RIGHT.B2bActvTLWorstPerfInOpsIndex
//SELF.B2bActvTLWorstPerfInOthIndex := RIGHT.B2bActvTLWorstPerfInOthIndex
//SELF.B2bActvTLW1pDpdCnt := RIGHT.B2bActvTLW1pDpdCnt
//SELF.B2bActvTLW31pDpdCnt := RIGHT.B2bActvTLW31pDpdCnt
//SELF.B2bActvTLW61pDpdCnt := RIGHT.B2bActvTLW61pDpdCnt
//SELF.B2bActvTLW91pDpdCnt := RIGHT.B2bActvTLW91pDpdCnt
//SELF.B2bActvTLW1pDpdPct := RIGHT.B2bActvTLW1pDpdPct
//SELF.B2bActvTLW31pDpdPct := RIGHT.B2bActvTLW31pDpdPct
//SELF.B2bActvTLW61pDpdPct := RIGHT.B2bActvTLW61pDpdPct
//SELF.B2bActvTLW91pDpdPct := RIGHT.B2bActvTLW91pDpdPct
//SELF.B2bBalOnActvTL1pDpdTot := RIGHT.B2bBalOnActvTL1pDpdTot
//SELF.B2bBalOnActvTL31pDpdTot := RIGHT.B2bBalOnActvTL31pDpdTot
//SELF.B2bBalOnActvTL61pDpdTot := RIGHT.B2bBalOnActvTL61pDpdTot
//SELF.B2bBalOnActvTL91pDpdTot := RIGHT.B2bBalOnActvTL91pDpdTot
//SELF.B2bBalOnActvTL1pDpdPct := RIGHT.B2bBalOnActvTL1pDpdPct
//SELF.B2bBalOnActvTL31pDpdPct := RIGHT.B2bBalOnActvTL31pDpdPct
//SELF.B2bBalOnActvTL61pDpdPct := RIGHT.B2bBalOnActvTL61pDpdPct
//SELF.B2bBalOnActvTL91pDpdPct := RIGHT.B2bBalOnActvTL91pDpdPct
//SELF.B2bBalOnActvTL1pDpdTotArch1Y := RIGHT.B2bBalOnActvTL1pDpdTotArch1Y
//SELF.B2bBalOnActvTL31pDpdTotArch1Y := RIGHT.B2bBalOnActvTL31pDpdTotArch1Y
//SELF.B2bBalOnActvTL61pDpdTotArch1Y := RIGHT.B2bBalOnActvTL61pDpdTotArch1Y
//SELF.B2bBalOnActvTL91pDpdTotArch1Y := RIGHT.B2bBalOnActvTL91pDpdTotArch1Y
//SELF.B2bBalOnActvTL1pDpdGrow1Y := RIGHT.B2bBalOnActvTL1pDpdGrow1Y
//SELF.B2bBalOnActvTL31pDpdGrow1Y := RIGHT.B2bBalOnActvTL31pDpdGrow1Y
//SELF.B2bBalOnActvTL61pDpdGrow1Y := RIGHT.B2bBalOnActvTL61pDpdGrow1Y
//SELF.B2bBalOnActvTL91pDpdGrow1Y := RIGHT.B2bBalOnActvTL91pDpdGrow1Y
//SELF.B2bTLWorstPerfIndex2Y := RIGHT.B2bTLWorstPerfIndex2Y
//SELF.B2bTLWorstPerfInCarrIndex2Y := RIGHT.B2bTLWorstPerfInCarrIndex2Y
//SELF.B2bTLWorstPerfInFltIndex2Y := RIGHT.B2bTLWorstPerfInFltIndex2Y
//SELF.B2bTLWorstPerfInMatIndex2Y := RIGHT.B2bTLWorstPerfInMatIndex2Y
//SELF.B2bTLWorstPerfInOpsIndex2Y := RIGHT.B2bTLWorstPerfInOpsIndex2Y
//SELF.B2bTLWorstPerfInOthIndex2Y := RIGHT.B2bTLWorstPerfInOthIndex2Y
//SELF.B2bTLWorstPerfDt2Y := RIGHT.B2bTLWorstPerfDt2Y
//SELF.B2bTLWorstPerfInCarrDt2Y := RIGHT.B2bTLWorstPerfInCarrDt2Y
//SELF.B2bTLWorstPerfInFltDt2Y := RIGHT.B2bTLWorstPerfInFltDt2Y
//SELF.B2bTLWorstPerfInMatDt2Y := RIGHT.B2bTLWorstPerfInMatDt2Y
//SELF.B2bTLWorstPerfInOpsDt2Y := RIGHT.B2bTLWorstPerfInOpsDt2Y
//SELF.B2bTLWorstPerfInOthDt2Y := RIGHT.B2bTLWorstPerfInOthDt2Y
//SELF.B2bTLWorstPerfMsince2Y := RIGHT.B2bTLWorstPerfMsince2Y
//SELF.B2bTLWorstPerfInCarrMsince2Y := RIGHT.B2bTLWorstPerfInCarrMsince2Y
//SELF.B2bTLWorstPerfInFltMsince2Y := RIGHT.B2bTLWorstPerfInFltMsince2Y
//SELF.B2bTLWorstPerfInMatMsince2Y := RIGHT.B2bTLWorstPerfInMatMsince2Y
//SELF.B2bTLWorstPerfInOpsMsince2Y := RIGHT.B2bTLWorstPerfInOpsMsince2Y
//SELF.B2bTLWorstPerfInOthMsince2Y := RIGHT.B2bTLWorstPerfInOthMsince2Y
//SELF.B2bTLCnt24Mfull := RIGHT.B2bTLCnt24Mfull
//SELF.B2bTLInCarrCnt24Mfull := RIGHT.B2bTLInCarrCnt24Mfull
//SELF.B2bTLInFltCnt24Mfull := RIGHT.B2bTLInFltCnt24Mfull
//SELF.B2bTLInMatCnt24Mfull := RIGHT.B2bTLInMatCnt24Mfull
//SELF.B2bTLInOpsCnt24Mfull := RIGHT.B2bTLInOpsCnt24Mfull
//SELF.B2bTLInOthCnt24Mfull := RIGHT.B2bTLInOthCnt24Mfull
//SELF.B2bIndOfMonWTLStr24Mfull := RIGHT.B2bIndOfMonWTLStr24Mfull
//SELF.B2bIndOfMonWTLInCarrStr24Mfull := RIGHT.B2bIndOfMonWTLInCarrStr24Mfull
//SELF.B2bIndOfMonWTLInFltStr24Mfull := RIGHT.B2bIndOfMonWTLInFltStr24Mfull
//SELF.B2bIndOfMonWTLInMatStr24Mfull := RIGHT.B2bIndOfMonWTLInMatStr24Mfull
//SELF.B2bIndOfMonWTLInOpsStr24Mfull := RIGHT.B2bIndOfMonWTLInOpsStr24Mfull
//SELF.B2bIndOfMonWTLInOthStr24Mfull := RIGHT.B2bIndOfMonWTLInOthStr24Mfull
//SELF.B2bMonWTLCnt24Mfull := RIGHT.B2bMonWTLCnt24Mfull
//SELF.B2bMonWTLInCarrCnt24Mfull := RIGHT.B2bMonWTLInCarrCnt24Mfull
//SELF.B2bMonWTLInFltCnt24Mfull := RIGHT.B2bMonWTLInFltCnt24Mfull
//SELF.B2bMonWTLInMatCnt24Mfull := RIGHT.B2bMonWTLInMatCnt24Mfull
//SELF.B2bMonWTLInOpsCnt24Mfull := RIGHT.B2bMonWTLInOpsCnt24Mfull
//SELF.B2bMonWTLInOthCnt24Mfull := RIGHT.B2bMonWTLInOthCnt24Mfull
//SELF.B2bTLBalVol24Mfull := RIGHT.B2bTLBalVol24Mfull
//SELF.B2bTLBalInCarrVol24Mfull := RIGHT.B2bTLBalInCarrVol24Mfull
//SELF.B2bTLBalInFltVol24Mfull := RIGHT.B2bTLBalInFltVol24Mfull
//SELF.B2bTLBalInMatVol24Mfull := RIGHT.B2bTLBalInMatVol24Mfull
//SELF.B2bTLBalInOpsVol24Mfull := RIGHT.B2bTLBalInOpsVol24Mfull
//SELF.B2bTLBalInOthVol24Mfull := RIGHT.B2bTLBalInOthVol24Mfull		
			SELF := LEFT,
			SELF := [];
		),LEFT OUTER, KEEP(1));

	BusinessAttributesNoDatesWithSeleID := IF(Options.OutputMasterResults,
		JOIN(BusinessAttributesWithSeleID, BusinessSeleIDNoDatesAttributesRaw, LEFT.BusInputUIDAppend = RIGHT.BusInputUIDAppend, 
			TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutBusinessSeleID,
				ResultsFound := RIGHT.LexIDBusLegalEntityAppend > 0;
				// If we didn't find any records when searching without an archive date, then the SeleID only exists on restricted sources, and we set LexIDBusLegalEntityRestricted to 1.
				SELF.LexIDBusLegalEntityRestricted := IF(ResultsFound, RIGHT.LexIDBusLegalEntityRestricted, '1'); 
				SELF := LEFT;
			),LEFT OUTER, KEEP(1)),
		BusinessAttributesWithSeleID);
	
	// Assign special values to records with no SeleID
	BusinessAttributesWithoutSeleID := PROJECT(RecordsWithoutSeleID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutBusinessSeleID,
			// Attributes from NonFCRABusinessSeleIDAttributesV1 KEL query
			SELF.BusHeaderHistoryBuild := Risk_Indicators.get_build_date('bip_build_version');
			SELF.LexIDBusLegalEntitySeen := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.SrcVerBusLegalEntityList := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.OldestDtSrcVerBusLegalEntityList := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.NewestDtSrcVerBusLegalEntityList :=  PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			
			// Attribute from NonFCRABusinessSeleIDNoDatesAttributesV1 KEL query
			SELF.LexIDBusLegalEntityRestricted := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			//Tradeline Attributes No ID
			SELF.B2bHistoryBuild := Risk_Indicators.get_Build_date('cortera_build_version');
			SELF.B2bTLCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bTLCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bTLInCarrCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bTLInFltCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bTLInMatCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bTLInOpsCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bTLInOthCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bTLInCarrPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bTLInFltPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bTLInMatPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bTLInOpsPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bTLInOthPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;	
			SELF.B2bOldestTLDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.B2bOldestTLMsinceEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bOldestTLDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.B2bNewestTLDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.B2bOldestTLMsince2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bNewestTLMsince2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInCarrCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInFltCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInMatCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInOpsCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInOthCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInCarrPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInFltPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInMatPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInOpsPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInOthPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;	
			SELF.B2bActvTLCntArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInCarrCntArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInFltCntArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInMatCntArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInOpsCntArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLInOthCntArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLCntGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLCntInCarrGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLCntInFltGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLCntInMatGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLCntInOpsGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLCntInOthGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLBalInCarrTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLBalInFltTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLBalInMatTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLBalInOpsTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLBalInOthTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLBalInCarrPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLBalInFltPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLBalInMatPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLBalInOpsPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.B2bActvTLBalInOthPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalTotBin := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bActvTLBalInCarrTotBin := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bActvTLBalInFltTotBin := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bActvTLBalInMatTotBin := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bActvTLBalInOpsTotBin := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bActvTLBalInOthTotBin := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bActvTLBalAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInCarrAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInFltAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInMatAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInOpsAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInOthAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInCarrArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInFltArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInMatArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInOpsArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInOthArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInCarrGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInFltGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInMatGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInOpsGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInOthGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalGrowIndex1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLBalInCarrGrowIndex1Y := ;
// SELF.B2bActvTLBalInFltGrowIndex1Y := ;
// SELF.B2bActvTLBalInMatGrowIndex1Y := ;
// SELF.B2bActvTLBalInOpsGrowIndex1Y := ;
// SELF.B2bActvTLBalInOthGrowIndex1Y := ;
// SELF.B2bTLBalMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLBalInCarrMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLBalInFltMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLBalInMatMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLBalInOpsMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLBalInOthMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bMaxTLBalDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bMaxTLBalInCarrDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bMaxTLBalInFltDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bMaxTLBalInMatDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bMaxTLBalInOpsDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bMaxTLBalInOthDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bMaxTLBalMsince2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bMaxTLBalInCarrMsince2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bMaxTLBalInFltMsince2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bMaxTLBalInMatMsince2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bMaxTLBalInOpsMsince2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bMaxTLBalInOthMsince2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLWMaxBalSeg2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bActvTLWorstPerfIndex := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bActvTLWorstPerfInCarrIndex := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bActvTLWorstPerfInFltIndex := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bActvTLWorstPerfInMatIndex := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bActvTLWorstPerfInOpsIndex := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bActvTLWorstPerfInOthIndex := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bActvTLW1pDpdCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLW31pDpdCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLW61pDpdCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLW91pDpdCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLW1pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLW31pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLW61pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bActvTLW91pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL1pDpdTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL31pDpdTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL61pDpdTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL91pDpdTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL1pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL31pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL61pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL91pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL1pDpdTotArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL31pDpdTotArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL61pDpdTotArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL91pDpdTotArch1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL1pDpdGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL31pDpdGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL61pDpdGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bBalOnActvTL91pDpdGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLWorstPerfIndex2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bTLWorstPerfInCarrIndex2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bTLWorstPerfInFltIndex2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bTLWorstPerfInMatIndex2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bTLWorstPerfInOpsIndex2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bTLWorstPerfInOthIndex2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bTLWorstPerfDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bTLWorstPerfInCarrDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bTLWorstPerfInFltDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bTLWorstPerfInMatDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bTLWorstPerfInOpsDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bTLWorstPerfInOthDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bTLWorstPerfMsince2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLWorstPerfInCarrMsince2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLWorstPerfInFltMsince2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLWorstPerfInMatMsince2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLWorstPerfInOpsMsince2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLWorstPerfInOthMsince2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLCnt24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLInCarrCnt24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLInFltCnt24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLInMatCnt24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLInOpsCnt24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLInOthCnt24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bIndOfMonWTLStr24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bIndOfMonWTLInCarrStr24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bIndOfMonWTLInFltStr24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bIndOfMonWTLInMatStr24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bIndOfMonWTLInOpsStr24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bIndOfMonWTLInOthStr24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
// SELF.B2bMonWTLCnt24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bMonWTLInCarrCnt24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bMonWTLInFltCnt24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bMonWTLInMatCnt24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bMonWTLInOpsCnt24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bMonWTLInOthCnt24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLBalVol24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLBalInCarrVol24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLBalInFltVol24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLBalInMatVol24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLBalInOpsVol24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
// SELF.B2bTLBalInOthVol24Mfull := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;	
			SELF := LEFT));
			
	BusinessSeleIDAttributes := SORT(BusinessAttributesNoDatesWithSeleID + BusinessAttributesWithoutSeleID, BusInputUIDAppend);
	
	RETURN BusinessSeleIDAttributes;
END;	

