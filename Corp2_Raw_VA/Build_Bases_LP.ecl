IMPORT corp2, tools;

EXPORT Build_Bases_LP(
	STRING																					pfiledate,
	STRING																					pversion,
	BOOLEAN																					puseprod,
	DATASET(Corp2_Raw_VA.Layouts.LPLayoutIn)				pInLP   	= Corp2_Raw_VA.Files(pfiledate,puseprod).Input.LP.Logical,
	DATASET(Corp2_Raw_VA.Layouts.LPLayoutBase)			pBaseLP 	= IF(Corp2_Raw_VA._Flags.Base.LP, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.LP.qa, 	DATASET([], Corp2_Raw_VA.Layouts.LPLayoutBase))
) := MODULE

	Corp2_Raw_VA.Layouts.LPLayoutBase standardize_input(Corp2_Raw_VA.Layouts.LPLayoutIn L) := TRANSFORM
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF                    := L;
		SELF                    := [];
	END;

	// Take the VA LP update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInLP, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseLP;
	combined_dist := DISTRIBUTE(combined, HASH(LP_entity_id));
	combined_sort := SORT(combined_dist, LP_entity_id, RECORD, EXCEPT dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_VA.Layouts.LPLayoutBase rollupBase(Corp2_Raw_VA.Layouts.LPLayoutBase L,
																							 Corp2_Raw_VA.Layouts.LPLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF                    := L;
	END;
	
	baseLP			 := ROLLUP(	combined_sort,
													rollupBase(LEFT, RIGHT),
													RECORD,
													EXCEPT dt_first_received, dt_last_received,
													LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_VA.Filenames(pversion).Base.LP.New, baseLP, Build_LP_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_LP_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_VA.Build_Bases_LP attribute')
									 );

END;
