IMPORT tools, ut;

EXPORT Build_Base_Membership(STRING 													 pversion,
												     DATASET(Layouts.Base.Membership)  inMembershipBase,
												     DATASET(Layouts.Input.Membership) inMembershipUpdate) := MODULE

	TrimUpper(STRING s) := FUNCTION
		RETURN TRIM(StringLib.StringToUppercase(s), LEFT, RIGHT);
	END;

  Layouts.Base.Membership standardize_input(Layouts.Input.Membership L) := TRANSFORM
	  SELF.member_of                := TrimUpper(L.member_of);
	  SELF.position_held_years      := TrimUpper(L.position_held_years);
		SELF.dt_vendor_first_reported := (UNSIGNED4)pversion;
		SELF.dt_vendor_last_reported  := (UNSIGNED4)pversion;
		SELF.record_type              := 'C';
		
		SELF := L;
		SELF := [];
	END;

	// Take the membership update file, standardize it, and PROJECT it into the base layout.
	workingMembershipUpdate := PROJECT(inMembershipUpdate, standardize_input(LEFT));

  // Distribute needed files for quicker processing.
	workingMembershipUpdate_dist := DISTRIBUTE(workingMembershipUpdate, HASH(biog_number));
	inMembershipBase_dist := DISTRIBUTE(inMembershipBase, HASH(biog_number));

	// Make the input unique for biog_number, to help determine what's historical and what's not.
	unique_update := DEDUP(SORT(workingMembershipUpdate_dist, biog_number, LOCAL), biog_number, LOCAL);

  // If the vendor isn't sending records for a given biog_number anymore, we want them, but
	// don't need to do anything to them.  They've already been marked up with C and H appropriately.
	// (no inline transform needed).
  workingCurrentMembershipBase := JOIN(inMembershipBase_dist, unique_update,
	                                     LEFT.biog_number = RIGHT.biog_number,
																			 LEFT ONLY,
																			 LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that biog_number.
	workingHistoricalMembershipBase := JOIN(inMembershipBase_dist, unique_update,
																					LEFT.biog_number = RIGHT.biog_number,
																					TRANSFORM(Layouts.Base.Membership,
																										SELF.record_type := 'H';
																										SELF := LEFT),
																					LOCAL);

	// Join base and update membership to determine what's new.
	combinedMembership := workingMembershipUpdate + workingCurrentMembershipBase + workingHistoricalMembershipBase;
	combinedMembership_dist := DISTRIBUTE(combinedMembership, HASH(biog_number));
	combinedMembership_sort := SORT(combinedMembership_dist,
																	biog_number, member_of, position_held_years, record_type,
																	   -dt_vendor_last_reported,
																	LOCAL);
	
	Layouts.Base.Membership rollupMembership(Layouts.Base.Membership L,
	                                         Layouts.Base.Membership R) := TRANSFORM
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
																								 
	  SELF := L;
	END;
	
	baseMembership := ROLLUP(combinedMembership_sort,
													 rollupMembership(LEFT, RIGHT),
													 biog_number, member_of, position_held_years,
													 LOCAL);

	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.Membership.New, baseMembership, Build_Base_File);

	EXPORT full_build := SEQUENTIAL(Build_Base_File,
			                            Promote(pversion).buildfiles.New2Built);
		
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping ABMS.Build_Base_Membership atribute'));

END;