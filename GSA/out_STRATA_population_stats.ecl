import STRATA, GSA;

export out_STRATA_population_stats(string fileDate) := function

ds := gsa.File_GSA_Base;

rPopulationStats
 :=
  record
    string3  grouping                              := 'ALL';
    CountGroup                                     := count(group);
    DotID_CountNonZero		                 				 := sum(group,if(ds.DotID<>0,1,0));
    DotScore_CountNonZero                 				 := sum(group,if(ds.DotScore<>0,1,0));
    DotWeight_CountNonZero                         := sum(group,if(ds.DotWeight<>0,1,0));
    EmpID_CountNonZero	                           := sum(group,if(ds.EmpID<>0,1,0));
    EmpScore_CountNonZero                          := sum(group,if(ds.EmpScore<>0,1,0));
    EmpWeight_CountNonZero                         := sum(group,if(ds.EmpWeight<>0,1,0));
    POWID_CountNonZero		                         := sum(group,if(ds.POWID<>0,1,0));
    POWScore_CountNonZero                          := sum(group,if(ds.POWScore<>0,1,0));
    POWWeight_CountNonZero                         := sum(group,if(ds.POWWeight<>0,1,0));
    ProxID_CountNonZero	                           := sum(group,if(ds.ProxID<>0,1,0));
    ProxScore_CountNonZero                         := sum(group,if(ds.ProxScore<>0,1,0));
    ProxWeight_CountNonZero                        := sum(group,if(ds.ProxWeight<>0,1,0));
    SELEID_CountNonZero	                           := sum(group,if(ds.SELEID<>0,1,0));
    SELEScore_CountNonZero                         := sum(group,if(ds.SELEScore<>0,1,0));
    SELEWeight_CountNonZero                        := sum(group,if(ds.SELEWeight<>0,1,0));	
    OrgID_CountNonZero		                         := sum(group,if(ds.OrgID<>0,1,0));
    OrgScore_CountNonZero                          := sum(group,if(ds.OrgScore<>0,1,0));
    OrgWeight_CountNonZero                         := sum(group,if(ds.OrgWeight<>0,1,0));
    UltID_CountNonZero		                         := sum(group,if(ds.UltID<>0,1,0));
    UltScore_CountNonZero                          := sum(group,if(ds.UltScore<>0,1,0));
    UltWeight_CountNonZero                         := sum(group,if(ds.UltWeight<>0,1,0));			
    gsa_id_CountNonZero                            := sum(group,if(ds.gsa_id<>0,1,0));
    bdid_CountNonZero                              := sum(group,if(ds.bdid<>0,1,0));
    ExclusionType_CountNonBlank                    := sum(group,if(ds.ExclusionType<>'',1,0));
    SAM_number_CountNonBlank                       := sum(group,if(ds.SAM_number<>'',1,0));
    SAM_record_status_CountNonBlank                := sum(group,if(ds.SAM_record_status<>'',1,0));
    did_CountNonZero                               := sum(group,if(ds.did<>0,1,0));
    dt_last_seen_CountNonBlank                     := sum(group,if(ds.dt_last_seen<>'',1,0));
    primary_aka_name_CountNonBlank                 := sum(group,if(ds.primary_aka_name<>'',1,0));
    Name_CountNonBlank                             := sum(group,if(ds.Name<>'',1,0));
    Classification_CountNonBlank                   := sum(group,if(ds.Classification<>'',1,0));
    CTType_CountNonBlank                           := sum(group,if(ds.CTType<>'',1,0));
    Description_CountNonBlank                      := sum(group,if(ds.Description<>'',1,0));
    Street1_CountNonBlank                          := sum(group,if(ds.Street1<>'',1,0));
    Street2_CountNonBlank                          := sum(group,if(ds.Street2<>'',1,0));
    Street3_CountNonBlank                          := sum(group,if(ds.Street3<>'',1,0));
    City_CountNonBlank                             := sum(group,if(ds.City<>'',1,0));
    ZIP_CountNonBlank                              := sum(group,if(ds.ZIP<>'',1,0));
    Province_CountNonBlank                         := sum(group,if(ds.Province<>'',1,0));
    State_CountNonBlank                            := sum(group,if(ds.State<>'',1,0));
    Country_CountNonBlank                          := sum(group,if(ds.Country<>'',1,0));
    DUNS_CountNonBlank                             := sum(group,if(ds.DUNS<>'',1,0));
    dType_CountNonBlank                            := sum(group,if(ds.dType<>'',1,0));
    dValue_CountNonBlank                           := sum(group,if(ds.dValue<>'',1,0));
    ActionDate_CountNonBlank                       := sum(group,if(ds.ActionDate<>'',1,0));
    TermDate_CountNonBlank                         := sum(group,if(ds.TermDate<>'',1,0));
    TermDateIndefinite_CountNonBlank               := sum(group,if(ds.TermDateIndefinite<>'',1,0));
    TermDatePermanent_CountNonBlank                := sum(group,if(ds.TermDatePermanent<>'',1,0));
    TermType_CountNonBlank                         := sum(group,if(ds.TermType<>'',1,0));
    CTCode_CountNonBlank                           := sum(group,if(ds.CTCode<>'',1,0));
    AgencyComponent_CountNonBlank                  := sum(group,if(ds.AgencyComponent<>'',1,0));
    oldCTCode_CountNonBlank                        := sum(group,if(ds.oldCTCode<>'',1,0));
    oldAgencyComponent_CountNonBlank               := sum(group,if(ds.oldAgencyComponent<>'',1,0));
    ActionStatus_CountNonBlank                     := sum(group,if(ds.ActionStatus<>'',1,0));
    EPLSCreateDate_CountNonBlank                   := sum(group,if(ds.EPLSCreateDate<>'',1,0));
    EPLSModDate_CountNonBlank                      := sum(group,if(ds.EPLSModDate<>'',1,0));
    title_CountNonBlank                            := sum(group,if(ds.title<>'',1,0));
    fname_CountNonBlank                            := sum(group,if(ds.fname<>'',1,0));
    mname_CountNonBlank                            := sum(group,if(ds.mname<>'',1,0));
    lname_CountNonBlank                            := sum(group,if(ds.lname<>'',1,0));
    name_suffix_CountNonBlank                      := sum(group,if(ds.name_suffix<>'',1,0));
    name_score_CountNonBlank                       := sum(group,if(ds.name_score<>'',1,0));
    prim_range_CountNonBlank                       := sum(group,if(ds.prim_range<>'',1,0));
    predir_CountNonBlank                           := sum(group,if(ds.predir<>'',1,0));
    prim_name_CountNonBlank                        := sum(group,if(ds.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                      := sum(group,if(ds.addr_suffix<>'',1,0));
    postdir_CountNonBlank                          := sum(group,if(ds.postdir<>'',1,0));
    unit_desig_CountNonBlank                       := sum(group,if(ds.unit_desig<>'',1,0));
    sec_range_CountNonBlank                        := sum(group,if(ds.sec_range<>'',1,0));
    p_city_name_CountNonBlank                      := sum(group,if(ds.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                      := sum(group,if(ds.v_city_name<>'',1,0));
    st_CountNonBlank                               := sum(group,if(ds.st<>'',1,0));
    zip5_CountNonBlank                             := sum(group,if(ds.zip5<>'',1,0));
    zip4_CountNonBlank                             := sum(group,if(ds.zip4<>'',1,0));
    cart_CountNonBlank                             := sum(group,if(ds.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                       := sum(group,if(ds.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                              := sum(group,if(ds.lot<>'',1,0));
    lot_order_CountNonBlank                        := sum(group,if(ds.lot_order<>'',1,0));
    dbpc_CountNonBlank                             := sum(group,if(ds.dbpc<>'',1,0));
    chk_digit_CountNonBlank                        := sum(group,if(ds.chk_digit<>'',1,0));
    rec_type_CountNonBlank                         := sum(group,if(ds.rec_type<>'',1,0));
    county_CountNonBlank                           := sum(group,if(ds.county<>'',1,0));
    geo_lat_CountNonBlank                          := sum(group,if(ds.geo_lat<>'',1,0));
    geo_long_CountNonBlank                         := sum(group,if(ds.geo_long<>'',1,0));
    msa_CountNonBlank                              := sum(group,if(ds.msa<>'',1,0));
    geo_blk_CountNonBlank                          := sum(group,if(ds.geo_blk<>'',1,0));
    geo_match_CountNonBlank                        := sum(group,if(ds.geo_match<>'',1,0));
    err_stat_CountNonBlank                         := sum(group,if(ds.err_stat<>'',1,0));
		Append_RawAID_CountNonBlank                    := sum(group,if(ds.Append_RawAID<>0,1,0));
		Append_ACEAID_CountNonBlank                    := sum(group,if(ds.Append_ACEAID<>0,1,0));  
  end;

dPopulationStats_GSA := table(ds,rPopulationStats,few);                                                               

STRATA.createXMLStats(dPopulationStats_GSA,
                        'GSA',
						'data_samV1',
						fileDate,
						'',
						resultsOut,
						'view',
						'population'
					   );
		 
 return resultsOut;
 
 end;