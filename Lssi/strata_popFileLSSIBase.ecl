import ut,strata;

ds := Lssi.File_LSSI_Base;

rPopulationStats_File_LSSI_Base
 :=
  record
    
    recid_CountNonBlank                        := sum(group,if(ds.recid<>'',1,0));
    xcode_CountNonBlank                        := sum(group,if(ds.xcode<>'',1,0));
    lsttyp_CountNonBlank                       := sum(group,if(ds.lsttyp<>'',1,0));
    npa_CountNonBlank                          := sum(group,if(ds.npa<>'',1,0));
    telno_CountNonBlank                        := sum(group,if(ds.telno<>'',1,0));
    lststy_CountNonBlank                       := sum(group,if(ds.lststy<>'',1,0));
    indent_CountNonBlank                       := sum(group,if(ds.indent<>'',1,0));
    split_CountNonBlank                        := sum(group,if(ds.split<>'',1,0));
    fsn_CountNonBlank                          := sum(group,if(ds.fsn<>'',1,0));
    ftd_CountNonBlank                          := sum(group,if(ds.ftd<>'',1,0));
    lstnm_CountNonBlank                        := sum(group,if(ds.lstnm<>'',1,0));
    lstgn_CountNonBlank                        := sum(group,if(ds.lstgn<>'',1,0));
    hseno_CountNonBlank                        := sum(group,if(ds.hseno<>'',1,0));
    hsesx_CountNonBlank                        := sum(group,if(ds.hsesx<>'',1,0));
    strt_CountNonBlank                         := sum(group,if(ds.strt<>'',1,0));
    locnm_CountNonBlank                        := sum(group,if(ds.locnm<>'',1,0));
    state_CountNonBlank                        := sum(group,if(ds.state<>'',1,0));
    dirtx_CountNonBlank                        := sum(group,if(ds.dirtx<>'',1,0));
    zip_CountNonBlank                          := sum(group,if(ds.zip<>'',1,0));
    spltx_CountNonBlank                        := sum(group,if(ds.spltx<>'',1,0));
    nstel_CountNonBlank                        := sum(group,if(ds.nstel<>'',1,0));
    county_CountNonBlank                       := sum(group,if(ds.county<>'',1,0));
    geo_lat_CountNonBlank                      := sum(group,if(ds.geo_lat<>'',1,0));
    geo_long_CountNonBlank                     := sum(group,if(ds.geo_long<>'',1,0));
    geo_acc_CountNonBlank                      := sum(group,if(ds.geo_acc<>'',1,0));
    siccode_CountNonBlank                      := sum(group,if(ds.siccode<>'',1,0));
    mailable_CountNonBlank                     := sum(group,if(ds.mailable<>'',1,0));
    prim_range_CountNonBlank                   := sum(group,if(ds.prim_range<>'',1,0));
    predir_CountNonBlank                       := sum(group,if(ds.predir<>'',1,0));
    prim_name_CountNonBlank                    := sum(group,if(ds.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                  := sum(group,if(ds.addr_suffix<>'',1,0));
    postdir_CountNonBlank                      := sum(group,if(ds.postdir<>'',1,0));
    unit_desig_CountNonBlank                   := sum(group,if(ds.unit_desig<>'',1,0));
    sec_range_CountNonBlank                    := sum(group,if(ds.sec_range<>'',1,0));
    p_city_name_CountNonBlank                  := sum(group,if(ds.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                  := sum(group,if(ds.v_city_name<>'',1,0));
    st_CountNonBlank                           := sum(group,if(ds.st<>'',1,0));
    zipcode_CountNonBlank                      := sum(group,if(ds.zipcode<>'',1,0));
    zip4_CountNonBlank                         := sum(group,if(ds.zip4<>'',1,0));
    cart_CountNonBlank                         := sum(group,if(ds.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                   := sum(group,if(ds.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                          := sum(group,if(ds.lot<>'',1,0));
    lot_order_CountNonBlank                    := sum(group,if(ds.lot_order<>'',1,0));
    dbpc_CountNonBlank                         := sum(group,if(ds.dbpc<>'',1,0));
    chk_digit_CountNonBlank                    := sum(group,if(ds.chk_digit<>'',1,0));
    rec_type_CountNonBlank                     := sum(group,if(ds.rec_type<>'',1,0));
    countyname_CountNonBlank                   := sum(group,if(ds.countyname<>'',1,0));
    geo_lat_val_CountNonBlank                  := sum(group,if(ds.geo_lat_val<>'',1,0));
    geo_long_val_CountNonBlank                 := sum(group,if(ds.geo_long_val<>'',1,0));
    msa_CountNonBlank                          := sum(group,if(ds.msa<>'',1,0));
    geo_blk_CountNonBlank                      := sum(group,if(ds.geo_blk<>'',1,0));
    geo_match_CountNonBlank                    := sum(group,if(ds.geo_match<>'',1,0));
    err_stat_CountNonBlank                     := sum(group,if(ds.err_stat<>'',1,0));
    clean_phone_CountNonBlank                  := sum(group,if(ds.clean_phone<>'',1,0));
    title_CountNonBlank                        := sum(group,if(ds.title<>'',1,0));
    fname_CountNonBlank                        := sum(group,if(ds.fname<>'',1,0));
    mname_CountNonBlank                        := sum(group,if(ds.mname<>'',1,0));
    lname_CountNonBlank                        := sum(group,if(ds.lname<>'',1,0));
    name_suffix_CountNonBlank                  := sum(group,if(ds.name_suffix<>'',1,0));
    name_error_CountNonBlank                   := sum(group,if(ds.name_error<>'',1,0));
    clean_compname_CountNonBlank               := sum(group,if(ds.clean_compname<>'',1,0));
    hhid_CountNonZero                          := sum(group,if(ds.hhid<>0,1,0));
    did_CountNonZero                           := sum(group,if(ds.did<>0,1,0));
    did_score_CountNonZero                     := sum(group,if(ds.did_score<>0,1,0));
    b_did_CountNonZero                         := sum(group,if(ds.b_did<>0,1,0));
    b_did_score_CountNonZero                   := sum(group,if(ds.b_did_score<>0,1,0));
    
  end;
    
tStats := table(ds,rPopulationStats_File_LSSI_Base,few);

strata.createXMLStats(tStats,'LSSI: Customer Data','data',ut.GetDate,'',resultsOut);

export strata_popFileLSSIBase := resultsOut;

