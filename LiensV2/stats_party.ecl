import liensV2;

file_in := LiensV2.file_liens_party;

rPopulationStats_file_in
 :=
  record
    tmsid_CountNonBlank                                    := ave(group,if(file_in.tmsid<>'',100,0));
    rmsid_CountNonBlank                                    := ave(group,if(file_in.rmsid<>'',100,0));
    orig_full_debtorname_CountNonBlank                     := ave(group,if(file_in.orig_full_debtorname<>'',100,0));
    orig_name_CountNonBlank                                := ave(group,if(file_in.orig_name<>'',100,0));
    orig_lname_CountNonBlank                               := ave(group,if(file_in.orig_lname<>'',100,0));
    orig_fname_CountNonBlank                               := ave(group,if(file_in.orig_fname<>'',100,0));
    orig_mname_CountNonBlank                               := ave(group,if(file_in.orig_mname<>'',100,0));
    orig_suffix_CountNonBlank                              := ave(group,if(file_in.orig_suffix<>'',100,0));
    tax_id_CountNonBlank                                   := ave(group,if(file_in.tax_id<>'',100,0));
    ssn_CountNonBlank                                      := ave(group,if(file_in.ssn<>'',100,0));
    title_CountNonBlank                                    := ave(group,if(file_in.title<>'',100,0));
    fname_CountNonBlank                                    := ave(group,if(file_in.fname<>'',100,0));
    mname_CountNonBlank                                    := ave(group,if(file_in.mname<>'',100,0));
    lname_CountNonBlank                                    := ave(group,if(file_in.lname<>'',100,0));
    name_suffix_CountNonBlank                              := ave(group,if(file_in.name_suffix<>'',100,0));
    name_score_CountNonBlank                               := ave(group,if(file_in.name_score<>'',100,0));
    cname_CountNonBlank                                    := ave(group,if(file_in.cname<>'',100,0));
    orig_address100_CountNonBlank                            := ave(group,if(file_in.orig_address1<>'',100,0));
    orig_address2_CountNonBlank                            := ave(group,if(file_in.orig_address2<>'',100,0));
    orig_city_CountNonBlank                                := ave(group,if(file_in.orig_city<>'',100,0));
    orig_state_CountNonBlank                               := ave(group,if(file_in.orig_state<>'',100,0));
    orig_zip5_CountNonBlank                                := ave(group,if(file_in.orig_zip5<>'',100,0));
    orig_zip4_CountNonBlank                                := ave(group,if(file_in.orig_zip4<>'',100,0));
    orig_county_CountNonBlank                              := ave(group,if(file_in.orig_county<>'',100,0));
    orig_country_CountNonBlank                             := ave(group,if(file_in.orig_country<>'',100,0));
    prim_range_CountNonBlank                               := ave(group,if(file_in.prim_range<>'',100,0));
    predir_CountNonBlank                                   := ave(group,if(file_in.predir<>'',100,0));
    prim_name_CountNonBlank                                := ave(group,if(file_in.prim_name<>'',100,0));
    addr_suffix_CountNonBlank                              := ave(group,if(file_in.addr_suffix<>'',100,0));
    postdir_CountNonBlank                                  := ave(group,if(file_in.postdir<>'',100,0));
    unit_desig_CountNonBlank                               := ave(group,if(file_in.unit_desig<>'',100,0));
    sec_range_CountNonBlank                                := ave(group,if(file_in.sec_range<>'',100,0));
    p_city_name_CountNonBlank                              := ave(group,if(file_in.p_city_name<>'',100,0));
    v_city_name_CountNonBlank                              := ave(group,if(file_in.v_city_name<>'',100,0));
    st_CountNonBlank                                       := ave(group,if(file_in.st<>'',100,0));
    zip_CountNonBlank                                      := ave(group,if(file_in.zip<>'',100,0));
    zip4_CountNonBlank                                     := ave(group,if(file_in.zip4<>'',100,0));
    cart_CountNonBlank                                     := ave(group,if(file_in.cart<>'',100,0));
    cr_sort_sz_CountNonBlank                               := ave(group,if(file_in.cr_sort_sz<>'',100,0));
    lot_CountNonBlank                                      := ave(group,if(file_in.lot<>'',100,0));
    lot_order_CountNonBlank                                := ave(group,if(file_in.lot_order<>'',100,0));
    dbpc_CountNonBlank                                     := ave(group,if(file_in.dbpc<>'',100,0));
    chk_digit_CountNonBlank                                := ave(group,if(file_in.chk_digit<>'',100,0));
    rec_type_CountNonBlank                                 := ave(group,if(file_in.rec_type<>'',100,0));
    county_CountNonBlank                                   := ave(group,if(file_in.county<>'',100,0));
    geo_lat_CountNonBlank                                  := ave(group,if(file_in.geo_lat<>'',100,0));
    geo_long_CountNonBlank                                 := ave(group,if(file_in.geo_long<>'',100,0));
    msa_CountNonBlank                                      := ave(group,if(file_in.msa<>'',100,0));
    geo_blk_CountNonBlank                                  := ave(group,if(file_in.geo_blk<>'',100,0));
    geo_match_CountNonBlank                                := ave(group,if(file_in.geo_match<>'',100,0));
    err_stat_CountNonBlank                                 := ave(group,if(file_in.err_stat<>'',100,0));
    phone_CountNonBlank                                    := ave(group,if(file_in.phone<>'',100,0));
    name_type_CountNonBlank                                := ave(group,if(file_in.name_type<>'',100,0));
    DID_CountNonBlank                                      := ave(group,if((unsigned6)file_in.DID<>0,100,0));
    BDID_CountNonBlank                                     := ave(group,if((unsigned6)file_in.BDID<>0,100,0));
    date_first_seen_CountNonBlank                          := ave(group,if(file_in.date_first_seen<>'',100,0));
    date_last_seen_CountNonBlank                           := ave(group,if(file_in.date_last_seen<>'',100,0));
    date_vendor_first_reported_CountNonBlank               := ave(group,if(file_in.date_vendor_first_reported<>'',100,0));
    date_vendor_last_reported_CountNonBlank                := ave(group,if(file_in.date_vendor_last_reported<>'',100,0));
end;

stats_out := table(file_in, rPopulationStats_file_in, few);

export stats_party := output(stats_out);