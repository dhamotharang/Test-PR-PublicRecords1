import tools, ut;

export Build_Base_Specialty(
	 string pversion
	,dataset(Layouts.Base.Specialty) inSpecialtyBase
	,dataset(Layouts.Input.Specialty) inSpecialtyUpdate
	,dataset(Layouts.Input.Code) inCodeUpdate
) :=
module

	// Take the specialty update file and project it into the base layout.
	workingSpecialtyUpdate :=
		project(inSpecialtyUpdate(AMS_DELETED != 'Y'),
			transform(Layouts.Base.Specialty,
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
			  self.rawfields.specialty_type := left.specialty_type,
			  self.rawfields.specialty := left.specialty,
			  self.rawfields.src_cd := left.src_cd,
			  self.rawfields.add_date := left.add_date,
			  self.rawfields.update_date := left.update_date,
			  self.rawfields.delete_date := left.delete_date,
				self := left,
				self := []));
	
  // Distribute needed files for quicker processing
	workingSpecialtyUpdate_dist := DISTRIBUTE(workingSpecialtyUpdate, HASH(AMS_ID));
	inSpecialtyBase_dist := DISTRIBUTE(inSpecialtyBase, HASH(AMS_ID));

	// Make the input unique for ams_id, to help determine what's historical and what's not.
	unique_update := DEDUP(SORT(workingSpecialtyUpdate_dist, ams_id, LOCAL), ams_id, LOCAL);

	// Determine the records that are current, because the vendor is no longer sending any updates related
	// to that particular ams_id.
  workingCurrentSpecialtyBase := JOIN(inSpecialtyBase_dist, unique_update,
	                                    LEFT.ams_id = RIGHT.ams_id,
																			TRANSFORM(Layouts.Base.Specialty,
																			  SELF.record_type := 'C';
																				SELF.SPECIALTY_DESC := '';
																				SELF.SRC_CD_DESC := '';
																				SELF := LEFT),
																			LEFT ONLY,
																			LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that ams_id.
	workingHistoricalSpecialtyBase := JOIN(inSpecialtyBase_dist, unique_update,
	                                       LEFT.ams_id = RIGHT.ams_id,
																			   TRANSFORM(Layouts.Base.Specialty,
																			     SELF.record_type := 'H';
																				   SELF.SPECIALTY_DESC := '';
																				   SELF.SRC_CD_DESC := '';
																				   SELF := LEFT),
																				 LOCAL);

	// Join base and update specialties to determine what's new
	combinedSpecialties := workingCurrentSpecialtyBase + workingHistoricalSpecialtyBase +
	                       workingSpecialtyUpdate;
	combinedSpecialties_dist := DISTRIBUTE(combinedSpecialties, HASH(AMS_ID));
	combinedSpecialties_sort := SORT(combinedSpecialties_dist,
	                                 (UNSIGNED)AMS_ID, rawfields.SPECIALTY_TYPE, rawfields.SPECIALTY,
																	    rawfields.SRC_CD, record_type, -dt_last_seen,
				                           LOCAL);
	
	Layouts.Base.Specialty rollupSpecialties(Layouts.Base.Specialty L,
	                                         Layouts.Base.Specialty R) := TRANSFORM
    SELF.dt_first_seen := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen),
		                                      ut.EarliestDate(L.dt_last_seen, R.dt_last_seen));
    SELF.dt_last_seen := MAX(L.dt_last_seen, R.dt_last_seen);
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := MAX(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.rawfields := L.rawfields;
																								 
	  SELF := L;
	END;
	
	baseSpecialties := ROLLUP(combinedSpecialties_sort,
	                          rollupSpecialties(LEFT, RIGHT),
												    AMS_ID, rawfields.SPECIALTY_TYPE, rawfields.SPECIALTY, rawfields.SRC_CD,
												    LOCAL);
	
	// Finally, join to the codes file to expand the code descriptions.
	baseSpecialtiesPlusSpecialtyDescription :=
		join(baseSpecialties,inCodeUpdate,
			right.code_name = 'SPEC' and
			left.rawfields.specialty = right.code_cd,
			transform(Layouts.Base.Specialty,
				self.specialty_desc := right.code_desc,
				self := left,
				self := []),
			left outer,
			lookup);
	baseSpecialtiesPlusSrcCdDescription :=
		join(baseSpecialtiesPlusSpecialtyDescription,inCodeUpdate,
			right.code_name = 'SRC_CD' and
			left.rawfields.src_cd = right.code_cd,
			transform(Layouts.Base.Specialty,
				self.src_cd_desc := right.code_desc,
				self := left,
				self := []),
			left outer,
			lookup);
	
	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.Specialty.New,baseSpecialtiesPlusSrcCdDescription,Build_Base_File);

	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping AMS.Build_Base_Specialty atribute')
	);

end;
