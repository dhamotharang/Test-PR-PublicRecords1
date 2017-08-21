IMPORT tools, Corp2;

EXPORT Build_Bases_BusComment(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																	        			pUseOtherEnvironment,	
	DATASET(Corp2_Raw_MD.Layouts.BusCommentIn)						pInBusComment   	= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.BusComment.logical,
	DATASET(Corp2_Raw_MD.Layouts.BusCommentLayoutBase)		pBaseBusComment 	= IF(Corp2_Raw_MD._Flags.Base.BusComment, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.BusComment.qa, 	DATASET([], Corp2_Raw_MD.Layouts.BusCommentLayoutBase))
) := MODULE

	Corp2_Raw_MD.Layouts.BusCommentLayoutBase standardize_input(Corp2_Raw_MD.Layouts.BusCommentIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take the BusComment update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInBusComment, standardize_input(LEFT));

  // Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseBusComment;
	combined_dist := DISTRIBUTE(combined, HASH(id_comments));
	combined_sort := SORT(combined_dist,RECORD,EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_MD.Layouts.BusCommentLayoutBase rollupBase(Corp2_Raw_MD.Layouts.BusCommentLayoutBase L,
																											 Corp2_Raw_MD.Layouts.BusCommentLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_MD.Filenames(pversion).Base.BusComment.New, baseactions, Build_BusComment_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_BusComment_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MD.Build_Bases_BusComment attribute')
									 );

END;
