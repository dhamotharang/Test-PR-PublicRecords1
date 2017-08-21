IMPORT tools, corp2;

EXPORT Build_Bases_Main(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																								puseprod,
	DATASET(Corp2_Raw_SD.Layouts.vendor_mainLayout)				pIn_vendor_main     = Corp2_raw_SD.Files(pfiledate,puseprod).Input.ds_vendor_rawMain,
	DATASET(Corp2_Raw_SD.Layouts.vendor_mainLayoutBase)		pBase_vendor_main 	= IF(_Flags.Base.vendor_main, Corp2_Raw_SD.Files(,pUseOtherEnvironment := FALSE).Base.vendor_main.qa, DATASET([], Corp2_Raw_SD.Layouts.vendor_mainLayoutBase))
) := MODULE

	Corp2_Raw_SD.Layouts.vendor_mainLayoutBase standardize_input(Corp2_Raw_SD.Layouts.vendor_mainLayout L) := TRANSFORM
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF                    := L;
		SELF                    := [];
	END;

	// Take the SD vendor_main update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pIn_vendor_main, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBase_vendor_main;
	combined_dist := DISTRIBUTE(combined, HASH(org_corporate_id));
	combined_sort := SORT(combined_dist, org_corporate_id, RECORD, EXCEPT dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_SD.Layouts.vendor_mainLayoutBase rollupBase(Corp2_Raw_SD.Layouts.vendor_mainLayoutBase L,
																												Corp2_Raw_SD.Layouts.vendor_mainLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	(L.dt_last_received, 	R.dt_last_received);
	  SELF                    := L;
	END;
	
	base				 							:= ROLLUP(combined_sort,
																			rollupBase(LEFT, RIGHT),
																			RECORD,
																			EXCEPT dt_first_received, dt_last_received,
																			LOCAL);
	// Return
	tools.mac_WriteFile(Corp2_Raw_SD.Filenames(pversion).Base.vendor_main.New, base, Build_Main_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Main_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_SD.Build_Bases_Main attribute')
									 );

END;
