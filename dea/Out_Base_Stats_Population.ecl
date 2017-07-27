import STRATA;

export Out_Base_Stats_Population(string filedate) :=
function

rPopulationStats_dea__File_DEA
 :=
  record
	CountGroup                                          := count(group);
    date_first_reported_CountNonBlank                   := sum(group,if(dea.File_DEA_modified.date_first_reported<>'',1,0));
    date_last_reported_CountNonBlank                    := sum(group,if(dea.File_DEA_modified.date_last_reported<>'',1,0));
    Dea_Registration_Number_CountNonBlank               := sum(group,if(dea.File_DEA_modified.Dea_Registration_Number<>'',1,0));
    Business_activity_code_CountNonBlank                := sum(group,if(dea.File_DEA_modified.Business_activity_code<>'',1,0));
    Drug_Schedules_CountNonBlank                        := sum(group,if(dea.File_DEA_modified.Drug_Schedules<>'',1,0));
    Expiration_Date_CountNonBlank                       := sum(group,if(dea.File_DEA_modified.Expiration_Date<>'',1,0));
    Address1_CountNonBlank                              := sum(group,if(dea.File_DEA_modified.Address1<>'',1,0));
    Address2_CountNonBlank                              := sum(group,if(dea.File_DEA_modified.Address2<>'',1,0));
    Address3_CountNonBlank                              := sum(group,if(dea.File_DEA_modified.Address3<>'',1,0));
    Address4_CountNonBlank                              := sum(group,if(dea.File_DEA_modified.Address4<>'',1,0));
    Address5_CountNonBlank                              := sum(group,if(dea.File_DEA_modified.Address5<>'',1,0));
    dea.File_DEA_modified.State;
    Zip_Code_CountNonBlank                              := sum(group,if(dea.File_DEA_modified.Zip_Code<>'',1,0));
    prim_range_CountNonBlank                            := sum(group,if(dea.File_DEA_modified.prim_range<>'',1,0));
    predir_CountNonBlank                                := sum(group,if(dea.File_DEA_modified.predir<>'',1,0));
    prim_name_CountNonBlank                             := sum(group,if(dea.File_DEA_modified.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                           := sum(group,if(dea.File_DEA_modified.addr_suffix<>'',1,0));
    postdir_CountNonBlank                               := sum(group,if(dea.File_DEA_modified.postdir<>'',1,0));
    unit_desig_CountNonBlank                            := sum(group,if(dea.File_DEA_modified.unit_desig<>'',1,0));
    sec_range_CountNonBlank                             := sum(group,if(dea.File_DEA_modified.sec_range<>'',1,0));
    p_city_name_CountNonBlank                           := sum(group,if(dea.File_DEA_modified.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                           := sum(group,if(dea.File_DEA_modified.v_city_name<>'',1,0));
    st_CountNonBlank                                    := sum(group,if(dea.File_DEA_modified.st<>'',1,0));
    zip_CountNonBlank                                   := sum(group,if(dea.File_DEA_modified.zip<>'',1,0));
    zip4_CountNonBlank                                  := sum(group,if(dea.File_DEA_modified.zip4<>'',1,0));
    cart_CountNonBlank                                  := sum(group,if(dea.File_DEA_modified.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                            := sum(group,if(dea.File_DEA_modified.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                   := sum(group,if(dea.File_DEA_modified.lot<>'',1,0));
    lot_order_CountNonBlank                             := sum(group,if(dea.File_DEA_modified.lot_order<>'',1,0));
    dbpc_CountNonBlank                                  := sum(group,if(dea.File_DEA_modified.dbpc<>'',1,0));
    chk_digit_CountNonBlank                             := sum(group,if(dea.File_DEA_modified.chk_digit<>'',1,0));
    rec_type_CountNonBlank                              := sum(group,if(dea.File_DEA_modified.rec_type<>'',1,0));
    county_CountNonBlank                                := sum(group,if(dea.File_DEA_modified.county<>'',1,0));
    geo_lat_CountNonBlank                               := sum(group,if(dea.File_DEA_modified.geo_lat<>'',1,0));
    geo_long_CountNonBlank                              := sum(group,if(dea.File_DEA_modified.geo_long<>'',1,0));
    msa_CountNonBlank                                   := sum(group,if(dea.File_DEA_modified.msa<>'',1,0));
    geo_blk_CountNonBlank                               := sum(group,if(dea.File_DEA_modified.geo_blk<>'',1,0));
    geo_match_CountNonBlank                             := sum(group,if(dea.File_DEA_modified.geo_match<>'',1,0));
    err_stat_CountNonBlank                              := sum(group,if(dea.File_DEA_modified.err_stat<>'',1,0));
    title_CountNonBlank                                 := sum(group,if(dea.File_DEA_modified.title<>'',1,0));
    fname_CountNonBlank                                 := sum(group,if(dea.File_DEA_modified.fname<>'',1,0));
    mname_CountNonBlank                                 := sum(group,if(dea.File_DEA_modified.mname<>'',1,0));
    lname_CountNonBlank                                 := sum(group,if(dea.File_DEA_modified.lname<>'',1,0));
    name_suffix_CountNonBlank                           := sum(group,if(dea.File_DEA_modified.name_suffix<>'',1,0));
    name_score_CountNonBlank                            := sum(group,if(dea.File_DEA_modified.name_score<>'',1,0));
    filler_CountNonZero                                 := sum(group,if(dea.File_DEA_modified.filler<>0,1,0));
    is_company_flag_CountTrue                           := sum(group,if(dea.File_DEA_modified.is_company_flag=TRUE,1,0));
    cname_CountNonBlank                                 := sum(group,if(dea.File_DEA_modified.cname<>'',1,0));
    crlf_CountNonBlank                                  := sum(group,if(dea.File_DEA_modified.crlf<>'',1,0));
    county_name_CountNonBlank                           := sum(group,if(dea.File_DEA_modified.county_name<>'',1,0));
    did_CountNonBlank                                   := sum(group,if(dea.File_DEA_modified.did<>'',1,0));
    score_CountNonBlank                                 := sum(group,if(dea.File_DEA_modified.score<>'',1,0));
    best_ssn_CountNonBlank                              := sum(group,if(dea.File_DEA_modified.best_ssn<>'',1,0));
    bdid_CountNonBlank                                  := sum(group,if(dea.File_DEA_modified.bdid<>'',1,0));
    //Added for BIPV2
    source_rec_id_CountNonZero                          := sum(group,if(dea.File_DEA_modified.source_rec_id<>0,1,0));
    DotID_CountNonZero                                  := sum(group,if(dea.File_DEA_modified.DotID<>0,1,0));
    DotScore_CountNonZero                               := sum(group,if(dea.File_DEA_modified.DotScore<>0,1,0));
    DotWeight_CountNonZero                              := sum(group,if(dea.File_DEA_modified.DotWeight<>0,1,0));
    EmpID_CountNonZero                                  := sum(group,if(dea.File_DEA_modified.EmpID<>0,1,0));
    EmpScore_CountNonZero                               := sum(group,if(dea.File_DEA_modified.EmpScore<>0,1,0));
    EmpWeight_CountNonZero                              := sum(group,if(dea.File_DEA_modified.EmpWeight<>0,1,0));
    POWID_CountNonZero                                  := sum(group,if(dea.File_DEA_modified.POWID<>0,1,0));
    POWScore_CountNonZero                               := sum(group,if(dea.File_DEA_modified.POWScore<>0,1,0));
    POWWeight_CountNonZero                              := sum(group,if(dea.File_DEA_modified.POWWeight<>0,1,0));
    ProxID_CountNonZero                                 := sum(group,if(dea.File_DEA_modified.ProxID<>0,1,0));
    ProxScore_CountNonZero                              := sum(group,if(dea.File_DEA_modified.ProxScore<>0,1,0));
    ProxWeight_CountNonZero                             := sum(group,if(dea.File_DEA_modified.ProxWeight<>0,1,0));
    SELEID_CountNonZero                                 := sum(group,if(dea.File_DEA_modified.SELEID<>0,1,0));
    SELEScore_CountNonZero                              := sum(group,if(dea.File_DEA_modified.SELEScore<>0,1,0));
    SELEWeight_CountNonZero                             := sum(group,if(dea.File_DEA_modified.SELEWeight<>0,1,0));
    OrgID_CountNonZero                                  := sum(group,if(dea.File_DEA_modified.OrgID<>0,1,0));
    OrgScore_CountNonZero                               := sum(group,if(dea.File_DEA_modified.OrgScore<>0,1,0));
    OrgWeight_CountNonZero                              := sum(group,if(dea.File_DEA_modified.OrgWeight<>0,1,0));
    UltID_CountNonZero                                  := sum(group,if(dea.File_DEA_modified.UltID<>0,1,0));
    UltScore_CountNonZero                               := sum(group,if(dea.File_DEA_modified.UltScore<>0,1,0));
    UltWeight_CountNonZero                              := sum(group,if(dea.File_DEA_modified.UltWeight<>0,1,0));
  end;
	
dPopulationStats_DEA__File_DEA := table(dea.File_DEA_modified,
                                        rPopulationStats_DEA__File_DEA,
                                        State,
										                    few
									                     );

STRATA.createXMLStats(dPopulationStats_DEA__File_DEA,
                      'DEA Controlled Substances',
					            'baseV2',
					            filedate,
					            '',
					            resultsOut,
								      'view',
								      'population'
					           );

	  return resultsOut;

end;					 