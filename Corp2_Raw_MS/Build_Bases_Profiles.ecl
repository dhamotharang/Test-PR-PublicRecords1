IMPORT tools, corp2;

EXPORT Build_Bases_Profiles(
	STRING																						pfiledate,
	STRING																						pversion,
	BOOLEAN                                           puseprod,
	DATASET(Corp2_Raw_MS.Layouts.ProfilesLayoutIn)		pInProfiles  	= Corp2_Raw_MS.Files(pfiledate,puseprod).Input.Profiles.logical,
	DATASET(Corp2_Raw_MS.Layouts.ProfilesLayoutBase)	pBaseProfiles = IF(Corp2_Raw_MS._Flags.Base.Profiles, Corp2_Raw_MS.Files(,pUseOtherEnvironment := FALSE).Base.Profiles.qa, 	DATASET([], Corp2_Raw_MS.Layouts.ProfilesLayoutBase))
) := MODULE

	Corp2_Raw_MS.Layouts.ProfilesLayoutBase standardize_input(Corp2_Raw_MS.Layouts.ProfilesLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the Profiles update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInProfiles, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseProfiles;
	combined_dist := DISTRIBUTE(combined, HASH(EntityId));
	combined_sort := SORT(combined_dist, EntityId, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_MS.Layouts.ProfilesLayoutBase rollupBase(	Corp2_Raw_MS.Layouts.ProfilesLayoutBase L,
																											Corp2_Raw_MS.Layouts.ProfilesLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseProfiles			 := ROLLUP(combined_sort,
															 rollupBase(LEFT, RIGHT),
															 RECORD,
															 EXCEPT dt_last_received, dt_first_received,
															 LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_MS.Filenames(pversion).Base.Profiles.New, baseProfiles, Build_Profiles_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Profiles_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MS.Build_Bases_Profiles attribute')
									 );

END;
