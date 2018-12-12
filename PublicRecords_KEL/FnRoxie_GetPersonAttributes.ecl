IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL, Risk_Indicators;

EXPORT FnRoxie_GetPersonAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

	RecordsWithLexID := InputData(LexidAppend > 0);
	RecordsWithoutLexID := InputData(LexidAppend <= 0);
	
	LayoutFCRAPersonAttributes := RECORDOF(PublicRecords_KEL.Q_F_C_R_A_Person_Attributes_V1([], 0, 0).res0);
	LayoutNonFCRAPersonAttributes := RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Person_Attributes_V1([], 0, 0).res0);
	
	NonFCRAPersonAttributesRaw := PROJECT(InputData, TRANSFORM({INTEGER InputUIDAppend, LayoutNonFCRAPersonAttributes},
		SELF.InputUIDAppend := LEFT.InputUIDAppend;
		NonFCRAPersonResults := PublicRecords_KEL.Q_Non_F_C_R_A_Person_Attributes_V1([LEFT.LexIDAppend], (INTEGER)(LEFT.InputArchiveDateClean[1..8]), IF(Options.IsFCRA, PublicRecords_KEL.CFG_Uses.Permit_FCRA,PublicRecords_KEL.CFG_Uses.Permit_nonFCRA), FDCDataset).res0;	
		SELF := NonFCRAPersonResults[1]));	

	FCRAPersonAttributesRaw := PROJECT(InputData, TRANSFORM({INTEGER InputUIDAppend, LayoutNonFCRAPersonAttributes},
		SELF.InputUIDAppend := LEFT.InputUIDAppend;
		FCRAPersonResults := PublicRecords_KEL.Q_F_C_R_A_Person_Attributes_V1([LEFT.LexIDAppend], (INTEGER)(LEFT.InputArchiveDateClean[1..8]), IF(Options.IsFCRA, PublicRecords_KEL.CFG_Uses.Permit_FCRA,PublicRecords_KEL.CFG_Uses.Permit_nonFCRA), FDCDataset).res0;	
		SELF := FCRAPersonResults[1],
		SELF := []));	
		
	PersonAttributesClean := IF(Options.IsFCRA, 
															KEL.Clean(FCRAPersonAttributesRaw, TRUE, TRUE, TRUE),
															KEL.Clean(NonFCRAPersonAttributesRaw, TRUE, TRUE, TRUE));
	
	
	// Cast Attributes back to their string values
	PersonAttributesWithLexID := JOIN(RecordsWithLexID, PersonAttributesClean, LEFT.InputUIDAppend = RIGHT.InputUIDAppend AND LEFT.LexidAppend = RIGHT.LexID, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutPerson,
			SELF.CrimHistoryBuild := Risk_Indicators.get_Build_date('doc_build_version');
			ResultsFound := RIGHT.LexID > 0;
			SELF.FelonyCnt1Y := RIGHT.FelonyCnt1Y;
			SELF.FelonyCnt7Y := RIGHT.FelonyCnt7Y;
			SELF.FelonyNew1Y := IF(ResultsFound, (STRING)RIGHT.FelonyNew1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.FelonyOld1Y := IF(ResultsFound, (STRING)RIGHT.FelonyOld1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND); 
			SELF.FelonyNew7Y := IF(ResultsFound, (STRING)RIGHT.FelonyNew7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND); 
			SELF.FelonyOld7Y := IF(ResultsFound, (STRING)RIGHT.FelonyOld7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.MonSinceNewestFelonyCnt1Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceNewestFelonyCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceOldestFelonyCnt1Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceOldestFelonyCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceNewestFelonyCnt7Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceNewestFelonyCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT); 
			SELF.MonSinceOldestFelonyCnt7Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceOldestFelonyCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.NonFelonyCnt1Y := RIGHT.NonFelonyCnt1Y;
			SELF.NonFelonyCnt7Y := RIGHT.NonFelonyCnt7Y;
			SELF.NonfelonyNew1Y := IF(ResultsFound, (STRING)RIGHT.NonfelonyNew1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.NonfelonyOld1Y := IF(ResultsFound, (STRING)RIGHT.NonfelonyOld1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.NonfelonyNew7Y := IF(ResultsFound, (STRING)RIGHT.NonfelonyNew7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.NonfelonyOld7Y := IF(ResultsFound, (STRING)RIGHT.NonfelonyOld7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.MonSinceNewestNonfelonyCnt1Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceNewestNonfelonyCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceOldestNonfelonyCnt1Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceOldestNonfelonyCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceNewestNonfelonyCnt7Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceNewestNonfelonyCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceOldestNonfelonyCnt7Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceOldestNonfelonyCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			// Arrest fields are NonFCRA only
			SELF.ArrestCnt1Y := MAP(Options.IsFCRA 		=> 0,
                              NOT Options.IsFCRA AND ResultsFound => RIGHT.ArrestCnt1Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.ArrestCnt7Y := MAP(Options.IsFCRA		=> 0,
															NOT Options.IsFCRA AND ResultsFound => RIGHT.ArrestCnt7Y, 
                                                                  PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.ArrestNew1Y := MAP(Options.IsFCRA 		=> '',
															NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.ArrestNew1Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.ArrestOld1Y := MAP(Options.IsFCRA 		=> '',
															NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.ArrestOld1Y, 
                                                                  PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.ArrestNew7Y := MAP(Options.IsFCRA  		=> '',
															NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.ArrestNew7Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.ArrestOld7Y := MAP(Options.IsFCRA  		=> '',
															NOT Options.IsFCRA AND ResultsFound => (STRING)RIGHT.ArrestOld7Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
      SELF.MonSinceNewestArrestCnt1Y := MAP(Options.IsFCRA 	=> 0,
															NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.MonSinceNewestArrestCnt1Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceOldestArrestCnt1Y := MAP(Options.IsFCRA  => 0,
															NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.MonSinceOldestArrestCnt1Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceNewestArrestCnt7Y := MAP(Options.IsFCRA => 0,
															NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.MonSinceNewestArrestCnt7Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceOldestArrestCnt7Y := MAP(Options.IsFCRA 	=> 0,
															NOT Options.IsFCRA AND ResultsFound => (INTEGER)RIGHT.MonSinceOldestArrestCnt7Y, 
																																	PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.CrimCnt1Y := RIGHT.CrimCnt1Y;
			SELF.CrimCnt7Y := RIGHT.CrimCnt7Y;
			SELF.CrimNew1Y := IF(ResultsFound, (STRING)RIGHT.CrimNew1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.CrimOld1Y := IF(ResultsFound, (STRING)RIGHT.CrimOld1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.CrimNew7Y := IF(ResultsFound, (STRING)RIGHT.CrimNew7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.CrimOld7Y := IF(ResultsFound, (STRING)RIGHT.CrimOld7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.MonSinceNewestCrimCnt1Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceNewestCrimCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceOldestCrimCnt1Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceOldestCrimCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceNewestCrimCnt7Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceNewestCrimCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceOldestCrimCnt7Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceOldestCrimCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.CrimSeverityIndex7Y := IF(ResultsFound, (STRING)RIGHT.CrimSeverityIndex7Y,'0 - 0');
			SELF.CrimBehaviorIndex7Y := IF(ResultsFound, (STRING)RIGHT.CrimBehaviorIndex7Y,'0');
			SELF := LEFT;
		),LEFT OUTER, KEEP(1)); 
	
	PersonAttributesWithoutLexID := PROJECT(RecordsWithoutLexID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutPerson,
			SELF.CrimHistoryBuild := Risk_Indicators.get_Build_date('doc_build_version');
			SELF.FelonyCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.FelonyCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.FelonyNew1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.FelonyOld1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.FelonyNew7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA; 
			SELF.FelonyOld7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.MonSinceNewestFelonyCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceOldestFelonyCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceNewestFelonyCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceOldestFelonyCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.NonFelonyCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.NonFelonyCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.NonfelonyNew1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.NonfelonyOld1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.NonfelonyNew7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.NonfelonyOld7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.MonSinceNewestNonfelonyCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceOldestNonfelonyCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceNewestNonfelonyCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceOldestNonfelonyCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			// Arrest fields are nonFCRA only
			SELF.ArrestCnt1Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.ArrestCnt7Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.ArrestNew1Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.ArrestOld1Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.ArrestNew7Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.ArrestOld7Y := IF(Options.IsFCRA, '',PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
			SELF.MonSinceNewestArrestCnt1Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.MonSinceOldestArrestCnt1Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.MonSinceNewestArrestCnt7Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.MonSinceOldestArrestCnt7Y := IF(Options.IsFCRA,0,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
			SELF.CrimCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.CrimCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.CrimNew1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.CrimOld1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.CrimNew7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.CrimOld7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.MonSinceNewestCrimCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceOldestCrimCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceNewestCrimCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceOldestCrimCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.CrimSeverityIndex7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.CrimBehaviorIndex7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF := LEFT)); 	
			
	PersonAttributes := SORT( PersonAttributesWithLexID + PersonAttributesWithoutLexID, InputUIDAppend ); 
	
	RETURN PersonAttributes;
END;
