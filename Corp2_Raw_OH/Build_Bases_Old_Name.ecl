IMPORT tools, Corp2;

EXPORT Build_Bases_Old_Name(
	STRING																					pfiledate,
	STRING																				  pversion,
	BOOLEAN																			  	pUseOtherEnvironment,
	DATASET(Corp2_Raw_OH.Layouts.Old_NameLayoutIn)	pInOld_Name   	= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Old_Name.Logical,
	DATASET(Corp2_Raw_OH.Layouts.Old_NameLayoutBase)pBaseOld_Name 	= IF(Corp2_Raw_OH._Flags.Base.Old_Name, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Old_Name.qa, 	DATASET([], Corp2_Raw_OH.Layouts.Old_NameLayoutBase))
) := MODULE

	Corp2_Raw_OH.Layouts.Old_NameLayoutBase standardize_input(Corp2_Raw_OH.Layouts.Old_NameLayoutIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take Old_Name update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInOld_Name, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseOld_Name;
	combined_dist := DISTRIBUTE(combined, HASH(Charter_Num));
	combined_sort := SORT(combined_dist, Charter_Num, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_OH.Layouts.Old_NameLayoutBase rollupBase(Corp2_Raw_OH.Layouts.Old_NameLayoutBase L,
																										 Corp2_Raw_OH.Layouts.Old_NameLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_OH.Filenames(pversion).Base.Old_Name.New, baseactions, Build_Old_Name_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Old_Name_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OH.Build_Bases_Old_Name attribute')
									 );

END;
