EXPORT Out_File_Main_Stats_Population(pMain
                                     ,pOffenses
									 ,pImages
									 ,pVersion
									 ,zOut) := MACRO

import STRATA;

	#uniquename(rPopulationStats_SexOffender_file_Main);
	#uniquename(dPopulationStats_SexOffender_file_Main);
	#uniquename(zMain);
	#uniquename(rPopulationStats_File_Offenses);
	#uniquename(dPopulationStats_File_Offenses);
	#uniquename(zOffenses);
	#uniquename(rPopulationStats_File_Images);
	#uniquename(dPopulationStats_File_Images);
	#uniquename(zImages);

%rPopulationStats_SexOffender_file_Main%
 :=
  record
    CountGroup                                                                  := count(group);
    did_CountNonZero                                       := sum(group,if(pMain.did<>0,1,0));
    score_CountNonZero                                     := sum(group,if(pMain.score<>0,1,0));
    ssn_appended_CountNonBlank                             := sum(group,if(pMain.ssn_appended<>'',1,0));
    ssn_perms_CountNonZero                                 := sum(group,if(pMain.ssn_perms<>0,1,0));
    dt_first_reported_CountNonBlank                        := sum(group,if(pMain.dt_first_reported<>'',1,0));
    dt_last_reported_CountNonBlank                         := sum(group,if(pMain.dt_last_reported<>'',1,0));
    orig_state_CountNonBlank                               := sum(group,if(pMain.orig_state<>'',1,0));
    pMain.orig_state_code;
    seisint_primary_key_CountNonBlank                      := sum(group,if(pMain.seisint_primary_key<>'',1,0));
    vendor_code_CountNonBlank                              := sum(group,if(pMain.vendor_code<>'',1,0));
    pMain.source_file;
    record_type_CountNonBlank                              := sum(group,if(pMain.record_type<>'',1,0));
    name_orig_CountNonBlank                                := sum(group,if(pMain.name_orig<>'',1,0));
    lname_CountNonBlank                                    := sum(group,if(pMain.lname<>'',1,0));
    fname_CountNonBlank                                    := sum(group,if(pMain.fname<>'',1,0));
    mname_CountNonBlank                                    := sum(group,if(pMain.mname<>'',1,0));
    name_suffix_CountNonBlank                              := sum(group,if(pMain.name_suffix<>'',1,0));
    name_type_CountNonBlank                                := sum(group,if(pMain.name_type<>'',1,0));
    offender_status_CountNonBlank                          := sum(group,if(pMain.offender_status<>'',1,0));
    offender_category_CountNonBlank                        := sum(group,if(pMain.offender_category<>'',1,0));
    risk_level_code_CountNonBlank                          := sum(group,if(pMain.risk_level_code<>'',1,0));
    risk_description_CountNonBlank                         := sum(group,if(pMain.risk_description<>'',1,0));
    police_agency_CountNonBlank                            := sum(group,if(pMain.police_agency<>'',1,0));
    police_agency_contact_name_CountNonBlank               := sum(group,if(pMain.police_agency_contact_name<>'',1,0));
    police_agency_address_1_CountNonBlank                  := sum(group,if(pMain.police_agency_address_1<>'',1,0));
    police_agency_address_2_CountNonBlank                  := sum(group,if(pMain.police_agency_address_2<>'',1,0));
    police_agency_phone_CountNonBlank                      := sum(group,if(pMain.police_agency_phone<>'',1,0));
    registration_type_CountNonBlank                        := sum(group,if(pMain.registration_type<>'',1,0));
    reg_date_1_CountNonBlank                               := sum(group,if(pMain.reg_date_1<>'',1,0));
    reg_date_1_type_CountNonBlank                          := sum(group,if(pMain.reg_date_1_type<>'',1,0));
    reg_date_2_CountNonBlank                               := sum(group,if(pMain.reg_date_2<>'',1,0));
    reg_date_2_type_CountNonBlank                          := sum(group,if(pMain.reg_date_2_type<>'',1,0));
    reg_date_3_CountNonBlank                               := sum(group,if(pMain.reg_date_3<>'',1,0));
    reg_date_3_type_CountNonBlank                          := sum(group,if(pMain.reg_date_3_type<>'',1,0));
    registration_address_1_CountNonBlank                   := sum(group,if(pMain.registration_address_1<>'',1,0));
    registration_address_2_CountNonBlank                   := sum(group,if(pMain.registration_address_2<>'',1,0));
    registration_address_3_CountNonBlank                   := sum(group,if(pMain.registration_address_3<>'',1,0));
    registration_address_4_CountNonBlank                   := sum(group,if(pMain.registration_address_4<>'',1,0));
    registration_address_5_CountNonBlank                   := sum(group,if(pMain.registration_address_5<>'',1,0));
    registration_county_CountNonBlank                      := sum(group,if(pMain.registration_county<>'',1,0));
    employer_CountNonBlank                                 := sum(group,if(pMain.employer<>'',1,0));
    employer_address_1_CountNonBlank                       := sum(group,if(pMain.employer_address_1<>'',1,0));
    employer_address_2_CountNonBlank                       := sum(group,if(pMain.employer_address_2<>'',1,0));
    employer_address_3_CountNonBlank                       := sum(group,if(pMain.employer_address_3<>'',1,0));
    employer_address_4_CountNonBlank                       := sum(group,if(pMain.employer_address_4<>'',1,0));
    employer_address_5_CountNonBlank                       := sum(group,if(pMain.employer_address_5<>'',1,0));
    employer_county_CountNonBlank                          := sum(group,if(pMain.employer_county<>'',1,0));
    school_CountNonBlank                                   := sum(group,if(pMain.school<>'',1,0));
    school_address_1_CountNonBlank                         := sum(group,if(pMain.school_address_1<>'',1,0));
    school_address_2_CountNonBlank                         := sum(group,if(pMain.school_address_2<>'',1,0));
    school_address_3_CountNonBlank                         := sum(group,if(pMain.school_address_3<>'',1,0));
    school_address_4_CountNonBlank                         := sum(group,if(pMain.school_address_4<>'',1,0));
    school_address_5_CountNonBlank                         := sum(group,if(pMain.school_address_5<>'',1,0));
    school_county_CountNonBlank                            := sum(group,if(pMain.school_county<>'',1,0));
    offender_id_CountNonBlank                              := sum(group,if(pMain.offender_id<>'',1,0));
    doc_number_CountNonBlank                               := sum(group,if(pMain.doc_number<>'',1,0));
    sor_number_CountNonBlank                               := sum(group,if(pMain.sor_number<>'',1,0));
    st_id_number_CountNonBlank                             := sum(group,if(pMain.st_id_number<>'',1,0));
    fbi_number_CountNonBlank                               := sum(group,if(pMain.fbi_number<>'',1,0));
    ncic_number_CountNonBlank                              := sum(group,if(pMain.ncic_number<>'',1,0));
    ssn_CountNonBlank                                      := sum(group,if(pMain.ssn<>'',1,0));
    dob_CountNonBlank                                      := sum(group,if(pMain.dob<>'',1,0));
    dob_aka_CountNonBlank                                  := sum(group,if(pMain.dob_aka<>'',1,0));
    age_CountNonBlank                                      := sum(group,if(pMain.age<>'',1,0));
    race_CountNonBlank                                     := sum(group,if(pMain.race<>'',1,0));
    ethnicity_CountNonBlank                                := sum(group,if(pMain.ethnicity<>'',1,0));
    sex_CountNonBlank                                      := sum(group,if(pMain.sex<>'',1,0));
    hair_color_CountNonBlank                               := sum(group,if(pMain.hair_color<>'',1,0));
    eye_color_CountNonBlank                                := sum(group,if(pMain.eye_color<>'',1,0));
    height_CountNonBlank                                   := sum(group,if(pMain.height<>'',1,0));
    weight_CountNonBlank                                   := sum(group,if(pMain.weight<>'',1,0));
    skin_tone_CountNonBlank                                := sum(group,if(pMain.skin_tone<>'',1,0));
    build_type_CountNonBlank                               := sum(group,if(pMain.build_type<>'',1,0));
    scars_marks_tattoos_CountNonBlank                      := sum(group,if(pMain.scars_marks_tattoos<>'',1,0));
    shoe_size_CountNonBlank                                := sum(group,if(pMain.shoe_size<>'',1,0));
    corrective_lense_flag_CountNonBlank                    := sum(group,if(pMain.corrective_lense_flag<>'',1,0));
    addl_comments_1_CountNonBlank                          := sum(group,if(pMain.addl_comments_1<>'',1,0));
    addl_comments_2_CountNonBlank                          := sum(group,if(pMain.addl_comments_2<>'',1,0));
    orig_dl_number_CountNonBlank                           := sum(group,if(pMain.orig_dl_number<>'',1,0));
    orig_dl_state_CountNonBlank                            := sum(group,if(pMain.orig_dl_state<>'',1,0));
    orig_veh_year_1_CountNonBlank                          := sum(group,if(pMain.orig_veh_year_1<>'',1,0));
    orig_veh_color_1_CountNonBlank                         := sum(group,if(pMain.orig_veh_color_1<>'',1,0));
    orig_veh_make_model_1_CountNonBlank                    := sum(group,if(pMain.orig_veh_make_model_1<>'',1,0));
    orig_veh_plate_1_CountNonBlank                         := sum(group,if(pMain.orig_veh_plate_1<>'',1,0));
    orig_veh_state_1_CountNonBlank                         := sum(group,if(pMain.orig_veh_state_1<>'',1,0));
    orig_veh_year_2_CountNonBlank                          := sum(group,if(pMain.orig_veh_year_2<>'',1,0));
    orig_veh_color_2_CountNonBlank                         := sum(group,if(pMain.orig_veh_color_2<>'',1,0));
    orig_veh_make_model_2_CountNonBlank                    := sum(group,if(pMain.orig_veh_make_model_2<>'',1,0));
    orig_veh_plate_2_CountNonBlank                         := sum(group,if(pMain.orig_veh_plate_2<>'',1,0));
    orig_veh_state_2_CountNonBlank                         := sum(group,if(pMain.orig_veh_state_2<>'',1,0));
    image_link_CountNonBlank                               := sum(group,if(pMain.image_link<>'',1,0));
    image_date_CountNonBlank                               := sum(group,if(pMain.image_date<>'',1,0));
    addr_dt_last_seen_CountNonBlank                        := sum(group,if(pMain.addr_dt_last_seen<>'',1,0));
    prim_range_CountNonBlank                               := sum(group,if(pMain.prim_range<>'',1,0));
    predir_CountNonBlank                                   := sum(group,if(pMain.predir<>'',1,0));
    prim_name_CountNonBlank                                := sum(group,if(pMain.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                              := sum(group,if(pMain.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                  := sum(group,if(pMain.postdir<>'',1,0));
    unit_desig_CountNonBlank                               := sum(group,if(pMain.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                := sum(group,if(pMain.sec_range<>'',1,0));
    p_city_name_CountNonBlank                              := sum(group,if(pMain.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                              := sum(group,if(pMain.v_city_name<>'',1,0));
    st_CountNonBlank                                       := sum(group,if(pMain.st<>'',1,0));
    zip5_CountNonBlank                                     := sum(group,if(pMain.zip5<>'',1,0));
    zip4_CountNonBlank                                     := sum(group,if(pMain.zip4<>'',1,0));
    clean_errors_CountNonZero                              := sum(group,if(pMain.clean_errors<>0,1,0));
  end;

%rPopulationStats_File_Offenses%
 :=
  record
    CountGroup                                          := count(group);
	string2 state                                       := pOffenses.Seisint_Primary_Key[3..4];
    Seisint_Primary_Key_CountNonBlank                   := sum(group,if(pOffenses.Seisint_Primary_Key<>'',1,0));
    conviction_jurisdiction_CountNonBlank               := sum(group,if(pOffenses.conviction_jurisdiction<>'',1,0));
    conviction_date_CountNonBlank                       := sum(group,if(pOffenses.conviction_date<>'',1,0));
    court_CountNonBlank                                 := sum(group,if(pOffenses.court<>'',1,0));
    court_case_number_CountNonBlank                     := sum(group,if(pOffenses.court_case_number<>'',1,0));
    offense_date_CountNonBlank                          := sum(group,if(pOffenses.offense_date<>'',1,0));
    offense_code_or_statute_CountNonBlank               := sum(group,if(pOffenses.offense_code_or_statute<>'',1,0));
    offense_description_CountNonBlank                   := sum(group,if(pOffenses.offense_description<>'',1,0));
    offense_description_2_CountNonBlank                 := sum(group,if(pOffenses.offense_description_2<>'',1,0));
    victim_minor_CountNonBlank                          := sum(group,if(pOffenses.victim_minor<>'',1,0));
    victim_age_CountNonBlank                            := sum(group,if(pOffenses.victim_age<>'',1,0));
    victim_gender_CountNonBlank                         := sum(group,if(pOffenses.victim_gender<>'',1,0));
    victim_relationship_CountNonBlank                   := sum(group,if(pOffenses.victim_relationship<>'',1,0));
    sentence_description_CountNonBlank                  := sum(group,if(pOffenses.sentence_description<>'',1,0));
    sentence_description_2_CountNonBlank                := sum(group,if(pOffenses.sentence_description_2<>'',1,0));
  end;

%rPopulationStats_File_Images%
 :=
  record
    CountGroup                             := count(group);
    did_CountNonZero                       := sum(group,if(pImages.did<>0,1,0));
    pImages.state;
    rtype_CountNonBlank                    := sum(group,if(pImages.rtype<>'',1,0));
    id_CountNonBlank                       := sum(group,if(pImages.id<>'',1,0));
    seq_CountNonZero                       := sum(group,if(pImages.seq<>0,1,0));
    date_CountNonBlank                     := sum(group,if(pImages.date<>'',1,0));
    num_CountNonZero                       := sum(group,if(pImages.num<>0,1,0));
    image_link_CountNonBlank               := sum(group,if(pImages.image_link<>'',1,0));
    imgLength_CountNonZero                 := sum(group,if(pImages.imgLength<>0,1,0));
  end;

// Create the Main table and run the STRATA statistics
%dPopulationStats_SexOffender_file_Main% := table(pMain
											     ,%rPopulationStats_SexOffender_file_Main%
											     ,orig_state_code
											     ,source_file
											     ,few);
STRATA.createXMLStats(%dPopulationStats_SexOffender_file_Main%
					 ,'Sex Offender'
					 ,'Main file'
					 ,pVersion
					 ,''
					 ,%zMain%);
// Create the Offenses table and run the STRATA statistics
%dPopulationStats_File_Offenses% := table(pOffenses
								  	     ,%rPopulationStats_File_Offenses%
										 ,Seisint_Primary_Key[3..4]
									     ,few);
STRATA.createXMLStats(%dPopulationStats_File_Offenses%
					 ,'Sex Offender'
					 ,'Offenses V2'
					 ,pVersion
					 ,''
					 ,%zOffenses%);

%dPopulationStats_File_Images% := table(pImages
								  	   ,%rPopulationStats_File_Images%
									   ,state
									   ,few);
STRATA.createXMLStats(%dPopulationStats_File_Images%
					 ,'Sex Offender'
					 ,'Images'
					 ,pVersion
					 ,''
					 ,%zImages%);

zOut := parallel(%zMain%
                 ,%zOffenses%
				 ,%zImages%
				 );

ENDMACRO;