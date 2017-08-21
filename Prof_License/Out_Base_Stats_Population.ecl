import STRATA;

rPopulationStats_Prof_License__file_prof_license_base
 :=
  record
	  CountGroup                                                  := count(group);
    prolic_key_CountNonBlank                                    := sum(group,if(Prof_License.File_prof_license_base_AID.prolic_key<>'',1,0));
    date_first_seen_CountNonBlank                               := sum(group,if(Prof_License.File_prof_license_base_AID.date_first_seen<>'',1,0));
    date_last_seen_CountNonBlank                                := sum(group,if(Prof_License.File_prof_license_base_AID.date_last_seen<>'',1,0));
    profession_or_board_CountNonBlank                           := sum(group,if(Prof_License.File_prof_license_base_AID.profession_or_board<>'',1,0));
    license_type_CountNonBlank                                  := sum(group,if(Prof_License.File_prof_license_base_AID.license_type<>'',1,0));
    status_CountNonBlank                                        := sum(group,if(Prof_License.File_prof_license_base_AID.status<>'',1,0));
    orig_license_number_CountNonBlank                           := sum(group,if(Prof_License.File_prof_license_base_AID.orig_license_number<>'',1,0));
    license_number_CountNonBlank                                := sum(group,if(Prof_License.File_prof_license_base_AID.license_number<>'',1,0));
    previous_license_number_CountNonBlank                       := sum(group,if(Prof_License.File_prof_license_base_AID.previous_license_number<>'',1,0));
    previous_license_type_CountNonBlank                         := sum(group,if(Prof_License.File_prof_license_base_AID.previous_license_type<>'',1,0));
    company_name_CountNonBlank                                  := sum(group,if(Prof_License.File_prof_license_base_AID.company_name<>'',1,0));
    orig_name_CountNonBlank                                     := sum(group,if(Prof_License.File_prof_license_base_AID.orig_name<>'',1,0));
    name_order_CountNonBlank                                    := sum(group,if(Prof_License.File_prof_license_base_AID.name_order<>'',1,0));
    orig_former_name_CountNonBlank                              := sum(group,if(Prof_License.File_prof_license_base_AID.orig_former_name<>'',1,0));
    former_name_order_CountNonBlank                             := sum(group,if(Prof_License.File_prof_license_base_AID.former_name_order<>'',1,0));
    orig_addr_1_CountNonBlank                                   := sum(group,if(Prof_License.File_prof_license_base_AID.orig_addr_1<>'',1,0));
    orig_addr_2_CountNonBlank                                   := sum(group,if(Prof_License.File_prof_license_base_AID.orig_addr_2<>'',1,0));
    orig_addr_3_CountNonBlank                                   := sum(group,if(Prof_License.File_prof_license_base_AID.orig_addr_3<>'',1,0));
    orig_addr_4_CountNonBlank                                   := sum(group,if(Prof_License.File_prof_license_base_AID.orig_addr_4<>'',1,0));
    orig_city_CountNonBlank                                     := sum(group,if(Prof_License.File_prof_license_base_AID.orig_city<>'',1,0));
    orig_st_CountNonBlank                                       := sum(group,if(Prof_License.File_prof_license_base_AID.orig_st<>'',1,0));
    orig_zip_CountNonBlank                                      := sum(group,if(Prof_License.File_prof_license_base_AID.orig_zip<>'',1,0));
    county_str_CountNonBlank                                    := sum(group,if(Prof_License.File_prof_license_base_AID.county_str<>'',1,0));
    country_str_CountNonBlank                                   := sum(group,if(Prof_License.File_prof_license_base_AID.country_str<>'',1,0));
    business_flag_CountNonBlank                                 := sum(group,if(Prof_License.File_prof_license_base_AID.business_flag<>'',1,0));
    phone_CountNonBlank                                         := sum(group,if(Prof_License.File_prof_license_base_AID.phone<>'',1,0));
    sex_CountNonBlank                                           := sum(group,if(Prof_License.File_prof_license_base_AID.sex<>'',1,0));
    dob_CountNonBlank                                           := sum(group,if(Prof_License.File_prof_license_base_AID.dob<>'',1,0));
    issue_date_CountNonBlank                                    := sum(group,if(Prof_License.File_prof_license_base_AID.issue_date<>'',1,0));
    expiration_date_CountNonBlank                               := sum(group,if(Prof_License.File_prof_license_base_AID.expiration_date<>'',1,0));
    last_renewal_date_CountNonBlank                             := sum(group,if(Prof_License.File_prof_license_base_AID.last_renewal_date<>'',1,0));
    license_obtained_by_CountNonBlank                           := sum(group,if(Prof_License.File_prof_license_base_AID.license_obtained_by<>'',1,0));
    board_action_indicator_CountNonBlank                        := sum(group,if(Prof_License.File_prof_license_base_AID.board_action_indicator<>'',1,0));
    Prof_License.File_prof_license_base_AID.source_st;
    Prof_License.File_prof_license_base_AID.vendor;
    action_record_type_CountNonBlank                            := sum(group,if(Prof_License.File_prof_license_base_AID.action_record_type<>'',1,0));
    action_complaint_violation_cds_CountNonBlank                := sum(group,if(Prof_License.File_prof_license_base_AID.action_complaint_violation_cds<>'',1,0));
    action_complaint_violation_desc_CountNonBlank               := sum(group,if(Prof_License.File_prof_license_base_AID.action_complaint_violation_desc<>'',1,0));
    action_complaint_violation_dt_CountNonBlank                 := sum(group,if(Prof_License.File_prof_license_base_AID.action_complaint_violation_dt<>'',1,0));
    action_case_number_CountNonBlank                            := sum(group,if(Prof_License.File_prof_license_base_AID.action_case_number<>'',1,0));
    action_effective_dt_CountNonBlank                           := sum(group,if(Prof_License.File_prof_license_base_AID.action_effective_dt<>'',1,0));
    action_cds_CountNonBlank                                    := sum(group,if(Prof_License.File_prof_license_base_AID.action_cds<>'',1,0));
    action_desc_CountNonBlank                                   := sum(group,if(Prof_License.File_prof_license_base_AID.action_desc<>'',1,0));
    action_final_order_no_CountNonBlank                         := sum(group,if(Prof_License.File_prof_license_base_AID.action_final_order_no<>'',1,0));
    action_status_CountNonBlank                                 := sum(group,if(Prof_License.File_prof_license_base_AID.action_status<>'',1,0));
    action_posting_status_dt_CountNonBlank                      := sum(group,if(Prof_License.File_prof_license_base_AID.action_posting_status_dt<>'',1,0));
    action_original_filename_or_url_CountNonBlank               := sum(group,if(Prof_License.File_prof_license_base_AID.action_original_filename_or_url<>'',1,0));
    additional_name_addr_type_CountNonBlank                     := sum(group,if(Prof_License.File_prof_license_base_AID.additional_name_addr_type<>'',1,0));
    additional_orig_name_CountNonBlank                          := sum(group,if(Prof_License.File_prof_license_base_AID.additional_orig_name<>'',1,0));
    additional_name_order_CountNonBlank                         := sum(group,if(Prof_License.File_prof_license_base_AID.additional_name_order<>'',1,0));
    additional_orig_additional_1_CountNonBlank                  := sum(group,if(Prof_License.File_prof_license_base_AID.additional_orig_additional_1<>'',1,0));
    additional_orig_additional_2_CountNonBlank                  := sum(group,if(Prof_License.File_prof_license_base_AID.additional_orig_additional_2<>'',1,0));
    additional_orig_additional_3_CountNonBlank                  := sum(group,if(Prof_License.File_prof_license_base_AID.additional_orig_additional_3<>'',1,0));
    additional_orig_additional_4_CountNonBlank                  := sum(group,if(Prof_License.File_prof_license_base_AID.additional_orig_additional_4<>'',1,0));
    additional_orig_city_CountNonBlank                          := sum(group,if(Prof_License.File_prof_license_base_AID.additional_orig_city<>'',1,0));
    additional_orig_st_CountNonBlank                            := sum(group,if(Prof_License.File_prof_license_base_AID.additional_orig_st<>'',1,0));
    additional_orig_zip_CountNonBlank                           := sum(group,if(Prof_License.File_prof_license_base_AID.additional_orig_zip<>'',1,0));
    additional_phone_CountNonBlank                              := sum(group,if(Prof_License.File_prof_license_base_AID.additional_phone<>'',1,0));
    misc_occupation_CountNonBlank                               := sum(group,if(Prof_License.File_prof_license_base_AID.misc_occupation<>'',1,0));
    misc_practice_hours_CountNonBlank                           := sum(group,if(Prof_License.File_prof_license_base_AID.misc_practice_hours<>'',1,0));
    misc_practice_type_CountNonBlank                            := sum(group,if(Prof_License.File_prof_license_base_AID.misc_practice_type<>'',1,0));
    misc_email_CountNonBlank                                    := sum(group,if(Prof_License.File_prof_license_base_AID.misc_email<>'',1,0));
    misc_fax_CountNonBlank                                      := sum(group,if(Prof_License.File_prof_license_base_AID.misc_fax<>'',1,0));
    misc_web_site_CountNonBlank                                 := sum(group,if(Prof_License.File_prof_license_base_AID.misc_web_site<>'',1,0));
    misc_other_id_CountNonBlank                                 := sum(group,if(Prof_License.File_prof_license_base_AID.misc_other_id<>'',1,0));
    misc_other_id_type_CountNonBlank                            := sum(group,if(Prof_License.File_prof_license_base_AID.misc_other_id_type<>'',1,0));
    education_continuing_education_CountNonBlank                := sum(group,if(Prof_License.File_prof_license_base_AID.education_continuing_education<>'',1,0));
    education_1_school_attended_CountNonBlank                   := sum(group,if(Prof_License.File_prof_license_base_AID.education_1_school_attended<>'',1,0));
    education_1_dates_attended_CountNonBlank                    := sum(group,if(Prof_License.File_prof_license_base_AID.education_1_dates_attended<>'',1,0));
    education_1_curriculum_CountNonBlank                        := sum(group,if(Prof_License.File_prof_license_base_AID.education_1_curriculum<>'',1,0));
    education_1_degree_CountNonBlank                            := sum(group,if(Prof_License.File_prof_license_base_AID.education_1_degree<>'',1,0));
    education_2_school_attended_CountNonBlank                   := sum(group,if(Prof_License.File_prof_license_base_AID.education_2_school_attended<>'',1,0));
    education_2_dates_attended_CountNonBlank                    := sum(group,if(Prof_License.File_prof_license_base_AID.education_2_dates_attended<>'',1,0));
    education_2_curriculum_CountNonBlank                        := sum(group,if(Prof_License.File_prof_license_base_AID.education_2_curriculum<>'',1,0));
    education_2_degree_CountNonBlank                            := sum(group,if(Prof_License.File_prof_license_base_AID.education_2_degree<>'',1,0));
    education_3_school_attended_CountNonBlank                   := sum(group,if(Prof_License.File_prof_license_base_AID.education_3_school_attended<>'',1,0));
    education_3_dates_attended_CountNonBlank                    := sum(group,if(Prof_License.File_prof_license_base_AID.education_3_dates_attended<>'',1,0));
    education_3_curriculum_CountNonBlank                        := sum(group,if(Prof_License.File_prof_license_base_AID.education_3_curriculum<>'',1,0));
    education_3_degree_CountNonBlank                            := sum(group,if(Prof_License.File_prof_license_base_AID.education_3_degree<>'',1,0));
    additional_licensing_specifics_CountNonBlank                := sum(group,if(Prof_License.File_prof_license_base_AID.additional_licensing_specifics<>'',1,0));
    personal_pob_cd_CountNonBlank                               := sum(group,if(Prof_License.File_prof_license_base_AID.personal_pob_cd<>'',1,0));
    personal_pob_desc_CountNonBlank                             := sum(group,if(Prof_License.File_prof_license_base_AID.personal_pob_desc<>'',1,0));
    personal_race_cd_CountNonBlank                              := sum(group,if(Prof_License.File_prof_license_base_AID.personal_race_cd<>'',1,0));
    personal_race_desc_CountNonBlank                            := sum(group,if(Prof_License.File_prof_license_base_AID.personal_race_desc<>'',1,0));
    status_status_cds_CountNonBlank                             := sum(group,if(Prof_License.File_prof_license_base_AID.status_status_cds<>'',1,0));
    status_effective_dt_CountNonBlank                           := sum(group,if(Prof_License.File_prof_license_base_AID.status_effective_dt<>'',1,0));
    status_renewal_desc_CountNonBlank                           := sum(group,if(Prof_License.File_prof_license_base_AID.status_renewal_desc<>'',1,0));
    status_other_agency_CountNonBlank                           := sum(group,if(Prof_License.File_prof_license_base_AID.status_other_agency<>'',1,0));
    prim_range_CountNonBlank                                    := sum(group,if(Prof_License.File_prof_license_base_AID.prim_range<>'',1,0));
    predir_CountNonBlank                                        := sum(group,if(Prof_License.File_prof_license_base_AID.predir<>'',1,0));
    prim_name_CountNonBlank                                     := sum(group,if(Prof_License.File_prof_license_base_AID.prim_name<>'',1,0));
    suffix_CountNonBlank                                        := sum(group,if(Prof_License.File_prof_license_base_AID.suffix<>'',1,0));
    postdir_CountNonBlank                                       := sum(group,if(Prof_License.File_prof_license_base_AID.postdir<>'',1,0));
    unit_desig_CountNonBlank                                    := sum(group,if(Prof_License.File_prof_license_base_AID.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                     := sum(group,if(Prof_License.File_prof_license_base_AID.sec_range<>'',1,0));
    p_city_name_CountNonBlank                                   := sum(group,if(Prof_License.File_prof_license_base_AID.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                                   := sum(group,if(Prof_License.File_prof_license_base_AID.v_city_name<>'',1,0));
    st_CountNonBlank                                            := sum(group,if(Prof_License.File_prof_license_base_AID.st<>'',1,0));
    zip_CountNonBlank                                           := sum(group,if(Prof_License.File_prof_license_base_AID.zip<>'',1,0));
    zip4_CountNonBlank                                          := sum(group,if(Prof_License.File_prof_license_base_AID.zip4<>'',1,0));
    cart_CountNonBlank                                          := sum(group,if(Prof_License.File_prof_license_base_AID.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                                    := sum(group,if(Prof_License.File_prof_license_base_AID.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                           := sum(group,if(Prof_License.File_prof_license_base_AID.lot<>'',1,0));
    lot_order_CountNonBlank                                     := sum(group,if(Prof_License.File_prof_license_base_AID.lot_order<>'',1,0));
    dpbc_CountNonBlank                                          := sum(group,if(Prof_License.File_prof_license_base_AID.dpbc<>'',1,0));
    chk_digit_CountNonBlank                                     := sum(group,if(Prof_License.File_prof_license_base_AID.chk_digit<>'',1,0));
    record_type_CountNonBlank                                   := sum(group,if(Prof_License.File_prof_license_base_AID.record_type<>'',1,0));
    ace_fips_st_CountNonBlank                                   := sum(group,if(Prof_License.File_prof_license_base_AID.ace_fips_st<>'',1,0));
    county_CountNonBlank                                        := sum(group,if(Prof_License.File_prof_license_base_AID.county<>'',1,0));
    geo_lat_CountNonBlank                                       := sum(group,if(Prof_License.File_prof_license_base_AID.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                      := sum(group,if(Prof_License.File_prof_license_base_AID.geo_long<>'',1,0));
    msa_CountNonBlank                                           := sum(group,if(Prof_License.File_prof_license_base_AID.msa<>'',1,0));
    geo_blk_CountNonBlank                                       := sum(group,if(Prof_License.File_prof_license_base_AID.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                     := sum(group,if(Prof_License.File_prof_license_base_AID.geo_match<>'',1,0));
    err_stat_CountNonBlank                                      := sum(group,if(Prof_License.File_prof_license_base_AID.err_stat<>'',1,0));
    title_CountNonBlank                                         := sum(group,if(Prof_License.File_prof_license_base_AID.title<>'',1,0));
    fname_CountNonBlank                                         := sum(group,if(Prof_License.File_prof_license_base_AID.fname<>'',1,0));
    mname_CountNonBlank                                         := sum(group,if(Prof_License.File_prof_license_base_AID.mname<>'',1,0));
    lname_CountNonBlank                                         := sum(group,if(Prof_License.File_prof_license_base_AID.lname<>'',1,0));
    name_suffix_CountNonBlank                                   := sum(group,if(Prof_License.File_prof_license_base_AID.name_suffix<>'',1,0));
    pl_score_in_CountNonBlank                                   := sum(group,if(Prof_License.File_prof_license_base_AID.pl_score_in<>'',1,0));
    county_name_CountNonBlank                                   := sum(group,if(Prof_License.File_prof_license_base_AID.county_name<>'',1,0));
		did_CountNonBlank                                           := sum(group,if(Prof_License.File_prof_license_base_AID.did<>'',1,0));
		score_CountNonBlank                                         := sum(group,if(Prof_License.File_prof_license_base_AID.score<>'',1,0));
		best_ssn_CountNonBlank                                      := sum(group,if(Prof_License.File_prof_license_base_AID.best_ssn<>'',1,0));
		bdid_CountNonBlank                                          := sum(group,if(Prof_License.File_prof_license_base_AID.bdid<>'',1,0));
				//BIPV2 fields have been added for Strata
	  source_rec_id_CountNonZeros	   												 			:= sum(group,if(Prof_License.File_prof_license_base_AID.source_rec_id<>0,1,0));
		DotID_CountNonZeros	 																	 			:= sum(group,if(Prof_License.File_prof_license_base_AID.DotID<>0,1,0));
		DotScore_CountNonZeros	   														 			:= sum(group,if(Prof_License.File_prof_license_base_AID.DotScore<>0,1,0));
		DotWeight_CountNonZeros	 															 			:= sum(group,if(Prof_License.File_prof_license_base_AID.DotWeight<>0,1,0));
		EmpID_CountNonZeros	   																 			:= sum(group,if(Prof_License.File_prof_license_base_AID.EmpID<>0,1,0));
 		EmpScore_CountNonZeros	 														   			:= sum(group,if(Prof_License.File_prof_license_base_AID.EmpScore<>0,1,0));
		EmpWeight_CountNonZeros	 									             			:= sum(group,if(Prof_License.File_prof_license_base_AID.EmpWeight<>0,1,0));
		POWID_CountNonZeros	                                   			:= sum(group,if(Prof_License.File_prof_license_base_AID.POWID<>0,1,0));
		POWScore_CountNonZeros	                              			:= sum(group,if(Prof_License.File_prof_license_base_AID.POWScore<>0,1,0));
		POWWeight_CountNonZeros	                               			:= sum(group,if(Prof_License.File_prof_license_base_AID.POWWeight<>0,1,0));
		ProxID_CountNonZeros	                                 			:= sum(group,if(Prof_License.File_prof_license_base_AID.ProxID<>0,1,0));
		ProxScore_CountNonZeros	                               			:= sum(group,if(Prof_License.File_prof_license_base_AID.ProxScore<>0,1,0));
		ProxWeight_CountNonZeros	                                  := sum(group,if(Prof_License.File_prof_license_base_AID.ProxWeight<>0,1,0));
		SELEID_CountNonZeros	                        							:= sum(group,if(Prof_License.File_prof_license_base_AID.SELEID<>0,1,0));
		SELEScore_CountNonZeros	                      							:= sum(group,if(Prof_License.File_prof_license_base_AID.SELEScore<>0,1,0));
		SELEWeight_CountNonZeros	                    							:= sum(group,if(Prof_License.File_prof_license_base_AID.SELEWeight<>0,1,0));
		OrgID_CountNonZeros	                                   			:= sum(group,if(Prof_License.File_prof_license_base_AID.OrgID<>0,1,0));
		OrgScore_CountNonZeros	                               			:= sum(group,if(Prof_License.File_prof_license_base_AID.OrgScore<>0,1,0));
		OrgWeight_CountNonZeros	                               		  := sum(group,if(Prof_License.File_prof_license_base_AID.OrgWeight<>0,1,0));
		UltID_CountNonZeros	                                   			:= sum(group,if(Prof_License.File_prof_license_base_AID.UltID<>0,1,0));
		UltScore_CountNonZeros	                               			:= sum(group,if(Prof_License.File_prof_license_base_AID.UltScore<>0,1,0));
		UltWeight_CountNonZeros	                               			:= sum(group,if(Prof_License.File_prof_license_base_AID.UltWeight<>0,1,0));
  end;

dPopulationStats_Prof_License__file_prof_license_base := table(Prof_License.File_prof_license_base_AID,
                                                               rPopulationStats_Prof_License__file_prof_license_base,
                                                               source_st,vendor,
										                                           few
									                                             );

STRATA.createXMLStats(dPopulationStats_Prof_License__file_prof_license_base,
                      'Professional Licenses',
					            'Base_data',
					            Prof_License.version,
					            '',
					            resultsOut,
								      'view',
								      'population',
											omit_output_to_screen := true
					           );
		 
export Out_Base_Stats_Population := resultsOut;