import tools, ut;

export Build_Base_StateLicense(
	 string pversion
	,dataset(Layouts.Base.StateLicense) inStateLicenseBase
	,dataset(Layouts.Input.StateLicense) inStateLicenseUpdate
	,dataset(Layouts.Input.Code) inCodeUpdate
) :=
module

	// Take the state license update file and project it into the base layout.
	workingStateLicenseUpdate :=
		project(inStateLicenseUpdate(AMS_DELETED != 'Y'),
			transform(Layouts.Base.StateLicense,
				self.dt_first_seen := map(
					left.ADD_DATE != ''						=>	(unsigned4)left.ADD_DATE,
					left.UPDATE_DATE != ''				=>	(unsigned4)left.UPDATE_DATE,
					/*otherwise*/											(unsigned4)pversion),
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
			  self.rawfields.indy_id := left.indy_id,
			  self.rawfields.src_cd := left.src_cd,
			  self.rawfields.st_lic_num := left.st_lic_num,
			  self.rawfields.st_lic_brd_cd := left.st_lic_brd_cd,
			  self.rawfields.st_lic_state := left.st_lic_state,
			  self.rawfields.st_lic_degree := left.st_lic_degree,
			  self.rawfields.st_lic_type := left.st_lic_type,
			  self.rawfields.st_lic_status := left.st_lic_status,
			  self.rawfields.st_lic_exp_date := left.st_lic_exp_date,
			  self.rawfields.st_lic_issue_date := left.st_lic_issue_date,
			  self.rawfields.st_lic_brd_date := left.st_lic_brd_date,
			  self.rawfields.eligibility_cd := left.eligibility_cd,
			  self.rawfields.add_date := left.add_date,
			  self.rawfields.update_date := left.update_date,
			  self.rawfields.delete_date := left.delete_date,
				self := left,
				self := []));
	
  // Distribute needed files for quicker processing
	workingStateLicenseUpdate_dist := DISTRIBUTE(workingStateLicenseUpdate, HASH(AMS_ID));
	inStateLicenseBase_dist := DISTRIBUTE(inStateLicenseBase, HASH(AMS_ID));

	// Make the input unique for ams_id, to help determine what's historical and what's not.
	unique_update := DEDUP(SORT(workingStateLicenseUpdate_dist, ams_id, LOCAL), ams_id, LOCAL);

	// Determine the records that are current, because the vendor is no longer sending any updates related
	// to that particular ams_id.
  workingCurrentStateLicenseBase := JOIN(inStateLicenseBase_dist, unique_update,
	                                       LEFT.ams_id = RIGHT.ams_id,
																			   TRANSFORM(Layouts.Base.StateLicense,
																			     SELF.record_type := 'C';
																				   SELF.SRC_CD_DESC := '';
																				   SELF.ST_LIC_STATE_DESC := '';
																				   SELF.ST_LIC_DEGREE_DESC := '';
																				   SELF.ST_LIC_TYPE_DESC := '';
																				   SELF.ST_LIC_STATUS_DESC := '';
																				   SELF.ELIGIBILITY_CD_DESC := '';
																				   SELF := LEFT),
																			   LEFT ONLY,
																				 LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that ams_id.
	workingHistoricalStateLicenseBase := JOIN(inStateLicenseBase_dist, unique_update,
	                                          LEFT.ams_id = RIGHT.ams_id,
																			      TRANSFORM(Layouts.Base.StateLicense,
																			        SELF.record_type := 'H';
																				      SELF.SRC_CD_DESC := '';
																				      SELF.ST_LIC_STATE_DESC := '';
																				      SELF.ST_LIC_DEGREE_DESC := '';
																				      SELF.ST_LIC_TYPE_DESC := '';
																				      SELF.ST_LIC_STATUS_DESC := '';
																				      SELF.ELIGIBILITY_CD_DESC := '';
																				      SELF := LEFT),
																						LOCAL);

	// Join base and update state licenses to determine what's new
	combinedStateLicenses := workingCurrentStateLicenseBase + workingHistoricalStateLicenseBase +
	                         workingStateLicenseUpdate;
	combinedStateLicenses_dist := DISTRIBUTE(combinedStateLicenses, HASH(AMS_ID));
	combinedStateLicenses_sort :=
	  SORT(combinedStateLicenses_dist,
	       (UNSIGNED)AMS_ID, rawfields.SRC_CD,
				    rawfields.ST_LIC_NUM, rawfields.ST_LIC_BRD_CD, rawfields.ST_LIC_STATE, rawfields.ST_LIC_DEGREE,
						rawfields.ST_LIC_TYPE, rawfields.ST_LIC_STATUS, -(UNSIGNED)rawfields.ST_LIC_EXP_DATE,
						-(UNSIGNED)rawfields.ST_LIC_ISSUE_DATE, -(UNSIGNED)rawfields.ST_LIC_BRD_DATE,
						rawfields.ELIGIBILITY_CD, record_type, -dt_last_seen,
				 LOCAL);
	
	Layouts.Base.StateLicense rollupStateLicenses(Layouts.Base.StateLicense L,
	                                              Layouts.Base.StateLicense R) := TRANSFORM
    SELF.dt_first_seen := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen),
		                                      ut.EarliestDate(L.dt_last_seen, R.dt_last_seen));
    SELF.dt_last_seen := MAX(L.dt_last_seen, R.dt_last_seen);
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := MAX(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		// The update date seems to always change with the st_lic_brd_date, but doing this, just in case
		// it's not always the case.
		SELF.rawfields.update_date :=
		  (STRING)MAX((UNSIGNED)L.rawfields.update_date, (UNSIGNED)R.rawfields.update_date);
																								 
	  SELF := L;
	END;
	
	baseStateLicenses := ROLLUP(combinedStateLicenses_sort,
	                            rollupStateLicenses(LEFT, RIGHT),
												      AMS_ID, rawfields.SRC_CD, rawfields.ST_LIC_NUM, rawfields.ST_LIC_BRD_CD,
															   rawfields.ST_LIC_STATE, rawfields.ST_LIC_DEGREE,
																 rawfields.ST_LIC_TYPE, rawfields.ST_LIC_STATUS,
																 rawfields.ST_LIC_EXP_DATE, rawfields.ST_LIC_ISSUE_DATE,
																 rawfields.ST_LIC_BRD_DATE, rawfields.ELIGIBILITY_CD,
												      LOCAL);
	
	// Finally, join to the codes file to expand the code descriptions.
	baseStateLicensesPlusSrcCdDescription :=
		join(baseStateLicenses,inCodeUpdate,
			right.code_name = 'SRC_CD' and
			left.rawfields.src_cd = right.code_cd,
			transform(Layouts.Base.StateLicense,
				self.src_cd_desc := right.code_desc,
				self := left,
				self := []),
			left outer,
			lookup);
	baseStateLicensesPlusStLicStateDescription :=
		join(baseStateLicensesPlusSrcCdDescription,inCodeUpdate,
			right.code_name = 'STATE_CODE' and
			left.rawfields.st_lic_state = right.code_cd,
			transform(Layouts.Base.StateLicense,
				self.st_lic_state_desc := right.code_desc,
				self := left,
				self := []),
			left outer,
			lookup);
	baseStateLicensesPlusStLicDegreeDescription :=
		join(baseStateLicensesPlusStLicStateDescription,inCodeUpdate,
			right.code_name = 'DEGREE' and
			left.rawfields.st_lic_degree = right.code_cd,
			transform(Layouts.Base.StateLicense,
				self.st_lic_degree_desc := right.code_desc,
				self := left,
				self := []),
			left outer,
			lookup);
	baseStateLicensesPlusStLicTypeDescription :=
		join(baseStateLicensesPlusStLicDegreeDescription,inCodeUpdate,
			right.code_name = 'ST_LIC_TYPE' and
			left.rawfields.st_lic_type = right.code_cd,
			transform(Layouts.Base.StateLicense,
				self.st_lic_type_desc := right.code_desc,
				self := left,
				self := []),
			left outer,
			lookup);
	baseStateLicensesPlusStLicStatusDescription :=
		join(baseStateLicensesPlusStLicTypeDescription,inCodeUpdate,
			right.code_name = 'ST_LIC_STATUS' and
			left.rawfields.st_lic_status = right.code_cd,
			transform(Layouts.Base.StateLicense,
				self.st_lic_status_desc := right.code_desc,
				self := left,
				self := []),
			left outer,
			lookup);
	baseStateLicensesPlusEligibilityCdDescription :=
		join(baseStateLicensesPlusStLicStatusDescription,inCodeUpdate,
			right.code_name = 'ELIGIBILITY_CD' and
			left.rawfields.eligibility_cd = right.code_cd,
			transform(Layouts.Base.StateLicense,
				self.eligibility_cd_desc := right.code_desc,
				self := left,
				self := []),
			left outer,
			lookup);
	
	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.StateLicense.New,baseStateLicensesPlusEligibilityCdDescription,Build_Base_File);

	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping AMS.Build_Base_StateLicense atribute')
	);

end;
