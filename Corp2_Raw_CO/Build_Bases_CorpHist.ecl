IMPORT corp2, tools;

EXPORT Build_Bases_CorpHist(
	STRING																						pfiledate,
	STRING																						ptmfiledate,	
	STRING																						pversion,
	BOOLEAN																						puseprod,	
	DATASET(Corp2_Raw_CO.Layouts.CorpHistLayoutIn)		pInCorpHist1   = Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.CorpHist1.Logical,
	DATASET(Corp2_Raw_CO.Layouts.CorpHistLayoutIn)		pInCorpHist2   = Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.CorpHist2.Logical,
	DATASET(Corp2_Raw_CO.Layouts.CorpHistLayoutBase)	pBaseCorpHist  = IF(Corp2_Raw_CO._Flags().Base.CorpHist, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.CorpHist.qa, DATASET([], Corp2_Raw_CO.Layouts.CorpHistLayoutBase))
) := MODULE

	Corp2_Raw_CO.Layouts.CorpHistLayoutBase standardize_input(Corp2_Raw_CO.Layouts.CorpHistLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the CO Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate1 := PROJECT(pInCorpHist1, standardize_input(LEFT));
	workingUpdate2 := PROJECT(pInCorpHist2, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate1 + workingUpdate2 + pBaseCorpHist;
	
	combined_dist := DISTRIBUTE(combined, HASH(HistEntityID));
	combined_sort := SORT(combined_dist, HistEntityID, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_CO.Layouts.CorpHistLayoutBase rollupBase(Corp2_Raw_CO.Layouts.CorpHistLayoutBase L,
																										 Corp2_Raw_CO.Layouts.CorpHistLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																							 
	  SELF                    := L;
	END;
	
	baseCorpHist := ROLLUP(	combined_sort,
													rollupBase(LEFT, RIGHT),
													RECORD,
													EXCEPT dt_first_received, dt_last_received,
													LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CO.Filenames(pversion).Base.CorpHist.New, baseCorpHist, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CO.Build_Bases_CorpHist attribute')
									 );

END;