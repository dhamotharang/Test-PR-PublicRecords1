IMPORT tools, Corp2;

EXPORT Build_Bases_Officer(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN                                             	pUseProd,
	DATASET(Corp2_Raw_PA.Layouts.OfficerLayoutIn)					pInOfficer   	= Corp2_Raw_PA.Files(pfiledate,pUseProd).Input.Officer.logical,
	DATASET(Corp2_Raw_PA.Layouts.OfficerLayoutBase)				pBaseOfficer 	= IF(Corp2_Raw_PA._Flags.Base.Officer, Corp2_Raw_PA.Files(,pUseOtherEnvironment := FALSE).Base.Officer.qa, 	DATASET([], Corp2_Raw_PA.Layouts.OfficerLayoutBase))
) := MODULE

	Corp2_Raw_PA.Layouts.OfficerLayoutBase standardize_input(Corp2_Raw_PA.Layouts.OfficerLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the PA Officer update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInOfficer, standardize_input(LEFT));

	// Combine base and update to determine what's new.
	combined 			:= workingUpdate + pBaseOfficer;
	combined_dist := DISTRIBUTE(combined, HASH(corporationid));
	combined_sort := SORT(combined_dist, corporationid, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_PA.Layouts.OfficerLayoutBase rollupBase(	Corp2_Raw_PA.Layouts.OfficerLayoutBase L,
																											Corp2_Raw_PA.Layouts.OfficerLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseOfficer			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_PA.Filenames(pversion).Base.Officer.New, baseOfficer, Build_Officer_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Officer_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_PA.Build_Bases_Officer attribute')
									 );

END;
