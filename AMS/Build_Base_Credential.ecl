import tools, ut;

export Build_Base_Credential(
	 string pversion
	,dataset(Layouts.Base.Credential) inCredentialBase
	,dataset(Layouts.Input.Credential) inCredentialUpdate
	,dataset(Layouts.Input.Code) inCodeUpdate
) :=
module

	// Take the credential update file and project it into the base layout.
	workingCredentialUpdate :=
		project(inCredentialUpdate(AMS_DELETED != 'Y'),
			transform(Layouts.Base.Credential,
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
			  self.rawfields.credential := left.credential,
			  self.rawfields.add_date := left.add_date,
			  self.rawfields.update_date := left.update_date,
			  self.rawfields.delete_date := left.delete_date,
				self := left,
				self := []));

  // Distribute needed files for quicker processing
	workingCredentialUpdate_dist := DISTRIBUTE(workingCredentialUpdate, HASH(AMS_ID));
	inCredentialBase_dist := DISTRIBUTE(inCredentialBase, HASH(AMS_ID));

	// Make the input unique for ams_id, to help determine what's historical and what's not.
	unique_update := DEDUP(SORT(workingCredentialUpdate_dist, ams_id, LOCAL), ams_id, LOCAL);

	// Determine the records that are current, because the vendor is no longer sending any updates related
	// to that particular ams_id.
  workingCurrentCredentialBase := JOIN(inCredentialBase_dist, unique_update,
	                                     LEFT.ams_id = RIGHT.ams_id,
																			 TRANSFORM(Layouts.Base.Credential,
																			   SELF.record_type := 'C';
																				 SELF.CREDENTIAL_DESC := '';
																				 SELF := LEFT),
																			 LEFT ONLY,
																			 LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that ams_id.
	workingHistoricalCredentialBase := JOIN(inCredentialBase_dist, unique_update,
	                                        LEFT.ams_id = RIGHT.ams_id,
																			    TRANSFORM(Layouts.Base.Credential,
																			      SELF.record_type := 'H';
																				    SELF.CREDENTIAL_DESC := '';
																				    SELF := LEFT),
																					LOCAL);

	// Join base and update credentials to determine what's new
	combinedCredentials := workingCredentialUpdate + workingCurrentCredentialBase +
	                       workingHistoricalCredentialBase;
	combinedCredentials_dist := DISTRIBUTE(combinedCredentials, HASH(AMS_ID));
	combinedCredentials_sort := SORT(combinedCredentials_dist,
	                                 (UNSIGNED)AMS_ID, rawfields.CREDENTIAL, record_type, -dt_last_seen,
				                           LOCAL);
	
	Layouts.Base.Credential rollupCredentials(Layouts.Base.Credential L,
	                                          Layouts.Base.Credential R) := TRANSFORM
    SELF.dt_first_seen := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen),
		                                      ut.EarliestDate(L.dt_last_seen, R.dt_last_seen));
    SELF.dt_last_seen := MAX(L.dt_last_seen, R.dt_last_seen);
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := MAX(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.rawfields := L.rawfields;
																								 
	  SELF := L;
	END;
	
	baseCredentials := ROLLUP(combinedCredentials_sort,
	                          rollupCredentials(LEFT, RIGHT),
														AMS_ID, rawfields.CREDENTIAL,
														LOCAL);

	// Finally, join to the codes file to expand the code descriptions.
	baseCredentialsPlusCredentialDescription :=
		join(baseCredentials,inCodeUpdate,
			right.code_name = 'CRED' and
			left.rawfields.credential = right.code_cd,
			transform(Layouts.Base.Credential,
				self.credential_desc := right.code_desc,
				self := left,
				self := []),
			left outer,
			lookup);
	
	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.Credential.New,baseCredentialsPlusCredentialDescription,Build_Base_File);

	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping AMS.Build_Base_Credential atribute')
	);

end;
