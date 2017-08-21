IMPORT tools, corp2;

EXPORT Build_Bases_Names(
	STRING																				pfiledate,
	STRING																				pversion,
	Boolean 																			pUseOtherEnvironment,
	DATASET(Corp2_Raw_NC.Layouts.NamesLayoutIn)		pInNames   	= Corp2_Raw_NC.Files(pfiledate,pUseOtherEnvironment).Input.Names.logical,
	DATASET(Corp2_Raw_NC.Layouts.NamesLayoutBase)	pBaseNames 	= IF(Corp2_Raw_NC._Flags.Base.Names, Corp2_Raw_NC.Files(,pUseOtherEnvironment := FALSE).Base.Names.qa, 	DATASET([], Corp2_Raw_NC.Layouts.NamesLayoutBase))
) := MODULE

	Corp2_Raw_NC.Layouts.NamesLayoutBase standardize_input(Corp2_Raw_NC.Layouts.NamesLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the Names update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInNames, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseNames;
	combined_dist := DISTRIBUTE(combined, HASH(Name_EntityID));
	combined_sort := SORT(combined_dist, Name_EntityID, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_NC.Layouts.NamesLayoutBase rollupBase(Corp2_Raw_NC.Layouts.NamesLayoutBase L,
																									Corp2_Raw_NC.Layouts.NamesLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NC.Filenames(pversion).Base.Names.New, baseactions, Build_Names_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Names_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NC.Build_Bases_Names attribute')
									 );

END;
