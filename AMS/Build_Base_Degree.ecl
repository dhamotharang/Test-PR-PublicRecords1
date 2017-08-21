import tools, ut;

export Build_Base_Degree(
	 string pversion
	,dataset(Layouts.Base.Degree) inDegreeBase
	,dataset(Layouts.Input.Degree) inDegreeUpdate
	,dataset(Layouts.Input.Code) inCodeUpdate
) :=
module

	// Take the degree update file and project it into the base layout.
	workingDegreeUpdate :=
		project(inDegreeUpdate(AMS_DELETED != 'Y'),
			transform(Layouts.Base.Degree,
				self.dt_first_seen := map(
					left.ADD_DATE != ''			=>	(unsigned4)left.ADD_DATE,
					left.UPDATE_DATE != ''	=>	(unsigned4)left.UPDATE_DATE,
					/*otherwise*/								(unsigned4)pversion),
				self.dt_last_seen := map(
					left.UPDATE_DATE != ''	=>	(unsigned4)left.UPDATE_DATE,
					/*otherwise*/								(unsigned4)pversion),
				self.dt_vendor_first_reported := (unsigned4)pversion,
				self.dt_vendor_last_reported := (unsigned4)pversion,
				self.record_type := 'C',
			  self.rawfields.ams_seq := left.ams_seq,
			  self.rawfields.ams_batch := left.ams_batch,
			  self.rawfields.ams_deleted := left.ams_deleted,
			  self.rawfields.ams_id := left.ams_id,
			  self.rawfields.degree := left.degree,
			  self.rawfields.best_degree := left.best_degree,
			  self.rawfields.add_date := left.add_date,
			  self.rawfields.update_date := left.update_date,
			  self.rawfields.delete_date := left.delete_date,
				self := left,
				self := []));
	
  // Distribute needed files for quicker processing
	workingDegreeUpdate_dist := DISTRIBUTE(workingDegreeUpdate, HASH(AMS_ID));
	inDegreeBase_dist := DISTRIBUTE(inDegreeBase, HASH(AMS_ID));

	// Make the input unique for ams_id, to help determine what's historical and what's not.
	unique_update := DEDUP(SORT(workingDegreeUpdate_dist, ams_id, LOCAL), ams_id, LOCAL);

	// Determine the records that are current, because the vendor is no longer sending any updates related
	// to that particular ams_id.
  workingCurrentDegreeBase := JOIN(inDegreeBase_dist, unique_update,
	                                 LEFT.ams_id = RIGHT.ams_id,
																	 TRANSFORM(Layouts.Base.Degree,
																		 SELF.record_type := 'C';
																		 SELF.DEGREE_DESC := '';
																		 SELF := LEFT),
																	 LEFT ONLY,
																	 LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that ams_id.
	workingHistoricalDegreeBase := JOIN(inDegreeBase_dist, unique_update,
	                                    LEFT.ams_id = RIGHT.ams_id,
																			TRANSFORM(Layouts.Base.Degree,
																			  SELF.record_type := 'H';
																				SELF.DEGREE_DESC := '';
																				SELF := LEFT),
																			LOCAL);

	// Join base and update degrees to determine what's new
	combinedDegrees := workingCurrentDegreeBase + workingHistoricalDegreeBase +
	                   workingDegreeUpdate;
	combinedDegrees_dist := DISTRIBUTE(combinedDegrees, HASH(AMS_ID));
	combinedDegrees_sort := SORT(combinedDegrees_dist,
	                             (UNSIGNED)AMS_ID, rawfields.DEGREE, rawfields.BEST_DEGREE, record_type,
															    -dt_last_seen,
				                       LOCAL);
	
	Layouts.Base.Degree rollupDegrees(Layouts.Base.Degree L, Layouts.Base.Degree R) := TRANSFORM
    SELF.dt_first_seen := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen),
		                                      ut.EarliestDate(L.dt_last_seen, R.dt_last_seen));
    SELF.dt_last_seen := MAX(L.dt_last_seen, R.dt_last_seen);
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := MAX(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.rawfields := L.rawfields;
																								 
	  SELF := L;
	END;
	
	baseDegrees := ROLLUP(combinedDegrees_sort,
	                      rollupDegrees(LEFT, RIGHT),
												AMS_ID, rawfields.DEGREE, rawfields.BEST_DEGREE,
												LOCAL);

	// Finally, join to the codes file to expand the code descriptions.
	baseDegreesPlusDegreeDescription :=
		join(baseDegrees,inCodeUpdate,
			right.code_name = 'DEGREE' and
			left.rawfields.degree = right.code_cd,
			transform(Layouts.Base.Degree,
				self.degree_desc := right.code_desc,
				self := left,
				self := []),
			left outer,
			lookup);
	
	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.Degree.New,baseDegreesPlusDegreeDescription,Build_Base_File);

	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping AMS.Build_Base_Degree atribute')
	);

end;
