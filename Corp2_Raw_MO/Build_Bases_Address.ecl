IMPORT tools, corp2;

EXPORT Build_Bases_Address(
	STRING																							pfiledate,
	STRING																							pversion,
	Boolean 																						pUseOtherEnvironment,
	DATASET(Corp2_Raw_MO.Layouts.AddressLayoutIn)				pInAddress   	= Corp2_Raw_MO.Files(pfiledate,pUseOtherEnvironment).Input.Address.Logical,
	DATASET(Corp2_Raw_MO.Layouts.AddressLayoutBase)			pBaseAddress 	= IF(Corp2_Raw_MO._Flags.Base.Address, Corp2_Raw_MO.Files(,pUseOtherEnvironment := FALSE).Base.Address.qa, 	DATASET([], Corp2_Raw_MO.Layouts.AddressLayoutBase))
) := MODULE

	Corp2_Raw_MO.Layouts.AddressLayoutBase standardize_input(Corp2_Raw_MO.Layouts.AddressLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the  Address update file & stamp received dates , action_flag (U=update) and projecting it into the base layout
	workingUpdate := PROJECT(pInAddress, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseAddress;
	combined_dist := DISTRIBUTE(combined, HASH(CorpID));
	combined_sort := SORT(combined_dist, CorpID, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_MO.Layouts.AddressLayoutBase rollupBase(Corp2_Raw_MO.Layouts.AddressLayoutBase L,
																										Corp2_Raw_MO.Layouts.AddressLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);

	tools.mac_WriteFile(Corp2_Raw_MO.Filenames(pversion).Base.Address.New, baseactions, Build_Address_Base);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Address_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_MO.Build_Bases_Address attribute')
									 );

END;
