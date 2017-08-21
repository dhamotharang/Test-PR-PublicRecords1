import STRATA;

export Out_Base_Stats_Population(string filedate) :=
function

	rPopulationStats_drivers__File_DL
	 :=
		record
		CountGroup                                           := count(group);
		dl_seq_CountNonZero                                  := sum(group,if(driversV2.File_DL.dl_seq<>0,1,0));
		did_CountNonZero                                     := sum(group,if(driversV2.File_DL.did<>0,1,0));
		Preglb_did_CountNonZero                              := sum(group,if(driversV2.File_DL.Preglb_did<>0,1,0));
		dt_first_seen_CountNonZero                           := sum(group,if(driversV2.File_DL.dt_first_seen<>0,1,0));
		dt_last_seen_CountNonZero                            := sum(group,if(driversV2.File_DL.dt_last_seen<>0,1,0));
		dt_vendor_first_reported_CountNonZero                := sum(group,if(driversV2.File_DL.dt_vendor_first_reported<>0,1,0));
		dt_vendor_last_reported_CountNonZero                 := sum(group,if(driversV2.File_DL.dt_vendor_last_reported<>0,1,0));
		DLCP_Key_CountNonBlank                               := sum(group,if(driversV2.File_DL.DLCP_Key<>'',1,0));  
		driversV2.File_DL.orig_state;
		driversV2.File_DL.source_code;
		history_CountNonBlank                                := sum(group,if(driversV2.File_DL.history<>'',1,0));
		name_CountNonBlank                                   := sum(group,if(driversV2.File_DL.name<>'',1,0));
		addr_type_CountNonBlank                              := sum(group,if(driversV2.File_DL.addr_type<>'',1,0));
		addr1_CountNonBlank                                  := sum(group,if(driversV2.File_DL.addr1<>'',1,0));
		city_CountNonBlank                                   := sum(group,if(driversV2.File_DL.city<>'',1,0));
		state_CountNonBlank                                  := sum(group,if(driversV2.File_DL.state<>'',1,0));
		zip_CountNonBlank                                    := sum(group,if(driversV2.File_DL.zip<>'',1,0));	
		province_CountNonBlank                               := sum(group,if(driversV2.File_DL.province<>'',1,0));
		country_CountNonBlank                                := sum(group,if(driversV2.File_DL.country<>'',1,0));
		postal_code_CountNonBlank                            := sum(group,if(driversV2.File_DL.postal_code<>'',1,0));	
		dob_CountNonZero                                     := sum(group,if(driversV2.File_DL.dob<>0,1,0));
		race_CountNonBlank                                   := sum(group,if(driversV2.File_DL.race<>'',1,0));
		sex_flag_CountNonBlank                               := sum(group,if(driversV2.File_DL.sex_flag<>'',1,0));	
		license_class_CountNonBlank                          := sum(group,if(driversV2.File_DL.license_class<>'',1,0));	
		license_type_CountNonBlank                           := sum(group,if(driversV2.File_DL.license_type<>'',1,0));
		attention_flag_CountNonBlank                         := sum(group,if(driversV2.File_DL.attention_flag<>'',1,0));
		dod_CountNonBlank                                    := sum(group,if(driversV2.File_DL.dod<>'',1,0));
		restrictions_CountNonBlank                           := sum(group,if(driversV2.File_DL.restrictions<>'',1,0));
		restrictions_delimited_CountNonBlank                 := sum(group,if(driversV2.File_DL.restrictions_delimited<>'',1,0));
		orig_expiration_date_CountNonZero                    := sum(group,if(driversV2.File_DL.orig_expiration_date<>0,1,0));
		orig_issue_date_CountNonZero                         := sum(group,if(driversV2.File_DL.orig_issue_date<>0,1,0));
		lic_issue_date_CountNonZero                          := sum(group,if(driversV2.File_DL.lic_issue_date<>0,1,0));
		expiration_date_CountNonZero                         := sum(group,if(driversV2.File_DL.expiration_date<>0,1,0));
		active_date_CountNonZero                             := sum(group,if(driversV2.File_DL.active_date<>0,1,0));
		inactive_date_CountNonZero                           := sum(group,if(driversV2.File_DL.inactive_date<>0,1,0));
		lic_endorsement_CountNonBlank                        := sum(group,if(driversV2.File_DL.lic_endorsement<>'',1,0));
		motorcycle_code_CountNonBlank                        := sum(group,if(driversV2.File_DL.motorcycle_code<>'',1,0));
		dl_number_CountNonBlank                              := sum(group,if(driversV2.File_DL.dl_number<>'',1,0));
		ssn_CountNonBlank                                    := sum(group,if(driversV2.File_DL.ssn<>'',1,0));
		ssn_safe_CountNonBlank                               := sum(group,if(driversV2.File_DL.ssn_safe<>'',1,0));
		age_CountNonBlank                                    := sum(group,if(driversV2.File_DL.age<>'',1,0));
		privacy_flag_CountNonBlank                           := sum(group,if(driversV2.File_DL.privacy_flag<>'',1,0));
		driver_edu_code_CountNonBlank                        := sum(group,if(driversV2.File_DL.driver_edu_code<>'',1,0));
		dup_lic_count_CountNonBlank                          := sum(group,if(driversV2.File_DL.dup_lic_count<>'',1,0));
		rcd_stat_flag_CountNonBlank                          := sum(group,if(driversV2.File_DL.rcd_stat_flag<>'',1,0));
		height_CountNonBlank                                 := sum(group,if(driversV2.File_DL.height<>'',1,0));
		hair_color_CountNonBlank                             := sum(group,if(driversV2.File_DL.hair_color<>'',1,0));
		eye_color_CountNonBlank                              := sum(group,if(driversV2.File_DL.eye_color<>'',1,0));
		weight_CountNonBlank                                 := sum(group,if(driversV2.File_DL.weight<>'',1,0));
		oos_previous_dl_number_CountNonBlank                 := sum(group,if(driversV2.File_DL.oos_previous_dl_number<>'',1,0));
		oos_previous_st_CountNonBlank                        := sum(group,if(driversV2.File_DL.oos_previous_st<>'',1,0));
		title_CountNonBlank                                  := sum(group,if(driversV2.File_DL.title<>'',1,0));
		fname_CountNonBlank                                  := sum(group,if(driversV2.File_DL.fname<>'',1,0));
		mname_CountNonBlank                                  := sum(group,if(driversV2.File_DL.mname<>'',1,0));
		lname_CountNonBlank                                  := sum(group,if(driversV2.File_DL.lname<>'',1,0));
		name_suffix_CountNonBlank                            := sum(group,if(driversV2.File_DL.name_suffix<>'',1,0));
		cleaning_score_CountNonBlank                         := sum(group,if(driversV2.File_DL.cleaning_score<>'',1,0));
		addr_fix_flag_CountNonBlank                          := sum(group,if(driversV2.File_DL.addr_fix_flag<>'',1,0));
		prim_range_CountNonBlank                             := sum(group,if(driversV2.File_DL.prim_range<>'',1,0));
		predir_CountNonBlank                                 := sum(group,if(driversV2.File_DL.predir<>'',1,0));
		prim_name_CountNonBlank                              := sum(group,if(driversV2.File_DL.prim_name<>'',1,0));
		suffix_CountNonBlank                                 := sum(group,if(driversV2.File_DL.suffix<>'',1,0));
		postdir_CountNonBlank                                := sum(group,if(driversV2.File_DL.postdir<>'',1,0));
		unit_desig_CountNonBlank                             := sum(group,if(driversV2.File_DL.unit_desig<>'',1,0));
		sec_range_CountNonBlank                              := sum(group,if(driversV2.File_DL.sec_range<>'',1,0));
		p_city_name_CountNonBlank                            := sum(group,if(driversV2.File_DL.p_city_name<>'',1,0));
		v_city_name_CountNonBlank                            := sum(group,if(driversV2.File_DL.v_city_name<>'',1,0));
		st_CountNonBlank                                     := sum(group,if(driversV2.File_DL.st<>'',1,0));
		zip5_CountNonBlank                                   := sum(group,if(driversV2.File_DL.zip5<>'',1,0));
		zip4_CountNonBlank                                   := sum(group,if(driversV2.File_DL.zip4<>'',1,0));
		cart_CountNonBlank                                   := sum(group,if(driversV2.File_DL.cart<>'',1,0));
		cr_sort_sz_CountNonBlank                             := sum(group,if(driversV2.File_DL.cr_sort_sz<>'',1,0));
		lot_CountNonBlank                                    := sum(group,if(driversV2.File_DL.lot<>'',1,0));
		lot_order_CountNonBlank                              := sum(group,if(driversV2.File_DL.lot_order<>'',1,0));
		dpbc_CountNonBlank                                   := sum(group,if(driversV2.File_DL.dpbc<>'',1,0));
		chk_digit_CountNonBlank                              := sum(group,if(driversV2.File_DL.chk_digit<>'',1,0));
		rec_type_CountNonBlank                               := sum(group,if(driversV2.File_DL.rec_type<>'',1,0));
		ace_fips_st_CountNonBlank                            := sum(group,if(driversV2.File_DL.ace_fips_st<>'',1,0));
		county_CountNonBlank                                 := sum(group,if(driversV2.File_DL.county<>'',1,0));
		geo_lat_CountNonBlank                                := sum(group,if(driversV2.File_DL.geo_lat<>'',1,0));
		geo_long_CountNonBlank                               := sum(group,if(driversV2.File_DL.geo_long<>'',1,0));
		msa_CountNonBlank                                    := sum(group,if(driversV2.File_DL.msa<>'',1,0));
		geo_blk_CountNonBlank                                := sum(group,if(driversV2.File_DL.geo_blk<>'',1,0));
		geo_match_CountNonBlank                              := sum(group,if(driversV2.File_DL.geo_match<>'',1,0));
		err_stat_CountNonBlank                               := sum(group,if(driversV2.File_DL.err_stat<>'',1,0));
		status_CountNonBlank                                 := sum(group,if(driversV2.File_DL.status<>'',1,0));
		issuance_CountNonBlank                               := sum(group,if(driversV2.File_DL.issuance<>'',1,0));
		address_change_CountNonBlank                         := sum(group,if(driversV2.File_DL.address_change<>'',1,0));
		name_change_CountNonBlank                            := sum(group,if(driversV2.File_DL.name_change<>'',1,0));
		dob_change_CountNonBlank                             := sum(group,if(driversV2.File_DL.dob_change<>'',1,0));
		sex_change_CountNonBlank                             := sum(group,if(driversV2.File_DL.sex_change<>'',1,0));
		old_dl_number_CountNonBlank                          := sum(group,if(driversV2.File_DL.old_dl_number<>'',1,0));
		dl_key_number_CountNonBlank                          := sum(group,if(driversV2.File_DL.dl_key_number<>'',1,0));	
		CDL_status_CountNonBlank                             := sum(group,if(driversV2.File_DL.CDL_status<>'',1,0));	
	end;

	dPopulationStats_drivers__File_DL := table(DriversV2.File_DL,
												 rPopulationStats_drivers__File_DL,
												 source_code,orig_state,
												 few
													);

	STRATA.createXMLStats(dPopulationStats_drivers__File_DL,
												'Drivers LicensesV2',
							'data',
							filedate,
							'',
							resultsOut,
							'view',
							'population'
						 );
						 
	return resultsOut;
end;