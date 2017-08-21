IMPORT corp2, tools, ut;

EXPORT Build_Bases_Officer(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN                                               pUseProd,
	DATASET(Corp2_Raw_GA.Layouts.OfficerLayoutIn)					pInOfficer   	= Corp2_Raw_GA.Files(pfiledate,pUseProd).Input.Officer.logical,
	DATASET(Corp2_Raw_GA.Layouts.OfficerLayoutBase)				pBaseOfficer 	= IF(Corp2_Raw_GA._Flags.Base.Officer, Corp2_Raw_GA.Files(,pUseOtherEnvironment := FALSE).Base.Officer.qa, 	DATASET([], Corp2_Raw_GA.Layouts.OfficerLayoutBase))
) := MODULE

	Corp2_Raw_GA.Layouts.OfficerLayoutBase standardize_input(Corp2_Raw_GA.Layouts.OfficerLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the NV Officer update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInOfficer, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseOfficer;
	combined_dist := DISTRIBUTE(combined, HASH(ControlNumber));
	combined_sort := SORT(combined_dist, ControlNumber, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received,LOCAL);
	
	Corp2_Raw_GA.Layouts.OfficerLayoutBase rollupBase(	Corp2_Raw_GA.Layouts.OfficerLayoutBase L,
																											Corp2_Raw_GA.Layouts.OfficerLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_GA.Filenames(pversion).Base.Officer.New, baseactions, Build_Officer_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Officer_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_GA.Build_Bases_Officer attribute')
									 );

END;
