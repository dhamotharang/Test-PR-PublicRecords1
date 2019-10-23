import strata;

export strata_popFileQsentBase(string pversion) := function;
ds := Phonesplus.file_Qsent_base;

rPopulationStats_file_Qsent_base
 :=
  record
		string3  grouping                                   := 'ALL';
    CountGroup                                          := count(group);		
    DateVendorFirstReported_CountNonZero                := sum(group,if(ds.DateVendorFirstReported<>0,1,0));
    DateVendorLastReported_CountNonZero                 := sum(group,if(ds.DateVendorLastReported<>0,1,0));
    DateFirstSeen_CountNonZero                          := sum(group,if(ds.DateFirstSeen<>0,1,0));
    DateLastSeen_CountNonZero                           := sum(group,if(ds.DateLastSeen<>0,1,0));
    dt_nonglb_last_seen_CountNonZero                    := sum(group,if(ds.dt_nonglb_last_seen<>0,1,0));
    glb_dppa_flag_CountNonBlank                         := sum(group,if(ds.glb_dppa_flag<>'',1,0));
    ActiveFlag_CountNonBlank                            := sum(group,if(ds.ActiveFlag<>'',1,0));
    CellPhoneIDKey_CountNonZero                         := sum(group,if(ds.CellPhoneIDKey<>(data)0,1,0));
    Initscore_CountNonZero                              := sum(group,if(ds.Initscore<>0,1,0));
    InitScoreType_CountNonBlank                         := sum(group,if(ds.InitScoreType<>'',1,0));
    LnameMatch_CountNonZero                             := sum(group,if(ds.LnameMatch<>0,1,0));
    FnameMatch_CountNonZero                             := sum(group,if(ds.FnameMatch<>0,1,0));
    ConfidenceScore_CountNonZero                        := sum(group,if(ds.ConfidenceScore<>0,1,0));
    RecordKey_CountNonBlank                             := sum(group,if(ds.RecordKey<>'',1,0));
    Vendor_CountNonBlank                                := sum(group,if(ds.Vendor<>'',1,0));
    StateOrigin_CountNonBlank                           := sum(group,if(ds.StateOrigin<>'',1,0));
    SourceFile_CountNonBlank                            := sum(group,if(ds.SourceFile<>'',1,0));
    src_CountNonBlank                                   := sum(group,if(ds.src<>'',1,0));
    OrigName_CountNonBlank                              := sum(group,if(ds.OrigName<>'',1,0));
    NameFormat_CountNonBlank                            := sum(group,if(ds.NameFormat<>'',1,0));
    Address1_CountNonBlank                              := sum(group,if(ds.Address1<>'',1,0));
    Address2_CountNonBlank                              := sum(group,if(ds.Address2<>'',1,0));
    Address3_CountNonBlank                              := sum(group,if(ds.Address3<>'',1,0));
    OrigCity_CountNonBlank                              := sum(group,if(ds.OrigCity<>'',1,0));
    OrigState_CountNonBlank                             := sum(group,if(ds.OrigState<>'',1,0));
    OrigZip_CountNonBlank                               := sum(group,if(ds.OrigZip<>'',1,0));
    Country_CountNonBlank                               := sum(group,if(ds.Country<>'',1,0));
    Dob_CountNonBlank                                   := sum(group,if(ds.Dob<>'',1,0));
    AgeGroup_CountNonBlank                              := sum(group,if(ds.AgeGroup<>'',1,0));
    Gender_CountNonBlank                                := sum(group,if(ds.Gender<>'',1,0));
    Email_CountNonBlank                                 := sum(group,if(ds.Email<>'',1,0));
    HomePhone_CountNonBlank                             := sum(group,if(ds.HomePhone<>'',1,0));
    CellPhone_CountNonBlank								              := sum(group,if(ds.CellPhone<>'',1,0));
    ListingType_CountNonBlank                           := sum(group,if(ds.ListingType<>'',1,0));
    PublishCode_CountNonBlank                           := sum(group,if(ds.PublishCode<>'',1,0));
    Company_CountNonBlank                               := sum(group,if(ds.Company<>'',1,0));
    OrigTitle_CountNonBlank                             := sum(group,if(ds.OrigTitle<>'',1,0));
    RegistrationDate_CountNonZero                       := sum(group,if(ds.RegistrationDate<>0,1,0));
    PhoneModel_CountNonBlank                            := sum(group,if(ds.PhoneModel<>'',1,0));
    IPAddress_CountNonBlank                             := sum(group,if(ds.IPAddress<>'',1,0));
    CarrierCode_CountNonBlank                           := sum(group,if(ds.CarrierCode<>'',1,0));
    CountryCode_CountNonBlank                           := sum(group,if(ds.CountryCode<>'',1,0));
    KeyCode_CountNonBlank                               := sum(group,if(ds.KeyCode<>'',1,0));
    GlobalKeyCode_CountNonBlank                         := sum(group,if(ds.GlobalKeyCode<>'',1,0));
    prim_range_CountNonBlank                            := sum(group,if(ds.prim_range<>'',1,0));
    predir_CountNonBlank                                := sum(group,if(ds.predir<>'',1,0));
    prim_name_CountNonBlank                             := sum(group,if(ds.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                           := sum(group,if(ds.addr_suffix<>'',1,0));
    postdir_CountNonBlank                               := sum(group,if(ds.postdir<>'',1,0));
    unit_desig_CountNonBlank                            := sum(group,if(ds.unit_desig<>'',1,0));
    sec_range_CountNonBlank                             := sum(group,if(ds.sec_range<>'',1,0));
    p_city_name_CountNonBlank                           := sum(group,if(ds.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                           := sum(group,if(ds.v_city_name<>'',1,0));
    state_CountNonBlank									                := sum(group,if(ds.state<>'',1,0));
    zip5_CountNonBlank                                  := sum(group,if(ds.zip5<>'',1,0));
    zip4_CountNonBlank                                  := sum(group,if(ds.zip4<>'',1,0));
    cart_CountNonBlank                                  := sum(group,if(ds.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                            := sum(group,if(ds.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                   := sum(group,if(ds.lot<>'',1,0));
    lot_order_CountNonBlank                             := sum(group,if(ds.lot_order<>'',1,0));
    dpbc_CountNonBlank                                  := sum(group,if(ds.dpbc<>'',1,0));
    chk_digit_CountNonBlank                             := sum(group,if(ds.chk_digit<>'',1,0));
    rec_type_CountNonBlank                              := sum(group,if(ds.rec_type<>'',1,0));
    ace_fips_st_CountNonBlank                           := sum(group,if(ds.ace_fips_st<>'',1,0));
    ace_fips_county_CountNonBlank                       := sum(group,if(ds.ace_fips_county<>'',1,0));
    geo_lat_CountNonBlank                               := sum(group,if(ds.geo_lat<>'',1,0));
    geo_long_CountNonBlank                              := sum(group,if(ds.geo_long<>'',1,0));
    msa_CountNonBlank                                   := sum(group,if(ds.msa<>'',1,0));
    geo_blk_CountNonBlank                               := sum(group,if(ds.geo_blk<>'',1,0));
    geo_match_CountNonBlank                             := sum(group,if(ds.geo_match<>'',1,0));
    err_stat_CountNonBlank                              := sum(group,if(ds.err_stat<>'',1,0));
    title_CountNonBlank                                 := sum(group,if(ds.title<>'',1,0));
    fname_CountNonBlank                                 := sum(group,if(ds.fname<>'',1,0));
    mname_CountNonBlank                                 := sum(group,if(ds.mname<>'',1,0));
    lname_CountNonBlank                                 := sum(group,if(ds.lname<>'',1,0));
    name_suffix_CountNonBlank                           := sum(group,if(ds.name_suffix<>'',1,0));
    name_score_CountNonBlank                            := sum(group,if(ds.name_score<>'',1,0));
    did_CountNonZero                                    := sum(group,if(ds.did<>0,1,0));
    did_score_CountNonBlank                             := sum(group,if(ds.did_score<>'',1,0));
  end;

tStats := table(ds,rPopulationStats_file_Qsent_base,few);

strata.createXMLStats(tStats,'Qsent','data',pversion,'',resultsOut);

return resultsOut;
end;

