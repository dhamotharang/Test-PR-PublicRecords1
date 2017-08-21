IMPORT tools, Corp2;

EXPORT Build_Bases_Authorized_Share(
	STRING																										pfiledate,
	STRING																										pversion,
	BOOLEAN																					          pUseOtherEnvironment,
	DATASET(Corp2_Raw_OH.Layouts.Authorized_ShareLayoutIn)		pInAuthorized_Share   	= Corp2_Raw_OH.Files(pfiledate,pUseOtherEnvironment).Input.Authorized_Share.Logical,
	DATASET(Corp2_Raw_OH.Layouts.Authorized_ShareLayoutBase)	pBaseAuthorized_Share 	= IF(Corp2_Raw_OH._Flags.Base.Authorized_Share, Corp2_Raw_OH.Files(,pUseOtherEnvironment := FALSE).Base.Authorized_Share.qa, 	DATASET([], Corp2_Raw_OH.Layouts.Authorized_ShareLayoutBase))
) := MODULE

	Corp2_Raw_OH.Layouts.Authorized_ShareLayoutBase standardize_input(Corp2_Raw_OH.Layouts.Authorized_ShareLayoutIn L) := TRANSFORM
	
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF 									 	:= L;
		
	END;

	// Take the Authorized_Share update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInAuthorized_Share, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseAuthorized_Share;
	combined_dist := DISTRIBUTE(combined, HASH(Charter_Num));
	combined_sort := SORT(combined_dist, Charter_Num, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_OH.Layouts.Authorized_ShareLayoutBase rollupBase(Corp2_Raw_OH.Layouts.Authorized_ShareLayoutBase L,
																														 Corp2_Raw_OH.Layouts.Authorized_ShareLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_OH.Filenames(pversion).Base.Authorized_Share.New, baseactions, Build_Authorized_Share_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Authorized_Share_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OH.Build_Bases_Authorized_Share attribute')
									 );

END;
