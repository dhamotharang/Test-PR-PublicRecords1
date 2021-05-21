IMPORT KEL11 AS KEL;
IMPORT Business_Risk_BIP, PublicRecords_KEL, STD, _Control, risk_indicators;


EXPORT FNRoxie_GetInferredPerformanceAttributes (DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
			PublicRecords_KEL.Interface_Options Options,
      DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset) := FUNCTION
	WithInputParms :=InputData(P_LexID > 0 OR P_InpClnArchDt <> '0' AND p_inpclnarchdt[1..8] <> (((string)risk_indicators.iid_constants.todaydate)[1..8]));
	WithOutInputParms :=InputData((P_LexID <= 0 AND P_InpClnArchDt =	 '0') OR p_inpclnarchdt[1..8] = (((string)risk_indicators.iid_constants.todaydate)[1..8]));

	LayoutInferredPerformanceAttributes := {UNSIGNED G_ProcUID, BOOLEAN ResultsFoundNormal, BOOLEAN ResultsFoundDates,
		recordof(PublicRecords_KEL.KEL_Queries_MAS_FCRA.L_Compile.Inferred_Performance_Dynamic_Res0_Layout) results,
		recordof(PublicRecords_KEL.KEL_Queries_MAS_FCRA.L_Compile.Inferred_Performance_Dynamic_Res1_Layout) dates};

	
	InferredPerformanceAttributesRaw := NOCOMBINE(JOIN( WithInputParms, FDCDataset, LEFT.G_ProcUID = RIGHT.G_ProcUID, TRANSFORM(LayoutInferredPerformanceAttributes,
		RawAttributes := PublicRecords_KEL.KEL_Queries_MAS_FCRA.Q_Inferred_Performance_Dynamic(LEFT.P_LexID,DATASET(LEFT),(INTEGER) LEFT.P_InpClnArchDt[1..8],Options.KEL_Permissions_Mask,DATASET(RIGHT)).res0;
		RawAttributesDates := PublicRecords_KEL.KEL_Queries_MAS_FCRA.Q_Inferred_Performance_Dynamic(LEFT.P_LexID,DATASET(LEFT),(INTEGER) LEFT.P_InpClnArchDt[1..8],Options.KEL_Permissions_Mask,DATASET(RIGHT)).res1;
		SELF.G_ProcUID := LEFT.G_ProcUID;				
		SELF.ResultsFoundNormal := EXISTS(RawAttributes);
		SELF.ResultsFoundDates := EXISTS(RawAttributesDates);
		SELF.results :=RawAttributes[1],
		SELF.dates := RawAttributesdates[1]),
		LEFT OUTER, ATMOST(100), KEEP(1)));
		
		InferredPerformanceAttributesClean := KEL.Clean(InferredPerformanceAttributesRaw, TRUE, TRUE, TRUE);

		
	WithInputParmsInferredPerformanceAttributes :=
		                  JOIN(WithInputParms,InferredPerformanceAttributesClean, LEFT.G_ProcUID = RIGHT.G_ProcUID,
											    TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInferredAttributes,
														SELF.PL_DrgCrimFelCnt1YF1Y := MAP(LEFT.P_LexID > 0 AND RIGHT.ResultsFoundNormal => (INTEGER)RIGHT.Results.PL_DrgCrimFelCnt1YF1Y,
															PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
														SELF.PL_DrgLienCnt1YF1Y := MAP(LEFT.P_LexID > 0 AND RIGHT.ResultsFoundNormal => (INTEGER)RIGHT.Results.PL_DrgLienCnt1YF1Y,
															PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
														SELF.PL_DrgBkCnt1YF1Y := MAP(LEFT.P_LexID > 0 AND RIGHT.ResultsFoundNormal => (INTEGER)RIGHT.Results.PL_DrgBkCnt1YF1Y,
															PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
														SELF.PL_DrgLTD1YF1Y := MAP(LEFT.P_LexID > 0 AND RIGHT.ResultsFoundNormal => (INTEGER)RIGHT.Results.PL_DrgLTD1YF1Y,
															PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);

													SELF.P_InpClnArchDtF6M := RIGHT.dates.P_InpClnArchDtF6M;
													SELF.P_InpClnArchDtF1Y := RIGHT.dates.P_InpClnArchDtF1Y;
													SELF.P_InpClnArchDtF2Y := RIGHT.dates.P_InpClnArchDtF2Y;

													SELF := LEFT,
													SELF := []
												),LEFT OUTER,KEEP(1));
			WithOutinputInferredPerformanceAttributes :=
		                  PROJECT(WithOutInputParms,
											     TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInferredAttributes,
															ErrorCodeDates := IF(left.p_inpclnarchdt[1..8] = ((string)risk_indicators.iid_constants.todaydate)[1..8], PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
															ErrorCodeNormal := (INTEGER)PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
															SELF.P_InpClnArchDtF6M := ErrorCodeDates;
															SELF.P_InpClnArchDtF1Y := ErrorCodeDates;
															SELF.P_InpClnArchDtF2Y := ErrorCodeDates;
															SELF.PL_DrgCrimFelCnt1YF1Y := ErrorCodeNormal;
															SELF.PL_DrgLienCnt1YF1Y := ErrorCodeNormal;
															SELF.PL_DrgBkCnt1YF1Y := ErrorCodeNormal;
															SELF.PL_DrgLTD1YF1Y := ErrorCodeNormal;

													 SELF := LEFT));
		InferredPerformanceAttributes := SORT( WithInputParmsInferredPerformanceAttributes + WithOutinputInferredPerformanceAttributes, G_ProcUID ); 

								return InferredPerformanceAttributes;

END;
