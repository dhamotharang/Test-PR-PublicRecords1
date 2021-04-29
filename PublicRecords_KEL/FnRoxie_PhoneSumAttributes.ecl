IMPORT KEL13 AS KEL;
IMPORT PublicRecords_KEL;

EXPORT FnRoxie_PhoneSumAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
																		PublicRecords_KEL.Interface_Options Options,
																		DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset) := FUNCTION
            
	GoodInputOnly := InputData(NOT P_InpClnPhoneHome = '');
	BadInputOnly := InputData(P_InpClnPhoneHome = '');

	LayoutPhoneSumAttributes := {UNSIGNED G_ProcUID, BOOLEAN ResultsFound, PublicRecords_KEL.KEL_Queries_MAS_NonFCRA.L_Compile.Non_F_C_R_A_Phone_Summary_Attributes_V1_Dynamic_Res0_Layout};

	PhoneSumAttributesRaw := NOCOMBINE(JOIN(GoodInputOnly, FDCDataset,  LEFT.G_ProcUID = RIGHT.G_ProcUID, TRANSFORM(LayoutPhoneSumAttributes,
		PhoneSummaryAttrs := PublicRecords_KEL.KEL_Queries_MAS_NonFCRA.Q_Non_F_C_R_A_Phone_Summary_Attributes_V1_Dynamic(
																		LEFT.P_InpClnPhoneHome,
																		DATASET(LEFT), 
																		(INTEGER) LEFT.P_InpClnArchDt[1..8], 
																		Options.KEL_Permissions_Mask, 
																		DATASET(RIGHT)).Res0;																	
		SELF.G_ProcUID := LEFT.G_ProcUID,				
		SELF.ResultsFound := EXISTS(PhoneSummaryAttrs);
		SELF := PhoneSummaryAttrs[1]
	), LEFT OUTER, ATMOST(100), KEEP(1)));
	
	PhoneSumInputPIIAttributeResults := KEL.Clean(PhoneSumAttributesRaw, TRUE, TRUE, TRUE);
	
  PhoneSumInputPIIAttributes :=
		                  JOIN(GoodInputOnly,PhoneSumInputPIIAttributeResults,LEFT.G_ProcUID = RIGHT.G_ProcUID,
											     TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutPhoneSumAttributes,
													 ResultsFound := RIGHT.ResultsFound;
													 
													 IsAddressPopulated := LEFT.P_InpClnAddrPrimRng  <> '' AND LEFT.P_InpClnAddrPrimName <> '' AND LEFT.P_InpClnAddrZip5 <> '';
													 SELF.PI_SrcWInpAPListEv := MAP(NOT IsAddressPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpAPListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 SELF.PI_SrcWInpAPEmrgDtListEv := MAP(NOT IsAddressPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpAPEmrgDtListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 SELF.PI_SrcWInpAPLastDtListEv := MAP(NOT IsAddressPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
														ResultsFound => RIGHT.PI_SrcWInpAPLastDtListEv,
														PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 
													 IsLastPopulated := LEFT.P_InpClnNameLast <> '';
													 SELF.PI_SrcWInpLPListEv := MAP(NOT IsLastPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
													 	ResultsFound => RIGHT.PI_SrcWInpLPListEv,
													 	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 SELF.PI_SrcWInpLPEmrgDtListEv := MAP(NOT IsLastPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
													 	ResultsFound => RIGHT.PI_SrcWInpLPEmrgDtListEv,
													 	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 SELF.PI_SrcWInpLPLastDtListEv := MAP(NOT IsLastPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
													 	ResultsFound => RIGHT.PI_SrcWInpLPLastDtListEv,
													 	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 
													 // Blank date reads as '00000000 ' and so P_InpClnDOB is measured against it
													 IsDOBPopulated := LEFT.P_InpClnDOB <> '00000000 ';
													 SELF.PI_SrcWInpPDListEv := MAP(NOT IsDOBPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
													 	ResultsFound => RIGHT.PI_SrcWInpPDListEv,
													 	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 SELF.PI_SrcWInpPDEmrgDtListEv := MAP(NOT IsDOBPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
													 	ResultsFound => RIGHT.PI_SrcWInpPDEmrgDtListEv,
													 	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
													 SELF.PI_SrcWInpPDLastDtListEv := MAP(NOT IsDOBPopulated => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
													 	ResultsFound => RIGHT.PI_SrcWInpPDLastDtListEv,
													 	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);

													 SELF := LEFT,
													 SELF := []
													),LEFT OUTER,KEEP(1));
													
	WithOutinputParmsPhoneSumAttributes := PROJECT(BadInputOnly,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutPhoneSumAttributes,
			SELF.PI_SrcWInpPDListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpPDEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpPDLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpLPListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpLPEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpLPLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpAPListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpAPEmrgDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.PI_SrcWInpAPLastDtListEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF := LEFT));
								
	RETURN SORT(PhoneSumInputPIIAttributes + WithOutinputParmsPhoneSumAttributes, G_ProcUID);
END;
