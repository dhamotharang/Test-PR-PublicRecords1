import STRATA, CourtLink;

export Out_Strata_Population_Stats(string pversion) := function

ds := courtlink.files().base.qa;

rPopulationStats_ds
 :=
  record
    CountGroup                                             := count(group);
    dt_first_seen_CountNonZero                           := sum(group,if(ds.dt_first_seen<>0,1,0));
    dt_last_seen_CountNonZero                            := sum(group,if(ds.dt_last_seen<>0,1,0));
    dt_vendor_first_reported_CountNonZero                := sum(group,if(ds.dt_vendor_first_reported<>0,1,0));
    dt_vendor_last_reported_CountNonZero                 := sum(group,if(ds.dt_vendor_last_reported<>0,1,0));
    record_type_CountNonBlank                            := sum(group,if(ds.record_type<>'',1,0));
    RecId_CountNonBlank                                  := sum(group,if(ds.RecId<>'',1,0));
    CourtState_CountNonBlank                             := sum(group,if(ds.CourtState<>'',1,0));
    CourtID_CountNonBlank                                := sum(group,if(ds.CourtID<>'',1,0));
    CourtName_CountNonBlank                              := sum(group,if(ds.CourtName<>'',1,0));
    DocketNumber_CountNonBlank                           := sum(group,if(ds.DocketNumber<>'',1,0));
    OfficeName_CountNonBlank                             := sum(group,if(ds.OfficeName<>'',1,0));
    AsOfDate_CountNonBlank                               := sum(group,if(ds.AsOfDate<>'',1,0));
    ClassCode_CountNonBlank                              := sum(group,if(ds.ClassCode<>'',1,0));
    CaseCaption_CountNonBlank                            := sum(group,if(ds.CaseCaption<>'',1,0));
    DateFiled_CountNonBlank                              := sum(group,if(ds.DateFiled<>'',1,0));
    JudgeTitle_CountNonBlank                             := sum(group,if(ds.JudgeTitle<>'',1,0));
    JudgeName_CountNonBlank                              := sum(group,if(ds.JudgeName<>'',1,0));
    ReferredToJudgeTitle_CountNonBlank                   := sum(group,if(ds.ReferredToJudgeTitle<>'',1,0));
    ReferredToJudge_CountNonBlank                        := sum(group,if(ds.ReferredToJudge<>'',1,0));
    JuryDemand_CountNonBlank                             := sum(group,if(ds.JuryDemand<>'',1,0));
    DemandAmount_CountNonBlank                           := sum(group,if(ds.DemandAmount<>'',1,0));
    SuitNatureCode_CountNonBlank                         := sum(group,if(ds.SuitNatureCode<>'',1,0));
    SuitNatureDesc_CountNonBlank                         := sum(group,if(ds.SuitNatureDesc<>'',1,0));
    LeadDocketNumber_CountNonBlank                       := sum(group,if(ds.LeadDocketNumber<>'',1,0));
    Jurisdiction_CountNonBlank                           := sum(group,if(ds.Jurisdiction<>'',1,0));
    Cause_CountNonBlank                                  := sum(group,if(ds.Cause<>'',1,0));
    Statute_CountNonBlank                                := sum(group,if(ds.Statute<>'',1,0));
    CA_CountNonBlank                                     := sum(group,if(ds.CA<>'',1,0));
    CaseClosed_CountNonBlank                             := sum(group,if(ds.CaseClosed<>'',1,0));
    DateRetrieved_CountNonBlank                          := sum(group,if(ds.DateRetrieved<>'',1,0));
    OtherDocketNumber_CountNonBlank                      := sum(group,if(ds.OtherDocketNumber<>'',1,0));
    LitigantName_CountNonBlank                           := sum(group,if(ds.LitigantName<>'',1,0));
    LitigantLabel_CountNonBlank                          := sum(group,if(ds.LitigantLabel<>'',1,0));
    LayoutCode_CountNonBlank                             := sum(group,if(ds.LayoutCode<>'',1,0));
    TerminationDate_CountNonBlank                        := sum(group,if(ds.TerminationDate<>'',1,0));
    AttorneyName_CountNonBlank                           := sum(group,if(ds.AttorneyName<>'',1,0));
    AttorneyLabel_CountNonBlank                          := sum(group,if(ds.AttorneyLabel<>'',1,0));
    FirmName_CountNonBlank                               := sum(group,if(ds.FirmName<>'',1,0));
    Address_CountNonBlank                                := sum(group,if(ds.Address<>'',1,0));
    City_CountNonBlank                                   := sum(group,if(ds.City<>'',1,0));
    State_CountNonBlank                                  := sum(group,if(ds.State<>'',1,0));
    Zipcode_CountNonBlank                                := sum(group,if(ds.Zipcode<>'',1,0));
    Country_CountNonBlank                                := sum(group,if(ds.Country<>'',1,0));
    AddtlInfo_CountNonBlank                              := sum(group,if(ds.AddtlInfo<>'',1,0));
    TermDate_CountNonBlank                               := sum(group,if(ds.TermDate<>'',1,0));
    bdid_CountNonZero                                    := sum(group,if(ds.bdid<>0,1,0));
    did_CountNonZero                                     := sum(group,if(ds.did<>0,1,0));
    causeCode_CountNonBlank                              := sum(group,if(ds.causeCode<>'',1,0));
    judge_title_CountNonBlank                            := sum(group,if(ds.judge_title<>'',1,0));
    judge_fname_CountNonBlank                            := sum(group,if(ds.judge_fname<>'',1,0));
    judge_mname_CountNonBlank                            := sum(group,if(ds.judge_mname<>'',1,0));
    judge_lname_CountNonBlank                            := sum(group,if(ds.judge_lname<>'',1,0));
    judge_suffix_CountNonBlank                           := sum(group,if(ds.judge_suffix<>'',1,0));
    judge_score_CountNonBlank                            := sum(group,if(ds.judge_score<>'',1,0));
    business_person_CountNonBlank                        := sum(group,if(ds.business_person<>'',1,0));
    debtor_CountNonBlank                                 := sum(group,if(ds.debtor<>'',1,0));
    debtor_title_CountNonBlank                           := sum(group,if(ds.debtor_title<>'',1,0));
    debtor_fname_CountNonBlank                           := sum(group,if(ds.debtor_fname<>'',1,0));
    debtor_mname_CountNonBlank                           := sum(group,if(ds.debtor_mname<>'',1,0));
    debtor_lname_CountNonBlank                           := sum(group,if(ds.debtor_lname<>'',1,0));
    debtor_suffix_CountNonBlank                          := sum(group,if(ds.debtor_suffix<>'',1,0));
    debtor_score_CountNonBlank                           := sum(group,if(ds.debtor_score<>'',1,0));
    attorney_title_CountNonBlank                         := sum(group,if(ds.attorney_title<>'',1,0));
    attorney_fname_CountNonBlank                         := sum(group,if(ds.attorney_fname<>'',1,0));
    attorney_mname_CountNonBlank                         := sum(group,if(ds.attorney_mname<>'',1,0));
    attorney_lname_CountNonBlank                         := sum(group,if(ds.attorney_lname<>'',1,0));
    attorney_suffix_CountNonBlank                        := sum(group,if(ds.attorney_suffix<>'',1,0));
    attorney_score_CountNonBlank                         := sum(group,if(ds.attorney_score<>'',1,0));
    prim_range_CountNonBlank                             := sum(group,if(ds.prim_range<>'',1,0));
    predir_CountNonBlank                                 := sum(group,if(ds.predir<>'',1,0));
    prim_name_CountNonBlank                              := sum(group,if(ds.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                            := sum(group,if(ds.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                := sum(group,if(ds.postdir<>'',1,0));
    unit_desig_CountNonBlank                             := sum(group,if(ds.unit_desig<>'',1,0));
    sec_range_CountNonBlank                              := sum(group,if(ds.sec_range<>'',1,0));
    p_city_name_CountNonBlank                            := sum(group,if(ds.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                            := sum(group,if(ds.v_city_name<>'',1,0));
    st_CountNonBlank                                     := sum(group,if(ds.st<>'',1,0));
    zip_CountNonBlank                                    := sum(group,if(ds.zip<>'',1,0));
    zip4_CountNonBlank                                   := sum(group,if(ds.zip4<>'',1,0));
    cart_CountNonBlank                                   := sum(group,if(ds.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                             := sum(group,if(ds.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                    := sum(group,if(ds.lot<>'',1,0));
    lot_order_CountNonBlank                              := sum(group,if(ds.lot_order<>'',1,0));
    dbpc_CountNonBlank                                   := sum(group,if(ds.dbpc<>'',1,0));
    chk_digit_CountNonBlank                              := sum(group,if(ds.chk_digit<>'',1,0));
    rec_type_CountNonBlank                               := sum(group,if(ds.rec_type<>'',1,0));
    fips_state_CountNonBlank                             := sum(group,if(ds.fips_state<>'',1,0));
    fips_county_CountNonBlank                            := sum(group,if(ds.fips_county<>'',1,0));
    geo_lat_CountNonBlank                                := sum(group,if(ds.geo_lat<>'',1,0));
    geo_long_CountNonBlank                               := sum(group,if(ds.geo_long<>'',1,0));
    msa_CountNonBlank                                    := sum(group,if(ds.msa<>'',1,0));
    geo_blk_CountNonBlank                                := sum(group,if(ds.geo_blk<>'',1,0));
    geo_match_CountNonBlank                              := sum(group,if(ds.geo_match<>'',1,0));
    err_stat_CountNonBlank                               := sum(group,if(ds.err_stat<>'',1,0));
  end;


dPopulationStats_CourtLink := table(ds,rPopulationStats_ds,few);                                                               

STRATA.createXMLStats(dPopulationStats_CourtLink,
                        'CourtLink',
						'base',
						pversion,
						'',
						resultsOut,
						'view',
						'population'
					   );
		 
 return resultsOut;
 
 end;