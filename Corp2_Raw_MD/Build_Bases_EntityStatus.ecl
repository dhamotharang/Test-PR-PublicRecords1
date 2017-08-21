IMPORT tools, Corp2;

EXPORT Build_Bases_EntityStatus(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																	        			pUseOtherEnvironment,	
	DATASET(Corp2_Raw_MD.Layouts.EntityStatusIn)					pInEntityStatus   	= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.EntityStatus.logical,
	DATASET(Corp2_Raw_MD.Layouts.EntityStatusLayoutBase)	pBaseEntityStatus 	= IF(Corp2_Raw_MD._Flags.Base.EntityStatus, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.EntityStatus.qa, 	DATASET([], Corp2_Raw_MD.Layouts.EntityStatusLayoutBase))
) := MODULE

	Corp2_Raw_MD.Layouts.EntityStatusLayoutBase standardize_input(Corp2_Raw_MD.Layouts.EntityStatusIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take EntityStatus update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInEntityStatus, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseEntityStatus;//Small look table type file , not adding distribute
	combined_sort := SORT(combined, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received);
	
	Corp2_Raw_MD.Layouts.EntityStatusLayoutBase rollupBase(Corp2_Raw_MD.Layouts.EntityStatusLayoutBase L,
																											   Corp2_Raw_MD.Layouts.EntityStatusLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received
														);
															
	tools.mac_WriteFile(Corp2_Raw_MD.Filenames(pversion).Base.EntityStatus.New, baseactions, Build_EntityStatus_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_EntityStatus_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MD.Build_Bases_EntityStatus attribute')
									 );

END;
