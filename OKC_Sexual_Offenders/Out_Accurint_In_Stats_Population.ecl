EXPORT Out_Accurint_In_Stats_Population(pVersion,zOut) := MACRO

import STRATA;

rPopulationStats_OKC_Sexual_Offenders__File_OKC_Cleaned_Accurint_In
 :=
  record
    CountGroup                                                                                              := count(group);
    dt_first_reported_CountNonBlank                        := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.dt_first_reported<>'',1,0));
    dt_last_reported_CountNonBlank                         := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.dt_last_reported<>'',1,0));
    OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.orig_state;
    seisint_primary_key_CountNonBlank                      := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.seisint_primary_key<>'',1,0));
    vendor_code_CountNonBlank                              := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.vendor_code<>'',1,0));
    OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.source_file;
    name_orig_CountNonBlank                                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.name_orig<>'',1,0));
    lname_CountNonBlank                                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.lname<>'',1,0));
    fname_CountNonBlank                                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.fname<>'',1,0));
    mname_CountNonBlank                                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.mname<>'',1,0));
    name_suffix_CountNonBlank                              := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.name_suffix<>'',1,0));
    name_type_CountNonBlank                                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.name_type<>'',1,0));
    offender_status_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offender_status<>'',1,0));
    offender_category_CountNonBlank                        := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offender_category<>'',1,0));
    risk_level_code_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.risk_level_code<>'',1,0));
    risk_description_CountNonBlank                         := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.risk_description<>'',1,0));
    police_agency_CountNonBlank                            := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.police_agency<>'',1,0));
    police_agency_contact_name_CountNonBlank               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.police_agency_contact_name<>'',1,0));
    police_agency_address_1_CountNonBlank                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.police_agency_address_1<>'',1,0));
    police_agency_address_2_CountNonBlank                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.police_agency_address_2<>'',1,0));
    police_agency_phone_CountNonBlank                      := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.police_agency_phone<>'',1,0));
    registration_type_CountNonBlank                        := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.registration_type<>'',1,0));
    reg_date_1_CountNonBlank                               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.reg_date_1<>'',1,0));
    reg_date_1_type_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.reg_date_1_type<>'',1,0));
    reg_date_2_CountNonBlank                               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.reg_date_2<>'',1,0));
    reg_date_2_type_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.reg_date_2_type<>'',1,0));
    reg_date_3_CountNonBlank                               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.reg_date_3<>'',1,0));
    reg_date_3_type_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.reg_date_3_type<>'',1,0));
    registration_address_1_CountNonBlank                   := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.registration_address_1<>'',1,0));
    registration_address_2_CountNonBlank                   := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.registration_address_2<>'',1,0));
    registration_address_3_CountNonBlank                   := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.registration_address_3<>'',1,0));
    registration_address_4_CountNonBlank                   := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.registration_address_4<>'',1,0));
    registration_address_5_CountNonBlank                   := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.registration_address_5<>'',1,0));
    registration_county_CountNonBlank                      := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.registration_county<>'',1,0));
    employer_CountNonBlank                                 := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.employer<>'',1,0));
    employer_address_1_CountNonBlank                       := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.employer_address_1<>'',1,0));
    employer_address_2_CountNonBlank                       := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.employer_address_2<>'',1,0));
    employer_address_3_CountNonBlank                       := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.employer_address_3<>'',1,0));
    employer_address_4_CountNonBlank                       := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.employer_address_4<>'',1,0));
    employer_address_5_CountNonBlank                       := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.employer_address_5<>'',1,0));
    employer_county_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.employer_county<>'',1,0));
    school_CountNonBlank                                   := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.school<>'',1,0));
    school_address_1_CountNonBlank                         := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.school_address_1<>'',1,0));
    school_address_2_CountNonBlank                         := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.school_address_2<>'',1,0));
    school_address_3_CountNonBlank                         := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.school_address_3<>'',1,0));
    school_address_4_CountNonBlank                         := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.school_address_4<>'',1,0));
    school_address_5_CountNonBlank                         := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.school_address_5<>'',1,0));
    school_county_CountNonBlank                            := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.school_county<>'',1,0));
    offender_id_CountNonBlank                              := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offender_id<>'',1,0));
    doc_number_CountNonBlank                               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.doc_number<>'',1,0));
    sor_number_CountNonBlank                               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.sor_number<>'',1,0));
    st_id_number_CountNonBlank                             := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.st_id_number<>'',1,0));
    fbi_number_CountNonBlank                               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.fbi_number<>'',1,0));
    ncic_number_CountNonBlank                              := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.ncic_number<>'',1,0));
    ssn_CountNonBlank                                      := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.ssn<>'',1,0));
    dob_CountNonBlank                                      := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.dob<>'',1,0));
    dob_aka_CountNonBlank                                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.dob_aka<>'',1,0));
    age_CountNonBlank                                      := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.age<>'',1,0));
    race_CountNonBlank                                     := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.race<>'',1,0));
    ethnicity_CountNonBlank                                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.ethnicity<>'',1,0));
    sex_CountNonBlank                                      := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.sex<>'',1,0));
    hair_color_CountNonBlank                               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.hair_color<>'',1,0));
    eye_color_CountNonBlank                                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.eye_color<>'',1,0));
    height_CountNonBlank                                   := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.height<>'',1,0));
    weight_CountNonBlank                                   := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.weight<>'',1,0));
    skin_tone_CountNonBlank                                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.skin_tone<>'',1,0));
    build_type_CountNonBlank                               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.build_type<>'',1,0));
    scars_marks_tattoos_CountNonBlank                      := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.scars_marks_tattoos<>'',1,0));
    shoe_size_CountNonBlank                                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.shoe_size<>'',1,0));
    corrective_lense_flag_CountNonBlank                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.corrective_lense_flag<>'',1,0));
    conviction_jurisdiction_1_CountNonBlank                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.conviction_jurisdiction_1<>'',1,0));
    conviction_date_1_CountNonBlank                        := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.conviction_date_1<>'',1,0));
    court_1_CountNonBlank                                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.court_1<>'',1,0));
    court_case_number_1_CountNonBlank                      := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.court_case_number_1<>'',1,0));
    offense_date_1_CountNonBlank                           := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_date_1<>'',1,0));
    offense_code_or_statute_1_CountNonBlank                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_code_or_statute_1<>'',1,0));
    offense_description_1_CountNonBlank                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_description_1<>'',1,0));
    offense_description_1_2_CountNonBlank                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_description_1_2<>'',1,0));
    victim_minor_1_CountNonBlank                           := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_minor_1<>'',1,0));
    victim_age_1_CountNonBlank                             := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_age_1<>'',1,0));
    victim_gender_1_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_gender_1<>'',1,0));
    victim_relationship_1_CountNonBlank                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_relationship_1<>'',1,0));
    sentence_description_1_CountNonBlank                   := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.sentence_description_1<>'',1,0));
    sentence_description_1_2_CountNonBlank                 := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.sentence_description_1_2<>'',1,0));
    conviction_jurisdiction_2_CountNonBlank                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.conviction_jurisdiction_2<>'',1,0));
    conviction_date_2_CountNonBlank                        := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.conviction_date_2<>'',1,0));
    court_2_CountNonBlank                                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.court_2<>'',1,0));
    court_case_number_2_CountNonBlank                      := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.court_case_number_2<>'',1,0));
    offense_date_2_CountNonBlank                           := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_date_2<>'',1,0));
    offense_code_or_statute_2_CountNonBlank                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_code_or_statute_2<>'',1,0));
    offense_description_2_CountNonBlank                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_description_2<>'',1,0));
    offense_description_2_2_CountNonBlank                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_description_2_2<>'',1,0));
    victim_minor_2_CountNonBlank                           := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_minor_2<>'',1,0));
    victim_age_2_CountNonBlank                             := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_age_2<>'',1,0));
    victim_gender_2_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_gender_2<>'',1,0));
    victim_relationship_2_CountNonBlank                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_relationship_2<>'',1,0));
    sentence_description_2_CountNonBlank                   := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.sentence_description_2<>'',1,0));
    sentence_description_2_2_CountNonBlank                 := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.sentence_description_2_2<>'',1,0));
    conviction_jurisdiction_3_CountNonBlank                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.conviction_jurisdiction_3<>'',1,0));
    conviction_date_3_CountNonBlank                        := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.conviction_date_3<>'',1,0));
    court_3_CountNonBlank                                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.court_3<>'',1,0));
    court_case_number_3_CountNonBlank                      := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.court_case_number_3<>'',1,0));
    offense_date_3_CountNonBlank                           := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_date_3<>'',1,0));
    offense_code_or_statute_3_CountNonBlank                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_code_or_statute_3<>'',1,0));
    offense_description_3_CountNonBlank                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_description_3<>'',1,0));
    offense_description_3_2_CountNonBlank                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_description_3_2<>'',1,0));
    victim_minor_3_CountNonBlank                           := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_minor_3<>'',1,0));
    victim_age_3_CountNonBlank                             := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_age_3<>'',1,0));
    victim_gender_3_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_gender_3<>'',1,0));
    victim_relationship_3_CountNonBlank                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_relationship_3<>'',1,0));
    sentence_description_3_CountNonBlank                   := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.sentence_description_3<>'',1,0));
    sentence_description_3_2_CountNonBlank                 := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.sentence_description_3_2<>'',1,0));
    conviction_jurisdiction_4_CountNonBlank                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.conviction_jurisdiction_4<>'',1,0));
    conviction_date_4_CountNonBlank                        := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.conviction_date_4<>'',1,0));
    court_4_CountNonBlank                                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.court_4<>'',1,0));
    court_case_number_4_CountNonBlank                      := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.court_case_number_4<>'',1,0));
    offense_date_4_CountNonBlank                           := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_date_4<>'',1,0));
    offense_code_or_statute_4_CountNonBlank                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_code_or_statute_4<>'',1,0));
    offense_description_4_CountNonBlank                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_description_4<>'',1,0));
    offense_description_4_2_CountNonBlank                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_description_4_2<>'',1,0));
    victim_minor_4_CountNonBlank                           := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_minor_4<>'',1,0));
    victim_age_4_CountNonBlank                             := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_age_4<>'',1,0));
    victim_gender_4_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_gender_4<>'',1,0));
    victim_relationship_4_CountNonBlank                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_relationship_4<>'',1,0));
    sentence_description_4_CountNonBlank                   := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.sentence_description_4<>'',1,0));
    sentence_description_4_2_CountNonBlank                 := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.sentence_description_4_2<>'',1,0));
    conviction_jurisdiction_5_CountNonBlank                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.conviction_jurisdiction_5<>'',1,0));
    conviction_date_5_CountNonBlank                        := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.conviction_date_5<>'',1,0));
    court_5_CountNonBlank                                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.court_5<>'',1,0));
    court_case_number_5_CountNonBlank                      := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.court_case_number_5<>'',1,0));
    offense_date_5_CountNonBlank                           := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_date_5<>'',1,0));
    offense_code_or_statute_5_CountNonBlank                := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_code_or_statute_5<>'',1,0));
    offense_description_5_CountNonBlank                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_description_5<>'',1,0));
    offense_description_5_2_CountNonBlank                  := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.offense_description_5_2<>'',1,0));
    victim_minor_5_CountNonBlank                           := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_minor_5<>'',1,0));
    victim_age_5_CountNonBlank                             := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_age_5<>'',1,0));
    victim_gender_5_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_gender_5<>'',1,0));
    victim_relationship_5_CountNonBlank                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.victim_relationship_5<>'',1,0));
    sentence_description_5_CountNonBlank                   := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.sentence_description_5<>'',1,0));
    sentence_description_5_2_CountNonBlank                 := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.sentence_description_5_2<>'',1,0));
    addl_comments_1_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.addl_comments_1<>'',1,0));
    addl_comments_2_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.addl_comments_2<>'',1,0));
    orig_dl_number_CountNonBlank                           := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.orig_dl_number<>'',1,0));
    orig_dl_state_CountNonBlank                            := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.orig_dl_state<>'',1,0));
    orig_veh_year_1_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.orig_veh_year_1<>'',1,0));
    orig_veh_color_1_CountNonBlank                         := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.orig_veh_color_1<>'',1,0));
    orig_veh_make_model_1_CountNonBlank                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.orig_veh_make_model_1<>'',1,0));
    orig_veh_plate_1_CountNonBlank                         := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.orig_veh_plate_1<>'',1,0));
    orig_veh_state_1_CountNonBlank                         := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.orig_veh_state_1<>'',1,0));
    orig_veh_year_2_CountNonBlank                          := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.orig_veh_year_2<>'',1,0));
    orig_veh_color_2_CountNonBlank                         := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.orig_veh_color_2<>'',1,0));
    orig_veh_make_model_2_CountNonBlank                    := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.orig_veh_make_model_2<>'',1,0));
    orig_veh_plate_2_CountNonBlank                         := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.orig_veh_plate_2<>'',1,0));
    orig_veh_state_2_CountNonBlank                         := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.orig_veh_state_2<>'',1,0));
    image_link_CountNonBlank                               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.image_link<>'',1,0));
    image_date_CountNonBlank                               := sum(group,if(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In.image_date<>'',1,0));
  end;

dPopulationStats_OKC_Sexual_Offenders__File_OKC_Cleaned_Accurint_In
	:= table(OKC_Sexual_Offenders.File_OKC_Cleaned_Accurint_In
			,rPopulationStats_OKC_Sexual_Offenders__File_OKC_Cleaned_Accurint_In
			,orig_state, source_file
			,few
			);

STRATA.createXMLStats(dPopulationStats_OKC_Sexual_Offenders__File_OKC_Cleaned_Accurint_In
					 ,'Sex Offenders'
					 ,'Accurint In'
					 ,pVersion
					 ,''
					 ,zOut
					 );

ENDMACRO;