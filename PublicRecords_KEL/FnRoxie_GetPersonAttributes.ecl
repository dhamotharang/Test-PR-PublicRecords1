IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL, Risk_Indicators;

EXPORT FnRoxie_GetPersonAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

	RecordsWithLexID := InputData(LexidAppend > 0);
	RecordsWithoutLexID := InputData(LexidAppend <= 0);

	roll_list(dataset_to_roll, field_to_roll, delimiter) := FUNCTIONMACRO
	// cast the field we need to concatenate to a STRING so that it can be rolled up and preserve the same RECORD format.
	clean_dataset := PROJECT(dataset_to_roll, TRANSFORM({STRING roll_field},
		SELF.roll_field := (STRING)LEFT.field_to_roll));
	
	// Use ROLLUP to concatenate the dataset into a list	
	result := ROLLUP(clean_dataset, TRUE, TRANSFORM({string roll_field},
		SELF.roll_field := LEFT.roll_field + delimiter + RIGHT.roll_field));
		
	RETURN result[1].roll_field;
ENDMACRO;
	
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
                              NOT Options.IsFCRA AND ResultsFound => RIGHT.ArrestCnt1Y, 0);
			SELF.ArrestCnt7Y := MAP(Options.IsFCRA		=> 0,
															NOT Options.IsFCRA AND ResultsFound => RIGHT.ArrestCnt7Y, 0);
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
			//Bankruptcy	
			SELF.BkHistoryBuild := Risk_Indicators.get_Build_date('bankruptcy_daily'); 		
			SELF.BkCnt1Y := RIGHT.BkCnt1Y; 
			SELF.BkCnt7Y := RIGHT.BkCnt7Y;
			SELF.BkCnt10Y := RIGHT.BkCnt10Y;
			SELF.DtOfBksList1Y := IF(RIGHT.BkCnt1Y > 0,roll_list(RIGHT.DtOfBksList1Y, BankruptcyDate, '|'), PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.DtOfBksList7Y := IF(RIGHT.BkCnt7Y > 0,roll_list(RIGHT.DtOfBksList7Y, BankruptcyDate, '|'), PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.DtOfBksList10Y := IF(RIGHT.BkCnt10Y > 0,roll_list(RIGHT.DtOfBksList10Y, BankruptcyDate, '|'), PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.BkNew1Y := IF(ResultsFound, (STRING)RIGHT.BkNew1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.BkNew7Y := IF(ResultsFound, (STRING)RIGHT.BkNew7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.BkNew10Y := IF(ResultsFound, (STRING)RIGHT.BkNew10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.BkOld1Y := IF(ResultsFound, (STRING)RIGHT.BkOld1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.BkOld7Y := IF(ResultsFound, (STRING)RIGHT.BkOld7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.BkOld10Y := IF(ResultsFound, (STRING)RIGHT.BkOld10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.MonSinceNewestBkCnt1Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceNewestBkCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceNewestBkCnt7Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceNewestBkCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceNewestBkCnt10Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceNewestBkCnt10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceOldestBkCnt1Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceOldestBkCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceOldestBkCnt7Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceOldestBkCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceOldestBkCnt10Y := IF(ResultsFound, (INTEGER)RIGHT.MonSinceOldestBkCnt10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.ChForBksList1Y := IF(RIGHT.BkCnt1Y > 0,roll_list(RIGHT.ChForBksList1Y, OriginalChapter, '|'), PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.ChForBksList7Y := IF(RIGHT.BkCnt7Y > 0,roll_list(RIGHT.ChForBksList7Y, OriginalChapter, '|'), PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.ChForBksList10Y := IF(RIGHT.BkCnt10Y > 0,roll_list(RIGHT.ChForBksList10Y, OriginalChapter, '|'), PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.BkWithNewestDateCh1Y := IF(ResultsFound,(STRING)RIGHT.BkWithNewestDateCh1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.BkWithNewestDateCh7Y := IF(ResultsFound,(STRING)RIGHT.BkWithNewestDateCh7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.BkWithNewestDateCh10Y := IF(ResultsFound,(STRING)RIGHT.BkWithNewestDateCh10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.BkUnderCh7Cnt1Y := IF(ResultsFound,(INTEGER)RIGHT.BkUnderCh7Cnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.BkUnderCh7Cnt7Y := IF(ResultsFound,(INTEGER)RIGHT.BkUnderCh7Cnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.BkUnderCh7Cnt10Y := IF(ResultsFound,(INTEGER)RIGHT.BkUnderCh7Cnt10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.BkUnderCh13Cnt1Y := IF(ResultsFound,(INTEGER)RIGHT.BkUnderCh13Cnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.BkUnderCh13Cnt7Y := IF(ResultsFound,(INTEGER)RIGHT.BkUnderCh13Cnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.BkUnderCh13Cnt10Y := IF(ResultsFound,(INTEGER)RIGHT.BkUnderCh13Cnt10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);			
			SELF.NewestBkUpdateDt1Y := IF(ResultsFound,RIGHT.NewestBkUpdateDt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);	
			SELF.NewestBkUpdateDt7Y := IF(ResultsFound,RIGHT.NewestBkUpdateDt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);	
			SELF.NewestBkUpdateDt10Y := IF(ResultsFound,RIGHT.NewestBkUpdateDt10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);	
			SELF.MonSinceNewestBkUpdateCnt1Y := IF(ResultsFound,(INTEGER)RIGHT.MonSinceNewestBkUpdateCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);	
			SELF.MonSinceNewestBkUpdateCnt7Y := IF(ResultsFound,(INTEGER)RIGHT.MonSinceNewestBkUpdateCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);	
			SELF.MonSinceNewestBkUpdateCnt10Y := IF(ResultsFound,(INTEGER)RIGHT.MonSinceNewestBkUpdateCnt10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);	
			SELF.DispOfBksList1Y :=  IF(RIGHT.BkCnt1Y > 0,roll_list(RIGHT.DispOfBksList1Y, Disposition, '|'), PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.DispOfBksList7Y :=  IF(RIGHT.BkCnt7Y > 0,roll_list(RIGHT.DispOfBksList7Y, Disposition, '|'), PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.DispOfBksList10Y :=  IF(RIGHT.BkCnt10Y > 0,roll_list(RIGHT.DispOfBksList10Y, Disposition, '|'), PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.BkWithNewestDateDisp1Y := IF(ResultsFound,RIGHT.BkWithNewestDateDisp1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.BkWithNewestDateDisp7Y := IF(ResultsFound,RIGHT.BkWithNewestDateDisp7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.BkWithNewestDateDisp10Y := IF(ResultsFound,RIGHT.BkWithNewestDateDisp10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.DispOfNewestBkDt1Y := IF(ResultsFound,RIGHT.DispOfNewestBkDt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.DispOfNewestBkDt7Y := IF(ResultsFound,RIGHT.DispOfNewestBkDt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.DispOfNewestBkDt10Y := IF(ResultsFound,RIGHT.DispOfNewestBkDt10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.MonSinceDispOfNewestBkCnt1Y := IF(ResultsFound,(INTEGER)RIGHT.MonSinceDispOfNewestBkCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceDispOfNewestBkCnt7Y := IF(ResultsFound,(INTEGER)RIGHT.MonSinceDispOfNewestBkCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.MonSinceDispOfNewestBkCnt10Y := IF(ResultsFound,(INTEGER)RIGHT.MonSinceDispOfNewestBkCnt10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.BkDisposedCnt1Y := IF(ResultsFound,RIGHT.BkDisposedCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.BkDisposedCnt7Y := IF(ResultsFound,RIGHT.BkDisposedCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.BkDisposedCnt10Y := IF(ResultsFound,RIGHT.BkDisposedCnt10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.BkDismissedCnt1Y := IF(ResultsFound,RIGHT.BkDismissedCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.BkDismissedCnt7Y := IF(ResultsFound,RIGHT.BkDismissedCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.BkDismissedCnt10Y := IF(ResultsFound,RIGHT.BkDismissedCnt10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.BkDischargedCnt1Y := IF(ResultsFound,RIGHT.BkDischargedCnt1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.BkDischargedCnt7Y := IF(ResultsFound,RIGHT.BkDischargedCnt7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.BkDischargedCnt10Y := IF(ResultsFound,RIGHT.BkDischargedCnt10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT);
			SELF.TypeOfBksList1Y :=  IF(RIGHT.BkCnt1Y > 0,roll_list(RIGHT.TypeOfBksList1Y, FilingType, '|'), PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.TypeOfBksList7Y :=  IF(RIGHT.BkCnt7Y > 0,roll_list(RIGHT.TypeOfBksList7Y, FilingType, '|'), PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.TypeOfBksList10Y :=  IF(RIGHT.BkCnt10Y > 0,roll_list(RIGHT.TypeOfBksList10Y, FilingType, '|'), PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
			SELF.BkHavingBusTypeFlag1Y := IF(ResultsFound,RIGHT.BkHavingBusTypeFlag1Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.BkHavingBusTypeFlag7Y := IF(ResultsFound,RIGHT.BkHavingBusTypeFlag7Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.BkHavingBusTypeFlag10Y := IF(ResultsFound,RIGHT.BkHavingBusTypeFlag10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);		
			SELF.BkSeverityIndex10Y := IF(ResultsFound,RIGHT.BkSeverityIndex10Y, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);							
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
			//Bankruptcy			
			SELF.BkHistoryBuild := Risk_Indicators.get_Build_date('bankruptcy_daily');
			SELF.BkCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.DtOfBksList1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.DtOfBksList7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.DtOfBksList10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkNew1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkNew7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkNew10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkOld1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkOld7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkOld10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.MonSinceNewestBkCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceNewestBkCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceNewestBkCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceOldestBkCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceOldestBkCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceOldestBkCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.ChForBksList1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.ChForBksList7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.ChForBksList10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkWithNewestDateCh1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkWithNewestDateCh7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkWithNewestDateCh10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkUnderCh7Cnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkUnderCh7Cnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkUnderCh7Cnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkUnderCh13Cnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkUnderCh13Cnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkUnderCh13Cnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.NewestBkUpdateDt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.NewestBkUpdateDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.NewestBkUpdateDt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.MonSinceNewestBkUpdateCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceNewestBkUpdateCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceNewestBkUpdateCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.DispOfBksList1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.DispOfBksList7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.DispOfBksList10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkWithNewestDateDisp1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkWithNewestDateDisp7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkWithNewestDateDisp10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.DispOfNewestBkDt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.DispOfNewestBkDt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.DispOfNewestBkDt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.MonSinceDispOfNewestBkCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceDispOfNewestBkCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.MonSinceDispOfNewestBkCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkDisposedCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkDisposedCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkDisposedCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkDismissedCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkDismissedCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkDismissedCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkDischargedCnt1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkDischargedCnt7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.BkDischargedCnt10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.TypeOfBksList1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.TypeOfBksList7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.TypeOfBksList10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkHavingBusTypeFlag1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkHavingBusTypeFlag7Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkHavingBusTypeFlag10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.BkSeverityIndex10Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF := LEFT)); 
			
	PersonAttributes := SORT( PersonAttributesWithLexID + PersonAttributesWithoutLexID, InputUIDAppend ); 
	
	RETURN PersonAttributes;
END;
