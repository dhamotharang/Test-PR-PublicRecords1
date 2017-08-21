IMPORT tools, corp2;

EXPORT Build_Bases_AR(
	STRING																								pfiledate,
	STRING																								pversion,
	BOOLEAN																								puseprod,
	DATASET(Corp2_Raw_SD.Layouts.vendor_arLayout)			    pIn_vendor_ar    = Corp2_raw_SD.Files(pfiledate,puseprod).Input.vendor_ar.logical,
	DATASET(Corp2_Raw_SD.Layouts.vendor_arLayoutBase)	    pBase_vendor_ar  = IF(_Flags.Base.vendor_ar, Corp2_Raw_SD.Files(,pUseOtherEnvironment := FALSE).Base.vendor_ar.qa, DATASET([], Corp2_Raw_SD.Layouts.vendor_arLayoutBase))
) := MODULE

	Corp2_Raw_SD.Layouts.vendor_arLayoutBase standardize_input(Corp2_Raw_SD.Layouts.vendor_arLayout L) := TRANSFORM
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF                    := L;
		SELF                    := [];
	END;

	// Take the SD vendor_ar update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pIn_vendor_ar, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBase_vendor_ar;
	combined_dist := DISTRIBUTE(combined, HASH(org_corporate_id,ann_report_id));
	combined_sort := SORT(combined_dist, org_corporate_id,ann_report_id, RECORD, EXCEPT dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_SD.Layouts.vendor_arLayoutBase rollupBase(Corp2_Raw_SD.Layouts.vendor_arLayoutBase L,
																											Corp2_Raw_SD.Layouts.vendor_arLayoutBase R) := TRANSFORM
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
	tools.mac_WriteFile(Corp2_Raw_SD.Filenames(pversion).Base.vendor_ar.New, base, Build_AR_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_AR_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_SD.Build_Bases_AR attribute')
									 );

END;
