export Out_Population_Stats(pParty        // Party file against which stats are to be run
						   ,pMatter       // Matter file against which stats are to be run
                           ,pCaseActivity // Case Activity file against which stats are to be run
						   ,pVersion      // The version of the dataset against which the stats are run
						   ,zOut)         // Output of the population stats
 := MACRO

import STRATA;

	#uniquename(rPopulationStats_pParty);
	#uniquename(dPopulationStats_pParty);
	#uniquename(zPartyStats);
	#uniquename(rPopulationStats_pCaseActivity);
	#uniquename(dPopulationStats_pCaseActivity);
	#uniquename(zCaseActivityStats);
	#uniquename(rPopulationStats_pMatter);
	#uniquename(dPopulationStats_pMatter);
	#uniquename(zMatterStats);

%rPopulationStats_pParty%
 :=
  record
    CountGroup                                                 := count(group);
    dt_first_reported_CountNonBlank                            := sum(group,if(pParty.dt_first_reported<>'',1,0));
    dt_last_reported_CountNonBlank                             := sum(group,if(pParty.dt_last_reported<>'',1,0));
    process_date_CountNonBlank								   := sum(group,if(pParty.process_date<>'',1,0));
    pParty.vendor;
    pParty.state_origin;
    source_file_CountNonBlank                                  := sum(group,if(pParty.source_file<>'',1,0));
    case_key_CountNonBlank                                     := sum(group,if(pParty.case_key<>'',1,0));
    parent_case_key_CountNonBlank                              := sum(group,if(pParty.parent_case_key<>'',1,0));
    court_code_CountNonBlank                                   := sum(group,if(pParty.court_code<>'',1,0));
    court_CountNonBlank                                        := sum(group,if(pParty.court<>'',1,0));
    case_number_CountNonBlank                                  := sum(group,if(pParty.case_number<>'',1,0));
    case_type_code_CountNonBlank                               := sum(group,if(pParty.case_type_code<>'',1,0));
    case_type_CountNonBlank                                    := sum(group,if(pParty.case_type<>'',1,0));
    case_title_CountNonBlank                                   := sum(group,if(pParty.case_title<>'',1,0));
    ruled_for_against_code_CountNonBlank                       := sum(group,if(pParty.ruled_for_against_code<>'',1,0));
    ruled_for_against_CountNonBlank                            := sum(group,if(pParty.ruled_for_against<>'',1,0));
    entity_1_CountNonBlank                                     := sum(group,if(pParty.entity_1<>'',1,0));
    entity_nm_format_1_CountNonBlank                           := sum(group,if(pParty.entity_nm_format_1<>'',1,0));
    entity_type_code_1_orig_CountNonBlank                      := sum(group,if(pParty.entity_type_code_1_orig<>'',1,0));
    entity_type_description_1_orig_CountNonBlank               := sum(group,if(pParty.entity_type_description_1_orig<>'',1,0));
    entity_type_code_1_master_CountNonBlank                    := sum(group,if(pParty.entity_type_code_1_master<>'',1,0));
    entity_seq_num_1_CountNonBlank                             := sum(group,if(pParty.entity_seq_num_1<>'',1,0));
    atty_seq_num_1_CountNonBlank                               := sum(group,if(pParty.atty_seq_num_1<>'',1,0));
    entity_1_address_1_CountNonBlank                           := sum(group,if(pParty.entity_1_address_1<>'',1,0));
    entity_1_address_2_CountNonBlank                           := sum(group,if(pParty.entity_1_address_2<>'',1,0));
    entity_1_address_3_CountNonBlank                           := sum(group,if(pParty.entity_1_address_3<>'',1,0));
    entity_1_address_4_CountNonBlank                           := sum(group,if(pParty.entity_1_address_4<>'',1,0));
    entity_1_dob_CountNonBlank                                 := sum(group,if(pParty.entity_1_dob<>'',1,0));
    primary_entity_2_CountNonBlank                             := sum(group,if(pParty.primary_entity_2<>'',1,0));
    entity_nm_format_2_CountNonBlank                           := sum(group,if(pParty.entity_nm_format_2<>'',1,0));
    entity_type_code_2_orig_CountNonBlank                      := sum(group,if(pParty.entity_type_code_2_orig<>'',1,0));
    entity_type_description_2_orig_CountNonBlank               := sum(group,if(pParty.entity_type_description_2_orig<>'',1,0));
    entity_type_code_2_master_CountNonBlank                    := sum(group,if(pParty.entity_type_code_2_master<>'',1,0));
    entity_seq_num_2_CountNonBlank                             := sum(group,if(pParty.entity_seq_num_2<>'',1,0));
    atty_seq_num_2_CountNonBlank                               := sum(group,if(pParty.atty_seq_num_2<>'',1,0));
    entity_2_address_1_CountNonBlank                           := sum(group,if(pParty.entity_2_address_1<>'',1,0));
    entity_2_address_2_CountNonBlank                           := sum(group,if(pParty.entity_2_address_2<>'',1,0));
    entity_2_address_3_CountNonBlank                           := sum(group,if(pParty.entity_2_address_3<>'',1,0));
    entity_2_address_4_CountNonBlank                           := sum(group,if(pParty.entity_2_address_4<>'',1,0));
    entity_2_dob_CountNonBlank                                 := sum(group,if(pParty.entity_2_dob<>'',1,0));
    prim_range1_CountNonBlank                                  := sum(group,if(pParty.prim_range1<>'',1,0));
    predir1_CountNonBlank                                      := sum(group,if(pParty.predir1<>'',1,0));
    prim_name1_CountNonBlank                                   := sum(group,if(pParty.prim_name1<>'',1,0));
    addr_suffix1_CountNonBlank                                 := sum(group,if(pParty.addr_suffix1<>'',1,0));
    postdir1_CountNonBlank                                     := sum(group,if(pParty.postdir1<>'',1,0));
    unit_desig1_CountNonBlank                                  := sum(group,if(pParty.unit_desig1<>'',1,0));
    sec_range1_CountNonBlank                                   := sum(group,if(pParty.sec_range1<>'',1,0));
    p_city_name1_CountNonBlank                                 := sum(group,if(pParty.p_city_name1<>'',1,0));
    v_city_name1_CountNonBlank                                 := sum(group,if(pParty.v_city_name1<>'',1,0));
    st1_CountNonBlank                                          := sum(group,if(pParty.st1<>'',1,0));
    zip1_CountNonBlank                                         := sum(group,if(pParty.zip1<>'',1,0));
    zip41_CountNonBlank                                        := sum(group,if(pParty.zip41<>'',1,0));
    cart1_CountNonBlank                                        := sum(group,if(pParty.cart1<>'',1,0));
    cr_sort_sz1_CountNonBlank                                  := sum(group,if(pParty.cr_sort_sz1<>'',1,0));
    lot1_CountNonBlank                                         := sum(group,if(pParty.lot1<>'',1,0));
    lot_order1_CountNonBlank                                   := sum(group,if(pParty.lot_order1<>'',1,0));
    dpbc1_CountNonBlank                                        := sum(group,if(pParty.dpbc1<>'',1,0));
    chk_digit1_CountNonBlank                                   := sum(group,if(pParty.chk_digit1<>'',1,0));
    rec_type1_CountNonBlank                                    := sum(group,if(pParty.rec_type1<>'',1,0));
    ace_fips_st1_CountNonBlank                                 := sum(group,if(pParty.ace_fips_st1<>'',1,0));
    ace_fips_county1_CountNonBlank                             := sum(group,if(pParty.ace_fips_county1<>'',1,0));
    geo_lat1_CountNonBlank                                     := sum(group,if(pParty.geo_lat1<>'',1,0));
    geo_long1_CountNonBlank                                    := sum(group,if(pParty.geo_long1<>'',1,0));
    msa1_CountNonBlank                                         := sum(group,if(pParty.msa1<>'',1,0));
    geo_blk1_CountNonBlank                                     := sum(group,if(pParty.geo_blk1<>'',1,0));
    geo_match1_CountNonBlank                                   := sum(group,if(pParty.geo_match1<>'',1,0));
    err_stat1_CountNonBlank                                    := sum(group,if(pParty.err_stat1<>'',1,0));
    prim_range2_CountNonBlank                                  := sum(group,if(pParty.prim_range2<>'',1,0));
    predir2_CountNonBlank                                      := sum(group,if(pParty.predir2<>'',1,0));
    prim_name2_CountNonBlank                                   := sum(group,if(pParty.prim_name2<>'',1,0));
    addr_suffix2_CountNonBlank                                 := sum(group,if(pParty.addr_suffix2<>'',1,0));
    postdir2_CountNonBlank                                     := sum(group,if(pParty.postdir2<>'',1,0));
    unit_desig2_CountNonBlank                                  := sum(group,if(pParty.unit_desig2<>'',1,0));
    sec_range2_CountNonBlank                                   := sum(group,if(pParty.sec_range2<>'',1,0));
    p_city_name2_CountNonBlank                                 := sum(group,if(pParty.p_city_name2<>'',1,0));
    v_city_name2_CountNonBlank                                 := sum(group,if(pParty.v_city_name2<>'',1,0));
    st2_CountNonBlank                                          := sum(group,if(pParty.st2<>'',1,0));
    zip2_CountNonBlank                                         := sum(group,if(pParty.zip2<>'',1,0));
    zip42_CountNonBlank                                        := sum(group,if(pParty.zip42<>'',1,0));
    cart2_CountNonBlank                                        := sum(group,if(pParty.cart2<>'',1,0));
    cr_sort_sz2_CountNonBlank                                  := sum(group,if(pParty.cr_sort_sz2<>'',1,0));
    lot2_CountNonBlank                                         := sum(group,if(pParty.lot2<>'',1,0));
    lot_order2_CountNonBlank                                   := sum(group,if(pParty.lot_order2<>'',1,0));
    dpbc2_CountNonBlank                                        := sum(group,if(pParty.dpbc2<>'',1,0));
    chk_digit2_CountNonBlank                                   := sum(group,if(pParty.chk_digit2<>'',1,0));
    rec_type2_CountNonBlank                                    := sum(group,if(pParty.rec_type2<>'',1,0));
    ace_fips_st2_CountNonBlank                                 := sum(group,if(pParty.ace_fips_st2<>'',1,0));
    ace_fips_county2_CountNonBlank                             := sum(group,if(pParty.ace_fips_county2<>'',1,0));
    geo_lat2_CountNonBlank                                     := sum(group,if(pParty.geo_lat2<>'',1,0));
    geo_long2_CountNonBlank                                    := sum(group,if(pParty.geo_long2<>'',1,0));
    msa2_CountNonBlank                                         := sum(group,if(pParty.msa2<>'',1,0));
    geo_blk2_CountNonBlank                                     := sum(group,if(pParty.geo_blk2<>'',1,0));
    geo_match2_CountNonBlank                                   := sum(group,if(pParty.geo_match2<>'',1,0));
    err_stat2_CountNonBlank                                    := sum(group,if(pParty.err_stat2<>'',1,0));
    e1_title1_CountNonBlank                                    := sum(group,if(pParty.e1_title1<>'',1,0));
    e1_fname1_CountNonBlank                                    := sum(group,if(pParty.e1_fname1<>'',1,0));
    e1_mname1_CountNonBlank                                    := sum(group,if(pParty.e1_mname1<>'',1,0));
    e1_lname1_CountNonBlank                                    := sum(group,if(pParty.e1_lname1<>'',1,0));
    e1_suffix1_CountNonBlank                                   := sum(group,if(pParty.e1_suffix1<>'',1,0));
    e1_pname1_score_CountNonBlank                              := sum(group,if(pParty.e1_pname1_score<>'',1,0));
    e1_cname1_CountNonBlank                                    := sum(group,if(pParty.e1_cname1<>'',1,0));
    e1_title2_CountNonBlank                                    := sum(group,if(pParty.e1_title2<>'',1,0));
    e1_fname2_CountNonBlank                                    := sum(group,if(pParty.e1_fname2<>'',1,0));
    e1_mname2_CountNonBlank                                    := sum(group,if(pParty.e1_mname2<>'',1,0));
    e1_lname2_CountNonBlank                                    := sum(group,if(pParty.e1_lname2<>'',1,0));
    e1_suffix2_CountNonBlank                                   := sum(group,if(pParty.e1_suffix2<>'',1,0));
    e1_pname2_score_CountNonBlank                              := sum(group,if(pParty.e1_pname2_score<>'',1,0));
    e1_cname2_CountNonBlank                                    := sum(group,if(pParty.e1_cname2<>'',1,0));
    e1_title3_CountNonBlank                                    := sum(group,if(pParty.e1_title3<>'',1,0));
    e1_fname3_CountNonBlank                                    := sum(group,if(pParty.e1_fname3<>'',1,0));
    e1_mname3_CountNonBlank                                    := sum(group,if(pParty.e1_mname3<>'',1,0));
    e1_lname3_CountNonBlank                                    := sum(group,if(pParty.e1_lname3<>'',1,0));
    e1_suffix3_CountNonBlank                                   := sum(group,if(pParty.e1_suffix3<>'',1,0));
    e1_pname3_score_CountNonBlank                              := sum(group,if(pParty.e1_pname3_score<>'',1,0));
    e1_cname3_CountNonBlank                                    := sum(group,if(pParty.e1_cname3<>'',1,0));
    e1_title4_CountNonBlank                                    := sum(group,if(pParty.e1_title4<>'',1,0));
    e1_fname4_CountNonBlank                                    := sum(group,if(pParty.e1_fname4<>'',1,0));
    e1_mname4_CountNonBlank                                    := sum(group,if(pParty.e1_mname4<>'',1,0));
    e1_lname4_CountNonBlank                                    := sum(group,if(pParty.e1_lname4<>'',1,0));
    e1_suffix4_CountNonBlank                                   := sum(group,if(pParty.e1_suffix4<>'',1,0));
    e1_pname4_score_CountNonBlank                              := sum(group,if(pParty.e1_pname4_score<>'',1,0));
    e1_cname4_CountNonBlank                                    := sum(group,if(pParty.e1_cname4<>'',1,0));
    e1_title5_CountNonBlank                                    := sum(group,if(pParty.e1_title5<>'',1,0));
    e1_fname5_CountNonBlank                                    := sum(group,if(pParty.e1_fname5<>'',1,0));
    e1_mname5_CountNonBlank                                    := sum(group,if(pParty.e1_mname5<>'',1,0));
    e1_lname5_CountNonBlank                                    := sum(group,if(pParty.e1_lname5<>'',1,0));
    e1_suffix5_CountNonBlank                                   := sum(group,if(pParty.e1_suffix5<>'',1,0));
    e1_pname5_score_CountNonBlank                              := sum(group,if(pParty.e1_pname5_score<>'',1,0));
    e1_cname5_CountNonBlank                                    := sum(group,if(pParty.e1_cname5<>'',1,0));
    e2_title1_CountNonBlank                                    := sum(group,if(pParty.e2_title1<>'',1,0));
    e2_fname1_CountNonBlank                                    := sum(group,if(pParty.e2_fname1<>'',1,0));
    e2_mname1_CountNonBlank                                    := sum(group,if(pParty.e2_mname1<>'',1,0));
    e2_lname1_CountNonBlank                                    := sum(group,if(pParty.e2_lname1<>'',1,0));
    e2_suffix1_CountNonBlank                                   := sum(group,if(pParty.e2_suffix1<>'',1,0));
    e2_pname1_score_CountNonBlank                              := sum(group,if(pParty.e2_pname1_score<>'',1,0));
    e2_cname1_CountNonBlank                                    := sum(group,if(pParty.e2_cname1<>'',1,0));
    e2_title2_CountNonBlank                                    := sum(group,if(pParty.e2_title2<>'',1,0));
    e2_fname2_CountNonBlank                                    := sum(group,if(pParty.e2_fname2<>'',1,0));
    e2_mname2_CountNonBlank                                    := sum(group,if(pParty.e2_mname2<>'',1,0));
    e2_lname2_CountNonBlank                                    := sum(group,if(pParty.e2_lname2<>'',1,0));
    e2_suffix2_CountNonBlank                                   := sum(group,if(pParty.e2_suffix2<>'',1,0));
    e2_pname2_score_CountNonBlank                              := sum(group,if(pParty.e2_pname2_score<>'',1,0));
    e2_cname2_CountNonBlank                                    := sum(group,if(pParty.e2_cname2<>'',1,0));
    e2_title3_CountNonBlank                                    := sum(group,if(pParty.e2_title3<>'',1,0));
    e2_fname3_CountNonBlank                                    := sum(group,if(pParty.e2_fname3<>'',1,0));
    e2_mname3_CountNonBlank                                    := sum(group,if(pParty.e2_mname3<>'',1,0));
    e2_lname3_CountNonBlank                                    := sum(group,if(pParty.e2_lname3<>'',1,0));
    e2_suffix3_CountNonBlank                                   := sum(group,if(pParty.e2_suffix3<>'',1,0));
    e2_pname3_score_CountNonBlank                              := sum(group,if(pParty.e2_pname3_score<>'',1,0));
    e2_cname3_CountNonBlank                                    := sum(group,if(pParty.e2_cname3<>'',1,0));
    e2_title4_CountNonBlank                                    := sum(group,if(pParty.e2_title4<>'',1,0));
    e2_fname4_CountNonBlank                                    := sum(group,if(pParty.e2_fname4<>'',1,0));
    e2_mname4_CountNonBlank                                    := sum(group,if(pParty.e2_mname4<>'',1,0));
    e2_lname4_CountNonBlank                                    := sum(group,if(pParty.e2_lname4<>'',1,0));
    e2_suffix4_CountNonBlank                                   := sum(group,if(pParty.e2_suffix4<>'',1,0));
    e2_pname4_score_CountNonBlank                              := sum(group,if(pParty.e2_pname4_score<>'',1,0));
    e2_cname4_CountNonBlank                                    := sum(group,if(pParty.e2_cname4<>'',1,0));
    e2_title5_CountNonBlank                                    := sum(group,if(pParty.e2_title5<>'',1,0));
    e2_fname5_CountNonBlank                                    := sum(group,if(pParty.e2_fname5<>'',1,0));
    e2_mname5_CountNonBlank                                    := sum(group,if(pParty.e2_mname5<>'',1,0));
    e2_lname5_CountNonBlank                                    := sum(group,if(pParty.e2_lname5<>'',1,0));
    e2_suffix5_CountNonBlank                                   := sum(group,if(pParty.e2_suffix5<>'',1,0));
    e2_pname5_score_CountNonBlank                              := sum(group,if(pParty.e2_pname5_score<>'',1,0));
    e2_cname5_CountNonBlank                                    := sum(group,if(pParty.e2_cname5<>'',1,0));
    v1_title1_CountNonBlank                                    := sum(group,if(pParty.v1_title1<>'',1,0));
    v1_fname1_CountNonBlank                                    := sum(group,if(pParty.v1_fname1<>'',1,0));
    v1_mname1_CountNonBlank                                    := sum(group,if(pParty.v1_mname1<>'',1,0));
    v1_lname1_CountNonBlank                                    := sum(group,if(pParty.v1_lname1<>'',1,0));
    v1_suffix1_CountNonBlank                                   := sum(group,if(pParty.v1_suffix1<>'',1,0));
    v1_pname1_score_CountNonBlank                              := sum(group,if(pParty.v1_pname1_score<>'',1,0));
    v1_cname1_CountNonBlank                                    := sum(group,if(pParty.v1_cname1<>'',1,0));
    v1_title2_CountNonBlank                                    := sum(group,if(pParty.v1_title2<>'',1,0));
    v1_fname2_CountNonBlank                                    := sum(group,if(pParty.v1_fname2<>'',1,0));
    v1_mname2_CountNonBlank                                    := sum(group,if(pParty.v1_mname2<>'',1,0));
    v1_lname2_CountNonBlank                                    := sum(group,if(pParty.v1_lname2<>'',1,0));
    v1_suffix2_CountNonBlank                                   := sum(group,if(pParty.v1_suffix2<>'',1,0));
    v1_pname2_score_CountNonBlank                              := sum(group,if(pParty.v1_pname2_score<>'',1,0));
    v1_cname2_CountNonBlank                                    := sum(group,if(pParty.v1_cname2<>'',1,0));
    v1_title3_CountNonBlank                                    := sum(group,if(pParty.v1_title3<>'',1,0));
    v1_fname3_CountNonBlank                                    := sum(group,if(pParty.v1_fname3<>'',1,0));
    v1_mname3_CountNonBlank                                    := sum(group,if(pParty.v1_mname3<>'',1,0));
    v1_lname3_CountNonBlank                                    := sum(group,if(pParty.v1_lname3<>'',1,0));
    v1_suffix3_CountNonBlank                                   := sum(group,if(pParty.v1_suffix3<>'',1,0));
    v1_pname3_score_CountNonBlank                              := sum(group,if(pParty.v1_pname3_score<>'',1,0));
    v1_cname3_CountNonBlank                                    := sum(group,if(pParty.v1_cname3<>'',1,0));
    v1_title4_CountNonBlank                                    := sum(group,if(pParty.v1_title4<>'',1,0));
    v1_fname4_CountNonBlank                                    := sum(group,if(pParty.v1_fname4<>'',1,0));
    v1_mname4_CountNonBlank                                    := sum(group,if(pParty.v1_mname4<>'',1,0));
    v1_lname4_CountNonBlank                                    := sum(group,if(pParty.v1_lname4<>'',1,0));
    v1_suffix4_CountNonBlank                                   := sum(group,if(pParty.v1_suffix4<>'',1,0));
    v1_pname4_score_CountNonBlank                              := sum(group,if(pParty.v1_pname4_score<>'',1,0));
    v1_cname4_CountNonBlank                                    := sum(group,if(pParty.v1_cname4<>'',1,0));
    v1_title5_CountNonBlank                                    := sum(group,if(pParty.v1_title5<>'',1,0));
    v1_fname5_CountNonBlank                                    := sum(group,if(pParty.v1_fname5<>'',1,0));
    v1_mname5_CountNonBlank                                    := sum(group,if(pParty.v1_mname5<>'',1,0));
    v1_lname5_CountNonBlank                                    := sum(group,if(pParty.v1_lname5<>'',1,0));
    v1_suffix5_CountNonBlank                                   := sum(group,if(pParty.v1_suffix5<>'',1,0));
    v1_pname5_score_CountNonBlank                              := sum(group,if(pParty.v1_pname5_score<>'',1,0));
    v1_cname5_CountNonBlank                                    := sum(group,if(pParty.v1_cname5<>'',1,0));
    v2_title1_CountNonBlank                                    := sum(group,if(pParty.v2_title1<>'',1,0));
    v2_fname1_CountNonBlank                                    := sum(group,if(pParty.v2_fname1<>'',1,0));
    v2_mname1_CountNonBlank                                    := sum(group,if(pParty.v2_mname1<>'',1,0));
    v2_lname1_CountNonBlank                                    := sum(group,if(pParty.v2_lname1<>'',1,0));
    v2_suffix1_CountNonBlank                                   := sum(group,if(pParty.v2_suffix1<>'',1,0));
    v2_pname1_score_CountNonBlank                              := sum(group,if(pParty.v2_pname1_score<>'',1,0));
    v2_cname1_CountNonBlank                                    := sum(group,if(pParty.v2_cname1<>'',1,0));
    v2_title2_CountNonBlank                                    := sum(group,if(pParty.v2_title2<>'',1,0));
    v2_fname2_CountNonBlank                                    := sum(group,if(pParty.v2_fname2<>'',1,0));
    v2_mname2_CountNonBlank                                    := sum(group,if(pParty.v2_mname2<>'',1,0));
    v2_lname2_CountNonBlank                                    := sum(group,if(pParty.v2_lname2<>'',1,0));
    v2_suffix2_CountNonBlank                                   := sum(group,if(pParty.v2_suffix2<>'',1,0));
    v2_pname2_score_CountNonBlank                              := sum(group,if(pParty.v2_pname2_score<>'',1,0));
    v2_cname2_CountNonBlank                                    := sum(group,if(pParty.v2_cname2<>'',1,0));
    v2_title3_CountNonBlank                                    := sum(group,if(pParty.v2_title3<>'',1,0));
    v2_fname3_CountNonBlank                                    := sum(group,if(pParty.v2_fname3<>'',1,0));
    v2_mname3_CountNonBlank                                    := sum(group,if(pParty.v2_mname3<>'',1,0));
    v2_lname3_CountNonBlank                                    := sum(group,if(pParty.v2_lname3<>'',1,0));
    v2_suffix3_CountNonBlank                                   := sum(group,if(pParty.v2_suffix3<>'',1,0));
    v2_pname3_score_CountNonBlank                              := sum(group,if(pParty.v2_pname3_score<>'',1,0));
    v2_cname3_CountNonBlank                                    := sum(group,if(pParty.v2_cname3<>'',1,0));
    v2_title4_CountNonBlank                                    := sum(group,if(pParty.v2_title4<>'',1,0));
    v2_fname4_CountNonBlank                                    := sum(group,if(pParty.v2_fname4<>'',1,0));
    v2_mname4_CountNonBlank                                    := sum(group,if(pParty.v2_mname4<>'',1,0));
    v2_lname4_CountNonBlank                                    := sum(group,if(pParty.v2_lname4<>'',1,0));
    v2_suffix4_CountNonBlank                                   := sum(group,if(pParty.v2_suffix4<>'',1,0));
    v2_pname4_score_CountNonBlank                              := sum(group,if(pParty.v2_pname4_score<>'',1,0));
    v2_cname4_CountNonBlank                                    := sum(group,if(pParty.v2_cname4<>'',1,0));
    v2_title5_CountNonBlank                                    := sum(group,if(pParty.v2_title5<>'',1,0));
    v2_fname5_CountNonBlank                                    := sum(group,if(pParty.v2_fname5<>'',1,0));
    v2_mname5_CountNonBlank                                    := sum(group,if(pParty.v2_mname5<>'',1,0));
    v2_lname5_CountNonBlank                                    := sum(group,if(pParty.v2_lname5<>'',1,0));
    v2_suffix5_CountNonBlank                                   := sum(group,if(pParty.v2_suffix5<>'',1,0));
    v2_pname5_score_CountNonBlank                              := sum(group,if(pParty.v2_pname5_score<>'',1,0));
    v2_cname5_CountNonBlank                                    := sum(group,if(pParty.v2_cname5<>'',1,0));
  end;

%rPopulationStats_pCaseActivity%
 :=
  record
    CountGroup                                           := count(group);
    dt_first_reported_CountNonBlank                      := sum(group,if(pCaseActivity.dt_first_reported<>'',1,0));
    dt_last_reported_CountNonBlank                       := sum(group,if(pCaseActivity.dt_last_reported<>'',1,0));
    process_date_CountNonBlank							 := sum(group,if(pCaseActivity.process_date<>'',1,0));
    pCaseActivity.vendor;
    pCaseActivity.state_origin;
    source_file_CountNonBlank                            := sum(group,if(pCaseActivity.source_file<>'',1,0));
    case_key_CountNonBlank                               := sum(group,if(pCaseActivity.case_key<>'',1,0));
    court_code_CountNonBlank                             := sum(group,if(pCaseActivity.court_code<>'',1,0));
    court_CountNonBlank                                  := sum(group,if(pCaseActivity.court<>'',1,0));
    case_number_CountNonBlank                            := sum(group,if(pCaseActivity.case_number<>'',1,0));
    event_date_CountNonBlank                             := sum(group,if(pCaseActivity.event_date<>'',1,0));
    event_type_code_CountNonBlank                        := sum(group,if(pCaseActivity.event_type_code<>'',1,0));
    event_type_description_1_CountNonBlank               := sum(group,if(pCaseActivity.event_type_description_1<>'',1,0));
    event_type_description_2_CountNonBlank               := sum(group,if(pCaseActivity.event_type_description_2<>'',1,0));
  end;

%rPopulationStats_pMatter%
 :=
  record
    CountGroup                                          := count(group);
    dt_first_reported_CountNonBlank                     := sum(group,if(pMatter.dt_first_reported<>'',1,0));
    dt_last_reported_CountNonBlank                      := sum(group,if(pMatter.dt_last_reported<>'',1,0));
    process_date_CountNonBlank							:= sum(group,if(pMatter.process_date<>'',1,0));
    pMatter.vendor;
    pMatter.state_origin;
    source_file_CountNonBlank                           := sum(group,if(pMatter.source_file<>'',1,0));
    case_key_CountNonBlank                              := sum(group,if(pMatter.case_key<>'',1,0));
    parent_case_key_CountNonBlank                       := sum(group,if(pMatter.parent_case_key<>'',1,0));
    court_code_CountNonBlank                            := sum(group,if(pMatter.court_code<>'',1,0));
    court_CountNonBlank                                 := sum(group,if(pMatter.court<>'',1,0));
    case_number_CountNonBlank                           := sum(group,if(pMatter.case_number<>'',1,0));
    case_type_code_CountNonBlank                        := sum(group,if(pMatter.case_type_code<>'',1,0));
    case_type_CountNonBlank                             := sum(group,if(pMatter.case_type<>'',1,0));
    case_title_CountNonBlank                            := sum(group,if(pMatter.case_title<>'',1,0));
    case_cause_code_CountNonBlank                       := sum(group,if(pMatter.case_cause_code<>'',1,0));
    case_cause_CountNonBlank                            := sum(group,if(pMatter.case_cause<>'',1,0));
    manner_of_filing_code_CountNonBlank                 := sum(group,if(pMatter.manner_of_filing_code<>'',1,0));
    manner_of_filing_CountNonBlank                      := sum(group,if(pMatter.manner_of_filing<>'',1,0));
    filing_date_CountNonBlank                           := sum(group,if(pMatter.filing_date<>'',1,0));
    manner_of_judgmt_code_CountNonBlank                 := sum(group,if(pMatter.manner_of_judgmt_code<>'',1,0));
    manner_of_judgmt_CountNonBlank                      := sum(group,if(pMatter.manner_of_judgmt<>'',1,0));
    judgmt_date_CountNonBlank                           := sum(group,if(pMatter.judgmt_date<>'',1,0));
    ruled_for_against_code_CountNonBlank                := sum(group,if(pMatter.ruled_for_against_code<>'',1,0));
    ruled_for_against_CountNonBlank                     := sum(group,if(pMatter.ruled_for_against<>'',1,0));
    judgmt_type_code_CountNonBlank                      := sum(group,if(pMatter.judgmt_type_code<>'',1,0));
    judgmt_type_CountNonBlank                           := sum(group,if(pMatter.judgmt_type<>'',1,0));
    judgmt_disposition_date_CountNonBlank               := sum(group,if(pMatter.judgmt_disposition_date<>'',1,0));
    judgmt_disposition_code_CountNonBlank               := sum(group,if(pMatter.judgmt_disposition_code<>'',1,0));
    judgmt_disposition_CountNonBlank                    := sum(group,if(pMatter.judgmt_disposition<>'',1,0));
    disposition_code_CountNonBlank                      := sum(group,if(pMatter.disposition_code<>'',1,0));
    disposition_description_CountNonBlank               := sum(group,if(pMatter.disposition_description<>'',1,0));
    disposition_date_CountNonBlank                      := sum(group,if(pMatter.disposition_date<>'',1,0));
    suit_amount_CountNonBlank                           := sum(group,if(pMatter.suit_amount<>'',1,0));
    award_amount_CountNonBlank                          := sum(group,if(pMatter.award_amount<>'',1,0));
  end;

	%dPopulationStats_pParty%	:= table(pParty
	                                    ,%rPopulationStats_pParty%
                                        ,vendor,state_origin
										,few);

	STRATA.createXMLStats(%dPopulationStats_pParty%
	                     ,'Civil Court'
						 ,'Party'
						 ,pVersion
						 ,''
						 ,%zPartyStats%
						 ,'view'
						 ,'Population');

	%dPopulationStats_pCaseActivity%	:= table(pCaseActivity
	                                            ,%rPopulationStats_pCaseActivity%
                                                ,vendor,state_origin
												,few);

	STRATA.createXMLStats(%dPopulationStats_pCaseActivity%
	                     ,'Civil Court'
						 ,'Case Activity'
						 ,pVersion
						 ,''
						 ,%zCaseActivityStats%
						 ,'view'
						 ,'Population');

	%dPopulationStats_pMatter%	:= table(pMatter
	                                    ,%rPopulationStats_pMatter%
										,vendor,state_origin
										,few);

	STRATA.createXMLStats(%dPopulationStats_pMatter%
	                     ,'Civil Court'
						 ,'Matter'
						 ,pVersion
						 ,''
						 ,%zMatterStats%
						 ,'view'
						 ,'Population');

	zOut	:=	parallel(%zPartyStats%,%zCaseActivityStats%,%zMatterStats%);

  endmacro
 ;
