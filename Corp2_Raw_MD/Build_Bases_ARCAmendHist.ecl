IMPORT tools, Corp2;

EXPORT Build_Bases_ARCAmendHist(
	STRING																						pfiledate,
	STRING																						pversion,
	BOOLEAN																	        	pUseOtherEnvironment,	
	DATASET(Corp2_Raw_MD.Layouts.AmendHistIn)					pInARCAmendHist 		= Corp2_Raw_MD.Files(pfiledate,pUseOtherEnvironment).Input.ARCAmendHist.logical,
	DATASET(Corp2_Raw_MD.Layouts.AmendHistLayoutBase)	pBaseARCAmendHist 	= IF(Corp2_Raw_MD._Flags.Base.ARCAmendHist, Corp2_Raw_MD.Files(,pUseOtherEnvironment := FALSE).Base.ARCAmendHist.qa, 	DATASET([], Corp2_Raw_MD.Layouts.AmendHistLayoutBase))
) := MODULE

  //AmendHist & ARCAmendHist both have same layout	
	Corp2_Raw_MD.Layouts.AmendHistLayoutBase standardize_input(Corp2_Raw_MD.Layouts.AmendHistIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;
	
	//Take the ARCAmendHist update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInARCAmendHist, standardize_input(LEFT));

	//Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseARCAmendHist;
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

	tools.mac_WriteFile(Corp2_Raw_MD.Filenames(pversion).Base.ARCAmendHist.New, baseactions, Build_ARCAmendHist_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_ARCAmendHist_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MD.Build_Bases_ARCAmendHist attribute')
									 );

END;
