export Out_Population_Stats(pOffender, pOffenses, pPunishment, pVersion, pOutReference)
 :=
  macro
	import STRATA;

	#uniquename(rPopulationStats_POffender);
	#uniquename(rPopulationStats_POffenses);
	#uniquename(rPopulationStats_PPunishment);
	#uniquename(dPopulationStats_POffender);
	#uniquename(dPopulationStats_POffenses);
	#uniquename(dPopulationStats_PPunishment);
	#uniquename(zPopulationStats_pOffender);
	#uniquename(zPopulationStats_pOffenses);
	#uniquename(zPopulationStats_pPunishment);

	
	%rPopulationStats_pOffender%
	 :=
	  record
		CountGroup                                                := count(group);
		pOffender.vendor;
		pOffender.state_of_origin;
		pOffender.source_file;
		date_first_reported_CountNonBlank                         := sum(group,if(pOffender.date_first_reported<>'',1,0));
		date_last_reported_CountNonBlank                          := sum(group,if(pOffender.date_last_reported<>'',1,0));
		offender_key_CountNonBlank                                := sum(group,if(pOffender.offender_key<>'',1,0));
		data_type_CountNonBlank                                   := sum(group,if(pOffender.data_type<>'',1,0));
		off_name_type_CountNonBlank                               := sum(group,if(pOffender.off_name_type<>'',1,0));
		off_name_CountNonBlank                                    := sum(group,if(pOffender.off_name<>'',1,0));
		orig_lname_CountNonBlank                                  := sum(group,if(pOffender.orig_lname<>'',1,0));
		orig_fname_CountNonBlank                                  := sum(group,if(pOffender.orig_fname<>'',1,0));
		orig_mname_CountNonBlank                                  := sum(group,if(pOffender.orig_mname<>'',1,0));
		orig_name_suffix_CountNonBlank                            := sum(group,if(pOffender.orig_name_suffix<>'',1,0));
		place_of_birth_CountNonBlank                              := sum(group,if(pOffender.place_of_birth<>'',1,0));
		dob_CountNonBlank                                         := sum(group,if(pOffender.dob<>'',1,0));
		dob_alias_CountNonBlank                                   := sum(group,if(pOffender.dob_alias<>'',1,0));
		orig_ssn_CountNonBlank                                    := sum(group,if(pOffender.orig_ssn<>'',1,0));
		offender_id_num_1_CountNonBlank                           := sum(group,if(pOffender.offender_id_num_1<>'',1,0));
		offender_id_num_type_1_CountNonBlank                      := sum(group,if(pOffender.offender_id_num_type_1<>'',1,0));
		offender_id_num_2_CountNonBlank                           := sum(group,if(pOffender.offender_id_num_2<>'',1,0));
		offender_id_num_type_2_CountNonBlank                      := sum(group,if(pOffender.offender_id_num_type_2<>'',1,0));
		sor_date_1_CountNonBlank                                  := sum(group,if(pOffender.sor_date_1<>'',1,0));
		sor_date_type_1_CountNonBlank                             := sum(group,if(pOffender.sor_date_type_1<>'',1,0));
		sor_date_2_CountNonBlank                                  := sum(group,if(pOffender.sor_date_2<>'',1,0));
		sor_date_type_2_CountNonBlank                             := sum(group,if(pOffender.sor_date_type_2<>'',1,0));
		sor_date_3_CountNonBlank                                  := sum(group,if(pOffender.sor_date_3<>'',1,0));
		sor_date_type_3_CountNonBlank                             := sum(group,if(pOffender.sor_date_type_3<>'',1,0));
		sor_status_CountNonBlank                                  := sum(group,if(pOffender.sor_status<>'',1,0));
		sor_offender_category_CountNonBlank                       := sum(group,if(pOffender.sor_offender_category<>'',1,0));
		sor_risk_level_code_CountNonBlank                         := sum(group,if(pOffender.sor_risk_level_code<>'',1,0));
		sor_risk_level_desc_CountNonBlank                         := sum(group,if(pOffender.sor_risk_level_desc<>'',1,0));
		sor_registration_type_CountNonBlank                       := sum(group,if(pOffender.sor_registration_type<>'',1,0));
		offender_status_CountNonBlank                             := sum(group,if(pOffender.offender_status<>'',1,0));
		offender_address_1_CountNonBlank                          := sum(group,if(pOffender.offender_address_1<>'',1,0));
		offender_address_2_CountNonBlank                          := sum(group,if(pOffender.offender_address_2<>'',1,0));
		offender_address_3_CountNonBlank                          := sum(group,if(pOffender.offender_address_3<>'',1,0));
		offender_address_4_CountNonBlank                          := sum(group,if(pOffender.offender_address_4<>'',1,0));
		offender_address_5_CountNonBlank                          := sum(group,if(pOffender.offender_address_5<>'',1,0));
		case_number_CountNonBlank                                 := sum(group,if(pOffender.case_number<>'',1,0));
		case_court_CountNonBlank                                  := sum(group,if(pOffender.case_court<>'',1,0));
		case_name_CountNonBlank                                   := sum(group,if(pOffender.case_name<>'',1,0));
		case_type_CountNonBlank                                   := sum(group,if(pOffender.case_type<>'',1,0));
		case_type_desc_CountNonBlank                              := sum(group,if(pOffender.case_type_desc<>'',1,0));
		case_filing_date_CountNonBlank                            := sum(group,if(pOffender.case_filing_date<>'',1,0));
		race_desc_CountNonBlank                                   := sum(group,if(pOffender.race_desc<>'',1,0));
		sex_CountNonBlank                                         := sum(group,if(pOffender.sex<>'',1,0));
		hair_color_desc_CountNonBlank                             := sum(group,if(pOffender.hair_color_desc<>'',1,0));
		eye_color_desc_CountNonBlank                              := sum(group,if(pOffender.eye_color_desc<>'',1,0));
		skin_color_desc_CountNonBlank                             := sum(group,if(pOffender.skin_color_desc<>'',1,0));
		height_CountNonBlank                                      := sum(group,if(pOffender.height<>'',1,0));
		weight_CountNonBlank                                      := sum(group,if(pOffender.weight<>'',1,0));
		ethnicity_CountNonBlank                                   := sum(group,if(pOffender.ethnicity<>'',1,0));
		age_CountNonBlank                                         := sum(group,if(pOffender.age<>'',1,0));
		build_type_CountNonBlank                                  := sum(group,if(pOffender.build_type<>'',1,0));
		scars_marks_tattoos_CountNonBlank                         := sum(group,if(pOffender.scars_marks_tattoos<>'',1,0));
		fcra_conviction_flag_CountNonBlank                        := sum(group,if(pOffender.fcra_conviction_flag<>'',1,0));
		fcra_traffic_flag_CountNonBlank                           := sum(group,if(pOffender.fcra_traffic_flag<>'',1,0));
		fcra_date_CountNonBlank                                   := sum(group,if(pOffender.fcra_date<>'',1,0));
		fcra_date_type_CountNonBlank                              := sum(group,if(pOffender.fcra_date_type<>'',1,0));
		conviction_override_date_CountNonBlank                    := sum(group,if(pOffender.conviction_override_date<>'',1,0));
		conviction_override_date_type_CountNonBlank               := sum(group,if(pOffender.conviction_override_date_type<>'',1,0));
		offense_score_CountNonBlank                               := sum(group,if(pOffender.offense_score<>'',1,0));
		prim_range_CountNonBlank                                  := sum(group,if(pOffender.prim_range<>'',1,0));
		predir_CountNonBlank                                      := sum(group,if(pOffender.predir<>'',1,0));
		prim_name_CountNonBlank                                   := sum(group,if(pOffender.prim_name<>'',1,0));
		addr_suffix_CountNonBlank                                 := sum(group,if(pOffender.addr_suffix<>'',1,0));
		postdir_CountNonBlank                                     := sum(group,if(pOffender.postdir<>'',1,0));
		unit_desig_CountNonBlank                                  := sum(group,if(pOffender.unit_desig<>'',1,0));
		sec_range_CountNonBlank                                   := sum(group,if(pOffender.sec_range<>'',1,0));
		p_city_name_CountNonBlank                                 := sum(group,if(pOffender.p_city_name<>'',1,0));
		v_city_name_CountNonBlank                                 := sum(group,if(pOffender.v_city_name<>'',1,0));
		state_CountNonBlank                                       := sum(group,if(pOffender.state<>'',1,0));
		zip5_CountNonBlank                                        := sum(group,if(pOffender.zip5<>'',1,0));
		zip4_CountNonBlank                                        := sum(group,if(pOffender.zip4<>'',1,0));
		cart_CountNonBlank                                        := sum(group,if(pOffender.cart<>'',1,0));
		cr_sort_sz_CountNonBlank                                  := sum(group,if(pOffender.cr_sort_sz<>'',1,0));
		lot_CountNonBlank                                         := sum(group,if(pOffender.lot<>'',1,0));
		lot_order_CountNonBlank                                   := sum(group,if(pOffender.lot_order<>'',1,0));
		dpbc_CountNonBlank                                        := sum(group,if(pOffender.dpbc<>'',1,0));
		chk_digit_CountNonBlank                                   := sum(group,if(pOffender.chk_digit<>'',1,0));
		rec_type_CountNonBlank                                    := sum(group,if(pOffender.rec_type<>'',1,0));
		ace_fips_st_CountNonBlank                                 := sum(group,if(pOffender.ace_fips_st<>'',1,0));
		ace_fips_county_CountNonBlank                             := sum(group,if(pOffender.ace_fips_county<>'',1,0));
		geo_lat_CountNonBlank                                     := sum(group,if(pOffender.geo_lat<>'',1,0));
		geo_long_CountNonBlank                                    := sum(group,if(pOffender.geo_long<>'',1,0));
		msa_CountNonBlank                                         := sum(group,if(pOffender.msa<>'',1,0));
		geo_blk_CountNonBlank                                     := sum(group,if(pOffender.geo_blk<>'',1,0));
		geo_match_CountNonBlank                                   := sum(group,if(pOffender.geo_match<>'',1,0));
		err_stat_CountNonBlank                                    := sum(group,if(pOffender.err_stat<>'',1,0));
		title_CountNonBlank                                       := sum(group,if(pOffender.title<>'',1,0));
		fname_CountNonBlank                                       := sum(group,if(pOffender.fname<>'',1,0));
		mname_CountNonBlank                                       := sum(group,if(pOffender.mname<>'',1,0));
		lname_CountNonBlank                                       := sum(group,if(pOffender.lname<>'',1,0));
		name_suffix_CountNonBlank                                 := sum(group,if(pOffender.name_suffix<>'',1,0));
		cleaning_score_CountNonBlank                              := sum(group,if(pOffender.cleaning_score<>'',1,0));
		ssn_CountNonBlank                                         := sum(group,if(pOffender.ssn<>'',1,0));
		did_CountNonBlank                                         := sum(group,if(pOffender.did<>'',1,0));
	  end
	 ;

	%rPopulationStats_pOffenses%
	 :=
	  record
		CountGroup                                                := count(group);
		pOffenses.vendor;
		pOffenses.state_of_origin;
		pOffenses.source_file;
		date_first_reported_CountNonBlank                         := sum(group,if(pOffenses.date_first_reported<>'',1,0));
		date_last_reported_CountNonBlank                          := sum(group,if(pOffenses.date_last_reported<>'',1,0));
		offender_key_CountNonBlank                                := sum(group,if(pOffenses.offender_key<>'',1,0));
		orig_offense_key_CountNonBlank                            := sum(group,if(pOffenses.orig_offense_key<>'',1,0));
		off_name_CountNonBlank                                    := sum(group,if(pOffenses.off_name<>'',1,0));
		off_date_CountNonBlank                                    := sum(group,if(pOffenses.off_date<>'',1,0));
		off_code_CountNonBlank                                    := sum(group,if(pOffenses.off_code<>'',1,0));
		charge_CountNonBlank                                      := sum(group,if(pOffenses.charge<>'',1,0));
		counts_CountNonBlank                                      := sum(group,if(pOffenses.counts<>'',1,0));
		off_desc_1_CountNonBlank                                  := sum(group,if(pOffenses.off_desc_1<>'',1,0));
		off_desc_2_CountNonBlank                                  := sum(group,if(pOffenses.off_desc_2<>'',1,0));
		off_type_CountNonBlank                                    := sum(group,if(pOffenses.off_type<>'',1,0));
		off_level_CountNonBlank                                   := sum(group,if(pOffenses.off_level<>'',1,0));
		sor_off_victim_minor_CountNonBlank                        := sum(group,if(pOffenses.sor_off_victim_minor<>'',1,0));
		sor_off_victim_age_CountNonBlank                          := sum(group,if(pOffenses.sor_off_victim_age<>'',1,0));
		sor_off_victim_gender_CountNonBlank                       := sum(group,if(pOffenses.sor_off_victim_gender<>'',1,0));
		sor_off_victim_relationship_CountNonBlank                 := sum(group,if(pOffenses.sor_off_victim_relationship<>'',1,0));
		arrest_date_CountNonBlank                                 := sum(group,if(pOffenses.arrest_date<>'',1,0));
		arrest_off_code_CountNonBlank                             := sum(group,if(pOffenses.arrest_off_code<>'',1,0));
		arrest_off_desc_CountNonBlank                             := sum(group,if(pOffenses.arrest_off_desc<>'',1,0));
		arrest_off_level_CountNonBlank                            := sum(group,if(pOffenses.arrest_off_level<>'',1,0));
		arrest_off_statute_CountNonBlank                          := sum(group,if(pOffenses.arrest_off_statute<>'',1,0));
		arrest_statute_desc_CountNonBlank                         := sum(group,if(pOffenses.arrest_statute_desc<>'',1,0));
		arrest_disp_date_CountNonBlank                            := sum(group,if(pOffenses.arrest_disp_date<>'',1,0));
		arrest_disp_desc_CountNonBlank                            := sum(group,if(pOffenses.arrest_disp_desc<>'',1,0));
		le_agency_code_CountNonBlank                              := sum(group,if(pOffenses.le_agency_code<>'',1,0));
		le_agency_desc_CountNonBlank                              := sum(group,if(pOffenses.le_agency_desc<>'',1,0));
		le_agency_case_number_CountNonBlank                       := sum(group,if(pOffenses.le_agency_case_number<>'',1,0));
		traffic_ticket_number_CountNonBlank                       := sum(group,if(pOffenses.traffic_ticket_number<>'',1,0));
		case_number_CountNonBlank                                 := sum(group,if(pOffenses.case_number<>'',1,0));
		court_code_CountNonBlank                                  := sum(group,if(pOffenses.court_code<>'',1,0));
		court_desc_CountNonBlank                                  := sum(group,if(pOffenses.court_desc<>'',1,0));
		court_final_plea_CountNonBlank                            := sum(group,if(pOffenses.court_final_plea<>'',1,0));
		court_off_code_CountNonBlank                              := sum(group,if(pOffenses.court_off_code<>'',1,0));
		court_off_desc_CountNonBlank                              := sum(group,if(pOffenses.court_off_desc<>'',1,0));
		court_off_level_CountNonBlank                             := sum(group,if(pOffenses.court_off_level<>'',1,0));
		court_statute_CountNonBlank                               := sum(group,if(pOffenses.court_statute<>'',1,0));
		court_statute_desc_CountNonBlank                          := sum(group,if(pOffenses.court_statute_desc<>'',1,0));
		conv_date_CountNonBlank                                   := sum(group,if(pOffenses.conv_date<>'',1,0));
		conv_county_code_CountNonBlank                            := sum(group,if(pOffenses.conv_county_code<>'',1,0));
		conv_county_CountNonBlank                                 := sum(group,if(pOffenses.conv_county<>'',1,0));
		court_disp_date_CountNonBlank                             := sum(group,if(pOffenses.court_disp_date<>'',1,0));
		court_disp_code_CountNonBlank                             := sum(group,if(pOffenses.court_disp_code<>'',1,0));
		court_disp_desc_CountNonBlank                             := sum(group,if(pOffenses.court_disp_desc<>'',1,0));
		sent_date_CountNonBlank                                   := sum(group,if(pOffenses.sent_date<>'',1,0));
		sent_code_CountNonBlank                                   := sum(group,if(pOffenses.sent_code<>'',1,0));
		sent_comp_CountNonBlank                                   := sum(group,if(pOffenses.sent_comp<>'',1,0));
		sent_desc_1_CountNonBlank                                 := sum(group,if(pOffenses.sent_desc_1<>'',1,0));
		sent_desc_2_CountNonBlank                                 := sum(group,if(pOffenses.sent_desc_2<>'',1,0));
		sent_desc_3_CountNonBlank                                 := sum(group,if(pOffenses.sent_desc_3<>'',1,0));
		sent_desc_4_CountNonBlank                                 := sum(group,if(pOffenses.sent_desc_4<>'',1,0));
		inc_adm_date_CountNonBlank                                := sum(group,if(pOffenses.inc_adm_date<>'',1,0));
		fcra_offense_key_CountNonBlank                            := sum(group,if(pOffenses.fcra_offense_key<>'',1,0));
		fcra_conviction_flag_CountNonBlank                        := sum(group,if(pOffenses.fcra_conviction_flag<>'',1,0));
		fcra_traffic_flag_CountNonBlank                           := sum(group,if(pOffenses.fcra_traffic_flag<>'',1,0));
		fcra_date_CountNonBlank                                   := sum(group,if(pOffenses.fcra_date<>'',1,0));
		fcra_date_type_CountNonBlank                              := sum(group,if(pOffenses.fcra_date_type<>'',1,0));
		conviction_override_date_CountNonBlank                    := sum(group,if(pOffenses.conviction_override_date<>'',1,0));
		conviction_override_date_type_CountNonBlank               := sum(group,if(pOffenses.conviction_override_date_type<>'',1,0));
		offense_score_CountNonBlank                               := sum(group,if(pOffenses.offense_score<>'',1,0));
	  end
	 ;

	%rPopulationStats_pPunishment%
	 :=
	  record
		CountGroup                                                := count(group);
		pPunishment.vendor;
		pPunishment.source_file;
		date_first_reported_CountNonBlank                         := sum(group,if(pPunishment.date_first_reported<>'',1,0));
		date_last_reported_CountNonBlank                          := sum(group,if(pPunishment.date_last_reported<>'',1,0));
		offender_key_CountNonBlank                                := sum(group,if(pPunishment.offender_key<>'',1,0));
		event_date_CountNonBlank                                  := sum(group,if(pPunishment.event_date<>'',1,0));
		orig_offense_key_CountNonBlank                            := sum(group,if(pPunishment.orig_offense_key<>'',1,0));
		punishment_type_CountNonBlank                             := sum(group,if(pPunishment.punishment_type<>'',1,0));
		sent_length_CountNonBlank                                 := sum(group,if(pPunishment.sent_length<>'',1,0));
		sent_length_desc_CountNonBlank                            := sum(group,if(pPunishment.sent_length_desc<>'',1,0));
		inmate_cur_status_desc_CountNonBlank                      := sum(group,if(pPunishment.inmate_cur_status_desc<>'',1,0));
		inmate_cur_loc_CountNonBlank                              := sum(group,if(pPunishment.inmate_cur_loc<>'',1,0));
		admit_latest_date_CountNonBlank                           := sum(group,if(pPunishment.admit_latest_date<>'',1,0));
		release_sched_date_CountNonBlank                          := sum(group,if(pPunishment.release_sched_date<>'',1,0));
		release_actual_date_CountNonBlank                         := sum(group,if(pPunishment.release_actual_date<>'',1,0));
		parole_cur_status_desc_CountNonBlank                      := sum(group,if(pPunishment.parole_cur_status_desc<>'',1,0));
		parole_start_date_CountNonBlank                           := sum(group,if(pPunishment.parole_start_date<>'',1,0));
		parole_sched_end_date_CountNonBlank                       := sum(group,if(pPunishment.parole_sched_end_date<>'',1,0));
		parole_actual_end_date_CountNonBlank                      := sum(group,if(pPunishment.parole_actual_end_date<>'',1,0));
		parole_county_CountNonBlank                               := sum(group,if(pPunishment.parole_county<>'',1,0));
		conviction_override_date_CountNonBlank                    := sum(group,if(pPunishment.conviction_override_date<>'',1,0));
		conviction_override_date_type_CountNonBlank               := sum(group,if(pPunishment.conviction_override_date_type<>'',1,0));
	  end;

	%dPopulationStats_pOffender%	:=	table(pOffender
	                                         ,%rPopulationStats_pOffender%
	                                         ,vendor
											 ,state_of_origin
											 ,source_file
											 ,few);
	%dPopulationStats_pOffenses%	:=	table(pOffenses
	                                         ,%rPopulationStats_pOffenses%
											 ,vendor
											 ,state_of_origin
											 ,source_file
											 ,few);
	%dPopulationStats_pPunishment%	:=	table(pPunishment
	                                         ,%rPopulationStats_pPunishment%
											 ,vendor
											 ,source_file
											 ,few);
	
	STRATA.createXMLStats(%dPopulationStats_pOffender%,
						  'SecurintCriminal',
						  'Offender',
						  pVersion,
						  '',
						  %zPopulationStats_pOffender%,
						  'view',
						  'Population_V2'
						 );

	STRATA.createXMLStats(%dPopulationStats_pOffenses%,
						  'SecurintCriminal',
						  'Offenses',
						  pVersion,
						  '',
						  %zPopulationStats_pOffenses%,
						  'view',
						  'Population_V2'
						 );
	STRATA.createXMLStats(%dPopulationStats_pPunishment%,
						  'SecurintCriminal',
						  'Punishment',
						  pVersion,
						  '',
						  %zPopulationStats_pPunishment%,
						  'view',
						  'Population_V2'
						 );

	pOutReference	:=	parallel(
									 %zPopulationStats_pOffender%
									,%zPopulationStats_pOffenses%
									,%zPopulationStats_pPunishment%
								 );

  endmacro
 ;
