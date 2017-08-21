import strata, ut;

ds := Gong.File_History;

rPopulationStats_File_History
 :=
  record
    did_CountNonZero                                := sum(group,if(ds.did<>0,1,0));
    hhid_CountNonZero                               := sum(group,if(ds.hhid<>0,1,0));
    bdid_CountNonZero                               := sum(group,if(ds.bdid<>0,1,0));
    dt_first_seen_CountNonBlank                     := sum(group,if(ds.dt_first_seen<>'',1,0));
    dt_last_seen_CountNonBlank                      := sum(group,if(ds.dt_last_seen<>'',1,0));
    current_record_flag_CountNonBlank               := sum(group,if(ds.current_record_flag<>'',1,0));
    deletion_date_CountNonBlank                     := sum(group,if(ds.deletion_date<>'',1,0));
    disc_cnt6_CountNonZero                          := sum(group,if(ds.disc_cnt6<>0,1,0));
    disc_cnt12_CountNonZero                         := sum(group,if(ds.disc_cnt12<>0,1,0));
    disc_cnt18_CountNonZero                         := sum(group,if(ds.disc_cnt18<>0,1,0));
    bell_id_CountNonBlank                           := sum(group,if(ds.bell_id<>'',1,0));
    filedate_CountNonBlank                          := sum(group,if(ds.filedate<>'',1,0));
    dual_name_flag_CountNonBlank                    := sum(group,if(ds.dual_name_flag<>'',1,0));
    sequence_number_CountNonBlank                   := sum(group,if(ds.sequence_number<>'',1,0));
    listing_type_bus_CountNonBlank                  := sum(group,if(ds.listing_type_bus<>'',1,0));
    listing_type_res_CountNonBlank                  := sum(group,if(ds.listing_type_res<>'',1,0));
    listing_type_gov_CountNonBlank                  := sum(group,if(ds.listing_type_gov<>'',1,0));
    publish_code_CountNonBlank                      := sum(group,if(ds.publish_code<>'',1,0));
    style_code_CountNonBlank                        := sum(group,if(ds.style_code<>'',1,0));
    indent_code_CountNonBlank                       := sum(group,if(ds.indent_code<>'',1,0));
    book_neighborhood_code_CountNonBlank            := sum(group,if(ds.book_neighborhood_code<>'',1,0));
    prior_area_code_CountNonBlank                   := sum(group,if(ds.prior_area_code<>'',1,0));
    phone10_CountNonBlank                           := sum(group,if(ds.phone10<>'',1,0));
    prim_range_CountNonBlank                        := sum(group,if(ds.prim_range<>'',1,0));
    predir_CountNonBlank                            := sum(group,if(ds.predir<>'',1,0));
    prim_name_CountNonBlank                         := sum(group,if(ds.prim_name<>'',1,0));
    suffix_CountNonBlank                            := sum(group,if(ds.suffix<>'',1,0));
    postdir_CountNonBlank                           := sum(group,if(ds.postdir<>'',1,0));
    unit_desig_CountNonBlank                        := sum(group,if(ds.unit_desig<>'',1,0));
    sec_range_CountNonBlank                         := sum(group,if(ds.sec_range<>'',1,0));
    p_city_name_CountNonBlank                       := sum(group,if(ds.p_city_name<>'',1,0));
    v_predir_CountNonBlank                          := sum(group,if(ds.v_predir<>'',1,0));
    v_prim_name_CountNonBlank                       := sum(group,if(ds.v_prim_name<>'',1,0));
    v_suffix_CountNonBlank                          := sum(group,if(ds.v_suffix<>'',1,0));
    v_postdir_CountNonBlank                         := sum(group,if(ds.v_postdir<>'',1,0));
    v_city_name_CountNonBlank                       := sum(group,if(ds.v_city_name<>'',1,0));
    st_CountNonBlank                                := sum(group,if(ds.st<>'',1,0));
    z5_CountNonBlank                                := sum(group,if(ds.z5<>'',1,0));
    z4_CountNonBlank                                := sum(group,if(ds.z4<>'',1,0));
    cart_CountNonBlank                              := sum(group,if(ds.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                        := sum(group,if(ds.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                               := sum(group,if(ds.lot<>'',1,0));
    lot_order_CountNonBlank                         := sum(group,if(ds.lot_order<>'',1,0));
    dpbc_CountNonBlank                              := sum(group,if(ds.dpbc<>'',1,0));
    chk_digit_CountNonBlank                         := sum(group,if(ds.chk_digit<>'',1,0));
    rec_type_CountNonBlank                          := sum(group,if(ds.rec_type<>'',1,0));
    county_code_CountNonBlank                       := sum(group,if(ds.county_code<>'',1,0));
    geo_lat_CountNonBlank                           := sum(group,if(ds.geo_lat<>'',1,0));
    geo_long_CountNonBlank                          := sum(group,if(ds.geo_long<>'',1,0));
    msa_CountNonBlank                               := sum(group,if(ds.msa<>'',1,0));
    geo_blk_CountNonBlank                           := sum(group,if(ds.geo_blk<>'',1,0));
    geo_match_CountNonBlank                         := sum(group,if(ds.geo_match<>'',1,0));
    err_stat_CountNonBlank                          := sum(group,if(ds.err_stat<>'',1,0));
    designation_CountNonBlank                       := sum(group,if(ds.designation<>'',1,0));
    name_prefix_CountNonBlank                       := sum(group,if(ds.name_prefix<>'',1,0));
    name_first_CountNonBlank                        := sum(group,if(ds.name_first<>'',1,0));
    name_middle_CountNonBlank                       := sum(group,if(ds.name_middle<>'',1,0));
    name_last_CountNonBlank                         := sum(group,if(ds.name_last<>'',1,0));
    name_suffix_CountNonBlank                       := sum(group,if(ds.name_suffix<>'',1,0));
    listed_name_CountNonBlank                     	:= sum(group,if(ds.listed_name<>'',1,0));
    caption_text_CountNonBlank                      := sum(group,if(ds.caption_text<>'',1,0));
    group_id_CountNonBlank                          := sum(group,if(ds.group_id<>'',1,0));
    group_seq_CountNonBlank                         := sum(group,if(ds.group_seq<>'',1,0));
    omit_address_CountNonBlank                      := sum(group,if(ds.omit_address<>'',1,0));
    omit_phone_CountNonBlank                        := sum(group,if(ds.omit_phone<>'',1,0));
    omit_locality_CountNonBlank                     := sum(group,if(ds.omit_locality<>'',1,0));
    see_also_text_CountNonBlank                     := sum(group,if(ds.see_also_text<>'',1,0));
    
    
  end;

tStats := table(ds,rPopulationStats_File_History,few);

strata.createXMLStats(tStats,'Gong History','data',ut.GetDate,'',resultsOut);

export strata_popFileHistory := resultsOut;
