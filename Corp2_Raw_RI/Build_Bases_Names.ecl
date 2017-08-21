IMPORT tools, Corp2;

EXPORT Build_Bases_Names(
	STRING																		pfiledate,
	STRING																	  pversion,
	BOOLEAN                                   pUseOtherEnvironment,
	DATASET(Corp2_Raw_RI.Layouts.NamesIn)			pInNames   	= Corp2_Raw_RI.Files(pfiledate,pUseOtherEnvironment).Input.Names.logical,
	DATASET(Corp2_Raw_RI.Layouts.NamesBase)		pBaseNames 	= IF(Corp2_Raw_RI._Flags.Base.Names, Corp2_Raw_RI.Files(,pUseOtherEnvironment := FALSE).Base.Names.qa, 	DATASET([], Corp2_Raw_RI.Layouts.NamesBase))
) := MODULE

	Corp2_Raw_RI.Layouts.NamesBase standardize_input(Corp2_Raw_RI.Layouts.NamesIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take the Names update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInNames, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseNames;
	combined_dist := DISTRIBUTE(combined, HASH(Entity_id));
	combined_sort := SORT(combined_dist, Entity_id, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_RI.Layouts.NamesBase rollupBase(Corp2_Raw_RI.Layouts.NamesBase L  ,Corp2_Raw_RI.Layouts.NamesBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_RI.Filenames(pversion).Base.Names.New, baseactions, Build_Names_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Names_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_RI.Build_Bases_Names attribute')
									 );

END;
