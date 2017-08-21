IMPORT tools, corp2;

EXPORT Build_Bases_Filing(
	STRING																					pfiledate,
	STRING																					pversion,
	Boolean 																				pUseOtherEnvironment,
	DATASET(Corp2_Raw_MO.Layouts.FilingLayoutIn)		pInFiling   	= Corp2_Raw_MO.Files(pfiledate,pUseOtherEnvironment).Input.Filing.Logical,
	DATASET(Corp2_Raw_MO.Layouts.FilingLayoutBase)	pBaseFiling 	= IF(Corp2_Raw_MO._Flags.Base.Filing, Corp2_Raw_MO.Files(,pUseOtherEnvironment := FALSE).Base.Filing.qa, 	DATASET([], Corp2_Raw_MO.Layouts.FilingLayoutBase))
) := MODULE

	Corp2_Raw_MO.Layouts.FilingLayoutBase standardize_input(Corp2_Raw_MO.Layouts.FilingLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the  Filing update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInFiling, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseFiling;
	combined_dist := DISTRIBUTE(combined, HASH(CorpID));
	combined_sort := SORT(combined_dist, CorpID, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_MO.Layouts.FilingLayoutBase rollupBase(Corp2_Raw_MO.Layouts.FilingLayoutBase L,
																									 Corp2_Raw_MO.Layouts.FilingLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_MO.Filenames(pversion).Base.Filing.New, baseactions, Build_Filing_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Filing_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MO.Build_Bases_Filing Attribute')
									 );

END;
