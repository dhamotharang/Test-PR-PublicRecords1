IMPORT corp2, tools;

EXPORT Build_Bases_Officer(
	STRING																					   pfiledate,
	STRING																					   pversion,
	BOOLEAN																					   puseprod,
	DATASET(Corp2_Raw_VA.Layouts.OfficersLayoutIn)		 pInOfficer   	= Corp2_Raw_VA.Files(pfiledate,puseprod).Input.Officer.Logical,
	DATASET(Corp2_Raw_VA.Layouts.OfficersLayoutBase)	 pBaseOfficer 	= IF(Corp2_Raw_VA._Flags.Base.Officer, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.Officer.qa, 	DATASET([], Corp2_Raw_VA.Layouts.OfficersLayoutBase))
) := MODULE

	Corp2_Raw_VA.Layouts.OfficersLayoutBase standardize_input(Corp2_Raw_VA.Layouts.OfficersLayoutIn L) := TRANSFORM
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF                    := L;
		SELF                    := [];
	END;

	// Take the VA Officer update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInOfficer, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseOfficer;
	combined_dist := DISTRIBUTE(combined, HASH(offc_entity_id));
	combined_sort := SORT(combined_dist, offc_entity_id, RECORD, EXCEPT dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_VA.Layouts.OfficersLayoutBase rollupBase(Corp2_Raw_VA.Layouts.OfficersLayoutBase L,
																							        Corp2_Raw_VA.Layouts.OfficersLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF                    := L;
	END;
	
	baseOfficer			 := ROLLUP(	combined_sort,
												     	rollupBase(LEFT, RIGHT),
												     	RECORD,
													    EXCEPT dt_first_received, dt_last_received,
												     	LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_VA.Filenames(pversion).Base.Officer.New, baseOfficer, Build_Officer_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Officer_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_VA.Build_Bases_Officer attribute')
									 );

END;
