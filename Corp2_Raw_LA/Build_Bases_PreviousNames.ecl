IMPORT corp2,tools;

EXPORT Build_Bases_PreviousNames(
	STRING																				 				pfiledate,
	STRING																				 				pversion,
	BOOLEAN																				 				puseprod,	
	DATASET(Corp2_Raw_LA.Layouts.PreviousNamesLayoutIn)	 	pInPreviousNames   = Corp2_Raw_LA.Files(pfiledate,puseprod).Input.PreviousNames.Logical,
	DATASET(Corp2_Raw_LA.Layouts.PreviousNamesLayoutBase) pBasePreviousNames = IF(Corp2_Raw_LA._Flags(puseprod).Base.PreviousNames, Corp2_Raw_LA.Files(,pUseOtherEnvironment := FALSE).Base.PreviousNames.qa, DATASET([], Corp2_Raw_LA.Layouts.PreviousNamesLayoutBase))
) := MODULE

	Corp2_Raw_LA.Layouts.PreviousNamesLayoutBase standardize_input(Corp2_Raw_LA.Layouts.PreviousNamesLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the LA Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInPreviousNames, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasePreviousNames;
	combined_dist := DISTRIBUTE(combined, HASH(pre_entityid));
	combined_sort := SORT(combined_dist, pre_entityid, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_LA.Layouts.PreviousNamesLayoutBase rollupBase(	Corp2_Raw_LA.Layouts.PreviousNamesLayoutBase L,
																														Corp2_Raw_LA.Layouts.PreviousNamesLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	BaseRollup						 := ROLLUP(	combined_sort,
																		rollupBase(LEFT, RIGHT),
																		RECORD,
																		EXCEPT dt_first_received, dt_last_received,
																		LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_LA.Filenames(pversion).Base.PreviousNames.New, BaseRollup, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_LA.Build_Bases_PreviousNames attribute')
									 );

END;