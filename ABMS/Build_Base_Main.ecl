IMPORT Address, NID, tools, ut, _Validate;

EXPORT Build_Base_Main(STRING 																 pversion,
											 DATASET(Layouts.Base.Main) 						 inMainBase,
											 DATASET(Layouts.Input.BIOG) 						 inBIOGUpdate,
											 DATASET(Layouts.Input.Address) 				 inAddressUpdate,
											 DATASET(Layouts.Input.Contact) 				 inContactUpdate,
											 DATASET(Layouts.Input.Deceased) 				 inDeceasedUpdate,
											 DATASET(Layouts.Input.MOCParticipation) inMOCParticipationUpdate) := MODULE

  inBIOGUpdate_dist 						:= DISTRIBUTE(inBIOGUpdate, HASH(biog_number));
  inAddressUpdate_dist 					:= DISTRIBUTE(inAddressUpdate, HASH(biog_number));
  inContactUpdate_dist 					:= DISTRIBUTE(inContactUpdate, HASH(biog_number));
  inDeceasedUpdate_dist 				:= DISTRIBUTE(inDeceasedUpdate, HASH(biog_number));
  inMOCParticipationUpdate_dist := DISTRIBUTE(inMOCParticipationUpdate, HASH(biog_number));
	
	TrimUpper(STRING s) := FUNCTION
		RETURN TRIM(StringLib.StringToUppercase(s), LEFT, RIGHT);
	END;

  // ** Combine all necessary tables and transform it into the main base layout ** //
	workingMOCUpdate := JOIN(inBIOGUpdate_dist, inMOCParticipationUpdate_dist,
	                         LEFT.biog_number = RIGHT.biog_number,
													 LEFT OUTER,
													 LOCAL);

  // If there exists a record from the deceased input, the person is considered dead (even if the date
  // is empty).
	temp_dead_rec := RECORD
	  Layouts.Input.BIOG;
		Layouts.Input.MOCParticipation - [biog_number];
		Layouts.Input.Deceased - [biog_number];
		STRING dead_ind := '';
	END;

	temp_dead_rec determine_dead_indicator(workingMOCUpdate L, Layouts.Input.Deceased R) := TRANSFORM
    SELF.dead_ind := IF(L.biog_number = R.biog_number, 'Y', 'N');
    SELF 				  := L;
		SELF 					:= R;
	END;
	
  workingDeceasedUpdate := JOIN(workingMOCUpdate, inDeceasedUpdate_dist,
	                              LEFT.biog_number = RIGHT.biog_number,
																determine_dead_indicator(LEFT, RIGHT),
																LEFT OUTER,
																LOCAL);

  workingDeceasedUpdate_proj := PROJECT(workingDeceasedUpdate,
	                                      TRANSFORM(Layouts.Base.Main, SELF := LEFT, SELF := []));

  Layouts.Base.Main assign_address_occurrence(Layouts.Base.Main L, Layouts.Input.Address R) := TRANSFORM
	  SELF.address_occurrence_number := R.occurrence_number;
	  SELF.address_id                := R.address_id;
	  SELF.state                     := R.state;
	  SELF.full_zip                  := R.full_zip;
	  SELF.org1                      := R.org1;
	  SELF.line1                     := R.line1;
	  SELF.line2                     := R.line2;
	  SELF.line3                     := R.line3;
	  SELF.city                      := R.city;
	  SELF.country                   := R.country;
	  SELF.address_type              := R.address_type;
	  SELF.address_suppress_ind      := R.address_suppress_ind;
    SELF 													 := L;
	END;

  workingAddressUpdate := JOIN(workingDeceasedUpdate_proj, inAddressUpdate_dist,
	                             LEFT.biog_number = RIGHT.biog_number,
															 assign_address_occurrence(LEFT, RIGHT),
															 LEFT OUTER,
															 LOCAL);

  Layouts.Base.Main assign_contact_occurrence(Layouts.Base.Main L, Layouts.Input.Contact R) := TRANSFORM
		SELF.contact_occurrence_number := R.occurrence_number;
		SELF.contact_type              := R.contact_type;
		SELF.description               := R.description;
		SELF.area_code                 := R.area_code;
		SELF.exchange                  := R.exchange;
		SELF.phone_last_four           := R.phone_last_four;
    SELF 													 := L;
	END;

  workingContactUpdate := JOIN(workingAddressUpdate, inContactUpdate_dist,
	                             LEFT.biog_number = RIGHT.biog_number AND
															 LEFT.address_id = RIGHT.address_id,
															 assign_contact_occurrence(LEFT, RIGHT),
															 LEFT OUTER,
															 LOCAL);

  Layouts.Base.Main standardize_input(workingContactUpdate L) := TRANSFORM
		// Convert from MM/DD/YYYY format to YYYYMMDD format.
		the_dod         								 := IF(LENGTH(L.dod) = 10, L.dod[7..] + L.dod[1..2] + L.dod[4..5], '');
		the_dob         								 := L.birth_year + L.birth_month + L.birth_day;
		the_org1        								 := TrimUpper(L.org1);
		the_line1       								 := TrimUpper(L.line1);
		the_line2       								 := TrimUpper(L.line2);
		the_line3       								 := TrimUpper(L.line3);
		the_description 								 := TrimUpper(L.description);			
		SELF.birth_date_suppress_ind     := TrimUpper(L.birth_date_suppress_ind);
		SELF.birth_city                  := TrimUpper(L.birth_city);
		SELF.birth_state                 := TrimUpper(L.birth_state);
		SELF.birth_nation                := TrimUpper(L.birth_nation);
		SELF.birth_location_suppress_ind := TrimUpper(L.birth_location_suppress_ind);
		SELF.first_name                  := TrimUpper(L.first_name);
		SELF.middle_name                 := TrimUpper(L.middle_name);
		SELF.last_name                   := TrimUpper(L.last_name);
		SELF.name_suffix                 := TrimUpper(L.name_suffix);
		SELF.placement_cert              := TrimUpper(L.placement_cert);
		SELF.placement_city              := TrimUpper(L.placement_city);
		SELF.placement_state             := TrimUpper(L.placement_state);
		SELF.gender                      := TrimUpper(L.gender);
		SELF.board_certified             := TrimUpper(L.board_certified);
		SELF.npi                         := IF(ut.isNumeric(L.npi), L.npi, '');
    SELF.dod                         := IF(_Validate.Date.fIsValid(the_dod), the_dod, '');
		SELF.board_code                  := TrimUpper(L.board_code);
		SELF.board_name                  := TrimUpper(L.board_name);
		SELF.participation               := TrimUpper(L.participation);
		SELF.moc_cert_name               := TrimUpper(L.moc_cert_name);
		SELF.state                       := TrimUpper(L.state);
		SELF.org1                        := TrimUpper(the_org1);
		SELF.line1                       := TrimUpper(the_line1);
		SELF.line2                       := TrimUpper(the_line2);
		SELF.line3                       := TrimUpper(the_line3);
		SELF.city                        := TrimUpper(L.city);
		SELF.country                     := TrimUpper(L.country);
		SELF.address_type                := TrimUpper(L.address_type);
		SELF.contact_type                := TrimUpper(L.contact_type);
		SELF.description                 := the_description;
		SELF.dob                         := IF(_Validate.Date.fIsValid(the_dob), the_dob, '');
		SELF.org_name                    := the_org1;
		SELF.additional_org_text         := the_line1;
		SELF.address1                    := the_line2;
		SELF.address2                    := the_line3;
		// Piecing together the phone number, regardless of contact_type.
		SELF.phone_number                := L.area_code + L.exchange + L.phone_last_four;
		// The description holds the URL when the contact type is WS (website).
		SELF.website                     := IF(SELF.contact_type = 'WS', the_description, '');
		SELF.dt_vendor_first_reported    := (UNSIGNED4)pversion;
		SELF.dt_vendor_last_reported     := (UNSIGNED4)pversion;
		SELF.record_type                 := 'C';
		SELF.board_source                := 'ABMS';		
		SELF 														 := L;
		SELF 														 := [];
	END;

	// Take the main update file, standardize it, and PROJECT it into the base layout.
	workingMainUpdate := PROJECT(workingContactUpdate, standardize_input(LEFT));

  // Distribute needed files for quicker processing.
	workingMainUpdate_dist := DISTRIBUTE(workingMainUpdate, HASH(biog_number));
	inMainBase_dist 			 := DISTRIBUTE(inMainBase, HASH(biog_number));

	// Make the input unique for biog_number, to help determine what's historical and what's not.
	unique_update := DEDUP(SORT(workingMainUpdate_dist, biog_number, LOCAL), biog_number, LOCAL);

  // If the vendor isn't sending records for a given biog_number anymore, we want them, but
	// don't need to do anything to them.  They've already been marked up with C and H appropriately.
	// (no inline transform needed).
  workingCurrentMainBase := JOIN(inMainBase_dist, unique_update,
																 LEFT.biog_number = RIGHT.biog_number,
																 LEFT ONLY,
																 LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that biog_number.
	workingHistoricalMainBase := JOIN(inMainBase_dist, unique_update,
																		LEFT.biog_number = RIGHT.biog_number,
																		TRANSFORM(Layouts.Base.Main,
																							SELF.record_type := 'H';
																							SELF.address_type_desc := '';
																							SELF := LEFT),
																		LOCAL);

	workingMainUpdate_clean_phone := Standardize_Phone(workingCurrentMainBase + workingHistoricalMainBase +
																										 workingMainUpdate_dist);
	workingMainUpdate_clean_name  := Standardize_Name(workingMainUpdate_clean_phone);

	// Join base and update main to determine what's new.  Apply AID logic to everything.
	combinedMain 		:= Standardize_Addr(workingMainUpdate_clean_name);
	// Add DID and BDID
	combinedMainAID := Append_IDs.fAll(combinedMain);

 	combinedMain_dist := DISTRIBUTE(combinedMainAID, HASH(biog_number));
  combinedMain_sort := DEDUP(SORT(combinedMain_dist, RECORD, LOCAL), RECORD, LOCAL);
   	
   	ABMS.Layouts.Base.Main rollupMain(ABMS.Layouts.Base.Main L, ABMS.Layouts.Base.Main R) := TRANSFORM
      SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
      SELF.dt_vendor_last_reported  := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			source_rec_id_to_use					:= IF(L.source_rec_id = 0, R.source_rec_id, L.source_rec_id);
   		SELF.source_rec_id            := source_rec_id_to_use;
   		SELF.record_sid		            := source_rec_id_to_use;
   		// If there's a case where the records change gender to U or null, we keep the last known gender.
   		// Regardless, it'll keep the most recent gender that's a definied gender of M or F.
   		SELF.gender										:= IF(L.gender NOT IN ['M', 'F'], R.gender, L.gender);   
   	  self.record_type							:= if(l.record_type = 'C' or r.record_type = 'C', 'C', 'H');
			SELF 													:= L;
	END;
   	
   	baseMain := ROLLUP(combinedMain_sort,
   										 rollupMain(LEFT, RIGHT),
											 biog_number, address_id, address_occurrence_number, contact_occurrence_number,
   										 moc_cert_id, RECORD,
											 except
											 dt_vendor_first_reported
											,dt_vendor_last_reported
											,bdid_score
											,gender
											,record_type
											,source_rec_id
											,ultscore
											,orgscore
											,selescore
											,proxscore
											,powscore
											,empscore
											,dotscore
											,ultweight
											,orgweight
											,seleweight
											,proxweight
											,powweight
											,empweight
											,dotweight,LOCAL);
											
  Layouts.Base.Main add_description_text(Layouts.Base.Main L) := TRANSFORM
    SELF.address_type_desc := MAP(L.address_type = 'P' => 'PROFESSIONAL',
		                              L.address_type = 'S' => 'SECONDARY',
																  L.address_type = 'C' => 'COMBINATION (PROFESSIONAL/HOME)',
																  L.address_type = 'H' => 'HOME',
																  '');

    SELF 									 := L;
	END;

	// Finally, get descriptions.
	baseMainPlusDescriptions := PROJECT(baseMain, add_description_text(LEFT));
	
 	// Add source record id
  ut.MAC_Append_Rcid(baseMainPlusDescriptions, source_rec_id, baseMainPlusSourceRid);
	
	baseMainPlusSourceRid_sort	:= dedup(sort(baseMainPlusSourceRid, record, local), record, local);
	   	
  baseMain_roll := ROLLUP(baseMainPlusSourceRid_sort,
   										 rollupMain(LEFT, RIGHT),
											 biog_number, address_id, address_occurrence_number, contact_occurrence_number,
   										 moc_cert_id, RECORD,
											 except
											 dt_vendor_first_reported
											,dt_vendor_last_reported
											,bdid_score
											,gender
											,record_type
											,source_rec_id
											,ultscore
											,orgscore
											,selescore
											,proxscore
											,powscore
											,empscore
											,dotscore
											,ultweight
											,orgweight
											,seleweight
											,proxweight
											,powweight
											,empweight
											,dotweight,LOCAL);	
	
	// Add global_sid and record_sid for CCPA
	ABMS.Layouts.Base.Main add_sid(baseMain_roll L) := TRANSFORM
			SELF.global_sid								:= 23941;
			SELF.record_sid								:= L.source_rec_id;
			SELF						 							:= L;
		END;
	
	with_ccpa := project(baseMain_roll, add_sid (left));

	sort_with_ccpa:=dedup(sort(distribute(with_ccpa, hash(biog_number)), record, local), record, local);
   	
	ABMS.Layouts.Base.Main rollupLast(ABMS.Layouts.Base.Main L, ABMS.Layouts.Base.Main R) := TRANSFORM
      SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
      SELF.dt_vendor_last_reported  := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
			source_rec_id_to_use					:= IF(L.source_rec_id = 0, R.source_rec_id, L.source_rec_id);
   		SELF.source_rec_id            := source_rec_id_to_use;
   		SELF.record_sid		            := source_rec_id_to_use;
   		// If there's a case where the records change gender to U or null, we keep the last known gender.
   		// Regardless, it'll keep the most recent gender that's a definied gender of M or F.
   		SELF.gender										:= IF(L.gender NOT IN ['M', 'F'], R.gender, L.gender);   
   	  self.record_type							:= if(l.record_type = 'C' or r.record_type = 'C', 'C', 'H');
			SELF 													:= L;
	END;
   	
	baseMain_last := ROLLUP(sort_with_ccpa,
   										 rollupLast(LEFT, RIGHT),
											 biog_number, address_id, address_occurrence_number, contact_occurrence_number,
   										 moc_cert_id, 
											 RECORD,
											 except
											 dt_vendor_first_reported
											,dt_vendor_last_reported
											,bdid_score
											,gender
											,record_type
											,source_rec_id
											,record_sid
											,ultscore
											,orgscore
											,selescore
											,proxscore
											,powscore
											,empscore
											,dotscore
											,ultweight
											,orgweight
											,seleweight
											,proxweight
											,powweight
											,empweight
											,dotweight,LOCAL);

	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.Main.New, baseMain_last, Build_Base_File);

	EXPORT full_build := SEQUENTIAL(Build_Base_File,
			                            Promote(pversion).buildfiles.New2Built);
		
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping ABMS.Build_Base_Main atribute'));

END;