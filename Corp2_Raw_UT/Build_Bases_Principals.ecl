IMPORT tools, Corp2;

EXPORT Build_Bases_Principals(
	STRING																										pfiledate,
	STRING																										pversion,
	Boolean 																									pUseOtherEnvironment,
	DATASET(Corp2_Raw_UT.Layouts.PrincipalsLayoutIn)					pInPrincipals   	= Corp2_Raw_UT.Files(pfiledate,pUseOtherEnvironment).Input.Principals.Logical,
	DATASET(Corp2_Raw_UT.Layouts.PrincipalsLayoutBase)				pBasePrincipals 	= IF(Corp2_Raw_UT._Flags.Base.Principals, Corp2_Raw_UT.Files(,pUseOtherEnvironment := FALSE).Base.Principals.qa, 	DATASET([], Corp2_Raw_UT.Layouts.PrincipalsLayoutBase))
) := MODULE

	Corp2_Raw_UT.Layouts.PrincipalsLayoutBase standardize_input(Corp2_Raw_UT.Layouts.PrincipalsLayoutIn L) := TRANSFORM
		
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 										:= L;
		
	end;

	// Take the  Principals update file, stamp received dates & action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInPrincipals, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBasePrincipals;
	combined_dist := DISTRIBUTE(combined, HASH(Prin_Entity_ID));
	combined_sort := SORT(combined_dist, Prin_Entity_ID, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_UT.Layouts.PrincipalsLayoutBase rollupBase(Corp2_Raw_UT.Layouts.PrincipalsLayoutBase L,
																											 Corp2_Raw_UT.Layouts.PrincipalsLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);																								 
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_UT.Filenames(pversion).Base.Principals.New, baseactions, Build_Principals_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Principals_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_UT.Build_Bases_Principals attribute')
									 );

END;
