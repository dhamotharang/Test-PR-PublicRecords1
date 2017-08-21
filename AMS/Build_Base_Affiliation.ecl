import tools, ut;

export Build_Base_Affiliation(
	 string pversion
	,dataset(Layouts.Base.Affiliation) inAffiliationBase
	,dataset(Layouts.Input.Affiliation) inAffiliationUpdate
	,dataset(Layouts.Input.Code) inCodeUpdate
) :=
module

	// Take the affiliation update file and project it into the base layout.
	workingAffiliationUpdate :=
		project(inAffiliationUpdate(AMS_DELETED != 'Y'),
			transform(Layouts.Base.Affiliation,
				self.dt_first_seen := map(
					left.ADD_DATE != ''						=>	(unsigned4)left.ADD_DATE,
					left.UPDATE_DATE != ''				=>	(unsigned4)left.UPDATE_DATE,
					/*otherwise*/											(unsigned4)pversion),
				self.dt_last_seen := map(
					left.UPDATE_DATE != ''				=>	(unsigned4)left.UPDATE_DATE,
					/*otherwise*/											(unsigned4)pversion),
				self.dt_vendor_first_reported := (unsigned4)pversion,
				self.dt_vendor_last_reported := (unsigned4)pversion,
				self.record_type := 'C',
			  self.rawfields.ams_seq := left.ams_seq,
			  self.rawfields.ams_batch := left.ams_batch,
			  self.rawfields.ams_deleted := left.ams_deleted,
			  self.rawfields.src_cd := left.src_cd,
			  self.rawfields.ams_parent_id := left.ams_parent_id,
			  self.rawfields.ams_child_id := left.ams_child_id,
			  self.rawfields.affil_status := left.affil_status,
			  self.rawfields.affil_type := left.affil_type,
			  self.rawfields.affil_update_date := left.affil_update_date,
			  self.rawfields.affil_start_date := left.affil_start_date,
			  self.rawfields.affil_end_date := left.affil_end_date,
			  self.rawfields.add_date := left.add_date,
			  self.rawfields.update_date := left.update_date,
			  self.rawfields.delete_date := left.delete_date,
				self := left,
				self := []));

  // Distribute needed files for quicker processing
	workingAffiliationUpdate_dist := DISTRIBUTE(workingAffiliationUpdate, HASH(AMS_PARENT_ID, AMS_CHILD_ID));
	inAffiliationBase_dist := DISTRIBUTE(inAffiliationBase, HASH(AMS_PARENT_ID, AMS_CHILD_ID));

	// Make the input unique for ams_parent_id and ams_child_id, to help determine what's historical and
	// what's not.
	unique_update := DEDUP(SORT(workingAffiliationUpdate_dist,
	                            ams_parent_id, ams_child_id,
															LOCAL),
	                       ams_parent_id, ams_child_id,
												 LOCAL);

	// Determine the records that are current, because the vendor is no longer sending any updates related
	// to that particular ams_parent_id and ams_child_id.
  workingCurrentAffiliationBase := JOIN(inAffiliationBase_dist, unique_update,
	                                      LEFT.ams_parent_id = RIGHT.ams_parent_id AND
																				LEFT.ams_child_id = RIGHT.ams_child_id,
																			  TRANSFORM(Layouts.Base.Affiliation,
																			    SELF.record_type := 'C';
																				  SELF.SRC_CD_DESC := '';
																				  SELF := LEFT),
																			  LEFT ONLY,
																				LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that ams_parent_id
	// and ams_child_id.
	workingHistoricalAffiliationBase := JOIN(inAffiliationBase_dist, unique_update,
	                                         LEFT.ams_parent_id = RIGHT.ams_parent_id AND
																				   LEFT.ams_child_id = RIGHT.ams_child_id,
																			     TRANSFORM(Layouts.Base.Affiliation,
																			       SELF.record_type := 'H';
																				     SELF.SRC_CD_DESC := '';
																				     SELF := LEFT),
																					 LOCAL);

	// Join base and update affiliations to determine what's new
	combinedAffiliations := workingCurrentAffiliationBase + workingHistoricalAffiliationBase +
	                        workingAffiliationUpdate;
	combinedAffiliations_dist := DISTRIBUTE(combinedAffiliations, HASH(AMS_PARENT_ID, AMS_CHILD_ID));
	combinedAffiliations_sort :=
	  SORT(combinedAffiliations_dist,
	       (UNSIGNED)AMS_PARENT_ID, (UNSIGNED)AMS_CHILD_ID, rawfields.AFFIL_TYPE, rawfields.SRC_CD,
				    record_type, -dt_last_seen, rawfields.AFFIL_STATUS, rawfields.AFFIL_END_DATE,
				 LOCAL);
	
	Layouts.Base.Affiliation rollupAffiliations(Layouts.Base.Affiliation L,
	                                            Layouts.Base.Affiliation R) := TRANSFORM
    SELF.dt_first_seen := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen),
		                                      ut.EarliestDate(L.dt_last_seen, R.dt_last_seen));
    SELF.dt_last_seen := MAX(L.dt_last_seen, R.dt_last_seen);
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := MAX(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.rawfields.affil_update_date :=
		  (STRING)MAX((UNSIGNED)L.rawfields.affil_update_date, (UNSIGNED)R.rawfields.affil_update_date);
																								 
	  SELF := L;
	END;
	
	baseAffiliations := ROLLUP(combinedAffiliations_sort,
	                           rollupAffiliations(LEFT, RIGHT),
														 AMS_PARENT_ID, AMS_CHILD_ID, rawfields.SRC_CD, rawfields.AFFIL_STATUS,
														    rawfields.AFFIL_TYPE, rawfields.AFFIL_END_DATE,
														 LOCAL);

	// Finally, join to the codes file to expand the code descriptions.
	baseAffiliationsPlusSrcCdDescription :=
		join(baseAffiliations,inCodeUpdate,
			right.code_name = 'SRC_CD' and
			left.rawfields.src_cd = right.code_cd,
			transform(Layouts.Base.Affiliation,
				self.src_cd_desc := right.code_desc,
				self := left,
				self := []),
			left outer,
			lookup);
	
	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.Affiliation.New,baseAffiliationsPlusSrcCdDescription,Build_Base_File);

	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping AMS.Build_Base_Affiliation atribute')
	);

end;
