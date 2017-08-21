import DriversV2, STRATA;

export Out_Restricted_Base_Stats_Population(string filedate) :=
function

	rPopulationStats_drivers__File_DL_Restricted := record
		CountGroup                            := count(group);
		dl_seq_CountNonZero                   := sum(group,if(DriversV2.File_DL_Restricted.dl_seq <> 0, 1, 0));
		did_CountNonZero                      := sum(group,if(DriversV2.File_DL_Restricted.did <> 0, 1, 0));
		Preglb_did_CountNonZero               := sum(group,if(DriversV2.File_DL_Restricted.Preglb_did <> 0, 1, 0));
		dt_first_seen_CountNonZero            := sum(group,if(DriversV2.File_DL_Restricted.dt_first_seen <> 0, 1, 0));
		dt_last_seen_CountNonZero             := sum(group,if(DriversV2.File_DL_Restricted.dt_last_seen <> 0, 1, 0));
		dt_vendor_first_reported_CountNonZero := sum(group,if(DriversV2.File_DL_Restricted.dt_vendor_first_reported <> 0, 1, 0));
		dt_vendor_last_reported_CountNonZero  := sum(group,if(DriversV2.File_DL_Restricted.dt_vendor_last_reported <> 0, 1, 0));
		DLCP_Key_CountNonBlank                := sum(group,if(DriversV2.File_DL_Restricted.DLCP_Key <> '', 1, 0));  
		DriversV2.File_DL_Restricted.orig_state;
		DriversV2.File_DL_Restricted.source_code;
		history_CountNonBlank                 := sum(group,if(DriversV2.File_DL_Restricted.history <> '', 1, 0));
		name_CountNonBlank                    := sum(group,if(DriversV2.File_DL_Restricted.name <> '', 1, 0));
		addr_type_CountNonBlank               := sum(group,if(DriversV2.File_DL_Restricted.addr_type <> '', 1, 0));
		addr1_CountNonBlank                   := sum(group,if(DriversV2.File_DL_Restricted.addr1 <> '', 1, 0));
		city_CountNonBlank                    := sum(group,if(DriversV2.File_DL_Restricted.city <> '', 1, 0));
		state_CountNonBlank                   := sum(group,if(DriversV2.File_DL_Restricted.state <> '', 1, 0));
		zip_CountNonBlank                     := sum(group,if(DriversV2.File_DL_Restricted.zip <> '', 1, 0));	
		province_CountNonBlank                := sum(group,if(DriversV2.File_DL_Restricted.province <> '', 1, 0));
		country_CountNonBlank                 := sum(group,if(DriversV2.File_DL_Restricted.country <> '', 1, 0));
		postal_code_CountNonBlank             := sum(group,if(DriversV2.File_DL_Restricted.postal_code <> '', 1, 0));	
		dob_CountNonZero                      := sum(group,if(DriversV2.File_DL_Restricted.dob <> 0, 1, 0));
		race_CountNonBlank                    := sum(group,if(DriversV2.File_DL_Restricted.race <> '', 1, 0));
		sex_flag_CountNonBlank                := sum(group,if(DriversV2.File_DL_Restricted.sex_flag <> '', 1, 0));	
		license_class_CountNonBlank           := sum(group,if(DriversV2.File_DL_Restricted.license_class <> '', 1, 0));	
		license_type_CountNonBlank            := sum(group,if(DriversV2.File_DL_Restricted.license_type <> '', 1, 0));
		attention_flag_CountNonBlank          := sum(group,if(DriversV2.File_DL_Restricted.attention_flag <> '', 1, 0));
		dod_CountNonBlank                     := sum(group,if(DriversV2.File_DL_Restricted.dod <> '', 1, 0));
		restrictions_CountNonBlank            := sum(group,if(DriversV2.File_DL_Restricted.restrictions <> '', 1, 0));
		restrictions_delimited_CountNonBlank  := sum(group,if(DriversV2.File_DL_Restricted.restrictions_delimited <> '', 1, 0));
		orig_expiration_date_CountNonZero     := sum(group,if(DriversV2.File_DL_Restricted.orig_expiration_date <> 0, 1, 0));
		orig_issue_date_CountNonZero          := sum(group,if(DriversV2.File_DL_Restricted.orig_issue_date <> 0, 1, 0));
		lic_issue_date_CountNonZero           := sum(group,if(DriversV2.File_DL_Restricted.lic_issue_date <> 0, 1, 0));
		expiration_date_CountNonZero          := sum(group,if(DriversV2.File_DL_Restricted.expiration_date <> 0, 1, 0));
		active_date_CountNonZero              := sum(group,if(DriversV2.File_DL_Restricted.active_date <> 0, 1, 0));
		inactive_date_CountNonZero            := sum(group,if(DriversV2.File_DL_Restricted.inactive_date <> 0, 1, 0));
		lic_endorsement_CountNonBlank         := sum(group,if(DriversV2.File_DL_Restricted.lic_endorsement <> '', 1, 0));
		motorcycle_code_CountNonBlank         := sum(group,if(DriversV2.File_DL_Restricted.motorcycle_code <> '', 1, 0));
		dl_number_CountNonBlank               := sum(group,if(DriversV2.File_DL_Restricted.dl_number <> '', 1, 0));
		ssn_CountNonBlank                     := sum(group,if(DriversV2.File_DL_Restricted.ssn <> '', 1, 0));
		ssn_safe_CountNonBlank                := sum(group,if(DriversV2.File_DL_Restricted.ssn_safe <> '', 1, 0));
		age_CountNonBlank                     := sum(group,if(DriversV2.File_DL_Restricted.age <> '', 1, 0));
		privacy_flag_CountNonBlank            := sum(group,if(DriversV2.File_DL_Restricted.privacy_flag <> '', 1, 0));
		driver_edu_code_CountNonBlank         := sum(group,if(DriversV2.File_DL_Restricted.driver_edu_code <> '', 1, 0));
		dup_lic_count_CountNonBlank           := sum(group,if(DriversV2.File_DL_Restricted.dup_lic_count <> '', 1, 0));
		rcd_stat_flag_CountNonBlank           := sum(group,if(DriversV2.File_DL_Restricted.rcd_stat_flag <> '', 1, 0));
		height_CountNonBlank                  := sum(group,if(DriversV2.File_DL_Restricted.height <> '', 1, 0));
		hair_color_CountNonBlank              := sum(group,if(DriversV2.File_DL_Restricted.hair_color <> '', 1, 0));
		eye_color_CountNonBlank               := sum(group,if(DriversV2.File_DL_Restricted.eye_color <> '', 1, 0));
		weight_CountNonBlank                  := sum(group,if(DriversV2.File_DL_Restricted.weight <> '', 1, 0));
		oos_previous_dl_number_CountNonBlank  := sum(group,if(DriversV2.File_DL_Restricted.oos_previous_dl_number <> '', 1, 0));
		oos_previous_st_CountNonBlank         := sum(group,if(DriversV2.File_DL_Restricted.oos_previous_st <> '', 1, 0));
		title_CountNonBlank                   := sum(group,if(DriversV2.File_DL_Restricted.title <> '', 1, 0));
		fname_CountNonBlank                   := sum(group,if(DriversV2.File_DL_Restricted.fname <> '', 1, 0));
		mname_CountNonBlank                   := sum(group,if(DriversV2.File_DL_Restricted.mname <> '', 1, 0));
		lname_CountNonBlank                   := sum(group,if(DriversV2.File_DL_Restricted.lname <> '', 1, 0));
		name_suffix_CountNonBlank             := sum(group,if(DriversV2.File_DL_Restricted.name_suffix <> '', 1, 0));
		cleaning_score_CountNonBlank          := sum(group,if(DriversV2.File_DL_Restricted.cleaning_score <> '', 1, 0));
		addr_fix_flag_CountNonBlank           := sum(group,if(DriversV2.File_DL_Restricted.addr_fix_flag <> '', 1, 0));
		prim_range_CountNonBlank              := sum(group,if(DriversV2.File_DL_Restricted.prim_range <> '', 1, 0));
		predir_CountNonBlank                  := sum(group,if(DriversV2.File_DL_Restricted.predir <> '', 1, 0));
		prim_name_CountNonBlank               := sum(group,if(DriversV2.File_DL_Restricted.prim_name <> '', 1, 0));
		suffix_CountNonBlank                  := sum(group,if(DriversV2.File_DL_Restricted.suffix <> '', 1, 0));
		postdir_CountNonBlank                 := sum(group,if(DriversV2.File_DL_Restricted.postdir <> '', 1, 0));
		unit_desig_CountNonBlank              := sum(group,if(DriversV2.File_DL_Restricted.unit_desig <> '', 1, 0));
		sec_range_CountNonBlank               := sum(group,if(DriversV2.File_DL_Restricted.sec_range <> '', 1, 0));
		p_city_name_CountNonBlank             := sum(group,if(DriversV2.File_DL_Restricted.p_city_name <> '', 1, 0));
		v_city_name_CountNonBlank             := sum(group,if(DriversV2.File_DL_Restricted.v_city_name <> '', 1, 0));
		st_CountNonBlank                      := sum(group,if(DriversV2.File_DL_Restricted.st <> '', 1, 0));
		zip5_CountNonBlank                    := sum(group,if(DriversV2.File_DL_Restricted.zip5 <> '', 1, 0));
		zip4_CountNonBlank                    := sum(group,if(DriversV2.File_DL_Restricted.zip4 <> '', 1, 0));
		cart_CountNonBlank                    := sum(group,if(DriversV2.File_DL_Restricted.cart <> '', 1, 0));
		cr_sort_sz_CountNonBlank              := sum(group,if(DriversV2.File_DL_Restricted.cr_sort_sz <> '', 1, 0));
		lot_CountNonBlank                     := sum(group,if(DriversV2.File_DL_Restricted.lot <> '', 1, 0));
		lot_order_CountNonBlank               := sum(group,if(DriversV2.File_DL_Restricted.lot_order <> '', 1, 0));
		dpbc_CountNonBlank                    := sum(group,if(DriversV2.File_DL_Restricted.dpbc <> '', 1, 0));
		chk_digit_CountNonBlank               := sum(group,if(DriversV2.File_DL_Restricted.chk_digit <> '', 1, 0));
		rec_type_CountNonBlank                := sum(group,if(DriversV2.File_DL_Restricted.rec_type <> '', 1, 0));
		ace_fips_st_CountNonBlank             := sum(group,if(DriversV2.File_DL_Restricted.ace_fips_st <> '', 1, 0));
		county_CountNonBlank                  := sum(group,if(DriversV2.File_DL_Restricted.county <> '', 1, 0));
		geo_lat_CountNonBlank                 := sum(group,if(DriversV2.File_DL_Restricted.geo_lat <> '', 1, 0));
		geo_long_CountNonBlank                := sum(group,if(DriversV2.File_DL_Restricted.geo_long <> '', 1, 0));
		msa_CountNonBlank                     := sum(group,if(DriversV2.File_DL_Restricted.msa <> '', 1, 0));
		geo_blk_CountNonBlank                 := sum(group,if(DriversV2.File_DL_Restricted.geo_blk <> '', 1, 0));
		geo_match_CountNonBlank               := sum(group,if(DriversV2.File_DL_Restricted.geo_match <> '', 1, 0));
		err_stat_CountNonBlank                := sum(group,if(DriversV2.File_DL_Restricted.err_stat <> '', 1, 0));
		status_CountNonBlank                  := sum(group,if(DriversV2.File_DL_Restricted.status <> '', 1, 0));
		issuance_CountNonBlank                := sum(group,if(DriversV2.File_DL_Restricted.issuance <> '', 1, 0));
		address_change_CountNonBlank          := sum(group,if(DriversV2.File_DL_Restricted.address_change <> '', 1, 0));
		name_change_CountNonBlank             := sum(group,if(DriversV2.File_DL_Restricted.name_change <> '', 1, 0));
		dob_change_CountNonBlank              := sum(group,if(DriversV2.File_DL_Restricted.dob_change <> '', 1, 0));
		sex_change_CountNonBlank              := sum(group,if(DriversV2.File_DL_Restricted.sex_change <> '', 1, 0));
		old_dl_number_CountNonBlank           := sum(group,if(DriversV2.File_DL_Restricted.old_dl_number <> '', 1, 0));
		dl_key_number_CountNonBlank           := sum(group,if(DriversV2.File_DL_Restricted.dl_key_number <> '', 1, 0));	
		CDL_status_CountNonBlank              := sum(group,if(DriversV2.File_DL_Restricted.CDL_status <> '', 1, 0));	
	end;

	dPopulationStats_drivers__File_DL_Restricted := table(DriversV2.File_DL_Restricted,
																												rPopulationStats_drivers__File_DL_Restricted,
																												source_code, orig_state,
																												few);

	STRATA.createXMLStats(dPopulationStats_drivers__File_DL_Restricted,
												'Drivers LicensesV2 Restricted',
												'data',
												filedate,
												'',
												resultsOut,
												'view',
												'population');
					 
 return resultsOut;
end;