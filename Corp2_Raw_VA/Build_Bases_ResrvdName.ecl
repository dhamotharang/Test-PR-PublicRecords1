IMPORT corp2, tools;

EXPORT Build_Bases_ResrvdName(
	STRING																					   pfiledate,
	STRING																					   pversion,
	BOOLEAN																					   puseprod,
	DATASET(Corp2_Raw_VA.Layouts.ReservedLayoutIn)		 pInResrvdName   	= Corp2_Raw_VA.Files(pfiledate,puseprod).Input.ResrvdName.Logical,
	DATASET(Corp2_Raw_VA.Layouts.ReservedLayoutBase)	 pBaseResrvdName 	= IF(Corp2_Raw_VA._Flags.Base.ResrvdName, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.ResrvdName.qa, 	DATASET([], Corp2_Raw_VA.Layouts.ReservedLayoutBase))
) := MODULE

	Corp2_Raw_VA.Layouts.ReservedLayoutBase standardize_input(Corp2_Raw_VA.Layouts.ReservedLayoutIn L) := TRANSFORM
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF                    := L;
		SELF                    := [];
	END;

	// Take the VA Reserved Names update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInResrvdName, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseResrvdName;
	combined_dist := DISTRIBUTE(combined, HASH(res_number));
	combined_sort := SORT(combined_dist, res_number, RECORD, EXCEPT dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_VA.Layouts.ReservedLayoutBase rollupBase(Corp2_Raw_VA.Layouts.ReservedLayoutBase L,
																							       Corp2_Raw_VA.Layouts.ReservedLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF                    := L;
	END;
	
	baseResrvdName		 := ROLLUP(	combined_sort,
												      	rollupBase(LEFT, RIGHT),
												     	  RECORD,
													      EXCEPT dt_first_received, dt_last_received,
												       	LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_VA.Filenames(pversion).Base.ResrvdName.New, baseResrvdName, Build_ResrvdName_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_ResrvdName_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_VA.Build_Bases_ResrvdName attribute')
									 );

END;
