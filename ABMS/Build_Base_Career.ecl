IMPORT tools, ut;

EXPORT Build_Base_Career(STRING pversion,
												 DATASET(Layouts.Base.Career) inCareerBase,
												 DATASET(Layouts.Input.Career) inCareerUpdate) := MODULE

	TrimUpper(STRING s) := FUNCTION
		RETURN TRIM(StringLib.StringToUppercase(s), LEFT, RIGHT);
	END;

  Layouts.Base.Career standardize_input(Layouts.Input.Career L) := TRANSFORM
	  uppercase_state := TrimUpper(L.state);

	  SELF.specialty                := TrimUpper(L.specialty);
	  SELF.position                 := TrimUpper(L.position);
	  SELF.organization             := TrimUpper(L.organization);
	  SELF.city                     := TrimUpper(L.city);
	  SELF.state                    := IF(uppercase_state = 'UNKNOWN', '', uppercase_state);
	  SELF.nation                   := TrimUpper(L.nation);
	  SELF.career_type              := TrimUpper(L.career_type);
		SELF.dt_vendor_first_reported := (UNSIGNED4)pversion;
		SELF.dt_vendor_last_reported  := (UNSIGNED4)pversion;
		SELF.record_type              := 'C';
		
		SELF := L;
		SELF := [];
	END;

	// Take the career update file, standardize it, and PROJECT it into the base layout.
	workingCareerUpdate := PROJECT(inCareerUpdate, standardize_input(LEFT));

  // Distribute needed files for quicker processing.
	workingCareerUpdate_dist := DISTRIBUTE(workingCareerUpdate, HASH(biog_number));
	inCareerBase_dist := DISTRIBUTE(inCareerBase, HASH(biog_number));

	// Make the input unique for biog_number, to help determine what's historical and what's not.
	unique_update := DEDUP(SORT(workingCareerUpdate_dist, biog_number, LOCAL), biog_number, LOCAL);

  // If the vendor isn't sending records for a given biog_number anymore, we want them, but
	// don't need to do anything to them.  They've already been marked up with C and H appropriately.
	// (no inline transform needed).
  workingCurrentCareerBase := JOIN(inCareerBase_dist, unique_update,
	                                 LEFT.biog_number = RIGHT.biog_number,
																	 LEFT ONLY,
																	 LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that biog_number.
	workingHistoricalCareerBase := JOIN(inCareerBase_dist, unique_update,
	                                    LEFT.biog_number = RIGHT.biog_number,
																			TRANSFORM(Layouts.Base.Career,
																			          SELF.record_type := 'H';
																				        SELF.career_type_desc := '';
																				        SELF := LEFT),
																	    LOCAL);

	// Join base and update career to determine what's new.
	combinedCareer := workingCareerUpdate + workingCurrentCareerBase + workingHistoricalCareerBase;
	combinedCareer_dist := DISTRIBUTE(combinedCareer, HASH(biog_number));
	combinedCareer_sort := SORT(combinedCareer_dist,
	                            biog_number, (UNSIGNED)occurrence_number, record_type,
															   -dt_vendor_last_reported, RECORD,
				                      LOCAL);
	
	Layouts.Base.Career rollupCareer(Layouts.Base.Career L,
	                                 Layouts.Base.Career R) := TRANSFORM
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
																								 
	  SELF := L;
	END;
	
	baseCareer := ROLLUP(combinedCareer_sort,
	                     rollupCareer(LEFT, RIGHT),
											 biog_number, RECORD,
											    EXCEPT record_type, dt_vendor_last_reported, dt_vendor_first_reported,
											 LOCAL);

  Layouts.Base.Career add_description_text(Layouts.Base.Career L) := TRANSFORM
    SELF.career_type_desc := MAP(L.career_type = 'AAP' => 'ACADEMIC APPOINTMENT',
		                             L.career_type = 'HAP' => 'HOSPITAL APPOINTMENT',
																 L.career_type = 'TRA' => 'TRAINING',
																 '');

    SELF := L
	END;

	// Finally, get descriptions.
	baseCareerPlusDescriptions := PROJECT(baseCareer, add_description_text(LEFT));
	
	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.Career.New, baseCareerPlusDescriptions, Build_Base_File);

	EXPORT full_build := SEQUENTIAL(Build_Base_File,
			                            Promote(pversion).buildfiles.New2Built);
		
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping ABMS.Build_Base_Career atribute'));

END;