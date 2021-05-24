IMPORT KEL13 AS KEL;
IMPORT PublicRecords_KEL;

EXPORT FnRoxie_AddrSummaryAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
																		PublicRecords_KEL.Interface_Options Options,
																		DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset) := FUNCTION
            	
	RecordsWithInputParms := InputData(P_InpClnAddrPrimName <> '' AND P_InpClnAddrPrimRng <> '' AND P_InpClnAddrZip5 <> '');
	RecordsWithoutInputParms := InputData(P_InpClnAddrPrimName = '' OR P_InpClnAddrPrimRng = '' OR P_InpClnAddrZip5 = '');																	
	
		LayoutAddressSummaryAttributes := {UNSIGNED G_ProcUID, BOOLEAN ResultsFound, PublicRecords_KEL.KEL_Queries_MAS_NonFCRA.L_Compile.Non_F_C_R_A_Address_Summary_Attributes_V1_Dynamic_Res0_Layout};

		AddressSummaryAttributesRaw := NOCOMBINE(JOIN(RecordsWithInputParms, FDCDataset,  LEFT.G_ProcUID = RIGHT.G_ProcUID, TRANSFORM(LayoutAddressSummaryAttributes,
				AddressSummaryAttrs := PublicRecords_KEL.KEL_Queries_MAS_NonFCRA.Q_Non_F_C_R_A_Address_Summary_Attributes_V1_Dynamic(
																		LEFT.P_InpClnAddrPrimName,
																		LEFT.P_InpClnAddrPrimRng,
																		LEFT.P_InpClnAddrZip5,
																		DATASET(LEFT), 
																		(INTEGER) LEFT.P_InpClnArchDt[1..8], 
																		Options.KEL_Permissions_Mask, 
																		DATASET(RIGHT)).Res0;																	
		SELF.G_ProcUID := LEFT.G_ProcUID,				
		SELF.ResultsFound := EXISTS(AddressSummaryAttrs);
		SELF := AddressSummaryAttrs[1]
	), LEFT OUTER, ATMOST(100), KEEP(1)));
	
	AddressSummaryAttributeResults := KEL.Clean(AddressSummaryAttributesRaw, TRUE, TRUE, TRUE);
	
  AddressSummaryAttributesWithParm := JOIN(RecordsWithInputParms, AddressSummaryAttributeResults, LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutAddrSummaryAttributes,
			ResultsFound := RIGHT.ResultsFound;
			IsFirstLastPopulated := LEFT.P_InpClnNameFirst <> '' AND LEFT.P_InpClnNameLast  <> '';
													 SELF.PI_SrcWInpFLAListEv := MAP(NOT IsFirstLastPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpFLAListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 SELF.PI_SrcWInpFLAEmrgDtListEv := MAP(NOT IsFirstLastPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpFLAEmrgDtListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 SELF.PI_SrcWInpFLALastDtListEv := MAP(NOT IsFirstLastPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpFLALastDtListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 
													 // Blank date reads as '00000000 ' and so P_InpClnDOB is measured against it
													 IsDOBPopulated := LEFT.P_InpClnDOB <> '00000000 ';
													 SELF.PI_SrcWInpADListEv := MAP(NOT IsDOBPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpADListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 SELF.PI_SrcWInpADEmrgDtListEv := MAP(NOT IsDOBPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpADEmrgDtListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 SELF.PI_SrcWInpADLastDtListEv := MAP(NOT IsDOBPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpADLastDtListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 
													 SELF := LEFT,
													 SELF := []
		), LEFT OUTER, KEEP(1));
	
	RecordsWithoutInputParmsProjected := PROJECT(RecordsWithoutInputParms,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutAddrSummaryAttributes,
			SELF.PI_SrcWInpFLAListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpFLAEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpFLALastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpADListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpADEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpADLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF := LEFT)); 	
			
	AddressSummaryAttributes := SORT(AddressSummaryAttributesWithParm + RecordsWithoutInputParmsProjected, G_ProcUID); 
	
	RETURN AddressSummaryAttributes;
END;

