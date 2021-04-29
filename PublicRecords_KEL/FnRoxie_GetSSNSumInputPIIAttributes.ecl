IMPORT KEL13 AS KEL;
IMPORT PublicRecords_KEL;

EXPORT FnRoxie_GetSSNSumInputPIIAttributes (DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
																		PublicRecords_KEL.Interface_Options Options,
																		DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset) := FUNCTION

	WithInputParms := InputData(P_InpClnSSN <> '');
	WithOutInputParms := InputData(P_InpClnSSN = '');
	
	LayoutSSNSumAttributes := {UNSIGNED G_ProcUID, BOOLEAN ResultsFound, PublicRecords_KEL.KEL_Queries_MAS_NonFCRA.L_Compile.Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic_Res0_Layout};

	SSNSumInputPIIAttributesRaw := NOCOMBINE(JOIN(WithInputParms, FDCDataset,  LEFT.G_ProcUID = RIGHT.G_ProcUID, TRANSFORM(LayoutSSNSumAttributes,
		SSNSummaryAttrs := PublicRecords_KEL.KEL_Queries_MAS_NonFCRA.Q_Non_F_C_R_A_S_S_N_Summary_Attributes_V1_Dynamic(
																		LEFT.P_InpClnSSN,
																		DATASET(LEFT), 
																		(INTEGER) LEFT.P_InpClnArchDt[1..8], 
																		Options.KEL_Permissions_Mask, 
																		DATASET(RIGHT)).Res0;																	
		SELF.G_ProcUID := LEFT.G_ProcUID,				
		SELF.ResultsFound := EXISTS(SSNSummaryAttrs);
		SELF := SSNSummaryAttrs[1]
	), LEFT OUTER, ATMOST(100), KEEP(1)));
	
	SSNSumInputPIIAttributeResults := KEL.Clean(SSNSumInputPIIAttributesRaw, TRUE, TRUE, TRUE);
	
	WithInputParmsSSNSumAttributes := JOIN(WithInputParms, SSNSumInputPIIAttributeResults, LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutSSNSumAttributes,
			ResultsFound :=  RIGHT.ResultsFound;
			IsAddressPopulated := LEFT.P_InpClnAddrPrimRng  <> '' AND LEFT.P_InpClnAddrPrimName <> '' AND LEFT.P_InpClnAddrZip5 <> '';
													SELF.PI_SrcWInpASListEv := MAP(NOT IsAddressPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpASListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													SELF.PI_SrcWInpASEmrgDtListEv := MAP(NOT IsAddressPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpASEmrgDtListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													SELF.PI_SrcWInpASLastDtListEv := MAP(NOT IsAddressPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpASLastDtListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
														
													IsFirstLastPopulated := LEFT.P_InpClnNameFirst <> '' AND LEFT.P_InpClnNameLast <> '';
													SELF.PI_SrcWInpFLSListEv := MAP(NOT IsFirstLastPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpFLSListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													SELF.PI_SrcWInpFLSEmrgDtListEv := MAP(NOT IsFirstLastPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpFLSEmrgDtListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													SELF.PI_SrcWInpFLSLastDtListEv := MAP(NOT IsFirstLastPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpFLSLastDtListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
														
													IsPhonePopulated := LEFT.P_InpClnPhoneHome <> '';
													SELF.PI_SrcWInpPSListEv := MAP(NOT IsPhonePopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpPSListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													SELF.PI_SrcWInpPSEmrgDtListEv := MAP(NOT IsPhonePopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpPSEmrgDtListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													SELF.PI_SrcWInpPSLastDtListEv := MAP(NOT IsPhonePopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpPSLastDtListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);

													// Blank date reads as '00000000 ' and so P_InpClnDOB is measured against it
													IsDOBPopulated := LEFT.P_InpClnDOB <> '00000000 ';
													SELF.PI_SrcWInpSDListEv := MAP(NOT IsDOBPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpSDListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													SELF.PI_SrcWInpSDEmrgDtListEv := MAP(NOT IsDOBPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpSDEmrgDtListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													SELF.PI_SrcWInpSDLastDtListEv := MAP(NOT IsDOBPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpSDLastDtListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);

													SELF := LEFT,
													SELF := []
			),LEFT OUTER,KEEP(1));
													
	WithOutinputParmsSSNSumAttributes := PROJECT(WithOutInputParms,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutSSNSumAttributes,
			SELF.PI_SrcWInpASListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpASEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpASLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpSDListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpSDEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpSDLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpPSListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpPSEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpPSLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpFLSListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpFLSEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpFLSLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF := LEFT));
			
	SSNSumInputPIIAttributes := SORT(WithInputParmsSSNSumAttributes + WithOutinputParmsSSNSumAttributes, G_ProcUID); 
								
	RETURN SSNSumInputPIIAttributes;

END;

	