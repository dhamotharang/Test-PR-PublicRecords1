IMPORT tools, Corp2;

EXPORT Build_Bases_Addresses(
	STRING																								pfiledate,
	STRING																								pversion,
	Boolean 																							pUseOtherEnvironment,
	DATASET(Corp2_Raw_NC.Layouts.AddressesLayoutIn)				pInAddresses   	= Corp2_Raw_NC.Files(pfiledate,pUseOtherEnvironment).Input.Addresses.logical,
	DATASET(Corp2_Raw_NC.Layouts.AddressesLayoutBase)			pBaseAddresses 	= IF(Corp2_Raw_NC._Flags.Base.Addresses, Corp2_Raw_NC.Files(,pUseOtherEnvironment := FALSE).Base.Addresses.qa, 	DATASET([], Corp2_Raw_NC.Layouts.AddressesLayoutBase))
) := MODULE

	Corp2_Raw_NC.Layouts.AddressesLayoutBase standardize_input(Corp2_Raw_NC.Layouts.AddressesLayoutIn L) := TRANSFORM
	
		self.action_flag				:= 'U';
		self.dt_first_received	:= (integer)pversion;
		self.dt_last_received		:= (integer)pversion;
		self 									 	:= L;
		
	end;

	// Take the  Addresses update file, stamp received dates & action_flag (U=update) and projecting it into the base layout.
	workingUpdate := PROJECT(pInAddresses, standardize_input(LEFT));

	// Combine Update with Previous Base.
	combined 			:= workingUpdate + pBaseAddresses;
	combined_dist := DISTRIBUTE(combined, HASH(Address_EntityID));
	combined_sort := SORT(combined_dist,Address_EntityID, RECORD, EXCEPT action_flag, dt_first_received, dt_last_received, local);
	
	Corp2_Raw_NC.Layouts.AddressesLayoutBase rollupBase(Corp2_Raw_NC.Layouts.AddressesLayoutBase L,
																											Corp2_Raw_NC.Layouts.AddressesLayoutBase R) := TRANSFORM
																											
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF 										:= L;
		
	END;
	
	baseactions			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT action_flag, dt_first_received, dt_last_received,
															LOCAL);
															
	tools.mac_WriteFile(Corp2_Raw_NC.Filenames(pversion).Base.Addresses.New, baseactions, Build_Addresses_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 Build_Addresses_Base,
									 OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NC.Build_Bases_Addresses attribute')
									 );

END;
