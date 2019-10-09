IMPORT _control, MDR, std, tools, ut;

EXPORT Build_Base_Main(STRING pversion,
	                     DATASET(Death_MI.Layouts.Base) inMainBase) := MODULE

  inDeathUpdate   := IF(Death_MI._Flags.FileExists.Input.Death,
	                      Death_MI.Files().Input.Death.Sprayed,
												DATASET([], Death_MI.Layouts.Input.Death));
  inILDeathUpdate := IF(Death_MI._Flags.FileExists.Input.Death_IL,
	                      Death_MI.Files().Input.Death_IL.Sprayed,
												DATASET([], Death_MI.Layouts.Input.Death_IL));

	// Transform into the base layout, adding a few details.
	Death_MI.Layouts.Base add_dates(Death_MI.Layouts.Input.Death L) := TRANSFORM
    SELF.dt_vendor_first_reported := (UNSIGNED4)pversion;
    SELF.dt_vendor_last_reported  := (UNSIGNED4)pversion;
		SELF.customer_id              := Death_MI._Constants().mi_cust_id;

		SELF := L;
		SELF := [];
	END;

	Death_MI.Layouts.Base add_IL_dates(Death_MI.Layouts.Input.Death_IL L) := TRANSFORM
    SELF.dt_vendor_first_reported := (UNSIGNED4)pversion;
    SELF.dt_vendor_last_reported  := (UNSIGNED4)pversion;
		SELF.customer_id              := Death_MI._Constants().il_cust_id;

		SELF := L;
		SELF := [];
	END;

	workingMIMainUpdate := PROJECT(inDeathUpdate, add_dates(LEFT));	
	workingILMainUpdate := PROJECT(inILDeathUpdate, add_IL_dates(LEFT));	
	workingMainUpdate := workingMIMainUpdate + workingILMainUpdate;	
	
	addGlobal_SID			:= MDR.macGetGlobalSid(workingMainUpdate, 'Death_MI', 'customer_id', 'global_sid');	
	
	workingMainUpdate_clean_input := Death_MI.Standardize_Input(addGlobal_SID);
	workingMainUpdate_clean_name := Death_MI.Standardize_Name(workingMainUpdate_clean_input);

	// Join base and update
	combinedMain := Death_MI.Standardize_Addr(inMainBase + workingMainUpdate_clean_name);

	// Add DID
	combinedMainAID := Death_MI.Append_IDs.fAll(combinedMain);
	combinedMainAID_proj := PROJECT(combinedMainAID, Death_MI.Layouts.Base);
	combinedMain_dist := DISTRIBUTE(combinedMainAID_proj, HASH(ssn));

	combinedMain_sort := SORT(combinedMain_dist,
	                          ssn, customer_id, dod_year, dod_month, dod_day, dob_year, dob_month,
														   dob_day, lname, mname, fname, fileno, alias_code,
															 -dt_vendor_last_reported, RECORD,
				                    LOCAL);

  // Not applying DEDUP logic on those names that are considered aliases.  It incorrectly wipes out
	// many records.
	combinedMain_sort_alias_name := combinedMain_sort(alias_code = '2');
	combinedMain_sort_not_alias_name := combinedMain_sort(alias_code != '2');

  // MI data is additive, so a dedup is perfectly fine
	combinedMain_dedup := DEDUP(combinedMain_sort_not_alias_name(customer_id = Death_MI._Constants().mi_cust_id),
	                            ssn, customer_id, dod_year, dod_month, dod_day, dob_year, dob_month,
														     dob_day, lname, mname, fname, fileno, alias_code,
															LOCAL);

  // IL data is a full replace and will be rolled-up, so we can track the date vendor first seen
	//   attribute better.
	Death_MI.Layouts.Base rollupILMain(Death_MI.Layouts.Base L, Death_MI.Layouts.Base R) := TRANSFORM
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);

	  SELF := L;
	END;

	combinedMain_rollup := ROLLUP(combinedMain_sort_not_alias_name(customer_id = Death_MI._Constants().il_cust_id),
															  rollupILMain(LEFT, RIGHT),
																ssn, customer_id, dod_year, dod_month, dod_day, dob_year, dob_month,
																	 dob_day, lname, mname, fname, fileno, alias_code,
															  LOCAL);

  finalMain := combinedMain_dedup + combinedMain_rollup + combinedMain_sort_alias_name;

	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.Main.New, finalMain, Build_Base_File);

	EXPORT full_build := SEQUENTIAL(Build_Base_File,
			                            Promote(pversion).buildfiles.New2Built);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping Death_MI.Build_Base_Main atribute'));

END;
