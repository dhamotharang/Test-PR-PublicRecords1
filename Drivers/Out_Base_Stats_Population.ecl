import STRATA;

rPopulationStats_drivers__File_DL_Base_Dev
 :=
  record
	CountGroup                                           := count(group);
    did_CountNonZero                                     := sum(group,if(drivers.File_DL_Base_Dev.did<>0,1,0));
    Preglb_did_CountNonZero                              := sum(group,if(drivers.File_DL_Base_Dev.Preglb_did<>0,1,0));
    dt_first_seen_CountNonZero                           := sum(group,if(drivers.File_DL_Base_Dev.dt_first_seen<>0,1,0));
    dt_last_seen_CountNonZero                            := sum(group,if(drivers.File_DL_Base_Dev.dt_last_seen<>0,1,0));
    dt_vendor_first_reported_CountNonZero                := sum(group,if(drivers.File_DL_Base_Dev.dt_vendor_first_reported<>0,1,0));
    dt_vendor_last_reported_CountNonZero                 := sum(group,if(drivers.File_DL_Base_Dev.dt_vendor_last_reported<>0,1,0));
    drivers.File_DL_Base_Dev.orig_state;
    drivers.File_DL_Base_Dev.source_code;
    history_CountNonBlank                                := sum(group,if(drivers.File_DL_Base_Dev.history<>'',1,0));
    name_CountNonBlank                                   := sum(group,if(drivers.File_DL_Base_Dev.name<>'',1,0));
    addr1_CountNonBlank                                  := sum(group,if(drivers.File_DL_Base_Dev.addr1<>'',1,0));
    city_CountNonBlank                                   := sum(group,if(drivers.File_DL_Base_Dev.city<>'',1,0));
    state_CountNonBlank                                  := sum(group,if(drivers.File_DL_Base_Dev.state<>'',1,0));
    zip_CountNonBlank                                    := sum(group,if(drivers.File_DL_Base_Dev.zip<>'',1,0));
    dob_CountNonZero                                     := sum(group,if(drivers.File_DL_Base_Dev.dob<>0,1,0));
    race_CountNonBlank                                   := sum(group,if(drivers.File_DL_Base_Dev.race<>'',1,0));
    sex_flag_CountNonBlank                               := sum(group,if(drivers.File_DL_Base_Dev.sex_flag<>'',1,0));
    license_type_CountNonBlank                           := sum(group,if(drivers.File_DL_Base_Dev.license_type<>'',1,0));
    attention_flag_CountNonBlank                         := sum(group,if(drivers.File_DL_Base_Dev.attention_flag<>'',1,0));
    dod_CountNonBlank                                    := sum(group,if(drivers.File_DL_Base_Dev.dod<>'',1,0));
    restrictions_CountNonBlank                           := sum(group,if(drivers.File_DL_Base_Dev.restrictions<>'',1,0));
    restrictions_delimited_CountNonBlank                 := sum(group,if(drivers.File_DL_Base_Dev.restrictions_delimited<>'',1,0));
    orig_expiration_date_CountNonZero                    := sum(group,if(drivers.File_DL_Base_Dev.orig_expiration_date<>0,1,0));
    orig_issue_date_CountNonZero                         := sum(group,if(drivers.File_DL_Base_Dev.orig_issue_date<>0,1,0));
    lic_issue_date_CountNonZero                          := sum(group,if(drivers.File_DL_Base_Dev.lic_issue_date<>0,1,0));
    expiration_date_CountNonZero                         := sum(group,if(drivers.File_DL_Base_Dev.expiration_date<>0,1,0));
    active_date_CountNonZero                             := sum(group,if(drivers.File_DL_Base_Dev.active_date<>0,1,0));
    inactive_date_CountNonZero                           := sum(group,if(drivers.File_DL_Base_Dev.inactive_date<>0,1,0));
    lic_endorsement_CountNonBlank                        := sum(group,if(drivers.File_DL_Base_Dev.lic_endorsement<>'',1,0));
    motorcycle_code_CountNonBlank                        := sum(group,if(drivers.File_DL_Base_Dev.motorcycle_code<>'',1,0));
    dl_number_CountNonBlank                              := sum(group,if(drivers.File_DL_Base_Dev.dl_number<>'',1,0));
    ssn_CountNonBlank                                    := sum(group,if(drivers.File_DL_Base_Dev.ssn<>'',1,0));
    ssn_safe_CountNonBlank                               := sum(group,if(drivers.File_DL_Base_Dev.ssn_safe<>'',1,0));
    age_CountNonBlank                                    := sum(group,if(drivers.File_DL_Base_Dev.age<>'',1,0));
    privacy_flag_CountNonBlank                           := sum(group,if(drivers.File_DL_Base_Dev.privacy_flag<>'',1,0));
    driver_edu_code_CountNonBlank                        := sum(group,if(drivers.File_DL_Base_Dev.driver_edu_code<>'',1,0));
    dup_lic_count_CountNonBlank                          := sum(group,if(drivers.File_DL_Base_Dev.dup_lic_count<>'',1,0));
    rcd_stat_flag_CountNonBlank                          := sum(group,if(drivers.File_DL_Base_Dev.rcd_stat_flag<>'',1,0));
    height_CountNonBlank                                 := sum(group,if(drivers.File_DL_Base_Dev.height<>'',1,0));
    hair_color_CountNonBlank                             := sum(group,if(drivers.File_DL_Base_Dev.hair_color<>'',1,0));
    eye_color_CountNonBlank                              := sum(group,if(drivers.File_DL_Base_Dev.eye_color<>'',1,0));
    weight_CountNonBlank                                 := sum(group,if(drivers.File_DL_Base_Dev.weight<>'',1,0));
    oos_previous_dl_number_CountNonBlank                 := sum(group,if(drivers.File_DL_Base_Dev.oos_previous_dl_number<>'',1,0));
    oos_previous_st_CountNonBlank                        := sum(group,if(drivers.File_DL_Base_Dev.oos_previous_st<>'',1,0));
    title_CountNonBlank                                  := sum(group,if(drivers.File_DL_Base_Dev.title<>'',1,0));
    fname_CountNonBlank                                  := sum(group,if(drivers.File_DL_Base_Dev.fname<>'',1,0));
    mname_CountNonBlank                                  := sum(group,if(drivers.File_DL_Base_Dev.mname<>'',1,0));
    lname_CountNonBlank                                  := sum(group,if(drivers.File_DL_Base_Dev.lname<>'',1,0));
    name_suffix_CountNonBlank                            := sum(group,if(drivers.File_DL_Base_Dev.name_suffix<>'',1,0));
    cleaning_score_CountNonBlank                         := sum(group,if(drivers.File_DL_Base_Dev.cleaning_score<>'',1,0));
    addr_fix_flag_CountNonBlank                          := sum(group,if(drivers.File_DL_Base_Dev.addr_fix_flag<>'',1,0));
    prim_range_CountNonBlank                             := sum(group,if(drivers.File_DL_Base_Dev.prim_range<>'',1,0));
    predir_CountNonBlank                                 := sum(group,if(drivers.File_DL_Base_Dev.predir<>'',1,0));
    prim_name_CountNonBlank                              := sum(group,if(drivers.File_DL_Base_Dev.prim_name<>'',1,0));
    suffix_CountNonBlank                                 := sum(group,if(drivers.File_DL_Base_Dev.suffix<>'',1,0));
    postdir_CountNonBlank                                := sum(group,if(drivers.File_DL_Base_Dev.postdir<>'',1,0));
    unit_desig_CountNonBlank                             := sum(group,if(drivers.File_DL_Base_Dev.unit_desig<>'',1,0));
    sec_range_CountNonBlank                              := sum(group,if(drivers.File_DL_Base_Dev.sec_range<>'',1,0));
    p_city_name_CountNonBlank                            := sum(group,if(drivers.File_DL_Base_Dev.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                            := sum(group,if(drivers.File_DL_Base_Dev.v_city_name<>'',1,0));
    st_CountNonBlank                                     := sum(group,if(drivers.File_DL_Base_Dev.st<>'',1,0));
    zip5_CountNonBlank                                   := sum(group,if(drivers.File_DL_Base_Dev.zip5<>'',1,0));
    zip4_CountNonBlank                                   := sum(group,if(drivers.File_DL_Base_Dev.zip4<>'',1,0));
    cart_CountNonBlank                                   := sum(group,if(drivers.File_DL_Base_Dev.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                             := sum(group,if(drivers.File_DL_Base_Dev.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                    := sum(group,if(drivers.File_DL_Base_Dev.lot<>'',1,0));
    lot_order_CountNonBlank                              := sum(group,if(drivers.File_DL_Base_Dev.lot_order<>'',1,0));
    dpbc_CountNonBlank                                   := sum(group,if(drivers.File_DL_Base_Dev.dpbc<>'',1,0));
    chk_digit_CountNonBlank                              := sum(group,if(drivers.File_DL_Base_Dev.chk_digit<>'',1,0));
    rec_type_CountNonBlank                               := sum(group,if(drivers.File_DL_Base_Dev.rec_type<>'',1,0));
    ace_fips_st_CountNonBlank                            := sum(group,if(drivers.File_DL_Base_Dev.ace_fips_st<>'',1,0));
    county_CountNonBlank                                 := sum(group,if(drivers.File_DL_Base_Dev.county<>'',1,0));
    geo_lat_CountNonBlank                                := sum(group,if(drivers.File_DL_Base_Dev.geo_lat<>'',1,0));
    geo_long_CountNonBlank                               := sum(group,if(drivers.File_DL_Base_Dev.geo_long<>'',1,0));
    msa_CountNonBlank                                    := sum(group,if(drivers.File_DL_Base_Dev.msa<>'',1,0));
    geo_blk_CountNonBlank                                := sum(group,if(drivers.File_DL_Base_Dev.geo_blk<>'',1,0));
    geo_match_CountNonBlank                              := sum(group,if(drivers.File_DL_Base_Dev.geo_match<>'',1,0));
    err_stat_CountNonBlank                               := sum(group,if(drivers.File_DL_Base_Dev.err_stat<>'',1,0));
    status_CountNonBlank                                 := sum(group,if(drivers.File_DL_Base_Dev.status<>'',1,0));
    issuance_CountNonBlank                               := sum(group,if(drivers.File_DL_Base_Dev.issuance<>'',1,0));
    address_change_CountNonBlank                         := sum(group,if(drivers.File_DL_Base_Dev.address_change<>'',1,0));
    name_change_CountNonBlank                            := sum(group,if(drivers.File_DL_Base_Dev.name_change<>'',1,0));
    dob_change_CountNonBlank                             := sum(group,if(drivers.File_DL_Base_Dev.dob_change<>'',1,0));
    sex_change_CountNonBlank                             := sum(group,if(drivers.File_DL_Base_Dev.sex_change<>'',1,0));
    old_dl_number_CountNonBlank                          := sum(group,if(drivers.File_DL_Base_Dev.old_dl_number<>'',1,0));
    dl_key_number_CountNonBlank                          := sum(group,if(drivers.File_DL_Base_Dev.dl_key_number<>'',1,0));
  end;

dPopulationStats_drivers__File_DL_Base_Dev := table(Drivers.File_DL_Base_Dev,
													rPopulationStats_drivers__File_DL_Base_Dev,
													source_code,orig_state,
													few
									               );

STRATA.createXMLStats(dPopulationStats_drivers__File_DL_Base_Dev,
                      'Drivers Licenses',
					  'data',
					  Drivers.Version_Development,
					  '',
					  resultsOut,
					  'view',
					  'population'
					 );
					 
export Out_Base_Stats_Population := resultsOut;