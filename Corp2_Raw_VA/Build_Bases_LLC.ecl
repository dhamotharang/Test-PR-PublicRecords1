IMPORT corp2, tools;

EXPORT Build_Bases_LLC(
	STRING																					pfiledate,
	STRING																					pversion,
	BOOLEAN																					puseprod,
	DATASET(Corp2_Raw_VA.Layouts.LLCLayoutIn)				pInLLC   	= Corp2_Raw_VA.Files(pfiledate,puseprod).Input.LLC.Logical,
	DATASET(Corp2_Raw_VA.Layouts.LLCLayoutBase)			pBaseLLC 	= IF(Corp2_Raw_VA._Flags.Base.LLC, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.LLC.qa, 	DATASET([], Corp2_Raw_VA.Layouts.LLCLayoutBase))
) := MODULE

	Corp2_Raw_VA.Layouts.LLCLayoutBase standardize_input(Corp2_Raw_VA.Layouts.LLCLayoutIn L) := TRANSFORM
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF                    := L;
		SELF                    := [];
	END;

	// Take the VA LLC update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInLLC, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseLLC;
	combined_dist := DISTRIBUTE(combined, HASH(LLC_entity_id));
	combined_sort := SORT(combined_dist, LLC_entity_id, RECORD, EXCEPT dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_VA.Layouts.LLCLayoutBase rollupBase(Corp2_Raw_VA.Layouts.LLCLayoutBase L,
																								Corp2_Raw_VA.Layouts.LLCLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF                    := L;
	END;
	
	baseLLC			 := ROLLUP(	combined_sort,
													rollupBase(LEFT, RIGHT),
													RECORD,
													EXCEPT dt_first_received, dt_last_received,
													LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_VA.Filenames(pversion).Base.LLC.New, baseLLC, Build_LLC_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_LLC_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_VA.Build_Bases_LLC attribute')
									 );

END;
