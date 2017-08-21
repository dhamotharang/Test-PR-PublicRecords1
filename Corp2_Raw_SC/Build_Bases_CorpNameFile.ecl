IMPORT corp2, tools;

EXPORT Build_Bases_CorpNameFile(
	STRING																						pfiledate,
	STRING																						pversion,
	BOOLEAN																						puseprod,
	DATASET(Corp2_Raw_SC.Layouts.CorpNameLayoutIn)		pInCorpName   = Corp2_Raw_SC.Files(pfiledate,puseprod).Input.CorpName.Logical,
	DATASET(Corp2_Raw_SC.Layouts.CorpNameLayoutBase)	pBaseCorpName = IF(Corp2_Raw_SC._Flags.Base.CorpName, Corp2_Raw_SC.Files(,pUseOtherEnvironment := FALSE).Base.CorpName.qa, DATASET([], Corp2_Raw_SC.Layouts.CorpNameLayoutBase))
) := MODULE

	Corp2_Raw_SC.Layouts.CorpNameLayoutBase standardize_input(Corp2_Raw_SC.Layouts.CorpNameLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the current update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorpName, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCorpName;
	combined_dist := DISTRIBUTE(combined, HASH(corpdbid));
	combined_sort := SORT(combined_dist, corpdbid, record, except dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_SC.Layouts.CorpNameLayoutBase rollupBase(Corp2_Raw_SC.Layouts.CorpNameLayoutBase L,
																										 Corp2_Raw_SC.Layouts.CorpNameLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																							 
	  SELF                    := L;
	END;
	
	baseCorpName 							:= ROLLUP(combined_sort,
																			rollupBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);
	// Return
	tools.mac_WriteFile(Corp2_Raw_SC.Filenames(pversion).Base.CorpName.New, baseCorpName, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_SC.Build_Bases_CorpName attribute')
									 );

END;