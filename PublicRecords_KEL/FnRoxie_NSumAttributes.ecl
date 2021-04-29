IMPORT KEL13 AS KEL;
IMPORT PublicRecords_KEL;

EXPORT FnRoxie_NSumAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
																		PublicRecords_KEL.Interface_Options Options,
																		DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset) := FUNCTION
            
	WithInputParms := InputData(P_InpClnNameFirst <>''  AND P_InpClnNameLast <> '' AND P_InpClnDOB <> '');
	WithOutInputParms := InputData(P_InpClnNameFirst = ''  OR P_InpClnNameLast = '' OR P_InpClnDOB = '');

	LayoutNSumAttributes := {UNSIGNED G_ProcUID, BOOLEAN ResultsFound, PublicRecords_KEL.KEL_Queries_MAS_NonFCRA.L_Compile.Non_F_C_R_A_Name_Summary_Attributes_V1_Dynamic_Res0_Layout};

	NSumAttributesRaw := NOCOMBINE(JOIN(WithInputParms, FDCDataset,  LEFT.G_ProcUID = RIGHT.G_ProcUID, TRANSFORM(LayoutNSumAttributes,
		NameSummaryAttrs := PublicRecords_KEL.KEL_Queries_MAS_NonFCRA.Q_Non_F_C_R_A_Name_Summary_Attributes_V1_Dynamic(
																		LEFT.P_InpClnNameFirst,
																		LEFT.P_InpClnNameLast,
																		(INTEGER)LEFT.P_InpClnDOB,
																		DATASET(LEFT), 
																		(INTEGER) LEFT.P_InpClnArchDt[1..8], 
																		Options.KEL_Permissions_Mask, 
																		DATASET(RIGHT)).Res0;																	
		SELF.G_ProcUID := LEFT.G_ProcUID,				
		SELF.ResultsFound := EXISTS(NameSummaryAttrs);
		SELF := NameSummaryAttrs[1]
	), LEFT OUTER, ATMOST(100), KEEP(1)));
	
	NSumInputPIIAttributeResults := KEL.Clean(NSumAttributesRaw, TRUE, TRUE, TRUE);
	
  WithInputParmsNSumAttributes := JOIN(WithInputParms, NSumInputPIIAttributeResults, LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutNSumAttributes,
			ResultsFound := RIGHT.ResultsFound;
			
													 // Blank date reads as '00000000 ' and so P_InpClnDOB is measured against it
													 IsDOBPopulated := LEFT.P_InpClnDOB <> '00000000 ';
													 SELF.PI_SrcWInpFLDListEv := MAP(NOT IsDOBPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
															ResultsFound => RIGHT.PI_SrcWInpFLDListEv,
															PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 SELF.PI_SrcWInpFLDEmrgDtListEv := MAP(NOT IsDOBPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
															ResultsFound => RIGHT.PI_SrcWInpFLDEmrgDtListEv,
															PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 SELF.PI_SrcWInpFLDLastDtListEv := MAP(NOT IsDOBPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
															ResultsFound => RIGHT.PI_SrcWInpFLDLastDtListEv,
															PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													
													 SELF := LEFT,
													 SELF := []
		),LEFT OUTER,KEEP(1));
													
	WithOutinputParmsNSumAttributes := PROJECT(WithOutInputParms,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutNSumAttributes,
			SELF.PI_SrcWInpFLDListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpFLDEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpFLDLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF := LEFT));
													 
	NSumInputPIIAttributes := SORT(WithInputParmsNSumAttributes + WithOutinputParmsNSumAttributes, G_ProcUID); 
							
	RETURN NSumInputPIIAttributes;
END;

	