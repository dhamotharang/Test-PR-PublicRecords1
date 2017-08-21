IMPORT tools, Corp2;

EXPORT Build_Bases_AmendHist(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																	        			pUseOtherEnvironment,	
	DATASET(Corp2_Raw_MD.Layouts.AmendHistIn)				      pInAmendHist   	= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.AmendHist.logical,
	DATASET(Corp2_Raw_MD.Layouts.AmendHistLayoutBase)			pBaseAmendHist 	= IF(Corp2_Raw_MD._Flags.Base.AmendHist, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.AmendHist.qa, 	DATASET([], Corp2_Raw_MD.Layouts.AmendHistLayoutBase))
) := MODULE

	Corp2_Raw_MD.Layouts.AmendHistLayoutBase standardize_input(Corp2_Raw_MD.Layouts.AmendHistIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;
	
	//Take the AmendHist update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInAmendHist, standardize_input(LEFT));

	//Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseAmendHist;
	combined_sort := SORT(combined, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received); //payload file , not adding distribute
	
	Corp2_Raw_MD.Layouts.AmendHistLayoutBase rollupBase(Corp2_Raw_MD.Layouts.AmendHistLayoutBase L,
																											Corp2_Raw_MD.Layouts.AmendHistLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received
														);

	tools.mac_WriteFile(Corp2_Raw_MD.Filenames(pversion).Base.AmendHist.New, baseactions, Build_AmendHist_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_AmendHist_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MD.Build_Bases_AmendHist attribute')
									 );

END;
