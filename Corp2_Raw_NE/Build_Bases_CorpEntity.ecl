IMPORT tools, Corp2;

EXPORT Build_Bases_CorpEntity(
	STRING																						 pfiledate,
	STRING																						 pversion,
	Boolean 																					 pUseOtherEnvironment,
	DATASET(Corp2_Raw_NE.Layouts.CorpEntityLayoutIn)	 pInCorpEntity   	= Corp2_Raw_NE.Files(pfiledate,pUseOtherEnvironment := FALSE).Input.CorpEntity.Logical,
	DATASET(Corp2_Raw_NE.Layouts.CorpEntityLayoutBase) pBaseCorpEntity  = IF(Corp2_Raw_NE._Flags.Base.CorpEntity, Corp2_Raw_NE.Files(,pUseOtherEnvironment := FALSE).Base.CorpEntity.qa, 	DATASET([], Corp2_Raw_NE.Layouts.CorpEntityLayoutBase))
) := MODULE

	Corp2_Raw_NE.Layouts.CorpEntityLayoutBase standardize_input(Corp2_Raw_NE.Layouts.CorpEntityLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the CorpEntity update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInCorpEntity, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseCorpEntity;
	combined_dist := DISTRIBUTE(combined, HASH(AcctNumber));
	combined_sort := SORT(combined_dist, AcctNumber, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_NE.Layouts.CorpEntityLayoutBase rollupBase(Corp2_Raw_NE.Layouts.CorpEntityLayoutBase L,
																											 Corp2_Raw_NE.Layouts.CorpEntityLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															RollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_NE.Filenames(pversion).Base.CorpEntity.New, baseactions, Build_CorpEntity_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_CorpEntity_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NE.Build_Bases_CorpEntity attribute')
									 );

END;
