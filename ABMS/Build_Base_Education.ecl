IMPORT tools, ut;

EXPORT Build_Base_Education(STRING 													 pversion,
												    DATASET(Layouts.Base.Education)  inEducationBase,
												    DATASET(Layouts.Input.Education) inEducationUpdate,
														DATASET(Layouts.Input.Schools) 	 inSchoolCodes) := MODULE

	TrimUpper(STRING s) := FUNCTION
		RETURN TRIM(StringLib.StringToUppercase(s), LEFT, RIGHT);
	END;

  Layouts.Base.Education standardize_input(Layouts.Input.Education L) := TRANSFORM
	  SELF.degree                   := TrimUpper(L.degree);
	  SELF.school                   := TrimUpper(L.school);
	  SELF.city                     := TrimUpper(L.city);
	  SELF.state                    := TrimUpper(L.state);
	  SELF.country                  := TrimUpper(L.country);
		SELF.dt_vendor_first_reported := (UNSIGNED4)pversion;
		SELF.dt_vendor_last_reported  := (UNSIGNED4)pversion;
		SELF.record_type              := 'C';
		
		SELF := L;
		SELF := [];
	END;

	// Take the education update file, standardize it, and PROJECT it into the base layout.
	workingEducationUpdate := PROJECT(inEducationUpdate, standardize_input(LEFT));

  // Distribute needed files for quicker processing.
	workingEducationUpdate_dist := DISTRIBUTE(workingEducationUpdate, HASH(biog_number));
	inEducationBase_dist := DISTRIBUTE(inEducationBase, HASH(biog_number));

	// Make the input unique for biog_number, to help determine what's historical and what's not.
	unique_update := DEDUP(SORT(workingEducationUpdate_dist, biog_number, LOCAL), biog_number, LOCAL);

  // If the vendor isn't sending records for a given biog_number anymore, we want them, but
	// don't need to do anything to them.  They've already been marked up with C and H appropriately.
	// (no inline transform needed).
  workingCurrentEducationBase := JOIN(inEducationBase_dist, unique_update,
	                                    LEFT.biog_number = RIGHT.biog_number,
																	    LEFT ONLY,
																	    LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that biog_number.
	workingHistoricalEducationBase := JOIN(inEducationBase_dist, unique_update,
	                                       LEFT.biog_number = RIGHT.biog_number,
																			   TRANSFORM(Layouts.Base.Education,
																			             SELF.record_type := 'H';
																				           SELF.abms_school_code_desc := '';
																				           SELF.abms_school_code_desc_abbrev := '';
																				           SELF := LEFT),
																	       LOCAL);

	// Join base and update education to determine what's new.
	combinedEducation := workingEducationUpdate + workingCurrentEducationBase + workingHistoricalEducationBase;
	combinedEducation_dist := DISTRIBUTE(combinedEducation, HASH(biog_number));
	combinedEducation_sort := SORT(combinedEducation_dist,
	                               biog_number, (UNSIGNED)occurrence_number, record_type,
																    -dt_vendor_last_reported, RECORD,
				                         LOCAL);
	
	Layouts.Base.Education rollupEducation(Layouts.Base.Education L,
	                                       Layouts.Base.Education R) := TRANSFORM
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
																								 
	  SELF := L;
	END;
	
	baseEducation := ROLLUP(combinedEducation_sort,
	                        rollupEducation(LEFT, RIGHT),
											    biog_number, RECORD,
													   EXCEPT record_type, dt_vendor_last_reported, dt_vendor_first_reported,
											    LOCAL);

	// Finally, get descriptions.
	baseEducationPlusDescriptions := JOIN(baseEducation, inSchoolCodes,
																			  LEFT.abms_school_code = RIGHT.abms_school_code,
																				TRANSFORM(Layouts.Base.Education,
																					        SELF.abms_school_code_desc        := TrimUpper(RIGHT.school_name),
																					        SELF.abms_school_code_desc_abbrev := TrimUpper(RIGHT.school_name_abbrev),
																									SELF := LEFT,
																					        SELF := []),
																				LEFT OUTER,
																				LOOKUP);
	
	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.Education.New, baseEducationPlusDescriptions,
	                       Build_Base_File);

	EXPORT full_build := SEQUENTIAL(Build_Base_File,
			                            Promote(pversion).buildfiles.New2Built);
		
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping ABMS.Build_Base_Education atribute'));

END;