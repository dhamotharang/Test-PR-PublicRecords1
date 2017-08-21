IMPORT tools, corp2;

EXPORT Build_Bases_Address(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN                                             	pUseProd,
	DATASET(Corp2_Raw_PA.Layouts.AddressLayoutIn)					pInAddress   	= Corp2_Raw_PA.Files(pfiledate,pUseProd).Input.Address.logical,
	DATASET(Corp2_Raw_PA.Layouts.AddressLayoutBase)				pBaseAddress 	= IF(Corp2_Raw_PA._Flags.Base.Address, Corp2_Raw_PA.Files(,pUseOtherEnvironment := FALSE).Base.Address.qa, 	DATASET([], Corp2_Raw_PA.Layouts.AddressLayoutBase))
) := MODULE

	Corp2_Raw_PA.Layouts.AddressLayoutBase standardize_input(Corp2_Raw_PA.Layouts.AddressLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
		SELF                    :=  [];
	END;

	// Take the PA Address update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInAddress, standardize_input(LEFT));

	// Combine base and update to determine what's new.
	combined 			:= workingUpdate + pBaseAddress;
	combined_dist := DISTRIBUTE(combined, HASH(corporationid));
	combined_sort := SORT(combined_dist, corporationid, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_PA.Layouts.AddressLayoutBase rollupBase(	Corp2_Raw_PA.Layouts.AddressLayoutBase L,
																											Corp2_Raw_PA.Layouts.AddressLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF                    := L;
	END;
	
	baseAddress			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_PA.Filenames(pversion).Base.Address.New, baseAddress, Build_Address_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Address_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_PA.Build_Bases_Address attribute')
									 );

END;
