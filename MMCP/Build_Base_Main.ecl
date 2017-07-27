IMPORT tools, ut;

EXPORT Build_Base_Main(STRING pversion,
	                     DATASET(Layouts.Base) inMainBase) := MODULE

  inLicenseStatusUpdate      := IF(_Flags.FileExists.Input.License_Status,
	                                 Files().Input.License_Status.Sprayed,
																	 DATASET([], Layouts.Input.License_Status));
  inLicenseStatusUpdate_dist := DISTRIBUTE(inLicenseStatusUpdate, HASH(license_number));
  inLicenseeUpdate           := IF(_Flags.FileExists.Input.Licensee,
	                                 Files().Input.Licensee.Sprayed,
																	 DATASET([], Layouts.Input.Licensee));
  inLicenseeUpdate_dist      := DISTRIBUTE(inLicenseeUpdate, HASH(license_number));
  inILLicenseUpdate          := IF(_Flags.FileExists.Input.IL_License,
	                                 Files().Input.IL_License.Sprayed,
																	 DATASET([], Layouts.Input.IL_License));

	// Take the input files, join, and transform the result into the base layout.
	Layouts.Base add_dates_and_status(Layouts.Input.Licensee R, Layouts.Input.License_Status L) := TRANSFORM
    SELF.dt_vendor_first_reported := (UNSIGNED4)pversion;
    SELF.dt_vendor_last_reported  := (UNSIGNED4)pversion;
		SELF.customer_id              := _Constants().mi_cust_id;
		SELF.record_type              := 'C';
		
		SELF := L;
		SELF := R;
		SELF := [];
	END;

	// There can be more records in the license status file vs. the licensee... we don't want the
	// status info. w/o a person to attach it to.
	workingMainUpdate := JOIN(inLicenseeUpdate_dist, inLicenseStatusUpdate_dist,
	                          LEFT.license_number = RIGHT.license_number,
														add_dates_and_status(LEFT, RIGHT),
														LEFT OUTER,
														LOCAL);

  // This standardizes MI and IL data and comes back with 1 big input dataset
	workingMainUpdate_clean_input := Standardize_Input(workingMainUpdate, inILLicenseUpdate, pversion).All;

  // Distribute needed files for quicker processing
	workingMainUpdate_dist := DISTRIBUTE(workingMainUpdate_clean_input, HASH(license_number));
	inMainBase_dist := DISTRIBUTE(inMainBase, HASH(license_number));

	// Make the input unique for license_number (and now customer id), to help determine what's
	// historical and what's not.
	unique_update := DEDUP(SORT(workingMainUpdate_dist, license_number, customer_id, LOCAL),
	                       license_number, customer_id,
												 LOCAL);

  // If the vendor isn't sending records for a given license_number anymore (and now customer id),
	// we want them, but don't need to do anything to them.  They've already been marked up with C
	// and H appropriately.
	// Since this is strictly an update situation, leave them alone (no inline transform needed).
  workingCurrentMainBase := JOIN(inMainBase_dist, unique_update,
	                               LEFT.license_number = RIGHT.license_number AND
																 LEFT.customer_id = RIGHT.customer_id,
																 LEFT ONLY,
																 LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that
	// license_number (and now customer id).
	workingHistoricalMainBase := JOIN(inMainBase_dist, unique_update,
	                                  LEFT.license_number = RIGHT.license_number AND
																		LEFT.customer_id = RIGHT.customer_id,
																		TRANSFORM(Layouts.Base,
																			        SELF.record_type := 'H';
																			        SELF := LEFT),
																		LOCAL);

	// Join base and update to determine what's new
	combinedMain := Standardize_Addr(workingCurrentMainBase + workingHistoricalMainBase +
	                                    workingMainUpdate_dist);
	combinedMainCleanName := Standardize_Name(combinedMain);

	// Add DID and BDID
	combinedMainAID := Append_IDs.fAll(combinedMainCleanName);
	combinedMain_dist := DISTRIBUTE(combinedMainAID, HASH(license_number));
	combinedMain_sort := SORT(combinedMain_dist,
	                          license_number, customer_id, bull_license_type, sec_license_status,
														   audit_number, record_type, -dt_vendor_last_reported, RECORD,
				                    LOCAL);

  // Determine the various description attributes
	Layouts.Base add_descriptions(Layouts.Base L) := TRANSFORM
	  lic_brd_code := L.license_number[1..2];

    // IL has nothing to give this field, so null it out
	  SELF.license_board_code_desc := IF(L.customer_id = _Constants().mi_cust_id,
		                                   Lookups.get_lic_brd_desc(lic_brd_code),
																			 '');
    // IL defines all records as type = R, so the description is always 'REGULAR'
		SELF.bull_lic_type_desc := IF(L.customer_id = _Constants().mi_cust_id,
		                              Lookups.get_bull_lic_type_desc(lic_brd_code, L.bull_license_type),
																	'REGULAR');
		// IL's status is spelled-out for us, no lookup needed
		SELF.license_status_desc := IF(L.customer_id = _Constants().mi_cust_id,
		                               Lookups.get_lic_status_desc(L.sec_license_status),
																	 L.license_status);

	  SELF := L;
	END;

	baseMainDesc := PROJECT(combinedMain_sort, add_descriptions(LEFT));

	Layouts.Base rollupMain(Layouts.Base L, Layouts.Base R) := TRANSFORM
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);

	  SELF := L;
	END;

	baseMain := ROLLUP(baseMainDesc,
	                   rollupMain(LEFT, RIGHT),
										 license_number, customer_id, RECORD,
										    EXCEPT record_type, dt_vendor_last_reported, dt_vendor_first_reported,
										 LOCAL);

	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.Main.New, baseMain, Build_Base_File);

	EXPORT full_build := SEQUENTIAL(Build_Base_File,
			                            Promote(pversion).buildfiles.New2Built);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping MMCP.Build_Base_Main atribute'));

END;
