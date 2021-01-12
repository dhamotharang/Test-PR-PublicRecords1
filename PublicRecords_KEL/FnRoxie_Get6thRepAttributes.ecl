Import KEL13 AS KEL;
IMPORT PublicRecords_KEL, Risk_Indicators;

EXPORT FnRoxie_Get6thRepAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

	Common_Functions := PublicRecords_KEL.ECL_Functions.Common_Functions;

	RecordsWithLexID := InputData(P_LexID  > 0);
	RecordsWithoutLexID := InputData(P_LexID  <= 0);
	
	//update Q_* below
	LayoutNonFCRAPersonAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Sixth_Rep_Attributes_V1_Dynamic(0, DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII), 0, PublicRecords_KEL.CFG_Compile.Permit__NONE).res0);
	
	//update Q_* below
	NonFCRAPersonAttributesRaw := PROJECT(RecordsWithLexID, TRANSFORM({INTEGER G_ProcUID, LayoutNonFCRAPersonAttributes},
		SELF.G_ProcUID := LEFT.G_ProcUID;
		NonFCRAPersonResults := PublicRecords_KEL.Q_Non_F_C_R_A_Sixth_Rep_Attributes_V1_Dynamic(LEFT.P_LexID , DATASET(LEFT), (INTEGER)(LEFT.P_InpClnArchDt[1..8]), Options.KEL_Permissions_Mask, FDCDataset).res0;	
		SELF := NonFCRAPersonResults[1]));	
		
	PersonAttributesClean := KEL.Clean(NonFCRAPersonAttributesRaw, TRUE, TRUE, TRUE);
		
	PersonAttributesWithLexID := JOIN(RecordsWithLexID, PersonAttributesClean, LEFT.G_ProcUID = RIGHT.G_ProcUID AND LEFT.P_LexID  = RIGHT.LexID, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutPerson,
			ResultsFound := RIGHT.LexID > 0;
			// add 6th rep attributes here
			SELF := [];		
			),LEFT OUTER, KEEP(1)); 
	
	PersonAttributesWithoutLexID := PROJECT(RecordsWithoutLexID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutPerson,
			// add 6th rep attributes here
			SELF := [])); 
			
	PersonAttributes := SORT( PersonAttributesWithLexID + PersonAttributesWithoutLexID, G_ProcUID ); 
	RETURN PersonAttributes;
END;
