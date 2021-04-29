Import KEL13 AS KEL;
IMPORT PublicRecords_KEL, Risk_Indicators;

EXPORT FnRoxie_GetHighRiskAddress (DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
																		PublicRecords_KEL.Interface_Options Options,
																		DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset) := FUNCTION
																		
																		
	GoodInputOnly := InputData(NOT P_InpClnAddrPrimRng = '' AND NOT P_InpClnAddrPrimName = '' AND NOT P_InpClnAddrZip5 = '');
	BadInputOnly := InputData(P_InpClnAddrPrimRng = '' OR P_InpClnAddrPrimName = '' OR P_InpClnAddrZip5 = '');																		

	HighRiskAddressAttributesLayout := PublicRecords_KEL.KEL_Queries_MAS_Shared.L_Compile.Address_High_Risk_Res0_Internal_Layout;
			
	RawResults := NOCOMBINE(JOIN(GoodInputOnly, FDCDataset,
		LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM({INTEGER G_ProcUID, BOOLEAN ResultsFound, HighRiskAddressAttributesLayout},
			SELF.G_ProcUID := LEFT.G_ProcUID;
			HighRiskResults := PublicRecords_KEL.KEL_Queries_MAS_Shared.Q_Address_High_Risk_Dynamic(
																								(string)LEFT.P_InpClnAddrPrimRng,
																								LEFT.P_InpClnAddrPrimName, 
																								(INTEGER)LEFT.P_InpClnAddrZip5, 
																								LEFT.P_InpClnAddrPreDir,
																								LEFT.P_InpClnAddrSffx,
																								LEFT.P_InpClnAddrPostDir,
																								DATASET(LEFT), 
																								(INTEGER)(LEFT.P_InpClnArchDt[1..8]),
																								Options.KEL_Permissions_Mask, 
																								DATASET(RIGHT)).res0;	
			SELF := HighRiskResults[1];
			SELF.ResultsFound := EXISTS(HighRiskResults)), 
		LEFT OUTER, ATMOST(100), KEEP(1)));
	
	
		AttributeResults := KEL.Clean(RawResults, TRUE, TRUE, TRUE);
	
	 HighRiskAddressInputPIIAttributes :=
		                  JOIN(GoodInputOnly,AttributeResults,
											LEFT.G_ProcUID = RIGHT.G_ProcUID,
											     TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutHighRiskAddressAttributes,
													 ResultsFound :=  RIGHT.ResultsFound ;
													 SELF.PI_InpAddrSICCodeHRList := IF(ResultsFound, RIGHT.PI_InpAddrSICCodeHRList, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 SELF.PI_InpAddrNAICSCodeHRList := IF(ResultsFound, RIGHT.PI_InpAddrNAICSCodeHRList, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 SELF.PI_InpAddrIsHRCorrectFacFlag := IF(ResultsFound, RIGHT.PI_InpAddrIsHRCorrectFacFlag, '0');
													 SELF := LEFT,
													 SELF := []
													),LEFT OUTER,KEEP(1));
	WithOutinputParmsHighRiskAddressAttributes :=
		                  PROJECT(BadInputOnly,
											     TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutHighRiskAddressAttributes,
													 SELF.PI_InpAddrSICCodeHRList := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
													 SELF.PI_InpAddrNAICSCodeHRList := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
													 SELF.PI_InpAddrIsHRCorrectFacFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;		 
													 SELF := LEFT));
								
RETURN SORT(HighRiskAddressInputPIIAttributes+WithOutinputParmsHighRiskAddressAttributes,G_ProcUID);
END;		