IMPORT tools, Corp2;

EXPORT Build_Bases_CorpName(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN                                             	pUseProd,
	DATASET(Corp2_Raw_PA.Layouts.CorpNameLayoutIn)				pInCorpName   	= Corp2_Raw_PA.Files(pfiledate,pUseProd).Input.CorpNamePipeDelim,
	DATASET(Corp2_Raw_PA.Layouts.CorpNameLayoutBase)			pBaseCorpName 	= IF(Corp2_Raw_PA._Flags.Base.CorpName, Corp2_Raw_PA.Files(,pUseOtherEnvironment := FALSE).Base.CorpName.qa, 	DATASET([], Corp2_Raw_PA.Layouts.CorpNameLayoutBase))
) := MODULE

	Corp2_Raw_PA.Layouts.CorpNameLayoutBase standardize_input(Corp2_Raw_PA.Layouts.CorpNameLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the PA CorpName update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorpName, standardize_input(LEFT));

	// Combine base and update to determine what's new.
	combined 			:= workingUpdate + pBaseCorpName;
	combined_dist := DISTRIBUTE(combined, HASH(corporationid));
	combined_sort := SORT(combined_dist, corporationid, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_PA.Layouts.CorpNameLayoutBase rollupBase(	Corp2_Raw_PA.Layouts.CorpNameLayoutBase L,
																											Corp2_Raw_PA.Layouts.CorpNameLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseCorpName			 := ROLLUP(combined_sort,
															 rollupBase(LEFT, RIGHT),
															 RECORD,
															 EXCEPT dt_last_received, dt_first_received,
															 LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_PA.Filenames(pversion).Base.CorpName.New, baseCorpName, Build_CorpName_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_CorpName_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_PA.Build_Bases_CorpName attribute')
									 );

END;
