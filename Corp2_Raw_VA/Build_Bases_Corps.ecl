IMPORT corp2, tools;

EXPORT Build_Bases_Corps(
	STRING																						pfiledate,
	STRING																						pversion,
	BOOLEAN																						puseprod,
	DATASET(Corp2_Raw_VA.Layouts.CorpsLayoutIn)				pInCorps   	= Corp2_Raw_VA.Files(pfiledate,puseprod).Input.Corps.Logical,
	DATASET(Corp2_Raw_VA.Layouts.CorpsLayoutBase)			pBaseCorps 	= IF(Corp2_Raw_VA._Flags.Base.Corps, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.Corps.qa, 	DATASET([], Corp2_Raw_VA.Layouts.CorpsLayoutBase))
) := MODULE

	Corp2_Raw_VA.Layouts.CorpsLayoutBase standardize_input(Corp2_Raw_VA.Layouts.CorpsLayoutIn L) := TRANSFORM
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF                    := L;
		SELF                    := [];
	END;

	// Take the VA Corps update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInCorps, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseCorps;
	combined_dist := DISTRIBUTE(combined, HASH(corps_entity_id));
	combined_sort := SORT(combined_dist, corps_entity_id, RECORD, EXCEPT dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_VA.Layouts.CorpsLayoutBase rollupBase(Corp2_Raw_VA.Layouts.CorpsLayoutBase L,
																									Corp2_Raw_VA.Layouts.CorpsLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF                    := L;
	END;
	
	baseCorps			 := ROLLUP(	combined_sort,
														rollupBase(LEFT, RIGHT),
														RECORD,
														EXCEPT dt_first_received, dt_last_received,
														LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_VA.Filenames(pversion).Base.Corps.New, baseCorps, Build_Corps_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Corps_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_VA.Build_Bases_Corps attribute')
									 );

END;
