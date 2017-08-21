IMPORT corp2, tools;

EXPORT Build_Bases_CorpMstr(
	STRING																						pfiledate,
	STRING																						ptmfiledate,	
	STRING																						pversion,
	BOOLEAN																						puseprod,	
	DATASET(Corp2_Raw_CO.Layouts.CorpMstrLayoutIn)		pInCorpMstr   = Corp2_Raw_CO.Files(pfiledate,ptmfiledate,pversion,pUseProd).Input.CorpMstr.Logical,
	DATASET(Corp2_Raw_CO.Layouts.CorpMstrLayoutBase)	pBaseCorpMstr = IF(Corp2_Raw_CO._Flags().Base.CorpMstr, Corp2_Raw_CO.Files(,,,pUseOtherEnvironment := FALSE).Base.CorpMstr.qa, DATASET([], Corp2_Raw_CO.Layouts.CorpMstrLayoutBase))
) := MODULE

	Corp2_Raw_CO.Layouts.CorpMstrLayoutBase standardize_input(Corp2_Raw_CO.Layouts.CorpMstrLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the CO Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorpMstr, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCorpMstr;
	combined_dist := DISTRIBUTE(combined, HASH(EntityID));
	combined_sort := SORT(combined_dist, EntityID, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_CO.Layouts.CorpMstrLayoutBase rollupBase(Corp2_Raw_CO.Layouts.CorpMstrLayoutBase L,
																										 Corp2_Raw_CO.Layouts.CorpMstrLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																							 
	  SELF                    := L;
	END;
	
	baseCorpMstr := ROLLUP(	combined_sort,
													rollupBase(LEFT, RIGHT),
													RECORD,
													EXCEPT dt_first_received, dt_last_received,
													LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CO.Filenames(pversion).Base.CorpMstr.New, baseCorpMstr, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CO.Build_Bases_CorpMstr attribute')
									 );

END;