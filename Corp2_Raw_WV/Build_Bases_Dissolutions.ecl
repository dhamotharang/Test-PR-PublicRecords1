IMPORT tools, Corp2;

EXPORT Build_Bases_Dissolutions(
	STRING																								pfiledate,
	STRING																								pversion,	
	Boolean 																							pUseOtherEnvironment,
	DATASET(Corp2_Raw_WV.Layouts.DissolutionsLayoutIn)		pInDissolutions   	= Corp2_Raw_WV.Files(pfiledate,pUseOtherEnvironment:= FALSE).Input.Dissolutions.logical,
	DATASET(Corp2_Raw_WV.Layouts.DissolutionsLayoutBase)	pBaseDissolutions 	= IF(Corp2_Raw_WV._Flags.Base.Dissolutions, Corp2_Raw_WV.Files(,pUseOtherEnvironment := FALSE).Base.Dissolutions.qa, 	DATASET([], Corp2_Raw_WV.Layouts.DissolutionsLayoutBase))
) := MODULE

	Corp2_Raw_WV.Layouts.DissolutionsLayoutBase standardize_input(Corp2_Raw_WV.Layouts.DissolutionsLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the Dissolutions update file,stamp received dates & action_flag (U=update) and projecting it into the base layout.
	workingUpdate := PROJECT(pInDissolutions, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseDissolutions;
	combined_dist := DISTRIBUTE(combined, HASH(record_did1));
	combined_sort := SORT(combined_dist,record_did1, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_WV.Layouts.DissolutionsLayoutBase rollupBase(Corp2_Raw_WV.Layouts.DissolutionsLayoutBase L,
																												 Corp2_Raw_WV.Layouts.DissolutionsLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD, EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_WV.Filenames(pversion).Base.Dissolutions.New, baseactions, Build_Dissolutions_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Dissolutions_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_WV.Build_Bases_Dissolutions attribute')
									 );

END;
