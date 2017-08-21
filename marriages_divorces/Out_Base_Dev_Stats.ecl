import strata;

ds := marriages_divorces.File_Marriage_Divorce_Base;

rPopulationStats_ds
 :=
  record
    CountGroup := count(group);
    ds.vendor;
    source_file_CountNonBlank                             := sum(group,if(ds.source_file<>'',1,0));
    process_date_CountNonBlank                            := sum(group,if(ds.process_date<>'',1,0));
    ds.state_origin;
    source_location_cd_CountNonBlank                      := sum(group,if(ds.source_location_cd<>'',1,0));
    source_county_CountNonBlank                           := sum(group,if(ds.source_county<>'',1,0));
    source_city_CountNonBlank                             := sum(group,if(ds.source_city<>'',1,0));
    filing_number_CountNonBlank                           := sum(group,if(ds.filing_number<>'',1,0));
    filing_type_CountNonBlank                             := sum(group,if(ds.filing_type<>'',1,0));
    filing_dt_CountNonBlank                               := sum(group,if(ds.filing_dt<>'',1,0));
    party1_type_CountNonBlank                             := sum(group,if(ds.party1_type<>'',1,0));
    party1_orig_name_CountNonBlank                        := sum(group,if(ds.party1_orig_name<>'',1,0));
    party1_orig_name_alias_CountNonBlank                  := sum(group,if(ds.party1_orig_name_alias<>'',1,0));
    party1_name_fmt_CountNonBlank                         := sum(group,if(ds.party1_name_fmt<>'',1,0));
    party1_dob_CountNonBlank                              := sum(group,if(ds.party1_dob<>'',1,0));
    party1_ssn_CountNonBlank                              := sum(group,if(ds.party1_ssn<>'',1,0));
    party1_age_CountNonBlank                              := sum(group,if(ds.party1_age<>'',1,0));
    party1_residence_cds_CountNonBlank                    := sum(group,if(ds.party1_residence_cds<>'',1,0));
    party1_residence_state_CountNonBlank                  := sum(group,if(ds.party1_residence_state<>'',1,0));
    party1_residence_city_CountNonBlank                   := sum(group,if(ds.party1_residence_city<>'',1,0));
    party1_orig_zip_CountNonBlank                         := sum(group,if(ds.party1_orig_zip<>'',1,0));
    party1_residence_county_CountNonBlank                 := sum(group,if(ds.party1_residence_county<>'',1,0));
    party1_residence_address1_CountNonBlank               := sum(group,if(ds.party1_residence_address1<>'',1,0));
    party1_status_cd_CountNonBlank                        := sum(group,if(ds.party1_status_cd<>'',1,0));
    party1_status_CountNonBlank                           := sum(group,if(ds.party1_status<>'',1,0));
    party1_times_married_CountNonBlank                    := sum(group,if(ds.party1_times_married<>'',1,0));
    party1_race_cd_CountNonBlank                          := sum(group,if(ds.party1_race_cd<>'',1,0));
    party1_race_CountNonBlank                             := sum(group,if(ds.party1_race<>'',1,0));
    party2_type_CountNonBlank                             := sum(group,if(ds.party2_type<>'',1,0));
    party2_orig_name_CountNonBlank                        := sum(group,if(ds.party2_orig_name<>'',1,0));
    party2_orig_name_alias_CountNonBlank                  := sum(group,if(ds.party2_orig_name_alias<>'',1,0));
    party2_name_fmt_CountNonBlank                         := sum(group,if(ds.party2_name_fmt<>'',1,0));
    party2_dob_CountNonBlank                              := sum(group,if(ds.party2_dob<>'',1,0));
    party2_ssn_CountNonBlank                              := sum(group,if(ds.party2_ssn<>'',1,0));
    party2_age_CountNonBlank                              := sum(group,if(ds.party2_age<>'',1,0));
    party2_residence_cds_CountNonBlank                    := sum(group,if(ds.party2_residence_cds<>'',1,0));
    party2_residence_state_CountNonBlank                  := sum(group,if(ds.party2_residence_state<>'',1,0));
    party2_residence_city_CountNonBlank                   := sum(group,if(ds.party2_residence_city<>'',1,0));
    party2_orig_zip_CountNonBlank                         := sum(group,if(ds.party2_orig_zip<>'',1,0));
    party2_residence_county_CountNonBlank                 := sum(group,if(ds.party2_residence_county<>'',1,0));
    party2_residence_address1_CountNonBlank               := sum(group,if(ds.party2_residence_address1<>'',1,0));
    party2_status_cd_CountNonBlank                        := sum(group,if(ds.party2_status_cd<>'',1,0));
    party2_status_CountNonBlank                           := sum(group,if(ds.party2_status<>'',1,0));
    party2_times_married_CountNonBlank                    := sum(group,if(ds.party2_times_married<>'',1,0));
    party2_race_cd_CountNonBlank                          := sum(group,if(ds.party2_race_cd<>'',1,0));
    party2_race_CountNonBlank                             := sum(group,if(ds.party2_race<>'',1,0));
    number_children_CountNonBlank                         := sum(group,if(ds.number_children<>'',1,0));
    marriage_dt_CountNonBlank                             := sum(group,if(ds.marriage_dt<>'',1,0));
    divorce_dt_CountNonBlank                              := sum(group,if(ds.divorce_dt<>'',1,0));
    marriage_months_duration_CountNonBlank                := sum(group,if(ds.marriage_months_duration<>'',1,0));
    divorce_granted_to_cd_CountNonBlank                   := sum(group,if(ds.divorce_granted_to_cd<>'',1,0));
    divorce_granted_to_CountNonBlank                      := sum(group,if(ds.divorce_granted_to<>'',1,0));
    divorce_grounds_cd_CountNonBlank                      := sum(group,if(ds.divorce_grounds_cd<>'',1,0));
    divorce_grounds_CountNonBlank                         := sum(group,if(ds.divorce_grounds<>'',1,0));
    p1_title_CountNonBlank                                := sum(group,if(ds.p1_title<>'',1,0));
    p1_fname_CountNonBlank                                := sum(group,if(ds.p1_fname<>'',1,0));
    p1_mname_CountNonBlank                                := sum(group,if(ds.p1_mname<>'',1,0));
    p1_lname_CountNonBlank                                := sum(group,if(ds.p1_lname<>'',1,0));
    p1_name_suffix_CountNonBlank                          := sum(group,if(ds.p1_name_suffix<>'',1,0));
    p1_score_in_CountNonBlank                             := sum(group,if(ds.p1_score_in<>'',1,0));
    p1a_title_CountNonBlank                               := sum(group,if(ds.p1a_title<>'',1,0));
    p1a_fname_CountNonBlank                               := sum(group,if(ds.p1a_fname<>'',1,0));
    p1a_mname_CountNonBlank                               := sum(group,if(ds.p1a_mname<>'',1,0));
    p1a_lname_CountNonBlank                               := sum(group,if(ds.p1a_lname<>'',1,0));
    p1a_name_suffix_CountNonBlank                         := sum(group,if(ds.p1a_name_suffix<>'',1,0));
    p1a_score_in_CountNonBlank                            := sum(group,if(ds.p1a_score_in<>'',1,0));
    p2_title_CountNonBlank                                := sum(group,if(ds.p2_title<>'',1,0));
    p2_fname_CountNonBlank                                := sum(group,if(ds.p2_fname<>'',1,0));
    p2_mname_CountNonBlank                                := sum(group,if(ds.p2_mname<>'',1,0));
    p2_lname_CountNonBlank                                := sum(group,if(ds.p2_lname<>'',1,0));
    p2_name_suffix_CountNonBlank                          := sum(group,if(ds.p2_name_suffix<>'',1,0));
    p2_score_in_CountNonBlank                             := sum(group,if(ds.p2_score_in<>'',1,0));
    p2a_title_CountNonBlank                               := sum(group,if(ds.p2a_title<>'',1,0));
    p2a_fname_CountNonBlank                               := sum(group,if(ds.p2a_fname<>'',1,0));
    p2a_mname_CountNonBlank                               := sum(group,if(ds.p2a_mname<>'',1,0));
    p2a_lname_CountNonBlank                               := sum(group,if(ds.p2a_lname<>'',1,0));
    p2a_name_suffix_CountNonBlank                         := sum(group,if(ds.p2a_name_suffix<>'',1,0));
    p2a_score_in_CountNonBlank                            := sum(group,if(ds.p2a_score_in<>'',1,0));
    prim_range_1_CountNonBlank                            := sum(group,if(ds.prim_range_1<>'',1,0));
    predir_1_CountNonBlank                                := sum(group,if(ds.predir_1<>'',1,0));
    prim_name_1_CountNonBlank                             := sum(group,if(ds.prim_name_1<>'',1,0));
    addr_suffix_1_CountNonBlank                           := sum(group,if(ds.addr_suffix_1<>'',1,0));
    postdir_1_CountNonBlank                               := sum(group,if(ds.postdir_1<>'',1,0));
    unit_desig_1_CountNonBlank                            := sum(group,if(ds.unit_desig_1<>'',1,0));
    sec_range_1_CountNonBlank                             := sum(group,if(ds.sec_range_1<>'',1,0));
    p_city_name_1_CountNonBlank                           := sum(group,if(ds.p_city_name_1<>'',1,0));
    v_city_name_1_CountNonBlank                           := sum(group,if(ds.v_city_name_1<>'',1,0));
    st_1_CountNonBlank                                    := sum(group,if(ds.st_1<>'',1,0));
    zip_1_CountNonBlank                                   := sum(group,if(ds.zip_1<>'',1,0));
    zip4_1_CountNonBlank                                  := sum(group,if(ds.zip4_1<>'',1,0));
    cart_1_CountNonBlank                                  := sum(group,if(ds.cart_1<>'',1,0));
    cr_sort_sz_1_CountNonBlank                            := sum(group,if(ds.cr_sort_sz_1<>'',1,0));
    lot_1_CountNonBlank                                   := sum(group,if(ds.lot_1<>'',1,0));
    lot_order_1_CountNonBlank                             := sum(group,if(ds.lot_order_1<>'',1,0));
    dpbc_1_CountNonBlank                                  := sum(group,if(ds.dpbc_1<>'',1,0));
    chk_digit_1_CountNonBlank                             := sum(group,if(ds.chk_digit_1<>'',1,0));
    rec_type_1_CountNonBlank                              := sum(group,if(ds.rec_type_1<>'',1,0));
    ace_fips_st_1_CountNonBlank                           := sum(group,if(ds.ace_fips_st_1<>'',1,0));
    ace_fips_county_1_CountNonBlank                       := sum(group,if(ds.ace_fips_county_1<>'',1,0));
    geo_lat_1_CountNonBlank                               := sum(group,if(ds.geo_lat_1<>'',1,0));
    geo_long_1_CountNonBlank                              := sum(group,if(ds.geo_long_1<>'',1,0));
    msa_1_CountNonBlank                                   := sum(group,if(ds.msa_1<>'',1,0));
    geo_blk_1_CountNonBlank                               := sum(group,if(ds.geo_blk_1<>'',1,0));
    geo_match_1_CountNonBlank                             := sum(group,if(ds.geo_match_1<>'',1,0));
    err_stat_1_CountNonBlank                              := sum(group,if(ds.err_stat_1<>'',1,0));
    prim_range_2_CountNonBlank                            := sum(group,if(ds.prim_range_2<>'',1,0));
    predir_2_CountNonBlank                                := sum(group,if(ds.predir_2<>'',1,0));
    prim_name_2_CountNonBlank                             := sum(group,if(ds.prim_name_2<>'',1,0));
    addr_suffix_2_CountNonBlank                           := sum(group,if(ds.addr_suffix_2<>'',1,0));
    postdir_2_CountNonBlank                               := sum(group,if(ds.postdir_2<>'',1,0));
    unit_desig_2_CountNonBlank                            := sum(group,if(ds.unit_desig_2<>'',1,0));
    sec_range_2_CountNonBlank                             := sum(group,if(ds.sec_range_2<>'',1,0));
    p_city_name_2_CountNonBlank                           := sum(group,if(ds.p_city_name_2<>'',1,0));
    v_city_name_2_CountNonBlank                           := sum(group,if(ds.v_city_name_2<>'',1,0));
    st_2_CountNonBlank                                    := sum(group,if(ds.st_2<>'',1,0));
    zip_2_CountNonBlank                                   := sum(group,if(ds.zip_2<>'',1,0));
    zip4_2_CountNonBlank                                  := sum(group,if(ds.zip4_2<>'',1,0));
    cart_2_CountNonBlank                                  := sum(group,if(ds.cart_2<>'',1,0));
    cr_sort_sz_2_CountNonBlank                            := sum(group,if(ds.cr_sort_sz_2<>'',1,0));
    lot_2_CountNonBlank                                   := sum(group,if(ds.lot_2<>'',1,0));
    lot_order_2_CountNonBlank                             := sum(group,if(ds.lot_order_2<>'',1,0));
    dpbc_2_CountNonBlank                                  := sum(group,if(ds.dpbc_2<>'',1,0));
    chk_digit_2_CountNonBlank                             := sum(group,if(ds.chk_digit_2<>'',1,0));
    rec_type_2_CountNonBlank                              := sum(group,if(ds.rec_type_2<>'',1,0));
    ace_fips_st_2_CountNonBlank                           := sum(group,if(ds.ace_fips_st_2<>'',1,0));
    ace_fips_county_2_CountNonBlank                       := sum(group,if(ds.ace_fips_county_2<>'',1,0));
    geo_lat_2_CountNonBlank                               := sum(group,if(ds.geo_lat_2<>'',1,0));
    geo_long_2_CountNonBlank                              := sum(group,if(ds.geo_long_2<>'',1,0));
    msa_2_CountNonBlank                                   := sum(group,if(ds.msa_2<>'',1,0));
    geo_blk_2_CountNonBlank                               := sum(group,if(ds.geo_blk_2<>'',1,0));
    geo_match_2_CountNonBlank                             := sum(group,if(ds.geo_match_2<>'',1,0));
    err_stat_2_CountNonBlank                              := sum(group,if(ds.err_stat_2<>'',1,0));
  end;

tStats := table(ds,rPopulationStats_ds,vendor,state_origin,few);

zOrig_Stats := output(choosen(tStats,all));

STRATA.createXMLStats(tStats,'Marriage and Divorce','Data',marriages_divorces.version_development,'jtrost@seisint.com',zPopulation_Stats,'View','Population')

//STRATA.createAsHeaderStats(marriages_divorces.marriage_divorce_as_header(marriages_divorces.File_Marriage_Divorce_Base),'Marriage and Divorce','Data',marriages_divorces.version_development,'jtrost@seisint.com',zAs_Header_Stats)

export Out_Base_Dev_Stats := parallel(zOrig_Stats
									  ,zPopulation_Stats
									  //,zAs_Header_Stats
									  );