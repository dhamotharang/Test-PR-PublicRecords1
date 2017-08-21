IMPORT tools, Corp2;

EXPORT Build_Bases_Explanation(
	STRING																						pfiledate,
	STRING																						pversion,
	BOOLEAN																				  	pUseOtherEnvironment,
	DATASET(Corp2_Raw_OH.Layouts.ExplanationLayoutIn)	pInExplanation   	= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Explanation.Logical,
	DATASET(Corp2_Raw_OH.Layouts.ExplanationLayoutBase)pBaseExplanation = IF(Corp2_Raw_OH._Flags.Base.Explanation, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Explanation.qa, 	DATASET([], Corp2_Raw_OH.Layouts.ExplanationLayoutBase))
) := MODULE

	Corp2_Raw_OH.Layouts.ExplanationLayoutBase standardize_input(Corp2_Raw_OH.Layouts.ExplanationLayoutIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take the Explanation update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInExplanation, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseExplanation;
	combined_dist := DISTRIBUTE(combined, HASH(Charter_Num));
	combined_sort := SORT(combined_dist, Charter_Num, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_OH.Layouts.ExplanationLayoutBase rollupBase(Corp2_Raw_OH.Layouts.ExplanationLayoutBase L,
																												Corp2_Raw_OH.Layouts.ExplanationLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_OH.Filenames(pversion).Base.Explanation.New, baseactions, Build_Explanation_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Explanation_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OH.Build_Bases_Explanation attribute')
									 );

END;
