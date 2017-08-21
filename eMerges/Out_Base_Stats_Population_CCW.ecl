import STRATA;

export Out_Base_Stats_Population_CCW(string version_date) := function
	rPopulationStats_eMerges__file_ccw_base
	 :=
	  record
		CountGroup                                     := count(group);
		process_date_CountNonBlank                     := sum(group,if(eMerges.file_ccw_base.process_date<>'',1,0));
		date_first_seen_CountNonBlank                  := sum(group,if(eMerges.file_ccw_base.date_first_seen<>'',1,0));
		date_last_seen_CountNonBlank                   := sum(group,if(eMerges.file_ccw_base.date_last_seen<>'',1,0));
		unique_id_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.unique_id<>'',1,0));
		score_CountNonBlank                            := sum(group,if(eMerges.file_ccw_base.score<>'',1,0));
		best_ssn_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.best_ssn<>'',1,0));
		did_out_CountNonBlank                          := sum(group,if(eMerges.file_ccw_base.did_out<>'',1,0));
		Source_CountNonBlank                           := sum(group,if(eMerges.file_ccw_base.Source<>'',1,0));
		file_id_CountNonBlank                          := sum(group,if(eMerges.file_ccw_base.file_id<>'',1,0));
		vendor_id_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.vendor_id<>'',1,0));
		eMerges.file_ccw_base.source_state;
		eMerges.file_ccw_base.source_code;
		file_acquired_date_CountNonBlank               := sum(group,if(eMerges.file_ccw_base.file_acquired_date<>'',1,0));
		use_CountNonBlank                              := sum(group,if(eMerges.file_ccw_base._use<>'',1,0));
		title_in_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.title_in<>'',1,0));
		lname_in_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.lname_in<>'',1,0));
		fname_in_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.fname_in<>'',1,0));
		mname_in_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.mname_in<>'',1,0));
		maiden_prior_CountNonBlank                     := sum(group,if(eMerges.file_ccw_base.maiden_prior<>'',1,0));
		name_suffix_in_CountNonBlank                   := sum(group,if(eMerges.file_ccw_base.name_suffix_in<>'',1,0));
		votefiller_CountNonBlank                       := sum(group,if(eMerges.file_ccw_base.votefiller<>'',1,0));
		source_voterId_CountNonBlank                   := sum(group,if(eMerges.file_ccw_base.source_voterId<>'',1,0));
		dob_CountNonBlank                              := sum(group,if(eMerges.file_ccw_base.dob<>'',1,0));
		ageCat_CountNonBlank                           := sum(group,if(eMerges.file_ccw_base.ageCat<>'',1,0));
		headHousehold_CountNonBlank                    := sum(group,if(eMerges.file_ccw_base.headHousehold<>'',1,0));
		place_of_birth_CountNonBlank                   := sum(group,if(eMerges.file_ccw_base.place_of_birth<>'',1,0));
		occupation_CountNonBlank                       := sum(group,if(eMerges.file_ccw_base.occupation<>'',1,0));
		maiden_name_CountNonBlank                      := sum(group,if(eMerges.file_ccw_base.maiden_name<>'',1,0));
		motorVoterId_CountNonBlank                     := sum(group,if(eMerges.file_ccw_base.motorVoterId<>'',1,0));
		regSource_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.regSource<>'',1,0));
		regDate_CountNonBlank                          := sum(group,if(eMerges.file_ccw_base.regDate<>'',1,0));
		race_CountNonBlank                             := sum(group,if(eMerges.file_ccw_base.race<>'',1,0));
		gender_CountNonBlank                           := sum(group,if(eMerges.file_ccw_base.gender<>'',1,0));
		poliparty_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.poliparty<>'',1,0));
		phone_CountNonBlank                            := sum(group,if(eMerges.file_ccw_base.phone<>'',1,0));
		work_phone_CountNonBlank                       := sum(group,if(eMerges.file_ccw_base.work_phone<>'',1,0));
		other_phone_CountNonBlank                      := sum(group,if(eMerges.file_ccw_base.other_phone<>'',1,0));
		active_status_CountNonBlank                    := sum(group,if(eMerges.file_ccw_base.active_status<>'',1,0));
		votefiller2_CountNonBlank                      := sum(group,if(eMerges.file_ccw_base.votefiller2<>'',1,0));
		active_other_CountNonBlank                     := sum(group,if(eMerges.file_ccw_base.active_other<>'',1,0));
		voterStatus_CountNonBlank                      := sum(group,if(eMerges.file_ccw_base.voterStatus<>'',1,0));
		resAddr1_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.resAddr1<>'',1,0));
		resAddr2_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.resAddr2<>'',1,0));
		res_city_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.res_city<>'',1,0));
		res_state_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.res_state<>'',1,0));
		res_zip_CountNonBlank                          := sum(group,if(eMerges.file_ccw_base.res_zip<>'',1,0));
		res_county_CountNonBlank                       := sum(group,if(eMerges.file_ccw_base.res_county<>'',1,0));
		mail_addr1_CountNonBlank                       := sum(group,if(eMerges.file_ccw_base.mail_addr1<>'',1,0));
		mail_addr2_CountNonBlank                       := sum(group,if(eMerges.file_ccw_base.mail_addr2<>'',1,0));
		mail_city_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.mail_city<>'',1,0));
		mail_state_CountNonBlank                       := sum(group,if(eMerges.file_ccw_base.mail_state<>'',1,0));
		mail_zip_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.mail_zip<>'',1,0));
		mail_county_CountNonBlank                      := sum(group,if(eMerges.file_ccw_base.mail_county<>'',1,0));
		CCWPermNum_CountNonBlank                       := sum(group,if(eMerges.file_ccw_base.CCWPermNum<>'',1,0));
		CCWWeaponType_CountNonBlank                    := sum(group,if(eMerges.file_ccw_base.CCWWeaponType<>'',1,0));
		CCWRegDate_CountNonBlank                       := sum(group,if(eMerges.file_ccw_base.CCWRegDate<>'',1,0));
		CCWExpDate_CountNonBlank                       := sum(group,if(eMerges.file_ccw_base.CCWExpDate<>'',1,0));
		CCWPermType_CountNonBlank                      := sum(group,if(eMerges.file_ccw_base.CCWPermType<>'',1,0));
		CCWFill1_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.CCWFill1<>'',1,0));
		CCWFill2_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.CCWFill2<>'',1,0));
		CCWFill3_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.CCWFill3<>'',1,0));
		CCWFill4_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.CCWFill4<>'',1,0));
		MiscFill1_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.MiscFill1<>'',1,0));
		MiscFIll2_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.MiscFIll2<>'',1,0));
		MiscFill3_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.MiscFill3<>'',1,0));
		MiscFill4_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.MiscFill4<>'',1,0));
		MiscFill5_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.MiscFill5<>'',1,0));
		title_CountNonBlank                            := sum(group,if(eMerges.file_ccw_base.title<>'',1,0));
		fname_CountNonBlank                            := sum(group,if(eMerges.file_ccw_base.fname<>'',1,0));
		mname_CountNonBlank                            := sum(group,if(eMerges.file_ccw_base.mname<>'',1,0));
		lname_CountNonBlank                            := sum(group,if(eMerges.file_ccw_base.lname<>'',1,0));
		name_suffix_CountNonBlank                      := sum(group,if(eMerges.file_ccw_base.name_suffix<>'',1,0));
		score_on_input_CountNonBlank                   := sum(group,if(eMerges.file_ccw_base.score_on_input<>'',1,0));
		prim_range_CountNonBlank                       := sum(group,if(eMerges.file_ccw_base.prim_range<>'',1,0));
		predir_CountNonBlank                           := sum(group,if(eMerges.file_ccw_base.predir<>'',1,0));
		prim_name_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.prim_name<>'',1,0));
		suffix_CountNonBlank                           := sum(group,if(eMerges.file_ccw_base.suffix<>'',1,0));
		postdir_CountNonBlank                          := sum(group,if(eMerges.file_ccw_base.postdir<>'',1,0));
		unit_desig_CountNonBlank                       := sum(group,if(eMerges.file_ccw_base.unit_desig<>'',1,0));
		sec_range_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.sec_range<>'',1,0));
		p_city_name_CountNonBlank                      := sum(group,if(eMerges.file_ccw_base.p_city_name<>'',1,0));
		city_name_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.city_name<>'',1,0));
		st_CountNonBlank                               := sum(group,if(eMerges.file_ccw_base.st<>'',1,0));
		zip_CountNonBlank                              := sum(group,if(eMerges.file_ccw_base.zip<>'',1,0));
		zip4_CountNonBlank                             := sum(group,if(eMerges.file_ccw_base.zip4<>'',1,0));
		cart_CountNonBlank                             := sum(group,if(eMerges.file_ccw_base.cart<>'',1,0));
		cr_sort_sz_CountNonBlank                       := sum(group,if(eMerges.file_ccw_base.cr_sort_sz<>'',1,0));
		lot_CountNonBlank                              := sum(group,if(eMerges.file_ccw_base.lot<>'',1,0));
		lot_order_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.lot_order<>'',1,0));
		dpbc_CountNonBlank                             := sum(group,if(eMerges.file_ccw_base.dpbc<>'',1,0));
		chk_digit_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.chk_digit<>'',1,0));
		record_type_CountNonBlank                      := sum(group,if(eMerges.file_ccw_base.record_type<>'',1,0));
		ace_fips_st_CountNonBlank                      := sum(group,if(eMerges.file_ccw_base.ace_fips_st<>'',1,0));
		county_CountNonBlank                           := sum(group,if(eMerges.file_ccw_base.county<>'',1,0));
		county_name_CountNonBlank                      := sum(group,if(eMerges.file_ccw_base.county_name<>'',1,0));
		geo_lat_CountNonBlank                          := sum(group,if(eMerges.file_ccw_base.geo_lat<>'',1,0));
		geo_long_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.geo_long<>'',1,0));
		msa_CountNonBlank                              := sum(group,if(eMerges.file_ccw_base.msa<>'',1,0));
		geo_blk_CountNonBlank                          := sum(group,if(eMerges.file_ccw_base.geo_blk<>'',1,0));
		geo_match_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.geo_match<>'',1,0));
		err_stat_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.err_stat<>'',1,0));
		mail_prim_range_CountNonBlank                  := sum(group,if(eMerges.file_ccw_base.mail_prim_range<>'',1,0));
		mail_predir_CountNonBlank                      := sum(group,if(eMerges.file_ccw_base.mail_predir<>'',1,0));
		mail_prim_name_CountNonBlank                   := sum(group,if(eMerges.file_ccw_base.mail_prim_name<>'',1,0));
		mail_addr_suffix_CountNonBlank                 := sum(group,if(eMerges.file_ccw_base.mail_addr_suffix<>'',1,0));
		mail_postdir_CountNonBlank                     := sum(group,if(eMerges.file_ccw_base.mail_postdir<>'',1,0));
		mail_unit_desig_CountNonBlank                  := sum(group,if(eMerges.file_ccw_base.mail_unit_desig<>'',1,0));
		mail_sec_range_CountNonBlank                   := sum(group,if(eMerges.file_ccw_base.mail_sec_range<>'',1,0));
		mail_p_city_name_CountNonBlank                 := sum(group,if(eMerges.file_ccw_base.mail_p_city_name<>'',1,0));
		mail_v_city_name_CountNonBlank                 := sum(group,if(eMerges.file_ccw_base.mail_v_city_name<>'',1,0));
		mail_st_CountNonBlank                          := sum(group,if(eMerges.file_ccw_base.mail_st<>'',1,0));
		mail_ace_zip_CountNonBlank                     := sum(group,if(eMerges.file_ccw_base.mail_ace_zip<>'',1,0));
		mail_zip4_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.mail_zip4<>'',1,0));
		mail_cart_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.mail_cart<>'',1,0));
		mail_cr_sort_sz_CountNonBlank                  := sum(group,if(eMerges.file_ccw_base.mail_cr_sort_sz<>'',1,0));
		mail_lot_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.mail_lot<>'',1,0));
		mail_lot_order_CountNonBlank                   := sum(group,if(eMerges.file_ccw_base.mail_lot_order<>'',1,0));
		mail_dpbc_CountNonBlank                        := sum(group,if(eMerges.file_ccw_base.mail_dpbc<>'',1,0));
		mail_chk_digit_CountNonBlank                   := sum(group,if(eMerges.file_ccw_base.mail_chk_digit<>'',1,0));
		mail_record_type_CountNonBlank                 := sum(group,if(eMerges.file_ccw_base.mail_record_type<>'',1,0));
		mail_ace_fips_st_CountNonBlank                 := sum(group,if(eMerges.file_ccw_base.mail_ace_fips_st<>'',1,0));
		mail_fipscounty_CountNonBlank                  := sum(group,if(eMerges.file_ccw_base.mail_fipscounty<>'',1,0));
		mail_geo_lat_CountNonBlank                     := sum(group,if(eMerges.file_ccw_base.mail_geo_lat<>'',1,0));
		mail_geo_long_CountNonBlank                    := sum(group,if(eMerges.file_ccw_base.mail_geo_long<>'',1,0));
		mail_msa_CountNonBlank                         := sum(group,if(eMerges.file_ccw_base.mail_msa<>'',1,0));
		mail_geo_blk_CountNonBlank                     := sum(group,if(eMerges.file_ccw_base.mail_geo_blk<>'',1,0));
		mail_geo_match_CountNonBlank                   := sum(group,if(eMerges.file_ccw_base.mail_geo_match<>'',1,0));
		mail_err_stat_CountNonBlank                    := sum(group,if(eMerges.file_ccw_base.mail_err_stat<>'',1,0));
	  end;

	dPopulationStats_eMerges__file_ccw_base := table(eMerges.file_ccw_base,
													 rPopulationStats_eMerges__file_ccw_base,
													 source_code,source_state,
													 few
													);

	STRATA.createXMLStats(dPopulationStats_eMerges__file_ccw_base,
						  'eMerges',
						  'ccw',
						  version_date,
						  '',
						  resultsOut,
						  'view',
						  'population'
						 );
		 
	ccw_base_stats := resultsOut;
	return ccw_base_stats;
end;