export Out_Population_Stats(pAccurintIn
                           ,pSearchFile
						   ,pVersion
						   ,zOut) := MACRO

import STRATA;

	#uniquename(rPopulationStats_pAccurintIn);
	#uniquename(dPopulationStats_pAccurintIn);
	#uniquename(zAccurintInStats);
	#uniquename(rPopulationStats_pSearchFile);
	#uniquename(dPopulationStats_pSearchFile);
	#uniquename(zSearchFileStats);

%rPopulationStats_pAccurintIn%
 := record
    CountGroup                                                        := count(group);
    dt_first_reported_CountNonBlank                        := sum(group,if(pAccurintIn.dt_first_reported<>'',1,0));
    dt_last_reported_CountNonBlank                         := sum(group,if(pAccurintIn.dt_last_reported<>'',1,0));
    pAccurintIn.orig_state;
    seisint_primary_key_CountNonBlank                      := sum(group,if(pAccurintIn.seisint_primary_key<>'',1,0));
    vendor_code_CountNonBlank                              := sum(group,if(pAccurintIn.vendor_code<>'',1,0));
    pAccurintIn.source_file;
    name_orig_CountNonBlank                                := sum(group,if(pAccurintIn.name_orig<>'',1,0));
    lname_CountNonBlank                                    := sum(group,if(pAccurintIn.lname<>'',1,0));
    fname_CountNonBlank                                    := sum(group,if(pAccurintIn.fname<>'',1,0));
    mname_CountNonBlank                                    := sum(group,if(pAccurintIn.mname<>'',1,0));
    name_suffix_CountNonBlank                              := sum(group,if(pAccurintIn.name_suffix<>'',1,0));
    name_type_CountNonBlank                                := sum(group,if(pAccurintIn.name_type<>'',1,0));
    offender_status_CountNonBlank                          := sum(group,if(pAccurintIn.offender_status<>'',1,0));
    offender_category_CountNonBlank                        := sum(group,if(pAccurintIn.offender_category<>'',1,0));
    risk_level_code_CountNonBlank                          := sum(group,if(pAccurintIn.risk_level_code<>'',1,0));
    risk_description_CountNonBlank                         := sum(group,if(pAccurintIn.risk_description<>'',1,0));
    police_agency_CountNonBlank                            := sum(group,if(pAccurintIn.police_agency<>'',1,0));
    police_agency_contact_name_CountNonBlank               := sum(group,if(pAccurintIn.police_agency_contact_name<>'',1,0));
    police_agency_address_1_CountNonBlank                  := sum(group,if(pAccurintIn.police_agency_address_1<>'',1,0));
    police_agency_address_2_CountNonBlank                  := sum(group,if(pAccurintIn.police_agency_address_2<>'',1,0));
    police_agency_phone_CountNonBlank                      := sum(group,if(pAccurintIn.police_agency_phone<>'',1,0));
    registration_type_CountNonBlank                        := sum(group,if(pAccurintIn.registration_type<>'',1,0));
    reg_date_1_CountNonBlank                               := sum(group,if(pAccurintIn.reg_date_1<>'',1,0));
    reg_date_1_type_CountNonBlank                          := sum(group,if(pAccurintIn.reg_date_1_type<>'',1,0));
    reg_date_2_CountNonBlank                               := sum(group,if(pAccurintIn.reg_date_2<>'',1,0));
    reg_date_2_type_CountNonBlank                          := sum(group,if(pAccurintIn.reg_date_2_type<>'',1,0));
    reg_date_3_CountNonBlank                               := sum(group,if(pAccurintIn.reg_date_3<>'',1,0));
    reg_date_3_type_CountNonBlank                          := sum(group,if(pAccurintIn.reg_date_3_type<>'',1,0));
    registration_address_1_CountNonBlank                   := sum(group,if(pAccurintIn.registration_address_1<>'',1,0));
    registration_address_2_CountNonBlank                   := sum(group,if(pAccurintIn.registration_address_2<>'',1,0));
    registration_address_3_CountNonBlank                   := sum(group,if(pAccurintIn.registration_address_3<>'',1,0));
    registration_address_4_CountNonBlank                   := sum(group,if(pAccurintIn.registration_address_4<>'',1,0));
    registration_address_5_CountNonBlank                   := sum(group,if(pAccurintIn.registration_address_5<>'',1,0));
    registration_county_CountNonBlank                      := sum(group,if(pAccurintIn.registration_county<>'',1,0));
    employer_CountNonBlank                                 := sum(group,if(pAccurintIn.employer<>'',1,0));
    employer_address_1_CountNonBlank                       := sum(group,if(pAccurintIn.employer_address_1<>'',1,0));
    employer_address_2_CountNonBlank                       := sum(group,if(pAccurintIn.employer_address_2<>'',1,0));
    employer_address_3_CountNonBlank                       := sum(group,if(pAccurintIn.employer_address_3<>'',1,0));
    employer_address_4_CountNonBlank                       := sum(group,if(pAccurintIn.employer_address_4<>'',1,0));
    employer_address_5_CountNonBlank                       := sum(group,if(pAccurintIn.employer_address_5<>'',1,0));
    employer_county_CountNonBlank                          := sum(group,if(pAccurintIn.employer_county<>'',1,0));
    school_CountNonBlank                                   := sum(group,if(pAccurintIn.school<>'',1,0));
    school_address_1_CountNonBlank                         := sum(group,if(pAccurintIn.school_address_1<>'',1,0));
    school_address_2_CountNonBlank                         := sum(group,if(pAccurintIn.school_address_2<>'',1,0));
    school_address_3_CountNonBlank                         := sum(group,if(pAccurintIn.school_address_3<>'',1,0));
    school_address_4_CountNonBlank                         := sum(group,if(pAccurintIn.school_address_4<>'',1,0));
    school_address_5_CountNonBlank                         := sum(group,if(pAccurintIn.school_address_5<>'',1,0));
    school_county_CountNonBlank                            := sum(group,if(pAccurintIn.school_county<>'',1,0));
    offender_id_CountNonBlank                              := sum(group,if(pAccurintIn.offender_id<>'',1,0));
    doc_number_CountNonBlank                               := sum(group,if(pAccurintIn.doc_number<>'',1,0));
    sor_number_CountNonBlank                               := sum(group,if(pAccurintIn.sor_number<>'',1,0));
    st_id_number_CountNonBlank                             := sum(group,if(pAccurintIn.st_id_number<>'',1,0));
    fbi_number_CountNonBlank                               := sum(group,if(pAccurintIn.fbi_number<>'',1,0));
    ncic_number_CountNonBlank                              := sum(group,if(pAccurintIn.ncic_number<>'',1,0));
    ssn_CountNonBlank                                      := sum(group,if(pAccurintIn.ssn<>'',1,0));
    dob_CountNonBlank                                      := sum(group,if(pAccurintIn.dob<>'',1,0));
    dob_aka_CountNonBlank                                  := sum(group,if(pAccurintIn.dob_aka<>'',1,0));
    age_CountNonBlank                                      := sum(group,if(pAccurintIn.age<>'',1,0));
    race_CountNonBlank                                     := sum(group,if(pAccurintIn.race<>'',1,0));
    ethnicity_CountNonBlank                                := sum(group,if(pAccurintIn.ethnicity<>'',1,0));
    sex_CountNonBlank                                      := sum(group,if(pAccurintIn.sex<>'',1,0));
    hair_color_CountNonBlank                               := sum(group,if(pAccurintIn.hair_color<>'',1,0));
    eye_color_CountNonBlank                                := sum(group,if(pAccurintIn.eye_color<>'',1,0));
    height_CountNonBlank                                   := sum(group,if(pAccurintIn.height<>'',1,0));
    weight_CountNonBlank                                   := sum(group,if(pAccurintIn.weight<>'',1,0));
    skin_tone_CountNonBlank                                := sum(group,if(pAccurintIn.skin_tone<>'',1,0));
    build_type_CountNonBlank                               := sum(group,if(pAccurintIn.build_type<>'',1,0));
    scars_marks_tattoos_CountNonBlank                      := sum(group,if(pAccurintIn.scars_marks_tattoos<>'',1,0));
    shoe_size_CountNonBlank                                := sum(group,if(pAccurintIn.shoe_size<>'',1,0));
    corrective_lense_flag_CountNonBlank                    := sum(group,if(pAccurintIn.corrective_lense_flag<>'',1,0));
    conviction_jurisdiction_1_CountNonBlank                := sum(group,if(pAccurintIn.conviction_jurisdiction_1<>'',1,0));
    conviction_date_1_CountNonBlank                        := sum(group,if(pAccurintIn.conviction_date_1<>'',1,0));
    court_1_CountNonBlank                                  := sum(group,if(pAccurintIn.court_1<>'',1,0));
    court_case_number_1_CountNonBlank                      := sum(group,if(pAccurintIn.court_case_number_1<>'',1,0));
    offense_date_1_CountNonBlank                           := sum(group,if(pAccurintIn.offense_date_1<>'',1,0));
    offense_code_or_statute_1_CountNonBlank                := sum(group,if(pAccurintIn.offense_code_or_statute_1<>'',1,0));
    offense_description_1_CountNonBlank                    := sum(group,if(pAccurintIn.offense_description_1<>'',1,0));
    offense_description_1_2_CountNonBlank                  := sum(group,if(pAccurintIn.offense_description_1_2<>'',1,0));
    victim_minor_1_CountNonBlank                           := sum(group,if(pAccurintIn.victim_minor_1<>'',1,0));
    victim_age_1_CountNonBlank                             := sum(group,if(pAccurintIn.victim_age_1<>'',1,0));
    victim_gender_1_CountNonBlank                          := sum(group,if(pAccurintIn.victim_gender_1<>'',1,0));
    victim_relationship_1_CountNonBlank                    := sum(group,if(pAccurintIn.victim_relationship_1<>'',1,0));
    sentence_description_1_CountNonBlank                   := sum(group,if(pAccurintIn.sentence_description_1<>'',1,0));
    sentence_description_1_2_CountNonBlank                 := sum(group,if(pAccurintIn.sentence_description_1_2<>'',1,0));
    conviction_jurisdiction_2_CountNonBlank                := sum(group,if(pAccurintIn.conviction_jurisdiction_2<>'',1,0));
    conviction_date_2_CountNonBlank                        := sum(group,if(pAccurintIn.conviction_date_2<>'',1,0));
    court_2_CountNonBlank                                  := sum(group,if(pAccurintIn.court_2<>'',1,0));
    court_case_number_2_CountNonBlank                      := sum(group,if(pAccurintIn.court_case_number_2<>'',1,0));
    offense_date_2_CountNonBlank                           := sum(group,if(pAccurintIn.offense_date_2<>'',1,0));
    offense_code_or_statute_2_CountNonBlank                := sum(group,if(pAccurintIn.offense_code_or_statute_2<>'',1,0));
    offense_description_2_CountNonBlank                    := sum(group,if(pAccurintIn.offense_description_2<>'',1,0));
    offense_description_2_2_CountNonBlank                  := sum(group,if(pAccurintIn.offense_description_2_2<>'',1,0));
    victim_minor_2_CountNonBlank                           := sum(group,if(pAccurintIn.victim_minor_2<>'',1,0));
    victim_age_2_CountNonBlank                             := sum(group,if(pAccurintIn.victim_age_2<>'',1,0));
    victim_gender_2_CountNonBlank                          := sum(group,if(pAccurintIn.victim_gender_2<>'',1,0));
    victim_relationship_2_CountNonBlank                    := sum(group,if(pAccurintIn.victim_relationship_2<>'',1,0));
    sentence_description_2_CountNonBlank                   := sum(group,if(pAccurintIn.sentence_description_2<>'',1,0));
    sentence_description_2_2_CountNonBlank                 := sum(group,if(pAccurintIn.sentence_description_2_2<>'',1,0));
    conviction_jurisdiction_3_CountNonBlank                := sum(group,if(pAccurintIn.conviction_jurisdiction_3<>'',1,0));
    conviction_date_3_CountNonBlank                        := sum(group,if(pAccurintIn.conviction_date_3<>'',1,0));
    court_3_CountNonBlank                                  := sum(group,if(pAccurintIn.court_3<>'',1,0));
    court_case_number_3_CountNonBlank                      := sum(group,if(pAccurintIn.court_case_number_3<>'',1,0));
    offense_date_3_CountNonBlank                           := sum(group,if(pAccurintIn.offense_date_3<>'',1,0));
    offense_code_or_statute_3_CountNonBlank                := sum(group,if(pAccurintIn.offense_code_or_statute_3<>'',1,0));
    offense_description_3_CountNonBlank                    := sum(group,if(pAccurintIn.offense_description_3<>'',1,0));
    offense_description_3_2_CountNonBlank                  := sum(group,if(pAccurintIn.offense_description_3_2<>'',1,0));
    victim_minor_3_CountNonBlank                           := sum(group,if(pAccurintIn.victim_minor_3<>'',1,0));
    victim_age_3_CountNonBlank                             := sum(group,if(pAccurintIn.victim_age_3<>'',1,0));
    victim_gender_3_CountNonBlank                          := sum(group,if(pAccurintIn.victim_gender_3<>'',1,0));
    victim_relationship_3_CountNonBlank                    := sum(group,if(pAccurintIn.victim_relationship_3<>'',1,0));
    sentence_description_3_CountNonBlank                   := sum(group,if(pAccurintIn.sentence_description_3<>'',1,0));
    sentence_description_3_2_CountNonBlank                 := sum(group,if(pAccurintIn.sentence_description_3_2<>'',1,0));
    conviction_jurisdiction_4_CountNonBlank                := sum(group,if(pAccurintIn.conviction_jurisdiction_4<>'',1,0));
    conviction_date_4_CountNonBlank                        := sum(group,if(pAccurintIn.conviction_date_4<>'',1,0));
    court_4_CountNonBlank                                  := sum(group,if(pAccurintIn.court_4<>'',1,0));
    court_case_number_4_CountNonBlank                      := sum(group,if(pAccurintIn.court_case_number_4<>'',1,0));
    offense_date_4_CountNonBlank                           := sum(group,if(pAccurintIn.offense_date_4<>'',1,0));
    offense_code_or_statute_4_CountNonBlank                := sum(group,if(pAccurintIn.offense_code_or_statute_4<>'',1,0));
    offense_description_4_CountNonBlank                    := sum(group,if(pAccurintIn.offense_description_4<>'',1,0));
    offense_description_4_2_CountNonBlank                  := sum(group,if(pAccurintIn.offense_description_4_2<>'',1,0));
    victim_minor_4_CountNonBlank                           := sum(group,if(pAccurintIn.victim_minor_4<>'',1,0));
    victim_age_4_CountNonBlank                             := sum(group,if(pAccurintIn.victim_age_4<>'',1,0));
    victim_gender_4_CountNonBlank                          := sum(group,if(pAccurintIn.victim_gender_4<>'',1,0));
    victim_relationship_4_CountNonBlank                    := sum(group,if(pAccurintIn.victim_relationship_4<>'',1,0));
    sentence_description_4_CountNonBlank                   := sum(group,if(pAccurintIn.sentence_description_4<>'',1,0));
    sentence_description_4_2_CountNonBlank                 := sum(group,if(pAccurintIn.sentence_description_4_2<>'',1,0));
    conviction_jurisdiction_5_CountNonBlank                := sum(group,if(pAccurintIn.conviction_jurisdiction_5<>'',1,0));
    conviction_date_5_CountNonBlank                        := sum(group,if(pAccurintIn.conviction_date_5<>'',1,0));
    court_5_CountNonBlank                                  := sum(group,if(pAccurintIn.court_5<>'',1,0));
    court_case_number_5_CountNonBlank                      := sum(group,if(pAccurintIn.court_case_number_5<>'',1,0));
    offense_date_5_CountNonBlank                           := sum(group,if(pAccurintIn.offense_date_5<>'',1,0));
    offense_code_or_statute_5_CountNonBlank                := sum(group,if(pAccurintIn.offense_code_or_statute_5<>'',1,0));
    offense_description_5_CountNonBlank                    := sum(group,if(pAccurintIn.offense_description_5<>'',1,0));
    offense_description_5_2_CountNonBlank                  := sum(group,if(pAccurintIn.offense_description_5_2<>'',1,0));
    victim_minor_5_CountNonBlank                           := sum(group,if(pAccurintIn.victim_minor_5<>'',1,0));
    victim_age_5_CountNonBlank                             := sum(group,if(pAccurintIn.victim_age_5<>'',1,0));
    victim_gender_5_CountNonBlank                          := sum(group,if(pAccurintIn.victim_gender_5<>'',1,0));
    victim_relationship_5_CountNonBlank                    := sum(group,if(pAccurintIn.victim_relationship_5<>'',1,0));
    sentence_description_5_CountNonBlank                   := sum(group,if(pAccurintIn.sentence_description_5<>'',1,0));
    sentence_description_5_2_CountNonBlank                 := sum(group,if(pAccurintIn.sentence_description_5_2<>'',1,0));
    addl_comments_1_CountNonBlank                          := sum(group,if(pAccurintIn.addl_comments_1<>'',1,0));
    addl_comments_2_CountNonBlank                          := sum(group,if(pAccurintIn.addl_comments_2<>'',1,0));
    orig_dl_number_CountNonBlank                           := sum(group,if(pAccurintIn.orig_dl_number<>'',1,0));
    orig_dl_state_CountNonBlank                            := sum(group,if(pAccurintIn.orig_dl_state<>'',1,0));
    orig_veh_year_1_CountNonBlank                          := sum(group,if(pAccurintIn.orig_veh_year_1<>'',1,0));
    orig_veh_color_1_CountNonBlank                         := sum(group,if(pAccurintIn.orig_veh_color_1<>'',1,0));
    orig_veh_make_model_1_CountNonBlank                    := sum(group,if(pAccurintIn.orig_veh_make_model_1<>'',1,0));
    orig_veh_plate_1_CountNonBlank                         := sum(group,if(pAccurintIn.orig_veh_plate_1<>'',1,0));
    orig_veh_state_1_CountNonBlank                         := sum(group,if(pAccurintIn.orig_veh_state_1<>'',1,0));
    orig_veh_year_2_CountNonBlank                          := sum(group,if(pAccurintIn.orig_veh_year_2<>'',1,0));
    orig_veh_color_2_CountNonBlank                         := sum(group,if(pAccurintIn.orig_veh_color_2<>'',1,0));
    orig_veh_make_model_2_CountNonBlank                    := sum(group,if(pAccurintIn.orig_veh_make_model_2<>'',1,0));
    orig_veh_plate_2_CountNonBlank                         := sum(group,if(pAccurintIn.orig_veh_plate_2<>'',1,0));
    orig_veh_state_2_CountNonBlank                         := sum(group,if(pAccurintIn.orig_veh_state_2<>'',1,0));
    image_link_CountNonBlank                               := sum(group,if(pAccurintIn.image_link<>'',1,0));
    image_date_CountNonBlank                               := sum(group,if(pAccurintIn.image_date<>'',1,0));
  end;

%rPopulationStats_pSearchFile%
 :=
  record
    CountGroup                                                    := count(group);
    seisint_primary_key_CountNonBlank                  := sum(group,if(pSearchFile.seisint_primary_key<>'',1,0));
    dt_last_reported_CountNonBlank                     := sum(group,if(pSearchFile.dt_last_reported<>'',1,0));
    vendor_code_CountNonBlank                          := sum(group,if(pSearchFile.vendor_code<>'',1,0));
    pSearchFile.source_file;
    pSearchFile.orig_state;
    name_orig_CountNonBlank                            := sum(group,if(pSearchFile.name_orig<>'',1,0));
    name_type_CountNonBlank                            := sum(group,if(pSearchFile.name_type<>'',1,0));
    ssn_CountNonBlank                                  := sum(group,if(pSearchFile.ssn<>'',1,0));
    dob_CountNonBlank                                  := sum(group,if(pSearchFile.dob<>'',1,0));
    dob_aka_CountNonBlank                              := sum(group,if(pSearchFile.dob_aka<>'',1,0));
    registration_address_1_CountNonBlank               := sum(group,if(pSearchFile.registration_address_1<>'',1,0));
    registration_address_2_CountNonBlank               := sum(group,if(pSearchFile.registration_address_2<>'',1,0));
    registration_address_3_CountNonBlank               := sum(group,if(pSearchFile.registration_address_3<>'',1,0));
    registration_address_4_CountNonBlank               := sum(group,if(pSearchFile.registration_address_4<>'',1,0));
    registration_address_5_CountNonBlank               := sum(group,if(pSearchFile.registration_address_5<>'',1,0));
    title_CountNonBlank                                := sum(group,if(pSearchFile.title<>'',1,0));
    fname_CountNonBlank                                := sum(group,if(pSearchFile.fname<>'',1,0));
    mname_CountNonBlank                                := sum(group,if(pSearchFile.mname<>'',1,0));
    lname_CountNonBlank                                := sum(group,if(pSearchFile.lname<>'',1,0));
    name_suffix_CountNonBlank                          := sum(group,if(pSearchFile.name_suffix<>'',1,0));
    cleaning_score_CountNonBlank                       := sum(group,if(pSearchFile.cleaning_score<>'',1,0));
    prim_range_CountNonBlank                           := sum(group,if(pSearchFile.prim_range<>'',1,0));
    predir_CountNonBlank                               := sum(group,if(pSearchFile.predir<>'',1,0));
    prim_name_CountNonBlank                            := sum(group,if(pSearchFile.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                          := sum(group,if(pSearchFile.addr_suffix<>'',1,0));
    postdir_CountNonBlank                              := sum(group,if(pSearchFile.postdir<>'',1,0));
    unit_desig_CountNonBlank                           := sum(group,if(pSearchFile.unit_desig<>'',1,0));
    sec_range_CountNonBlank                            := sum(group,if(pSearchFile.sec_range<>'',1,0));
    p_city_name_CountNonBlank                          := sum(group,if(pSearchFile.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                          := sum(group,if(pSearchFile.v_city_name<>'',1,0));
    st_CountNonBlank                                   := sum(group,if(pSearchFile.st<>'',1,0));
    zip_CountNonBlank                                  := sum(group,if(pSearchFile.zip<>'',1,0));
    zip4_CountNonBlank                                 := sum(group,if(pSearchFile.zip4<>'',1,0));
    cart_CountNonBlank                                 := sum(group,if(pSearchFile.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                           := sum(group,if(pSearchFile.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                  := sum(group,if(pSearchFile.lot<>'',1,0));
    lot_order_CountNonBlank                            := sum(group,if(pSearchFile.lot_order<>'',1,0));
    dpbc_CountNonBlank                                 := sum(group,if(pSearchFile.dpbc<>'',1,0));
    chk_digit_CountNonBlank                            := sum(group,if(pSearchFile.chk_digit<>'',1,0));
    rec_type_CountNonBlank                             := sum(group,if(pSearchFile.rec_type<>'',1,0));
    fips_st_CountNonBlank                              := sum(group,if(pSearchFile.fips_st<>'',1,0));
    fips_county_CountNonBlank                          := sum(group,if(pSearchFile.fips_county<>'',1,0));
    geo_lat_CountNonBlank                              := sum(group,if(pSearchFile.geo_lat<>'',1,0));
    geo_long_CountNonBlank                             := sum(group,if(pSearchFile.geo_long<>'',1,0));
    msa_CountNonBlank                                  := sum(group,if(pSearchFile.msa<>'',1,0));
    geo_blk_CountNonBlank                              := sum(group,if(pSearchFile.geo_blk<>'',1,0));
    geo_match_CountNonBlank                            := sum(group,if(pSearchFile.geo_match<>'',1,0));
    err_stat_CountNonBlank                             := sum(group,if(pSearchFile.err_stat<>'',1,0));
    did_CountNonBlank                                  := sum(group,if(pSearchFile.did<>'',1,0));
    did_score_CountNonBlank                            := sum(group,if(pSearchFile.did_score<>'',1,0));
    ssn_appended_CountNonBlank                         := sum(group,if(pSearchFile.ssn_appended<>'',1,0));
  end;

%dPopulationStats_pAccurintIn%
	:= table(pAccurintIn
			,%rPopulationStats_pAccurintIn%
			,orig_state, source_file
			,few);
STRATA.createXMLStats(%dPopulationStats_pAccurintIn%
					 ,'Sex Offenders'
					 ,'Accurint In'
					 ,pVersion
					 ,''
					 ,%zAccurintInStats%
					 );

%dPopulationStats_pSearchFile%
	:= table(pSearchFile
			,%rPopulationStats_pSearchFile%
			,source_file, orig_state
			,few
			);

STRATA.createXMLStats(%dPopulationStats_pSearchFile%
					 ,'Sex Offenders'
					 ,'Search File'
					 ,pVersion
					 ,''
					 ,%zSearchFileStats%
					 );

zOut := parallel(%zAccurintInStats%,%zSearchFileStats%);

ENDMACRO;