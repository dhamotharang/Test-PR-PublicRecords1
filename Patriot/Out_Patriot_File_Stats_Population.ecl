import STRATA;

EXPORT Out_Patriot_File_Stats_Population(pVersion,zOut) := MACRO

rPopulationStats_Patriot__File_Patriot
 :=
  record
    CountGroup                                                       := count(group);
    pty_key_CountNonBlank                        := sum(group,if(Patriot.File_Patriot.pty_key<>'',1,0));
    Patriot.File_Patriot.source;
    orig_pty_name_CountNonBlank                  := sum(group,if(Patriot.File_Patriot.orig_pty_name<>'',1,0));
    orig_vessel_name_CountNonBlank               := sum(group,if(Patriot.File_Patriot.orig_vessel_name<>'',1,0));
    country_CountNonBlank                        := sum(group,if(Patriot.File_Patriot.country<>'',1,0));
    name_type_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.name_type<>'',1,0));
    addr_1_CountNonBlank                         := sum(group,if(Patriot.File_Patriot.addr_1<>'',1,0));
    addr_2_CountNonBlank                         := sum(group,if(Patriot.File_Patriot.addr_2<>'',1,0));
    addr_3_CountNonBlank                         := sum(group,if(Patriot.File_Patriot.addr_3<>'',1,0));
    addr_4_CountNonBlank                         := sum(group,if(Patriot.File_Patriot.addr_4<>'',1,0));
    addr_5_CountNonBlank                         := sum(group,if(Patriot.File_Patriot.addr_5<>'',1,0));
    addr_6_CountNonBlank                         := sum(group,if(Patriot.File_Patriot.addr_6<>'',1,0));
    addr_7_CountNonBlank                         := sum(group,if(Patriot.File_Patriot.addr_7<>'',1,0));
    addr_8_CountNonBlank                         := sum(group,if(Patriot.File_Patriot.addr_8<>'',1,0));
    addr_9_CountNonBlank                         := sum(group,if(Patriot.File_Patriot.addr_9<>'',1,0));
    addr_10_CountNonBlank                        := sum(group,if(Patriot.File_Patriot.addr_10<>'',1,0));
    remarks_1_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.remarks_1<>'',1,0));
    remarks_2_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.remarks_2<>'',1,0));
    remarks_3_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.remarks_3<>'',1,0));
    remarks_4_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.remarks_4<>'',1,0));
    remarks_5_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.remarks_5<>'',1,0));
    remarks_6_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.remarks_6<>'',1,0));
    remarks_7_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.remarks_7<>'',1,0));
    remarks_8_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.remarks_8<>'',1,0));
    remarks_9_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.remarks_9<>'',1,0));
    remarks_10_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_10<>'',1,0));
    remarks_11_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_11<>'',1,0));
    remarks_12_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_12<>'',1,0));
    remarks_13_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_13<>'',1,0));
    remarks_14_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_14<>'',1,0));
    remarks_15_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_15<>'',1,0));
    remarks_16_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_16<>'',1,0));
    remarks_17_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_17<>'',1,0));
    remarks_18_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_18<>'',1,0));
    remarks_19_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_19<>'',1,0));
    remarks_20_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_20<>'',1,0));
    remarks_21_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_21<>'',1,0));
    remarks_22_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_22<>'',1,0));
    remarks_23_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_23<>'',1,0));
    remarks_24_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_24<>'',1,0));
    remarks_25_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_25<>'',1,0));
    remarks_26_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_26<>'',1,0));
    remarks_27_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_27<>'',1,0));
    remarks_28_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_28<>'',1,0));
    remarks_29_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_29<>'',1,0));
    remarks_30_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.remarks_30<>'',1,0));
    cname_CountNonBlank                          := sum(group,if(Patriot.File_Patriot.cname<>'',1,0));
    title_CountNonBlank                          := sum(group,if(Patriot.File_Patriot.title<>'',1,0));
    fname_CountNonBlank                          := sum(group,if(Patriot.File_Patriot.fname<>'',1,0));
    mname_CountNonBlank                          := sum(group,if(Patriot.File_Patriot.mname<>'',1,0));
    lname_CountNonBlank                          := sum(group,if(Patriot.File_Patriot.lname<>'',1,0));
    suffix_CountNonBlank                         := sum(group,if(Patriot.File_Patriot.suffix<>'',1,0));
    a_score_CountNonBlank                        := sum(group,if(Patriot.File_Patriot.a_score<>'',1,0));
    prim_range_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.prim_range<>'',1,0));
    predir_CountNonBlank                         := sum(group,if(Patriot.File_Patriot.predir<>'',1,0));
    prim_name_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                    := sum(group,if(Patriot.File_Patriot.addr_suffix<>'',1,0));
    postdir_CountNonBlank                        := sum(group,if(Patriot.File_Patriot.postdir<>'',1,0));
    unit_desig_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.unit_desig<>'',1,0));
    sec_range_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.sec_range<>'',1,0));
    p_city_name_CountNonBlank                    := sum(group,if(Patriot.File_Patriot.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                    := sum(group,if(Patriot.File_Patriot.v_city_name<>'',1,0));
    st_CountNonBlank                             := sum(group,if(Patriot.File_Patriot.st<>'',1,0));
    zip_CountNonBlank                            := sum(group,if(Patriot.File_Patriot.zip<>'',1,0));
    zip4_CountNonBlank                           := sum(group,if(Patriot.File_Patriot.zip4<>'',1,0));
    cart_CountNonBlank                           := sum(group,if(Patriot.File_Patriot.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                     := sum(group,if(Patriot.File_Patriot.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                            := sum(group,if(Patriot.File_Patriot.lot<>'',1,0));
    lot_order_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.lot_order<>'',1,0));
    dpbc_CountNonBlank                           := sum(group,if(Patriot.File_Patriot.dpbc<>'',1,0));
    chk_digit_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.chk_digit<>'',1,0));
    record_type_CountNonBlank                    := sum(group,if(Patriot.File_Patriot.record_type<>'',1,0));
    ace_fips_st_CountNonBlank                    := sum(group,if(Patriot.File_Patriot.ace_fips_st<>'',1,0));
    county_CountNonBlank                         := sum(group,if(Patriot.File_Patriot.county<>'',1,0));
    geo_lat_CountNonBlank                        := sum(group,if(Patriot.File_Patriot.geo_lat<>'',1,0));
    geo_long_CountNonBlank                       := sum(group,if(Patriot.File_Patriot.geo_long<>'',1,0));
    msa_CountNonBlank                            := sum(group,if(Patriot.File_Patriot.msa<>'',1,0));
    geo_blk_CountNonBlank                        := sum(group,if(Patriot.File_Patriot.geo_blk<>'',1,0));
    geo_match_CountNonBlank                      := sum(group,if(Patriot.File_Patriot.geo_match<>'',1,0));
    err_stat_CountNonBlank                       := sum(group,if(Patriot.File_Patriot.err_stat<>'',1,0));
  end;

dPopulationStats_Patriot__File_Patriot
	:= table(Patriot.File_Patriot
			,rPopulationStats_Patriot__File_Patriot
			,source
			,few
			);

STRATA.createXMLStats(dPopulationStats_Patriot__File_Patriot
					 ,'Patriot'
					 ,'Patriot File'
					 ,pVersion
					 ,''
					 ,zOut
					 );

ENDMACRO;
