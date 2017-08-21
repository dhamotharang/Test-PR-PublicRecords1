export fn_search_field_populations(
	dataset(recordof(ln_property.Layout_Deed_Mortgage_Property_Search)) srch_in0
) :=
function

r_stat
 :=
  record
    CountGroup := count(group);
    srch_in0.vendor_source_flag;
    ln_fares_id_CountNonBlank                      := sum(group,if(srch_in0.ln_fares_id<>'',1,0));
    process_date_CountNonBlank                     := sum(group,if(srch_in0.process_date<>'',1,0));
    source_code_CountNonBlank                      := sum(group,if(srch_in0.source_code<>'',1,0));
    title_CountNonBlank                            := sum(group,if(srch_in0.title<>'',1,0));
    fname_CountNonBlank                            := sum(group,if(srch_in0.fname<>'',1,0));
    mname_CountNonBlank                            := sum(group,if(srch_in0.mname<>'',1,0));
    lname_CountNonBlank                            := sum(group,if(srch_in0.lname<>'',1,0));
    name_suffix_CountNonBlank                      := sum(group,if(srch_in0.name_suffix<>'',1,0));
    cname_CountNonBlank                            := sum(group,if(srch_in0.cname<>'',1,0));
    nameasis_CountNonBlank                         := sum(group,if(srch_in0.nameasis<>'',1,0));
    prim_range_CountNonBlank                       := sum(group,if(srch_in0.prim_range<>'',1,0));
    predir_CountNonBlank                           := sum(group,if(srch_in0.predir<>'',1,0));
    prim_name_CountNonBlank                        := sum(group,if(srch_in0.prim_name<>'',1,0));
    suffix_CountNonBlank                           := sum(group,if(srch_in0.suffix<>'',1,0));
    postdir_CountNonBlank                          := sum(group,if(srch_in0.postdir<>'',1,0));
    unit_desig_CountNonBlank                       := sum(group,if(srch_in0.unit_desig<>'',1,0));
    sec_range_CountNonBlank                        := sum(group,if(srch_in0.sec_range<>'',1,0));
    p_city_name_CountNonBlank                      := sum(group,if(srch_in0.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                      := sum(group,if(srch_in0.v_city_name<>'',1,0));
    st_CountNonBlank                               := sum(group,if(srch_in0.st<>'',1,0));
    zip_CountNonBlank                              := sum(group,if(srch_in0.zip<>'',1,0));
    zip4_CountNonBlank                             := sum(group,if(srch_in0.zip4<>'',1,0));
    cart_CountNonBlank                             := sum(group,if(srch_in0.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                       := sum(group,if(srch_in0.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                              := sum(group,if(srch_in0.lot<>'',1,0));
    lot_order_CountNonBlank                        := sum(group,if(srch_in0.lot_order<>'',1,0));
    dbpc_CountNonBlank                             := sum(group,if(srch_in0.dbpc<>'',1,0));
    chk_digit_CountNonBlank                        := sum(group,if(srch_in0.chk_digit<>'',1,0));
    rec_type_CountNonBlank                         := sum(group,if(srch_in0.rec_type<>'',1,0));
    county_CountNonBlank                           := sum(group,if(srch_in0.county<>'',1,0));
    geo_lat_CountNonBlank                          := sum(group,if(srch_in0.geo_lat<>'',1,0));
    geo_long_CountNonBlank                         := sum(group,if(srch_in0.geo_long<>'',1,0));
    msa_CountNonBlank                              := sum(group,if(srch_in0.msa<>'',1,0));
    geo_blk_CountNonBlank                          := sum(group,if(srch_in0.geo_blk<>'',1,0));
    geo_match_CountNonBlank                        := sum(group,if(srch_in0.geo_match<>'',1,0));
    err_stat_CountNonBlank                         := sum(group,if(srch_in0.err_stat<>'',1,0));
  end;
 
t_stat := sort(table(srch_in0,r_stat,vendor_source_flag,few),vendor_source_flag);

return t_stat;

end;