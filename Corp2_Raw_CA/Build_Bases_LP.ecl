IMPORT tools, corp2;

EXPORT Build_Bases_LP(
	STRING  pfiledate,
	STRING  pversion,
	BOOLEAN	puseprod,
	DATASET(Corp2_Raw_CA.Layouts.LPLayoutIn)	 pInLP   	= Corp2_Raw_CA.Files(pfiledate,pUseProd).Input.LP.logical,
	DATASET(Corp2_Raw_CA.Layouts.LPLayoutBase) pBaseLP 	= IF(Corp2_Raw_CA._Flags.Base.LP, Corp2_Raw_CA.Files(,pUseOtherEnvironment := FALSE).Base.LP.qa, 	DATASET([], Corp2_Raw_CA.Layouts.LPLayoutBase))
) := MODULE

	Corp2_Raw_CA.Layouts.LPLayoutBase standardize_input(Corp2_Raw_CA.Layouts.LPLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the LP update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInLP, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseLP;
	combined_dist := DISTRIBUTE(combined, HASH(file_number));
	combined_sort := SORT(combined_dist, file_number, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_CA.Layouts.LPLayoutBase rollupBase( Corp2_Raw_CA.Layouts.LPLayoutBase L,
																								Corp2_Raw_CA.Layouts.LPLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseLP			 := ROLLUP(	combined_sort,
													rollupBase(LEFT, RIGHT),
													RECORD,
													EXCEPT dt_last_received, dt_first_received,
													LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_CA.Filenames(pversion).Base.LP.New, baseLP, Build_LP_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_LP_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_CA.Build_Bases_LP attribute')
									 );

END;
