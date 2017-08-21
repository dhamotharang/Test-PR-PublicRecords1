import tools, ut;

export Build_Base_IDNumber(
	 string pversion
	,dataset(Layouts.Base.IDNumber) inIDNumberBase
	,dataset(Layouts.Input.Xref) inXrefUpdate
	,dataset(Layouts.Input.Code) inCodeUpdate
) :=
module

	// Take the xref update file and project it into the base layout.
	workingXrefUpdate :=
		project(inXrefUpdate(AMS_DELETED != 'Y'),
			transform(Layouts.Base.IDNumber,
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
			  self.rawfields.indy_id := left.indy_id,
			  self.rawfields.src_cd := left.src_cd,
			  self.rawfields.indy_id_end_date := left.indy_id_end_date,
			  self.rawfields.end_date_reason := left.end_date_reason,
			  self.rawfields.add_date := left.add_date,
			  self.rawfields.update_date := left.update_date,
			  self.rawfields.delete_date := left.delete_date,
				self := left,
				self := []));
	
  // Distribute needed files for quicker processing
	workingXrefUpdate_dist := DISTRIBUTE(workingXrefUpdate, HASH(AMS_ID));
	inIDNumberBase_dist := DISTRIBUTE(inIDNumberBase, HASH(AMS_ID));

	// Make the input unique for ams_id, to help determine what's historical and what's not.
	unique_update := DEDUP(SORT(workingXrefUpdate_dist, ams_id, LOCAL), ams_id, LOCAL);

	// Determine the records that are current, because the vendor is no longer sending any updates related
	// to that particular ams_id.
  workingCurrentIDNumberBase := JOIN(inIDNumberBase_dist, unique_update,
	                                   LEFT.ams_id = RIGHT.ams_id,
																		 TRANSFORM(Layouts.Base.IDNumber,
																			 SELF.record_type := 'C';
																			 SELF.SRC_CD_DESC := '';
																			 SELF := LEFT),
																		 LEFT ONLY,
																		 LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that ams_id.
	workingHistoricalIDNumberBase := JOIN(inIDNumberBase_dist, unique_update,
	                                      LEFT.ams_id = RIGHT.ams_id,
																			  TRANSFORM(Layouts.Base.IDNumber,
																			    SELF.record_type := 'H';
																				  SELF.SRC_CD_DESC := '';
																				  SELF := LEFT),
																				LOCAL);

	// Join base and update ID numbers to determine what's new
	combinedIDNumbers := workingCurrentIDNumberBase + workingHistoricalIDNumberBase +
	                     workingXrefUpdate;
	combinedIDNumbers_dist := DISTRIBUTE(combinedIDNumbers, HASH(AMS_ID));
	combinedIDNumbers_sort := SORT(combinedIDNumbers_dist,
	                               (UNSIGNED)AMS_ID, rawfields.INDY_ID, rawfields.SRC_CD,
																    -(UNSIGNED)rawfields.INDY_ID_END_DATE, rawfields.END_DATE_REASON,
																    record_type, -dt_last_seen,
				                         LOCAL);
	
	Layouts.Base.IDNumber rollupIDNumbers(Layouts.Base.IDNumber L, Layouts.Base.IDNumber R) := TRANSFORM
    SELF.dt_first_seen := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen),
		                                      ut.EarliestDate(L.dt_last_seen, R.dt_last_seen));
    SELF.dt_last_seen := MAX(L.dt_last_seen, R.dt_last_seen);
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := MAX(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.rawfields.update_date :=
		  (STRING)MAX((UNSIGNED)L.rawfields.update_date, (UNSIGNED)R.rawfields.update_date);
																								 
	  SELF := L;
	END;
	
	baseIDNumbers := ROLLUP(combinedIDNumbers_sort,
	                        rollupIDNumbers(LEFT, RIGHT),
												  AMS_ID, rawfields.INDY_ID, rawfields.SRC_CD, rawfields.INDY_ID_END_DATE,
													   rawfields.END_DATE_REASON,
												  LOCAL);

	// Finally, join to the codes file to expand the code descriptions.
	baseIDNumbersPlusSrcCdDescription :=
		join(baseIDNumbers,inCodeUpdate,
			right.code_name = 'SRC_CD' and
			left.rawfields.src_cd = right.code_cd,
			transform(Layouts.Base.IDNumber,
				self.src_cd_desc := right.code_desc,
				self := left,
				self := []),
			left outer,
			lookup);
	
	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.IDNumber.New,baseIDNumbersPlusSrcCdDescription,Build_Base_File);

	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping AMS.Build_Base_IDNumber atribute')
	);

end;
