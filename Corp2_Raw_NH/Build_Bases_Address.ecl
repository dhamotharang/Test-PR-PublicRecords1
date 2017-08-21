IMPORT corp2, tools;

EXPORT Build_Bases_Address(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																								puseprod,
	DATASET(Corp2_Raw_NH.Layouts.AddressLayoutIn)					pInAddress   	= Corp2_Raw_NH.Files(pfiledate,puseprod).Input.Address.Logical,
	DATASET(Corp2_Raw_NH.Layouts.AddressLayoutBase)				pBaseAddress 	= IF(Corp2_Raw_NH._Flags.Base.Address, Corp2_Raw_NH.Files(,pUseOtherEnvironment := FALSE).Base.Address.qa, DATASET([], Corp2_Raw_NH.Layouts.AddressLayoutBase))
) := MODULE

	Corp2_Raw_NH.Layouts.AddressLayoutBase standardize_input(Corp2_Raw_NH.Layouts.AddressLayoutIn L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self 										:= 	L;
	end;

	// Take the NM Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInAddress, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseAddress;
	combined_dist := DISTRIBUTE(combined, HASH(addressid));
	combined_sort := SORT(combined_dist, addressid, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_NH.Layouts.AddressLayoutBase rollupBase(	Corp2_Raw_NH.Layouts.AddressLayoutBase L,
																											Corp2_Raw_NH.Layouts.AddressLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= Corp2.EarliestDate	(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= Corp2.LatestDate		(L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	baserollup			 					:= ROLLUP(combined_sort,
																			rollupBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_NH.Filenames(pversion).Base.Address.New, baserollup, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_NH.Build_Bases_Address attribute')
									 );

END;
