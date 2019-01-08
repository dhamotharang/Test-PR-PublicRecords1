import strata;


export Out_Base_Dev_Stats(string filedate) := function

ds_util :=  utilfile.file_util.full_did;

rPopulationStats_ds_util
 :=
  record
    CountGroup                                             := count(group);
	ds_util.util_type;
    id_CountNonBlank                                       := sum(group,if(ds_util.id<>'',1,0));
    exchange_serial_number_CountNonBlank                   := sum(group,if(ds_util.exchange_serial_number<>'',1,0));
    date_added_to_exchange_CountNonBlank                   := sum(group,if(ds_util.date_added_to_exchange<>'',1,0));
    connect_date_CountNonBlank                             := sum(group,if(ds_util.connect_date<>'',1,0));
    date_first_seen_CountNonBlank                          := sum(group,if(ds_util.date_first_seen<>'',1,0));
    record_date_CountNonBlank                              := sum(group,if(ds_util.record_date<>'',1,0));
    orig_lname_CountNonBlank                               := sum(group,if(ds_util.orig_lname<>'',1,0));
    orig_fname_CountNonBlank                               := sum(group,if(ds_util.orig_fname<>'',1,0));
    orig_mname_CountNonBlank                               := sum(group,if(ds_util.orig_mname<>'',1,0));
    orig_name_suffix_CountNonBlank                         := sum(group,if(ds_util.orig_name_suffix<>'',1,0));
    addr_type_CountNonBlank                                := sum(group,if(ds_util.addr_type<>'',1,0));
    addr_dual_CountNonBlank                                := sum(group,if(ds_util.addr_dual<>'',1,0));
    address_street_CountNonBlank                           := sum(group,if(ds_util.address_street<>'',1,0));
    address_street_Name_CountNonBlank                      := sum(group,if(ds_util.address_street_Name<>'',1,0));
    address_street_Type_CountNonBlank                      := sum(group,if(ds_util.address_street_Type<>'',1,0));
    address_street_direction_CountNonBlank                 := sum(group,if(ds_util.address_street_direction<>'',1,0));
    address_apartment_CountNonBlank                        := sum(group,if(ds_util.address_apartment<>'',1,0));
    address_city_CountNonBlank                             := sum(group,if(ds_util.address_city<>'',1,0));
    address_state_CountNonBlank                            := sum(group,if(ds_util.address_state<>'',1,0));
    address_zip_CountNonBlank                              := sum(group,if(ds_util.address_zip<>'',1,0));
    ssn_CountNonBlank                                      := sum(group,if(ds_util.ssn<>'',1,0));
    work_phone_CountNonBlank                               := sum(group,if(ds_util.work_phone<>'',1,0));
    phone_CountNonBlank                                    := sum(group,if(ds_util.phone<>'',1,0));
    dob_CountNonBlank                                      := sum(group,if(ds_util.dob<>'00000000',1,0));
    drivers_license_state_code_CountNonBlank               := sum(group,if(ds_util.drivers_license_state_code<>'',1,0));
    drivers_license_CountNonBlank                          := sum(group,if(ds_util.drivers_license<>'',1,0));
    prim_range_CountNonBlank                               := sum(group,if(ds_util.prim_range<>'',1,0));
    predir_CountNonBlank                                   := sum(group,if(ds_util.predir<>'',1,0));
    prim_name_CountNonBlank                                := sum(group,if(ds_util.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                              := sum(group,if(ds_util.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                  := sum(group,if(ds_util.postdir<>'',1,0));
    unit_desig_CountNonBlank                               := sum(group,if(ds_util.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                := sum(group,if(ds_util.sec_range<>'',1,0));
    p_city_name_CountNonBlank                              := sum(group,if(ds_util.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                              := sum(group,if(ds_util.v_city_name<>'',1,0));
    st_CountNonBlank                                       := sum(group,if(ds_util.st<>'',1,0));
    zip_CountNonBlank                                      := sum(group,if(ds_util.zip<>'',1,0));
    zip4_CountNonBlank                                     := sum(group,if(ds_util.zip4<>'',1,0));
    cart_CountNonBlank                                     := sum(group,if(ds_util.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                               := sum(group,if(ds_util.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                      := sum(group,if(ds_util.lot<>'',1,0));
    lot_order_CountNonBlank                                := sum(group,if(ds_util.lot_order<>'',1,0));
    dbpc_CountNonBlank                                     := sum(group,if(ds_util.dbpc<>'',1,0));
    chk_digit_CountNonBlank                                := sum(group,if(ds_util.chk_digit<>'',1,0));
    rec_type_CountNonBlank                                 := sum(group,if(ds_util.rec_type<>'',1,0));
    county_CountNonBlank                                   := sum(group,if(ds_util.county<>'',1,0));
    geo_lat_CountNonBlank                                  := sum(group,if(ds_util.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                 := sum(group,if(ds_util.geo_long<>'',1,0));
    msa_CountNonBlank                                      := sum(group,if(ds_util.msa<>'',1,0));
    geo_blk_CountNonBlank                                  := sum(group,if(ds_util.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                := sum(group,if(ds_util.geo_match<>'',1,0));
    err_stat_CountNonBlank                                 := sum(group,if(ds_util.err_stat<>'',1,0));
    did_CountNonBlank                                      := sum(group,if(ds_util.did<>'000000000000',1,0));
    title_CountNonBlank                                    := sum(group,if(ds_util.title<>'',1,0));
    fname_CountNonBlank                                    := sum(group,if(ds_util.fname<>'',1,0));
    mname_CountNonBlank                                    := sum(group,if(ds_util.mname<>'',1,0));
    lname_CountNonBlank                                    := sum(group,if(ds_util.lname<>'',1,0));
    name_suffix_CountNonBlank                              := sum(group,if(ds_util.name_suffix<>'',1,0));
    name_score_CountNonBlank                               := sum(group,if(ds_util.name_score<>'',1,0));
  end;


tStats := table(ds_util,rPopulationStats_ds_util,util_type,few);

zOrig_Stats := output(choosen(tStats,all));

STRATA.createXMLStats(tStats,'Utility','Data',filedate,',michael.gould@lexisnexis.com;jfreibaum@seisint.com',zPopulation_Stats,'View','Population')


return parallel(zOrig_Stats
									  ,zPopulation_Stats									  
									  );
									  
END;
									 