IMPORT tools, Corp2;

EXPORT Build_Bases_Business(
	STRING																					pfiledate,
	STRING																					pversion,
	BOOLEAN																					pUseOtherEnvironment,
	DATASET(Corp2_Raw_OH.Layouts.BusinessLayoutIn)	pInBusiness   	= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Business.Logical,
	DATASET(Corp2_Raw_OH.Layouts.BusinessLayoutBase)pBaseBusiness 	= IF(Corp2_Raw_OH._Flags.Base.Business, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Business.qa, 	DATASET([], Corp2_Raw_OH.Layouts.BusinessLayoutBase))
) := MODULE

	Corp2_Raw_OH.Layouts.BusinessLayoutBase standardize_input(Corp2_Raw_OH.Layouts.BusinessLayoutIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take the Business update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInBusiness, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseBusiness;
	combined_dist := DISTRIBUTE(combined, HASH(Charter_Num));
	combined_sort := SORT(combined_dist, Charter_Num, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_OH.Layouts.BusinessLayoutBase rollupBase(Corp2_Raw_OH.Layouts.BusinessLayoutBase L,
																														 Corp2_Raw_OH.Layouts.BusinessLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_OH.Filenames(pversion).Base.Business.New, baseactions, Build_Business_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Business_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OH.Build_Bases_Business attribute')
									 );

END;
