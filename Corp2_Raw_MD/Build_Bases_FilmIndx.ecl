IMPORT tools, Corp2;

EXPORT Build_Bases_FilmIndx(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																	        			pUseOtherEnvironment,
	DATASET(Corp2_Raw_MD.Layouts.FilmIndxIn)							pInFilmIndx   	= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.FilmIndx.logical,
	DATASET(Corp2_Raw_MD.Layouts.FilmIndxLayoutBase)			pBaseFilmIndx 	= IF(Corp2_Raw_MD._Flags.Base.FilmIndx, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.FilmIndx.qa, 	DATASET([], Corp2_Raw_MD.Layouts.FilmIndxLayoutBase))
) := MODULE

	Corp2_Raw_MD.Layouts.FilmIndxLayoutBase standardize_input(Corp2_Raw_MD.Layouts.FilmIndxIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;
	
	// Take FilmIndx update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInFilmIndx, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseFilmIndx;
	combined_sort := SORT(combined, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received);  //payload file , not adding distribute
	
	Corp2_Raw_MD.Layouts.FilmIndxLayoutBase rollupBase(Corp2_Raw_MD.Layouts.FilmIndxLayoutBase L,
																										 Corp2_Raw_MD.Layouts.FilmIndxLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received
														);
															
	tools.mac_WriteFile(Corp2_Raw_MD.Filenames(pversion).Base.FilmIndx.New, baseactions, Build_FilmIndx_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_FilmIndx_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MD.Build_Bases_FilmIndx attribute')
									 );

END;
