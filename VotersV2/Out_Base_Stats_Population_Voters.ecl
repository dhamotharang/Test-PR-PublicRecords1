import STRATA;

rPopulationStats_VotersV2__File_Voters_Base
 :=
  record
    CountGroup 									   := count(group); 
    VotersV2.File_Voters_Base.source_state;
	rid_CountNonZero                               := sum(group,if(VotersV2.File_Voters_Base.rid<>0,1,0));
	did_CountNonZero                               := sum(group,if(VotersV2.File_Voters_Base.did<>0,1,0));
    did_score_CountNonZero                         := sum(group,if(VotersV2.File_Voters_Base.did_score<>0,1,0));
    ssn_CountNonBlank                              := sum(group,if(VotersV2.File_Voters_Base.ssn<>'',1,0));
    vtid_CountNonZero                              := sum(group,if(VotersV2.File_Voters_Base.vtid<>0,1,0));
    process_date_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.process_date<>'',1,0));
    date_first_seen_CountNonBlank                  := sum(group,if(VotersV2.File_Voters_Base.date_first_seen<>'',1,0));
    date_last_seen_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.date_last_seen<>'',1,0));
    Source_CountNonBlank                           := sum(group,if(VotersV2.File_Voters_Base.Source<>'',1,0));
    file_id_CountNonBlank                          := sum(group,if(VotersV2.File_Voters_Base.file_id<>'',1,0));
    vendor_id_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.vendor_id<>'',1,0));
    source_code_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.source_code<>'',1,0));
    file_acquired_date_CountNonBlank               := sum(group,if(VotersV2.File_Voters_Base.file_acquired_date<>'',1,0));
    use_code_CountNonBlank                         := sum(group,if(VotersV2.File_Voters_Base.use_code<>'',1,0));
    name_type_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.name_type<>'',1,0));
    prefix_title_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.prefix_title<>'',1,0));
    last_name_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.last_name<>'',1,0));
    first_name_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.first_name<>'',1,0));
    middle_name_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.middle_name<>'',1,0));
    maiden_prior_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.maiden_prior<>'',1,0));
    clean_maiden_pri_CountNonBlank                 := sum(group,if(VotersV2.File_Voters_Base.clean_maiden_pri<>'',1,0));
    name_suffix_in_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.name_suffix_in<>'',1,0));
    voterfiller_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.voterfiller<>'',1,0));
		source_voterId_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.source_voterId<>'',1,0));		
    dob_CountNonBlank                              := sum(group,if(VotersV2.File_Voters_Base.dob<>'',1,0));
    ageCat_CountNonBlank                           := sum(group,if(VotersV2.File_Voters_Base.ageCat<>'',1,0));
    ageCat_exp_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.ageCat_exp<>'',1,0));
    headHousehold_CountNonBlank                    := sum(group,if(VotersV2.File_Voters_Base.headHousehold<>'',1,0));
    place_of_birth_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.place_of_birth<>'',1,0));
    occupation_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.occupation<>'',1,0));
    maiden_name_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.maiden_name<>'',1,0));
    motorVoterId_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.motorVoterId<>'',1,0));
    regSource_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.regSource<>'',1,0));
    regDate_CountNonBlank                          := sum(group,if(VotersV2.File_Voters_Base.regDate<>'',1,0));
    race_CountNonBlank                             := sum(group,if(VotersV2.File_Voters_Base.race<>'',1,0));
    race_exp_CountNonBlank                         := sum(group,if(VotersV2.File_Voters_Base.race_exp<>'',1,0));
    gender_CountNonBlank                           := sum(group,if(VotersV2.File_Voters_Base.gender<>'',1,0));
    political_party_CountNonBlank                  := sum(group,if(VotersV2.File_Voters_Base.political_party<>'',1,0));
    politicalparty_exp_CountNonBlank               := sum(group,if(VotersV2.File_Voters_Base.politicalparty_exp<>'',1,0));
    phone_CountNonBlank                            := sum(group,if(VotersV2.File_Voters_Base.phone<>'',1,0));
    work_phone_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.work_phone<>'',1,0));
    other_phone_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.other_phone<>'',1,0));
    active_status_CountNonBlank                    := sum(group,if(VotersV2.File_Voters_Base.active_status<>'',1,0));
    active_status_exp_CountNonBlank                := sum(group,if(VotersV2.File_Voters_Base.active_status_exp<>'',1,0));
    GenderSurNamGuess_CountNonBlank                := sum(group,if(VotersV2.File_Voters_Base.GenderSurNamGuess<>'',1,0));
    active_other_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.active_other<>'',1,0));
    voter_status_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.voter_status<>'',1,0));
    voter_status_exp_CountNonBlank                 := sum(group,if(VotersV2.File_Voters_Base.voter_status_exp<>'',1,0));
    res_Addr1_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.res_Addr1<>'',1,0));
    res_Addr2_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.res_Addr2<>'',1,0));
    res_city_CountNonBlank                         := sum(group,if(VotersV2.File_Voters_Base.res_city<>'',1,0));
    res_state_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.res_state<>'',1,0));
    res_zip_CountNonBlank                          := sum(group,if(VotersV2.File_Voters_Base.res_zip<>'',1,0));
    res_county_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.res_county<>'',1,0));
    mail_addr1_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.mail_addr1<>'',1,0));
    mail_addr2_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.mail_addr2<>'',1,0));
    mail_city_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.mail_city<>'',1,0));
    mail_state_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.mail_state<>'',1,0));
    mail_zip_CountNonBlank                         := sum(group,if(VotersV2.File_Voters_Base.mail_zip<>'',1,0));
    mail_county_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.mail_county<>'',1,0));
    addr_filler1_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.addr_filler1<>'',1,0));
    addr_filler2_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.addr_filler2<>'',1,0));
    city_filler_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.city_filler<>'',1,0));
    state_filler_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.state_filler<>'',1,0));
    zip_filler_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.zip_filler<>'',1,0));
    TimeZoneTbl_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.TimeZoneTbl<>'',1,0));
    towncode_CountNonBlank                         := sum(group,if(VotersV2.File_Voters_Base.towncode<>'',1,0));
    distcode_CountNonBlank                         := sum(group,if(VotersV2.File_Voters_Base.distcode<>'',1,0));
    countycode_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.countycode<>'',1,0));
    schoolcode_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.schoolcode<>'',1,0));
    cityInOut_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.cityInOut<>'',1,0));
    spec_dist1_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.spec_dist1<>'',1,0));
    spec_dist2_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.spec_dist2<>'',1,0));
    precinct1_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.precinct1<>'',1,0));
    precinct2_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.precinct2<>'',1,0));
    precinct3_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.precinct3<>'',1,0));
    villagePrecinct_CountNonBlank                  := sum(group,if(VotersV2.File_Voters_Base.villagePrecinct<>'',1,0));
    schoolPrecinct_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.schoolPrecinct<>'',1,0));
    ward_CountNonBlank                             := sum(group,if(VotersV2.File_Voters_Base.ward<>'',1,0));
    precinct_cityTown_CountNonBlank                := sum(group,if(VotersV2.File_Voters_Base.precinct_cityTown<>'',1,0));
    ANCSMDinDC_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.ANCSMDinDC<>'',1,0));
    cityCouncilDist_CountNonBlank                  := sum(group,if(VotersV2.File_Voters_Base.cityCouncilDist<>'',1,0));
    countyCommDist_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.countyCommDist<>'',1,0));
    stateHouse_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.stateHouse<>'',1,0));
    stateSenate_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.stateSenate<>'',1,0));
    USHouse_CountNonBlank                          := sum(group,if(VotersV2.File_Voters_Base.USHouse<>'',1,0));
    elemSchoolDist_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.elemSchoolDist<>'',1,0));
    schoolDist_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.schoolDist<>'',1,0));
    schoolFiller_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.schoolFiller<>'',1,0));
    CommCollDist_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.CommCollDist<>'',1,0));
    dist_filler_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.dist_filler<>'',1,0));
    municipal_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.municipal<>'',1,0));
    VillageDist_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.VillageDist<>'',1,0));
    PoliceJury_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.PoliceJury<>'',1,0));
    PoliceDist_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.PoliceDist<>'',1,0));
    PublicServComm_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.PublicServComm<>'',1,0));
    Rescue_CountNonBlank                           := sum(group,if(VotersV2.File_Voters_Base.Rescue<>'',1,0));
    Fire_CountNonBlank                             := sum(group,if(VotersV2.File_Voters_Base.Fire<>'',1,0));
    Sanitary_CountNonBlank                         := sum(group,if(VotersV2.File_Voters_Base.Sanitary<>'',1,0));
    SewerDist_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.SewerDist<>'',1,0));
    WaterDist_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.WaterDist<>'',1,0));
    MosquitoDist_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.MosquitoDist<>'',1,0));
    TaxDist_CountNonBlank                          := sum(group,if(VotersV2.File_Voters_Base.TaxDist<>'',1,0));
    SupremeCourt_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.SupremeCourt<>'',1,0));
    JusticeOfPeace_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.JusticeOfPeace<>'',1,0));
    JudicialDist_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.JudicialDist<>'',1,0));
    SuperiorCtDist_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.SuperiorCtDist<>'',1,0));
    AppealsCt_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.AppealsCt<>'',1,0));
    CourtFIller_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.CourtFIller<>'',1,0));
    CassAddrTypTbl_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.CassAddrTypTbl<>'',1,0));
    CassDelivPointCd_CountNonBlank                 := sum(group,if(VotersV2.File_Voters_Base.CassDelivPointCd<>'',1,0));
    CassCarrierRteTbl_CountNonBlank                := sum(group,if(VotersV2.File_Voters_Base.CassCarrierRteTbl<>'',1,0));
    BlkGrpEnumDist_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.BlkGrpEnumDist<>'',1,0));
    CongressionalDist_CountNonBlank                := sum(group,if(VotersV2.File_Voters_Base.CongressionalDist<>'',1,0));
    Lattitude_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.Lattitude<>'',1,0));
    CountyFips_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.CountyFips<>'',1,0));
    CensusTract_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.CensusTract<>'',1,0));
    FipsStCountyCd_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.FipsStCountyCd<>'',1,0));
    Longitude_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.Longitude<>'',1,0));
    LastDateVote_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.LastDateVote<>'',1,0));
    MiscVoteHist_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.MiscVoteHist<>'',1,0));
    title_CountNonBlank                            := sum(group,if(VotersV2.File_Voters_Base.title<>'',1,0));
    fname_CountNonBlank                            := sum(group,if(VotersV2.File_Voters_Base.fname<>'',1,0));
    mname_CountNonBlank                            := sum(group,if(VotersV2.File_Voters_Base.mname<>'',1,0));
    lname_CountNonBlank                            := sum(group,if(VotersV2.File_Voters_Base.lname<>'',1,0));
    name_suffix_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.name_suffix<>'',1,0));
    name_score_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.name_score<>'',1,0));
    addr_type_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.addr_type<>'',1,0));
		prim_range_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.prim_range<>'',1,0));
    predir_CountNonBlank                           := sum(group,if(VotersV2.File_Voters_Base.predir<>'',1,0));
    prim_name_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.addr_suffix<>'',1,0));
    postdir_CountNonBlank                          := sum(group,if(VotersV2.File_Voters_Base.postdir<>'',1,0));
    unit_desig_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.unit_desig<>'',1,0));
    sec_range_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.sec_range<>'',1,0));
    p_city_name_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.v_city_name<>'',1,0));
    st_CountNonBlank                               := sum(group,if(VotersV2.File_Voters_Base.st<>'',1,0));
    zip_CountNonBlank                              := sum(group,if(VotersV2.File_Voters_Base.zip<>'',1,0));
    zip4_CountNonBlank                             := sum(group,if(VotersV2.File_Voters_Base.zip4<>'',1,0));
    cart_CountNonBlank                             := sum(group,if(VotersV2.File_Voters_Base.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                       := sum(group,if(VotersV2.File_Voters_Base.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                              := sum(group,if(VotersV2.File_Voters_Base.lot<>'',1,0));
    lot_order_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.lot_order<>'',1,0));
    dpbc_CountNonBlank                             := sum(group,if(VotersV2.File_Voters_Base.dpbc<>'',1,0));
    chk_digit_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.chk_digit<>'',1,0));
    rec_type_CountNonBlank                         := sum(group,if(VotersV2.File_Voters_Base.rec_type<>'',1,0));
    ace_fips_st_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.ace_fips_st<>'',1,0));
    fips_county_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.fips_county<>'',1,0));
    geo_lat_CountNonBlank                          := sum(group,if(VotersV2.File_Voters_Base.geo_lat<>'',1,0));
    geo_long_CountNonBlank                         := sum(group,if(VotersV2.File_Voters_Base.geo_long<>'',1,0));
    msa_CountNonBlank                              := sum(group,if(VotersV2.File_Voters_Base.msa<>'',1,0));
    geo_blk_CountNonBlank                          := sum(group,if(VotersV2.File_Voters_Base.geo_blk<>'',1,0));
    geo_match_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.geo_match<>'',1,0));
    err_stat_CountNonBlank                         := sum(group,if(VotersV2.File_Voters_Base.err_stat<>'',1,0));
    mail_prim_range_CountNonBlank                  := sum(group,if(VotersV2.File_Voters_Base.mail_prim_range<>'',1,0));
    mail_predir_CountNonBlank                      := sum(group,if(VotersV2.File_Voters_Base.mail_predir<>'',1,0));
    mail_prim_name_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.mail_prim_name<>'',1,0));
    mail_addr_suffix_CountNonBlank                 := sum(group,if(VotersV2.File_Voters_Base.mail_addr_suffix<>'',1,0));
    mail_postdir_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.mail_postdir<>'',1,0));
    mail_unit_desig_CountNonBlank                  := sum(group,if(VotersV2.File_Voters_Base.mail_unit_desig<>'',1,0));
    mail_sec_range_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.mail_sec_range<>'',1,0));
    mail_p_city_name_CountNonBlank                 := sum(group,if(VotersV2.File_Voters_Base.mail_p_city_name<>'',1,0));
    mail_v_city_name_CountNonBlank                 := sum(group,if(VotersV2.File_Voters_Base.mail_v_city_name<>'',1,0));
    mail_st_CountNonBlank                          := sum(group,if(VotersV2.File_Voters_Base.mail_st<>'',1,0));
    mail_ace_zip_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.mail_ace_zip<>'',1,0));
    mail_zip4_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.mail_zip4<>'',1,0));
    mail_cart_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.mail_cart<>'',1,0));
    mail_cr_sort_sz_CountNonBlank                  := sum(group,if(VotersV2.File_Voters_Base.mail_cr_sort_sz<>'',1,0));
    mail_lot_CountNonBlank                         := sum(group,if(VotersV2.File_Voters_Base.mail_lot<>'',1,0));
    mail_lot_order_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.mail_lot_order<>'',1,0));
    mail_dpbc_CountNonBlank                        := sum(group,if(VotersV2.File_Voters_Base.mail_dpbc<>'',1,0));
    mail_chk_digit_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.mail_chk_digit<>'',1,0));
    mail_rec_type_CountNonBlank                    := sum(group,if(VotersV2.File_Voters_Base.mail_rec_type<>'',1,0));
    mail_ace_fips_st_CountNonBlank                 := sum(group,if(VotersV2.File_Voters_Base.mail_ace_fips_st<>'',1,0));
    mail_fips_county_CountNonBlank                 := sum(group,if(VotersV2.File_Voters_Base.mail_fips_county<>'',1,0));
    mail_geo_lat_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.mail_geo_lat<>'',1,0));
    mail_geo_long_CountNonBlank                    := sum(group,if(VotersV2.File_Voters_Base.mail_geo_long<>'',1,0));
    mail_msa_CountNonBlank                         := sum(group,if(VotersV2.File_Voters_Base.mail_msa<>'',1,0));
    mail_geo_blk_CountNonBlank                     := sum(group,if(VotersV2.File_Voters_Base.mail_geo_blk<>'',1,0));
    mail_geo_match_CountNonBlank                   := sum(group,if(VotersV2.File_Voters_Base.mail_geo_match<>'',1,0));
    mail_err_stat_CountNonBlank                    := sum(group,if(VotersV2.File_Voters_Base.mail_err_stat<>'',1,0));
  end;

dPopulationStats_VotersV2__File_Voters_Base := table(VotersV2.File_Voters_Base,
                                                      rPopulationStats_VotersV2__File_Voters_Base,
                                                      source_state,
																										  few
									                                   );


Layout_out := record
  string2 state_code := '';
	VotersV2.Layout_Voters_VoteHistory;
end;

vh_base := distribute(VotersV2.File_Voters_VoteHistory_base, vtid);

v_base  := distribute(VotersV2.File_Voters_Base, vtid);

Layout_out getStateCode(v_base l, vh_base r) := transform
 self.state_code := l.source_state;
 self := r; 
end;

out_vh_base := join(v_base, vh_base, left.vtid = right.vtid,
                    getStateCode(left, right), left outer, local);
										

rPopulationStats_VotersV2__File_Voters_VoteHistory_Base
 :=
  record
    out_vh_base.state_code;
		vh_vtid_CountNonZero            := sum(group,if(out_vh_base.vtid<>0,1,0));
    voted_year_CountNonBlank        := sum(group,if(out_vh_base.voted_year<>'',1,0));
    primary_CountNonBlank           := sum(group,if(out_vh_base.primary<>'',1,0));
    special_1_CountNonBlank         := sum(group,if(out_vh_base.special_1<>'',1,0));
    other_CountNonBlank             := sum(group,if(out_vh_base.other<>'',1,0));
    special_2_CountNonBlank         := sum(group,if(out_vh_base.special_2<>'',1,0));
    general_CountNonBlank           := sum(group,if(out_vh_base.general<>'',1,0));
		pres_CountNonBlank              := sum(group,if(out_vh_base.pres<>'',1,0));    
	end;

dPopulationStats_VotersV2__File_Voters_VoteHistory_Base := table(out_vh_base,
                                                      rPopulationStats_VotersV2__File_Voters_VoteHistory_Base,
                                                      state_code,
																										  few
									                                   );
Layout_full_stats := record
    string source_state;
		integer CountGroup;
		integer rid_CountNonZero;
    integer did_CountNonZero;
    integer did_score_CountNonZero;
    integer ssn_CountNonBlank;
    integer vtid_CountNonZero;
    integer process_date_CountNonBlank;
    integer date_first_seen_CountNonBlank;
    integer date_last_seen_CountNonBlank;
    integer Source_CountNonBlank;
    integer file_id_CountNonBlank;
    integer vendor_id_CountNonBlank;
    integer source_code_CountNonBlank;
    integer file_acquired_date_CountNonBlank;
    integer use_code_CountNonBlank;
    integer name_type_CountNonBlank;
    integer prefix_title_CountNonBlank;
    integer last_name_CountNonBlank;
    integer first_name_CountNonBlank;
    integer middle_name_CountNonBlank;
    integer maiden_prior_CountNonBlank;
    integer clean_maiden_pri_CountNonBlank;
    integer name_suffix_in_CountNonBlank;
    integer voterfiller_CountNonBlank;
    integer source_voterId_CountNonBlank;
    integer dob_CountNonBlank;
    integer ageCat_CountNonBlank;
    integer ageCat_exp_CountNonBlank;
    integer headHousehold_CountNonBlank;
    integer place_of_birth_CountNonBlank;
    integer occupation_CountNonBlank;
    integer maiden_name_CountNonBlank;
    integer motorVoterId_CountNonBlank;
    integer regSource_CountNonBlank;
    integer regDate_CountNonBlank;
    integer race_CountNonBlank;
    integer race_exp_CountNonBlank;
    integer gender_CountNonBlank;
    integer political_party_CountNonBlank;
    integer politicalparty_exp_CountNonBlank;
    integer phone_CountNonBlank;
    integer work_phone_CountNonBlank;
    integer other_phone_CountNonBlank;
    integer active_status_CountNonBlank;
    integer active_status_exp_CountNonBlank;
    integer GenderSurNamGuess_CountNonBlank;
    integer active_other_CountNonBlank;
    integer voter_status_CountNonBlank;
    integer voter_status_exp_CountNonBlank;
    integer res_Addr1_CountNonBlank;
    integer res_Addr2_CountNonBlank;
    integer res_city_CountNonBlank;
    integer res_state_CountNonBlank;
    integer res_zip_CountNonBlank;
    integer res_county_CountNonBlank;
    integer mail_addr1_CountNonBlank;
    integer mail_addr2_CountNonBlank;
    integer mail_city_CountNonBlank;
    integer mail_state_CountNonBlank;
    integer mail_zip_CountNonBlank;
    integer mail_county_CountNonBlank;
    integer addr_filler1_CountNonBlank;
    integer addr_filler2_CountNonBlank;
    integer city_filler_CountNonBlank;
    integer state_filler_CountNonBlank;
    integer zip_filler_CountNonBlank;
    integer TimeZoneTbl_CountNonBlank;
    integer towncode_CountNonBlank;
    integer distcode_CountNonBlank;
    integer countycode_CountNonBlank;
    integer schoolcode_CountNonBlank;
    integer cityInOut_CountNonBlank;
    integer spec_dist1_CountNonBlank;
    integer spec_dist2_CountNonBlank;
    integer precinct1_CountNonBlank;
    integer precinct2_CountNonBlank;
    integer precinct3_CountNonBlank;
    integer villagePrecinct_CountNonBlank;
    integer schoolPrecinct_CountNonBlank;
    integer ward_CountNonBlank;
    integer precinct_cityTown_CountNonBlank;
    integer ANCSMDinDC_CountNonBlank;
    integer cityCouncilDist_CountNonBlank;
    integer countyCommDist_CountNonBlank;
    integer stateHouse_CountNonBlank;
    integer stateSenate_CountNonBlank;
    integer USHouse_CountNonBlank;
    integer elemSchoolDist_CountNonBlank;
    integer schoolDist_CountNonBlank;
    integer schoolFiller_CountNonBlank;
    integer CommCollDist_CountNonBlank;
    integer dist_filler_CountNonBlank;
    integer municipal_CountNonBlank;
    integer VillageDist_CountNonBlank;
    integer PoliceJury_CountNonBlank;
    integer PoliceDist_CountNonBlank;
    integer PublicServComm_CountNonBlank;
    integer Rescue_CountNonBlank;
    integer Fire_CountNonBlank;
    integer Sanitary_CountNonBlank;
    integer SewerDist_CountNonBlank;
    integer WaterDist_CountNonBlank;
    integer MosquitoDist_CountNonBlank;
    integer TaxDist_CountNonBlank;
    integer SupremeCourt_CountNonBlank;
    integer JusticeOfPeace_CountNonBlank;
    integer JudicialDist_CountNonBlank;
    integer SuperiorCtDist_CountNonBlank;
    integer AppealsCt_CountNonBlank;
    integer CourtFIller_CountNonBlank;
    integer CassAddrTypTbl_CountNonBlank;
    integer CassDelivPointCd_CountNonBlank;
    integer CassCarrierRteTbl_CountNonBlank;
    integer BlkGrpEnumDist_CountNonBlank;
    integer CongressionalDist_CountNonBlank;
    integer Lattitude_CountNonBlank;
    integer CountyFips_CountNonBlank;
    integer CensusTract_CountNonBlank;
    integer FipsStCountyCd_CountNonBlank;
    integer Longitude_CountNonBlank;
    integer LastDateVote_CountNonBlank;
    integer MiscVoteHist_CountNonBlank;
    integer title_CountNonBlank;
    integer fname_CountNonBlank;
    integer mname_CountNonBlank;
    integer lname_CountNonBlank;
    integer name_suffix_CountNonBlank;
    integer name_score_CountNonBlank;
    integer addr_type_CountNonBlank;
    integer prim_range_CountNonBlank;
    integer predir_CountNonBlank;
    integer prim_name_CountNonBlank;
    integer addr_suffix_CountNonBlank;
    integer postdir_CountNonBlank;
    integer unit_desig_CountNonBlank;
    integer sec_range_CountNonBlank;
    integer p_city_name_CountNonBlank;
    integer v_city_name_CountNonBlank;
    integer st_CountNonBlank;
    integer zip_CountNonBlank;
    integer zip4_CountNonBlank;
    integer cart_CountNonBlank;
    integer cr_sort_sz_CountNonBlank;
    integer lot_CountNonBlank;
    integer lot_order_CountNonBlank;
    integer dpbc_CountNonBlank;
    integer chk_digit_CountNonBlank;
    integer rec_type_CountNonBlank;
    integer ace_fips_st_CountNonBlank;
    integer fips_county_CountNonBlank;
    integer geo_lat_CountNonBlank;
    integer geo_long_CountNonBlank;
    integer msa_CountNonBlank;
    integer geo_blk_CountNonBlank;
    integer geo_match_CountNonBlank;
    integer err_stat_CountNonBlank;
    integer mail_prim_range_CountNonBlank;
    integer mail_predir_CountNonBlank;
    integer mail_prim_name_CountNonBlank;
    integer mail_addr_suffix_CountNonBlank;
    integer mail_postdir_CountNonBlank;
    integer mail_unit_desig_CountNonBlank;
    integer mail_sec_range_CountNonBlank;
    integer mail_p_city_name_CountNonBlank;
    integer mail_v_city_name_CountNonBlank;
    integer mail_st_CountNonBlank;
    integer mail_ace_zip_CountNonBlank;
    integer mail_zip4_CountNonBlank;
    integer mail_cart_CountNonBlank;
    integer mail_cr_sort_sz_CountNonBlank;
    integer mail_lot_CountNonBlank;
    integer mail_lot_order_CountNonBlank;
    integer mail_dpbc_CountNonBlank;
    integer mail_chk_digit_CountNonBlank;
    integer mail_rec_type_CountNonBlank;
    integer mail_ace_fips_st_CountNonBlank;
    integer mail_fips_county_CountNonBlank;
    integer mail_geo_lat_CountNonBlank;
    integer mail_geo_long_CountNonBlank;
    integer mail_msa_CountNonBlank;
    integer mail_geo_blk_CountNonBlank;
    integer mail_geo_match_CountNonBlank;
    integer mail_err_stat_CountNonBlank; 
    integer vh_vtid_CountNonZero;   
    integer voted_year_CountNonBlank;
    integer primary_CountNonBlank;          
    integer special_1_CountNonBlank;        
    integer other_CountNonBlank;            
    integer special_2_CountNonBlank;
    integer general_CountNonBlank;          
    integer pres_CountNonBlank;              
end;	

Layout_full_stats trfJoinStats(dPopulationStats_VotersV2__File_Voters_Base l, 
															 dPopulationStats_VotersV2__File_Voters_VoteHistory_Base r) := transform
 self := l;
 self.vh_vtid_CountNonZero     := r.vh_vtid_CountNonZero;
 self.voted_year_CountNonBlank := r.voted_year_CountNonBlank;
 self.primary_CountNonBlank    := r.primary_CountNonBlank;
 self.special_1_CountNonBlank  := r.special_1_CountNonBlank;
 self.other_CountNonBlank      := r.other_CountNonBlank;
 self.special_2_CountNonBlank  := r.special_2_CountNonBlank;
 self.general_CountNonBlank    := r.general_CountNonBlank;
 self.pres_CountNonBlank       := r.pres_CountNonBlank;
end;

dPopulationStats_VotersV2_File_Base := join(dPopulationStats_VotersV2__File_Voters_Base,
																						 dPopulationStats_VotersV2__File_Voters_VoteHistory_Base,
																						 left.source_state = right.state_code,
																						 trfJoinStats(left,right));

STRATA.createXMLStats(dPopulationStats_VotersV2_File_Base,
						'eMerges',
						'votersV2',
					    VotersV2.version,
					    '',
					    resultsOut,
						'view',
						'population'
					  );

export Out_Base_Stats_Population_Voters := resultsOut;