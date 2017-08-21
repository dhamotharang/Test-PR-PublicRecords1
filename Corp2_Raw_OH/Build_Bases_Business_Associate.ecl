IMPORT tools, Corp2;

EXPORT Build_Bases_Business_Associate(
	STRING																										pfiledate,
	STRING																										pversion,
	BOOLEAN																					          pUseOtherEnvironment,
	DATASET(Corp2_Raw_OH.Layouts.Business_AssociateLayoutIn)	pInBusiness_Associate   	= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Business_Associate.Logical,
	DATASET(Corp2_Raw_OH.Layouts.Business_AssociateLayoutBase)pBaseBusiness_Associate 	= IF(Corp2_Raw_OH._Flags.Base.Business_Associate, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Business_Associate.qa, 	DATASET([], Corp2_Raw_OH.Layouts.Business_AssociateLayoutBase))
) := MODULE

	Corp2_Raw_OH.Layouts.Business_AssociateLayoutBase standardize_input(Corp2_Raw_OH.Layouts.Business_AssociateLayoutIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take the Business_Associate update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInBusiness_Associate, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseBusiness_Associate;
	combined_dist := DISTRIBUTE(combined, HASH(Charter_Num));
	combined_sort := SORT(combined_dist, Charter_Num, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_OH.Layouts.Business_AssociateLayoutBase rollupBase(Corp2_Raw_OH.Layouts.Business_AssociateLayoutBase L,
																															 Corp2_Raw_OH.Layouts.Business_AssociateLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_OH.Filenames(pversion).Base.Business_Associate.New, baseactions, Build_Business_Associate_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Business_Associate_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OH.Build_Bases_Business_Associate attribute')
									 );

END;
