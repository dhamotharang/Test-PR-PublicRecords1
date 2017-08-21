IMPORT tools, Corp2;

EXPORT Build_Bases_CorpNames(
	STRING																								pfiledate,
	STRING																								pversion,
	Boolean 																							pUseOtherEnvironment,
	DATASET(Corp2_Raw_AR.Layouts.CorpNamesLayoutIn)				pInCorpNames   	= Corp2_Raw_AR.Files(pfiledate,pUseOtherEnvironment).Input.CorpNames.logical,
	DATASET(Corp2_Raw_AR.Layouts.CorpNamesLayoutBase)			pBaseCorpNames 	= IF(Corp2_Raw_AR._Flags.Base.CorpNames, Corp2_Raw_AR.Files(,pUseOtherEnvironment := FALSE).Base.CorpNames.qa, 	DATASET([], Corp2_Raw_AR.Layouts.CorpNamesLayoutBase))
) := MODULE

	Corp2_Raw_AR.Layouts.CorpNamesLayoutBase standardize_input(Corp2_Raw_AR.Layouts.CorpNamesLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 										:= L;
		
	end;

	// Take the AR corp's update file,stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInCorpNames, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseCorpNames;
	combined_dist := DISTRIBUTE(combined, HASH(Filing_Number));
	combined_sort := SORT(combined_dist, Filing_Number,RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_AR.Layouts.CorpNamesLayoutBase rollupBase( Corp2_Raw_AR.Layouts.CorpNamesLayoutBase L,
																											 Corp2_Raw_AR.Layouts.CorpNamesLayoutBase R ) := TRANSFORM
																											
    SELF.dt_first_received	:=  Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:=  Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:=  L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD, 
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL
														);
															
	tools.mac_WriteFile(Corp2_Raw_AR.Filenames(pversion).Base.CorpNames.New, baseactions, Build_CorpNames_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_CorpNames_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_AR.Build_Bases_CorpNames attribute')
									 );

END;
