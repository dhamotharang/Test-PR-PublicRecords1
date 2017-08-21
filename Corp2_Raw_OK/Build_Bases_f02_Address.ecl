IMPORT tools, corp2;

EXPORT Build_Bases_f02_Address(
	STRING	pfiledate,
	STRING	pversion,
	BOOLEAN puseprod,
	DATASET(Corp2_Raw_OK.Layouts.Address_02_Layout)		  pInf02_Address   	= Corp2_Raw_OK.Files(pfiledate,pUseProd).Input.f02_Address,
	DATASET(Corp2_Raw_OK.Layouts.Address_02_LayoutBase)	pBasef02_Address 	= IF(Corp2_Raw_OK._Flags.Base.f02_Address, Corp2_Raw_OK.Files(,pUseOtherEnvironment := FALSE).Base.f02_Address.qa, 	DATASET([], Corp2_Raw_OK.Layouts.Address_02_LayoutBase))
) := MODULE

	Corp2_Raw_OK.Layouts.Address_02_LayoutBase standardize_input(Corp2_Raw_OK.Layouts.Address_02_Layout L) := TRANSFORM
		self.action_flag				:=	'U';
		self.dt_first_received	:=	(integer)pversion;
		self.dt_last_received		:=	(integer)pversion;
		self := L;
		self := [];
	end;

	// Take the IA f02_Address update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInf02_Address, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBasef02_Address;
	combined_dist := DISTRIBUTE(combined, HASH(f02_Address_ID));
	combined_sort := SORT(combined_dist, f02_Address_ID, record, except dt_last_received, dt_first_received, LOCAL);
	
	Corp2_Raw_OK.Layouts.Address_02_LayoutBase rollupBase(Corp2_Raw_OK.Layouts.Address_02_LayoutBase L,
																										   Corp2_Raw_OK.Layouts.Address_02_LayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received, 	R.dt_last_received);
																								 
	  SELF := L;
	END;
	
	basef02_Address			 := ROLLUP(	combined_sort,
															rollupBase(LEFT, RIGHT),
															RECORD,
															EXCEPT dt_last_received, dt_first_received,
															LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_OK.Filenames(pversion).Base.f02_Address.New, basef02_Address, Build_f02_Address_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_f02_Address_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_OK.Build_Bases_f02_Address attribute')
									 );

END;
