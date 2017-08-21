IMPORT corp2, tools;

EXPORT Build_Bases_CorpTrdnm(
	STRING																						pfiledate,
	STRING																						ptmfiledate,	
	STRING																						pversion,
	BOOLEAN																						puseprod,	
	DATASET(Corp2_Raw_CO.Layouts.CorpTrdnmLayoutIn)		pInCorpTrdnm   	= Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.CorpTrdnm.Logical,
	DATASET(Corp2_Raw_CO.Layouts.CorpTrdnmLayoutBase)	pBaseCorpTrdnm 	= IF(Corp2_Raw_CO._Flags().Base.CorpTrdnm, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.CorpTrdnm.qa, DATASET([], Corp2_Raw_CO.Layouts.CorpTrdnmLayoutBase))
) := MODULE

	Corp2_Raw_CO.Layouts.CorpTrdnmLayoutBase standardize_input(Corp2_Raw_CO.Layouts.CorpTrdnmLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the CO Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorpTrdnm, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCorpTrdnm;
	combined_dist := DISTRIBUTE(combined, HASH(tradenameid));
	combined_sort := SORT(combined_dist, tradenameid, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_CO.Layouts.CorpTrdnmLayoutBase rollupBase(Corp2_Raw_CO.Layouts.CorpTrdnmLayoutBase L,
																										  Corp2_Raw_CO.Layouts.CorpTrdnmLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																							 
	  SELF                    := L;
	END;
	
	baseCorpTrdnm := ROLLUP(combined_sort,
													rollupBase(LEFT, RIGHT),
													RECORD,
													EXCEPT dt_first_received, dt_last_received,
													LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CO.Filenames(pversion).Base.CorpTrdnm.New, baseCorpTrdnm, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CO.Build_Bases_CorpTrdnm attribute')
									 );

END;