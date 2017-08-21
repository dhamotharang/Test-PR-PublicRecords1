IMPORT tools, Corp2;

EXPORT Build_Bases_CorpData(
	STRING																								pfiledate,
	STRING																								pversion,	
	Boolean 																							pUseOtherEnvironment,
	DATASET(Corp2_Raw_AR.Layouts.CorpDataLayoutIn)				pInCorpData   	= Corp2_Raw_AR.Files(pfiledate,pUseOtherEnvironment).Input.CorpData.logical,
	DATASET(Corp2_Raw_AR.Layouts.CorpDataLayoutBase)			pBaseCorpData 	= IF(Corp2_Raw_AR._Flags.Base.CorpData, Corp2_Raw_AR.Files(,pUseOtherEnvironment := FALSE).Base.CorpData.qa, 	DATASET([], Corp2_Raw_AR.Layouts.CorpDataLayoutBase))
) := MODULE

	Corp2_Raw_AR.Layouts.CorpDataLayoutBase standardize_input(Corp2_Raw_AR.Layouts.CorpDataLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 										:= L;
		
	end;

	// Take the AR corp's update file,stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInCorpData, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseCorpData;
	combined_dist := DISTRIBUTE(combined, HASH(Filing_Number));
	combined_sort := SORT(combined_dist, Filing_Number,RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_AR.Layouts.CorpDataLayoutBase rollupBase(	Corp2_Raw_AR.Layouts.CorpDataLayoutBase L,
																											Corp2_Raw_AR.Layouts.CorpDataLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD, 
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL
														);
	
	tools.mac_WriteFile(Corp2_Raw_AR.Filenames(pversion).Base.CorpData.New, baseactions, Build_CorpData_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_CorpData_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_AR.Build_Bases_CorpData attribute')
									 );

END;
