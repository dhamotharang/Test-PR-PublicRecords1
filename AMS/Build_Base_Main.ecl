import tools, ut;

export Build_Base_Main(
	 string pversion
	,dataset(Layouts.Base.Main) inMainBase
	,dataset(Layouts.Input.ProviderDemographics) inProviderDemographicsUpdate
	,dataset(Layouts.Input.ProviderAddress) inProviderAddressUpdate
	,dataset(Layouts.Input.AccountDemographics) inAccountDemographicsUpdate
	,dataset(Layouts.Input.AccountAddress) inAccountAddressUpdate
	,dataset(Layouts.Input.Code) inCodeUpdate
) :=
module

	// Take the demographics update files and project them into the base layout.
	workingProviderDemographicsUpdate :=
		project(inProviderDemographicsUpdate(AMS_DELETED != 'Y'),
			transform(Layouts.Base.Main,
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
			  self.rawdemographicsfields.ams_seq := left.ams_seq,
			  self.rawdemographicsfields.ams_batch := left.ams_batch,
			  self.rawdemographicsfields.ams_deleted := left.ams_deleted,
			  self.rawdemographicsfields.amsid_type := left.amsid_type,
			  self.rawdemographicsfields.ams_id := left.ams_id,
			  self.rawdemographicsfields.full_name := left.full_name,
			  self.rawdemographicsfields.last_name := left.last_name,
			  self.rawdemographicsfields.first_name := left.first_name,
			  self.rawdemographicsfields.middle_name := left.middle_name,
			  self.rawdemographicsfields.suffix_name := left.suffix_name,
			  self.rawdemographicsfields.former_last_name := left.former_last_name,
			  self.rawdemographicsfields.former_first_name := left.former_first_name,
			  self.rawdemographicsfields.former_middle_name := left.former_middle_name,
			  self.rawdemographicsfields.former_suffix_name := left.former_suffix_name,
			  self.rawdemographicsfields.nick_name := left.nick_name,
			  self.rawdemographicsfields.gen_cd := left.gen_cd,
			  self.rawdemographicsfields.dob_date := left.dob_date,
			  self.rawdemographicsfields.yob_date := left.yob_date,
			  self.rawdemographicsfields.birth_city := left.birth_city,
			  self.rawdemographicsfields.birth_state := left.birth_state,
			  self.rawdemographicsfields.birth_cntry := left.birth_cntry,
			  self.rawdemographicsfields.opt_out_flag := left.opt_out_flag,
			  self.rawdemographicsfields.opt_out_start_date := left.opt_out_start_date,
			  self.rawdemographicsfields.kaiser_prov_flag := left.kaiser_prov_flag,
			  self.rawdemographicsfields.status := left.status,
			  self.rawdemographicsfields.status_update_date := left.status_update_date,
			  self.rawdemographicsfields.presumed_dead_flag := left.presumed_dead_flag,
			  self.rawdemographicsfields.contact_flag := left.contact_flag,
			  self.rawdemographicsfields.top_cd := left.top_cd,
			  self.rawdemographicsfields.pe_cd := left.pe_cd,
			  self.rawdemographicsfields.mpa_cd := left.mpa_cd,
			  self.rawdemographicsfields.tax_id := left.tax_id,
			  self.rawdemographicsfields.ssn_last4 := left.ssn_last4,
			  self.rawdemographicsfields.solo := left.solo,
			  self.rawdemographicsfields.group_affiliated := left.group_affiliated,
			  self.rawdemographicsfields.hospital_affiliated := left.hospital_affiliated,
			  self.rawdemographicsfields.administrator := left.administrator,
			  self.rawdemographicsfields.research := left.research,
			  self.rawdemographicsfields.clinical_trials := left.clinical_trials,
			  self.rawdemographicsfields.phone_flag := left.phone_flag,
			  self.rawdemographicsfields.email_flag := left.email_flag,
			  self.rawdemographicsfields.fax_flag := left.fax_flag,
			  self.rawdemographicsfields.url_flag := left.url_flag,
			  self.rawdemographicsfields.add_date := left.add_date,
			  self.rawdemographicsfields.update_date := left.update_date,
			  self.rawdemographicsfields.delete_date := left.delete_date,
				self := left,
				self := []));
	
	workingAccountDemographicsUpdate :=
		project(inAccountDemographicsUpdate(AMS_DELETED != 'Y'),
			transform(Layouts.Base.Main,
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
			  self.rawdemographicsfields.ams_seq := left.ams_seq,
			  self.rawdemographicsfields.ams_batch := left.ams_batch,
			  self.rawdemographicsfields.ams_deleted := left.ams_deleted,
			  self.rawdemographicsfields.ams_id := left.ams_id,
			  self.rawdemographicsfields.ams_gold_flag := left.ams_gold_flag,
			  self.rawdemographicsfields.amsid_type := left.amsid_type,
			  self.rawdemographicsfields.amsid_subtype := left.amsid_subtype,
			  self.rawdemographicsfields.indy_id := left.indy_id,
			  self.rawdemographicsfields.src_cd := left.src_cd,
			  self.rawdemographicsfields.acct_name := left.acct_name,
			  self.rawdemographicsfields.alt_name := left.alt_name,
			  self.rawdemographicsfields.sector_cd := left.sector_cd,
			  self.rawdemographicsfields.fiscal_cd := left.fiscal_cd,
			  self.rawdemographicsfields.academic_flag := left.academic_flag,
			  self.rawdemographicsfields.status_cd := left.status_cd,
			  self.rawdemographicsfields.status_update_date := left.status_update_date,
			  self.rawdemographicsfields.tax_id := left.tax_id,
			  self.rawdemographicsfields.add_date := left.add_date,
			  self.rawdemographicsfields.update_date := left.update_date,
			  self.rawdemographicsfields.delete_date := left.delete_date,
				self := left,
				self := []));
	
	workingDemographicsUpdates_noName :=
		workingProviderDemographicsUpdate +
		workingAccountDemographicsUpdate;
	
	workingDemographicsUpdates := Standardize_Name(workingDemographicsUpdates_noName);
	
	// Take the address update files and project them into the base layout.
	workingProviderAddressUpdate :=
		project(inProviderAddressUpdate(AMS_DELETED != 'Y'),
			transform(Layouts.Base.Main,
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
			  self.rawaddressfields.ams_seq := left.ams_seq,
			  self.rawaddressfields.ams_batch := left.ams_batch,
			  self.rawaddressfields.ams_deleted := left.ams_deleted,
			  self.rawaddressfields.ams_id := left.ams_id,
			  self.rawaddressfields.gold_record_flag := left.gold_record_flag,
			  self.rawaddressfields.bob_rank := left.bob_rank,
			  self.rawaddressfields.bob_value := left.bob_value,
			  self.rawaddressfields.new_ams_id := left.new_ams_id,
			  self.rawaddressfields.new_ams_addr_id := left.new_ams_addr_id,
			  self.rawaddressfields.ams_addr_id := left.ams_addr_id,
			  self.rawaddressfields.inactive_reason_cd := left.inactive_reason_cd,
			  self.rawaddressfields.indy_id := left.indy_id,
			  self.rawaddressfields.src_cd := left.src_cd,
			  self.rawaddressfields.ams_street := left.ams_street,
			  self.rawaddressfields.ams_unit := left.ams_unit,
			  self.rawaddressfields.ams_city := left.ams_city,
			  self.rawaddressfields.ams_state := left.ams_state,
			  self.rawaddressfields.ams_zip5 := left.ams_zip5,
			  self.rawaddressfields.ams_zip4 := left.ams_zip4,
			  self.rawaddressfields.leftovers := left.leftovers,
			  self.rawaddressfields.cntry_cd := left.cntry_cd,
			  self.rawaddressfields.cbsa_cd := left.cbsa_cd,
			  self.rawaddressfields.fips_cnty_cd := left.fips_cnty_cd,
			  self.rawaddressfields.fips_state_cd := left.fips_state_cd,
			  self.rawaddressfields.addr_type := left.addr_type,
			  self.rawaddressfields.ams_glid := left.ams_glid,
			  self.rawaddressfields.multiunit_cd := left.multiunit_cd,
			  self.rawaddressfields.ams_addr_pass_flag := left.ams_addr_pass_flag,
			  self.rawaddressfields.addr_status := left.addr_status,
			  self.rawaddressfields.add_start_date := left.add_start_date,
			  self.rawaddressfields.add_end_date := left.add_end_date,
			  self.rawaddressfields.org_unit := left.org_unit,
			  self.rawaddressfields.ams_account_id := left.ams_account_id,
			  self.rawaddressfields.unit_name := left.unit_name,
			  self.rawaddressfields.unit_value := left.unit_value,
			  self.rawaddressfields.floor_value := left.floor_value,
			  self.rawaddressfields.building_name_value := left.building_name_value,
			  self.rawaddressfields.dept_name_value := left.dept_name_value,
			  self.rawaddressfields.cass_flag := left.cass_flag,
			  self.rawaddressfields.cong_cd := left.cong_cd,
			  self.rawaddressfields.cmra_flag := left.cmra_flag,
			  self.rawaddressfields.dpc_cd := left.dpc_cd,
			  self.rawaddressfields.street_type_cd := left.street_type_cd,
			  self.rawaddressfields.invalidunit_flag := left.invalidunit_flag,
			  self.rawaddressfields.buildfirm_name := left.buildfirm_name,
			  self.rawaddressfields.dpv_cd := left.dpv_cd,
			  self.rawaddressfields.rdi_cd := left.rdi_cd,
			  self.rawaddressfields.lat_addr := left.lat_addr,
			  self.rawaddressfields.lng_addr := left.lng_addr,
			  self.rawaddressfields.latlong_type := left.latlong_type,
			  self.rawaddressfields.phone := left.phone,
			  self.rawaddressfields.phone_ext := left.phone_ext,
			  self.rawaddressfields.phone_flag := left.phone_flag,
			  self.rawaddressfields.email := left.email,
			  self.rawaddressfields.email_flag := left.email_flag,
			  self.rawaddressfields.fax := left.fax,
			  self.rawaddressfields.fax_flag := left.fax_flag,
			  self.rawaddressfields.url := left.url,
			  self.rawaddressfields.url_flag := left.url_flag,
			  self.rawaddressfields.dea_num := left.dea_num,
			  self.rawaddressfields.exp_date := left.exp_date,
			  self.rawaddressfields.drug_schedules := left.drug_schedules,
			  self.rawaddressfields.addr_id := left.addr_id,
			  self.rawaddressfields.add_date := left.add_date,
			  self.rawaddressfields.update_date := left.update_date,
			  self.rawaddressfields.delete_date := left.delete_date,
			  self.rawaddressfields.loc_id := left.loc_id,
				self := left,
				self := []));
	
	workingAccountAddressUpdate :=
		project(inAccountAddressUpdate(AMS_DELETED != 'Y'),
			transform(Layouts.Base.Main,
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
			  self.rawaddressfields.ams_seq := left.ams_seq,
			  self.rawaddressfields.ams_batch := left.ams_batch,
			  self.rawaddressfields.ams_deleted := left.ams_deleted,
			  self.rawaddressfields.ams_id := left.ams_id,
			  self.rawaddressfields.gold_record_flag := left.gold_record_flag,
			  self.rawaddressfields.bob_rank := left.bob_rank,
			  self.rawaddressfields.new_ams_id := left.new_ams_id,
			  self.rawaddressfields.new_ams_addr_id := left.new_ams_addr_id,
			  self.rawaddressfields.ams_addr_id := left.ams_addr_id,
			  self.rawaddressfields.inactive_reason_cd := left.inactive_reason_cd,
			  self.rawaddressfields.indy_id := left.indy_id,
			  self.rawaddressfields.src_cd := left.src_cd,
			  self.rawaddressfields.ams_street := left.ams_street,
			  self.rawaddressfields.ams_unit := left.ams_unit,
			  self.rawaddressfields.ams_city := left.ams_city,
			  self.rawaddressfields.ams_state := left.ams_state,
			  self.rawaddressfields.ams_zip5 := left.ams_zip5,
			  self.rawaddressfields.ams_zip4 := left.ams_zip4,
			  self.rawaddressfields.leftovers := left.leftovers,
			  self.rawaddressfields.cntry_cd := left.cntry_cd,
			  self.rawaddressfields.cbsa_cd := left.cbsa_cd,
			  self.rawaddressfields.fips_cnty_cd := left.fips_cnty_cd,
			  self.rawaddressfields.fips_state_cd := left.fips_state_cd,
			  self.rawaddressfields.addr_type := left.addr_type,
			  self.rawaddressfields.ams_glid := left.ams_glid,
			  self.rawaddressfields.multiunit_cd := left.multiunit_cd,
			  self.rawaddressfields.ams_addr_pass_flag := left.ams_addr_pass_flag,
			  self.rawaddressfields.addr_status := left.addr_status,
			  self.rawaddressfields.add_start_date := left.add_start_date,
			  self.rawaddressfields.add_end_date := left.add_end_date,
			  self.rawaddressfields.org_unit := left.org_unit,
			  self.rawaddressfields.ams_account_id := left.ams_account_id,
			  self.rawaddressfields.unit_name := left.unit_name,
			  self.rawaddressfields.unit_value := left.unit_value,
			  self.rawaddressfields.floor_value := left.floor_value,
			  self.rawaddressfields.building_name_value := left.building_name_value,
			  self.rawaddressfields.dept_name_value := left.dept_name_value,
			  self.rawaddressfields.cass_flag := left.cass_flag,
			  self.rawaddressfields.cong_cd := left.cong_cd,
			  self.rawaddressfields.cmra_flag := left.cmra_flag,
			  self.rawaddressfields.dpc_cd := left.dpc_cd,
			  self.rawaddressfields.street_type_cd := left.street_type_cd,
			  self.rawaddressfields.invalidunit_flag := left.invalidunit_flag,
			  self.rawaddressfields.buildfirm_name := left.buildfirm_name,
			  self.rawaddressfields.dpv_cd := left.dpv_cd,
			  self.rawaddressfields.rdi_cd := left.rdi_cd,
			  self.rawaddressfields.lat_addr := left.lat_addr,
			  self.rawaddressfields.lng_addr := left.lng_addr,
			  self.rawaddressfields.latlong_type := left.latlong_type,
			  self.rawaddressfields.phone := left.phone,
			  self.rawaddressfields.phone_ext := left.phone_ext,
			  self.rawaddressfields.phone_flag := left.phone_flag,
			  self.rawaddressfields.email := left.email,
			  self.rawaddressfields.email_flag := left.email_flag,
			  self.rawaddressfields.fax := left.fax,
			  self.rawaddressfields.fax_flag := left.fax_flag,
			  self.rawaddressfields.url := left.url,
			  self.rawaddressfields.url_flag := left.url_flag,
			  self.rawaddressfields.dea_num := left.dea_num,
			  self.rawaddressfields.exp_date := left.exp_date,
			  self.rawaddressfields.drug_schedules := left.drug_schedules,
			  self.rawaddressfields.addr_id := left.addr_id,
			  self.rawaddressfields.add_date := left.add_date,
			  self.rawaddressfields.update_date := left.update_date,
			  self.rawaddressfields.delete_date := left.delete_date,
			  self.rawaddressfields.loc_id := left.loc_id,
				self := left,
				self := []));
	
	workingAddressUpdates_noAddr :=
		workingProviderAddressUpdate +
		workingAccountAddressUpdate;
		
	workingAddressUpdates := Standardize_Phone(workingAddressUpdates_noAddr);
	
	// Join demographic info with address info
	workingUpdates :=
		join(workingDemographicsUpdates,workingAddressUpdates,
			left.AMS_ID = right.AMS_ID,
			transform(Layouts.Base.Main,
				self.AMS_ID := if(left.AMS_ID = '',right.AMS_ID,left.AMS_ID),
				self.AMSID_TYPE := left.AMSID_TYPE,
				self.AMSID_SUBTYPE := left.AMSID_SUBTYPE,
				self.dt_first_seen := map(
					left.AMS_ID = right.AMS_ID	=>	min(left.dt_first_seen,right.dt_first_seen),
					left.AMS_ID = ''						=>	right.dt_first_seen,
					/*otherwise*/										left.dt_first_seen),
				self.dt_last_seen := map(
					left.AMS_ID = right.AMS_ID	=>	max(left.dt_last_seen,right.dt_last_seen),
					left.AMS_ID = ''						=>	right.dt_last_seen,
					/*otherwise*/										left.dt_last_seen),
				self.dt_vendor_first_reported := left.dt_vendor_first_reported,
				self.dt_vendor_last_reported := left.dt_vendor_last_reported,
				self.record_type := left.record_type;
				self.rawdemographicsfields := left.rawdemographicsfields,
				self.rawaddressfields := right.rawaddressfields,
				self.clean_name := left.clean_name,
				self.clean_phones := right.clean_phones,
				self := []),
			full outer);

  // Distribute needed files for quicker processing
	workingUpdates_dist := DISTRIBUTE(workingUpdates, HASH(AMS_ID));
	inMainBase_dist := DISTRIBUTE(inMainBase, HASH(AMS_ID));

	// Make the input unique for ams_id, to help determine what's historical and what's not.
	unique_update := DEDUP(SORT(workingUpdates_dist, ams_id, LOCAL), ams_id, LOCAL);

	// Determine the records that are current, because the vendor is no longer sending any updates related
	// to that particular ams_id.
  workingCurrentMainBase := JOIN(inMainBase_dist, unique_update,
	                               LEFT.ams_id = RIGHT.ams_id,
																 TRANSFORM(Layouts.Base.Main,
																	 SELF.record_type := 'C';
																	 SELF.AMSID_TYPE_DESC := '';
																	 SELF.AMSID_SUBTYPE_DESC := '';
																	 SELF.SRC_CD_DESC := '';
																	 SELF.SECTOR_CD_DESC := '';
																	 SELF.ACADEMIC_FLAG_DESC := '';
																	 SELF.STATUS_CD_DESC := '';
																	 SELF.GEN_CD_DESC := '';
																	 SELF.BIRTH_CNTRY_DESC := '';
																	 SELF.OPT_OUT_FLAG_DESC := '';
																	 SELF.KAISER_PROV_FLAG_DESC := '';
																	 SELF.STATUS_DESC := '';
																	 SELF.PRESUMED_DEAD_FLAG_DESC := '';
																	 SELF.CONTACT_FLAG_DESC := '';
																	 SELF.TOP_CD_DESC := '';
																	 SELF.PE_CD_DESC := '';
																	 SELF.MPA_CD_DESC := '';
																	 SELF.SOLO_DESC := '';
																	 SELF.GROUP_AFFILIATED_DESC := '';
																	 SELF.HOSPITAL_AFFILIATED_DESC := '';
																	 SELF.ADMINISTRATOR_DESC := '';
																	 SELF.RESEARCH_DESC := '';
																	 SELF.CLINICAL_TRIALS_DESC := '';
																	 SELF.PHONE_FLAG_DESC := '';
																	 SELF.EMAIL_FLAG_DESC := '';
																	 SELF.FAX_FLAG_DESC := '';
																	 SELF.URL_FLAG_DESC := '';
																	 SELF := LEFT),
																 LEFT ONLY,
																 LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that ams_id.
	workingHistoricalMainBase := JOIN(inMainBase_dist, unique_update,
	                                  LEFT.ams_id = RIGHT.ams_id,
																	  TRANSFORM(Layouts.Base.Main,
																			SELF.record_type := 'H';
																	    SELF.AMSID_TYPE_DESC := '';
																	    SELF.AMSID_SUBTYPE_DESC := '';
																	    SELF.SRC_CD_DESC := '';
																	    SELF.SECTOR_CD_DESC := '';
																	    SELF.ACADEMIC_FLAG_DESC := '';
																	    SELF.STATUS_CD_DESC := '';
																	    SELF.GEN_CD_DESC := '';
																	    SELF.BIRTH_CNTRY_DESC := '';
																	    SELF.OPT_OUT_FLAG_DESC := '';
																	    SELF.KAISER_PROV_FLAG_DESC := '';
																	    SELF.STATUS_DESC := '';
																	    SELF.PRESUMED_DEAD_FLAG_DESC := '';
																	    SELF.CONTACT_FLAG_DESC := '';
																	    SELF.TOP_CD_DESC := '';
																	    SELF.PE_CD_DESC := '';
																	    SELF.MPA_CD_DESC := '';
																	    SELF.SOLO_DESC := '';
																	    SELF.GROUP_AFFILIATED_DESC := '';
																	    SELF.HOSPITAL_AFFILIATED_DESC := '';
																	    SELF.ADMINISTRATOR_DESC := '';
																	    SELF.RESEARCH_DESC := '';
																	    SELF.CLINICAL_TRIALS_DESC := '';
																	    SELF.PHONE_FLAG_DESC := '';
																	    SELF.EMAIL_FLAG_DESC := '';
																	    SELF.FAX_FLAG_DESC := '';
																	    SELF.URL_FLAG_DESC := '';
																			SELF := LEFT),
																		LOCAL);

	// Join base and update main to determine what's new.  Apply AID logic to everything.
	combinedMain := Standardize_Addr(workingCurrentMainBase + workingHistoricalMainBase + workingUpdates);
	// Add DID and BDID
	combinedMainAID := Append_IDs.fAll(combinedMain);
	combinedMain_dist := DISTRIBUTE(combinedMainAID, HASH(AMS_ID));
	combinedMain_sort := SORT(combinedMain_dist,
                            (UNSIGNED)AMS_ID, did, rawaddressfields.indy_id, -rawaddressfields.gold_record_flag,
														   (UNSIGNED)rawaddressfields.bob_rank, -(UNSIGNED)rawaddressfields.bob_value,
															 record_type, -dt_last_seen,RECORD,
				                    LOCAL);
	
	Layouts.Base.Main rollupMain(Layouts.Base.Main L, Layouts.Base.Main R) := TRANSFORM
    SELF.dt_first_seen := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen),
		                                      ut.EarliestDate(L.dt_last_seen, R.dt_last_seen));
    SELF.dt_last_seen := MAX(L.dt_last_seen, R.dt_last_seen);
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := MAX(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.rawdemographicsfields := L.rawdemographicsfields;
		SELF.rawaddressfields.update_date :=
		  (STRING)MAX((UNSIGNED)L.rawaddressfields.update_date, (UNSIGNED)R.rawaddressfields.update_date);
		SELF.clean_name := L.clean_name,
		SELF.clean_company_address := L.clean_company_address;
		SELF.clean_phones := L.clean_phones;
		self.source_rec_id	:= if(l.source_rec_id = 0, r.source_rec_id, l.source_rec_id);																						 
	  SELF := L;
	END;
	
	baseMain := ROLLUP(combinedMain_sort,
	                   rollupMain(LEFT, RIGHT),
										 AMS_ID, RECORD,
											  EXCEPT record_type, dt_first_seen, dt_last_seen, dt_vendor_first_reported,
												dt_vendor_last_reported, rawdemographicsfields.ams_seq,
												rawdemographicsfields.ams_batch, rawdemographicsfields.add_date,
												rawdemographicsfields.delete_date, rawaddressfields.ams_seq,
												rawaddressfields.ams_batch, rawaddressfields.add_start_date,
												rawaddressfields.add_date, rawaddressfields.delete_date,
												rawaddressfields.update_date,source_rec_id,
										 LOCAL);

	// Finally, join to the codes file to expand the code descriptions.
	addCode(inds,outds,incodename,incodekey,incodevalue) := macro
		outds :=
			join(inds,inCodeUpdate,
				right.code_name = incodename and
				left.incodekey = right.code_cd,
				transform(Layouts.Base.Main,
					self.incodevalue := right.code_desc,
					self := left,
					self := []),
				left outer,
				lookup);
	endmacro;
	addSubCode(inds,outds,incodename,incodekey,insubcodekey,incodevalue) := macro
		outds :=
			join(inds,inCodeUpdate,
				right.code_name = incodename and
				left.incodekey = right.code_cd and
				left.insubcodekey = right.subcode_cd,
				transform(Layouts.Base.Main,
					self.incodevalue := right.code_desc,
					self := left,
					self := []),
				left outer,
				lookup);
	endmacro;
	addCode(baseMain,addCode01,'AMSID_TYPE',amsid_type,amsid_type_desc);
	addSubCode(addCode01,addCode02,'AMSID_SUBTYPE',amsid_type,amsid_subtype,amsid_subtype_desc);
	// There are 2 src_cd fields, one in the demographics and one in the address info.  Going to just
	// show the demographics one for now, since all the other codes deal with demographics.
	addCode(addCode02,addCode03,'SRC_CD',rawdemographicsfields.src_cd,src_cd_desc);
	addCode(addCode03,addCode04,'SECTOR_CD',rawdemographicsfields.sector_cd,sector_cd_desc);
	addCode(addCode04,addCode05,'ACADEMIC_FLAG',rawdemographicsfields.academic_flag,academic_flag_desc);
	addCode(addCode05,addCode06,'STATUS_CD',rawdemographicsfields.status_cd,status_cd_desc);
	addCode(addCode06,addCode07,'GEN_CD',rawdemographicsfields.gen_cd,gen_cd_desc);
	addCode(addCode07,addCode08,'COUNTRY_CD',rawdemographicsfields.birth_cntry,birth_cntry_desc);
	addCode(addCode08,addCode09,'OPT_OUT_FLAG',rawdemographicsfields.opt_out_flag,opt_out_flag_desc);
	addCode(addCode09,addCode10,'KAISER_PROV_FLAG',rawdemographicsfields.kaiser_prov_flag,kaiser_prov_flag_desc);
	addCode(addCode10,addCode11,'PROVIDER_STATUS_CD',rawdemographicsfields.status,status_desc);
	addCode(addCode11,addCode12,'PRESUMED_DEAD_FLAG',rawdemographicsfields.presumed_dead_flag,presumed_dead_flag_desc);
	addCode(addCode12,addCode13,'CONTACT_FLAG',rawdemographicsfields.contact_flag,contact_flag_desc);
	addCode(addCode13,addCode14,'TOP_CD',rawdemographicsfields.top_cd,top_cd_desc);
	addCode(addCode14,addCode15,'PE_CD',rawdemographicsfields.pe_cd,pe_cd_desc);
	addCode(addCode15,addCode16,'MPA_CD',rawdemographicsfields.mpa_cd,mpa_cd_desc);
	addCode(addCode16,addCode17,'SOLO',rawdemographicsfields.solo,solo_desc);
	addCode(addCode17,addCode18,'GROUP_FLAG',rawdemographicsfields.group_affiliated,group_affiliated_desc);
	addCode(addCode18,addCode19,'HOSPITAL_AFFILIATED',rawdemographicsfields.hospital_affiliated,hospital_affiliated_desc);
	addCode(addCode19,addCode20,'ADMINISTRATOR',rawdemographicsfields.administrator,administrator_desc);
	addCode(addCode20,addCode21,'RESEARCH',rawdemographicsfields.research,research_desc);
	addCode(addCode21,addCode22,'CLINICAL_TRIALS',rawdemographicsfields.clinical_trials,clinical_trials_desc);
	addCode(addCode22,addCode23,'PHONE_FLAG',rawdemographicsfields.phone_flag,phone_flag_desc);
	addCode(addCode23,addCode24,'EMAIL_FLAG',rawdemographicsfields.email_flag,email_flag_desc);
	addCode(addCode24,addCode25,'FAX_FLAG',rawdemographicsfields.fax_flag,fax_flag_desc);
	addCode(addCode25,addCode26,'URL_FLAG',rawdemographicsfields.url_flag,url_flag_desc);
	
	ut.MAC_Append_Rcid (addCode26,source_rec_id,addSourceRid);
	
	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.Main.New,addSourceRid,Build_Base_File);

	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping AMS.Build_Base_Main atribute')
	);
	
end;
