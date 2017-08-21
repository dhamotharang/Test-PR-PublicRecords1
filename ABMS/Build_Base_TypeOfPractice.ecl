IMPORT tools, ut;

EXPORT Build_Base_TypeOfPractice(STRING 															 pversion,
												         DATASET(Layouts.Base.TypeOfPractice)  inTypeOfPracticeBase,
												         DATASET(Layouts.Input.TypeOfPractice) inTypeOfPracticeUpdate) := MODULE

	TrimUpper(STRING s) := FUNCTION
		RETURN TRIM(StringLib.StringToUppercase(s), LEFT, RIGHT);
	END;

  Layouts.Base.TypeOfPractice standardize_input(Layouts.Input.TypeOfPractice L) := TRANSFORM
	  SELF.type_of_practice         := TrimUpper(L.type_of_practice);
	  SELF.other_text               := TrimUpper(L.other_text);
		SELF.dt_vendor_first_reported := (UNSIGNED4)pversion;
		SELF.dt_vendor_last_reported  := (UNSIGNED4)pversion;
		SELF.record_type              := 'C';
		
		SELF := L;
		SELF := [];
	END;

	// Take the type of practice update file, standardize it, and PROJECT it into the base layout.
	workingTypeOfPracticeUpdate := PROJECT(inTypeOfPracticeUpdate, standardize_input(LEFT));

  // Distribute needed files for quicker processing.
	workingTypeOfPracticeUpdate_dist := DISTRIBUTE(workingTypeOfPracticeUpdate, HASH(biog_number));
	inTypeOfPracticeBase_dist := DISTRIBUTE(inTypeOfPracticeBase, HASH(biog_number));

	// Make the input unique for biog_number, to help determine what's historical and what's not.
	unique_update := DEDUP(SORT(workingTypeOfPracticeUpdate_dist, biog_number, LOCAL), biog_number, LOCAL);

  // If the vendor isn't sending records for a given biog_number anymore, we want them, but
	// don't need to do anything to them.  They've already been marked up with C and H appropriately.
	// (no inline transform needed).
  workingCurrentTypeOfPracticeBase := JOIN(inTypeOfPracticeBase_dist, unique_update,
																					 LEFT.biog_number = RIGHT.biog_number,
																					 LEFT ONLY,
																					 LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that biog_number.
	workingHistoricalTypeOfPracticeBase := JOIN(inTypeOfPracticeBase_dist, unique_update,
																							LEFT.biog_number = RIGHT.biog_number,
																							TRANSFORM(Layouts.Base.TypeOfPractice,
																												SELF.record_type := 'H';
																												SELF := LEFT),
																							LOCAL);

	// Join base and update type of practice to determine what's new.
	combinedTypeOfPractice := workingTypeOfPracticeUpdate + workingCurrentTypeOfPracticeBase +
	                             workingHistoricalTypeOfPracticeBase;
	combinedTypeOfPractice_dist := DISTRIBUTE(combinedTypeOfPractice, HASH(biog_number));
	combinedTypeOfPractice_sort := SORT(combinedTypeOfPractice_dist,
																			biog_number, type_of_practice, other_text, record_type,
																			   -dt_vendor_last_reported,
																			LOCAL);
	
	Layouts.Base.TypeOfPractice rollupTypeOfPractice(Layouts.Base.TypeOfPractice L,
	                                                 Layouts.Base.TypeOfPractice R) := TRANSFORM
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
																								 
	  SELF := L;
	END;
	
	baseTypeOfPractice := ROLLUP(combinedTypeOfPractice_sort,
															 rollupTypeOfPractice(LEFT, RIGHT),
															 biog_number, type_of_practice, other_text,
															 LOCAL);

	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.TypeOfPractice.New, baseTypeOfPractice, Build_Base_File);

	EXPORT full_build := SEQUENTIAL(Build_Base_File,
			                            Promote(pversion).buildfiles.New2Built);
		
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping ABMS.Build_Base_TypeOfPractice atribute'));

END;