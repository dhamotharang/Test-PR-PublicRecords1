import STRATA,TaxPro;

export Strata_Pop_Base(string pVersion) := function


rPopulationStats_TAXPRO
 :=
  record
    integer countGroup 									 := count(group);
	dt_first_seen_CountNonZero                           := sum(group,if(File_base.dt_first_seen<>0,1,0));
    dt_last_seen_CountNonZero                            := sum(group,if(File_base.dt_last_seen<>0,1,0));
    dt_vendor_first_reported_CountNonZero                := sum(group,if(File_base.dt_vendor_first_reported<>0,1,0));
    dt_vendor_last_reported_CountNonZero                 := sum(group,if(File_base.dt_vendor_last_reported<>0,1,0));
    firstnm_CountNonZero                                 := sum(group,if(File_base.firstnm<>'',1,0));
    midinit_CountNonZero                                 := sum(group,if(File_base.midinit<>'',1,0));
    lastnm_CountNonZero                                  := sum(group,if(File_base.lastnm<>'',1,0));
    company_CountNonZero                                 := sum(group,if(File_base.company<>'',1,0));
    occupation_CountNonZero                              := sum(group,if(File_base.occupation<>'',1,0));
    enroll_year_CountNonZero                             := sum(group,if(File_base.enroll_year<>'',1,0));
    addr1_CountNonZero                                   := sum(group,if(File_base.addr1<>'',1,0));
    addr2_CountNonZero                                   := sum(group,if(File_base.addr2<>'',1,0));
    addr3_CountNonZero                                   := sum(group,if(File_base.addr3<>'',1,0));
    city_CountNonZero                                    := sum(group,if(File_base.city<>'',1,0));
    state_CountNonZero                                   := sum(group,if(File_base.state<>'',1,0));
    zip_CountNonZero                                     := sum(group,if(File_base.zip<>'',1,0));
    country_CountNonZero                                 := sum(group,if(File_base.country<>'',1,0));
    title_CountNonZero                                   := sum(group,if(File_base.name.title<>'',1,0));
    fname_CountNonZero                                   := sum(group,if(File_base.name.fname<>'',1,0));
    mname_CountNonZero                                   := sum(group,if(File_base.name.mname<>'',1,0));
    lname_CountNonZero                                   := sum(group,if(File_base.name.lname<>'',1,0));
    name_suffix_CountNonZero                             := sum(group,if(File_base.name.name_suffix<>'',1,0));
    name_score_CountNonZero                              := sum(group,if(File_base.name.name_score<>'',1,0));
    prim_range_CountNonZero                              := sum(group,if(File_base.addr.prim_range<>'',1,0));
    predir_CountNonZero                                  := sum(group,if(File_base.addr.predir<>'',1,0));
    prim_name_CountNonZero                               := sum(group,if(File_base.addr.prim_name<>'',1,0));
    suffix_CountNonZero                                  := sum(group,if(File_base.addr.addr_suffix<>'',1,0));
    postdir_CountNonZero                                 := sum(group,if(File_base.addr.postdir<>'',1,0));
    unit_desig_CountNonZero                              := sum(group,if(File_base.addr.unit_desig<>'',1,0));
    sec_range_CountNonZero                               := sum(group,if(File_base.addr.sec_range<>'',1,0));
    p_city_name_CountNonZero                             := sum(group,if(File_base.addr.p_city_name<>'',1,0));
    v_city_name_CountNonZero                             := sum(group,if(File_base.addr.v_city_name<>'',1,0));
    st_CountNonZero                                      := sum(group,if(File_base.addr.st<>'',1,0));
    zip5_CountNonZero                                    := sum(group,if(File_base.addr.zip5<>'',1,0));
    zip4_CountNonZero                                    := sum(group,if(File_base.addr.zip4<>'',1,0));
    cart_CountNonZero                                    := sum(group,if(File_base.addr.cart<>'',1,0));
    cr_sort_sz_CountNonZero                              := sum(group,if(File_base.addr.cr_sort_sz<>'',1,0));
    lot_CountNonZero                                     := sum(group,if(File_base.addr.lot<>'',1,0));
    lot_order_CountNonZero                               := sum(group,if(File_base.addr.lot_order<>'',1,0));
    rec_type_CountNonZero                                := sum(group,if(File_base.addr.addr_rec_type<>'',1,0));
    ace_fips_st_CountNonZero                             := sum(group,if(File_base.addr.fips_state<>'',1,0));
    ace_fips_county_CountNonZero                         := sum(group,if(File_base.addr.fips_county<>'',1,0));
    geo_lat_CountNonZero                                 := sum(group,if(File_base.addr.geo_lat<>'',1,0));
    geo_long_CountNonZero                                := sum(group,if(File_base.addr.geo_long<>'',1,0));
    msa_CountNonZero                                     := sum(group,if(File_base.addr.cbsa<>'',1,0));
    geo_blk_CountNonZero                                 := sum(group,if(File_base.addr.geo_blk<>'',1,0));
    geo_match_CountNonZero                               := sum(group,if(File_base.addr.geo_match<>'',1,0));
    err_stat_CountNonZero                                := sum(group,if(File_base.addr.err_stat<>'',1,0));
    ssn_CountNonZero                                     := sum(group,if(File_base.ssn<>'',1,0));
    did_CountNonZero                                     := sum(group,if(File_base.did<>0,1,0));
    did_score_CountNonZero                               := sum(group,if(File_base.did_score<>0,1,0));
    bdid_CountNonZero                                    := sum(group,if(File_base.bdid<>0,1,0));
    bdid_score_CountNonZero                              := sum(group,if(File_base.bdid_score<>0,1,0));
  end;

rDIDstatsDID := record
  integer countGroup := count(group);
  File_Base.source;
  File_Base.State;
  Has_DID 	 := sum(group,IF((unsigned6)File_Base(name.lname <> '').did <> 0,1,0))/sum(group,IF(File_Base.name.lname <> '',1,0)) * 100;
  has_bdid   := sum(group,IF((unsigned6)File_Base(company <> '').bdid <> 0,1,0))/sum(group,IF(File_Base.company <> '',1,0)) * 100;
end;
	dPopulationStats_dMain := table(group(sort(distribute(File_base,hash( State)), State, source, local)
									  ,State, source, local) 
	                                  ,rPopulationStats_TAXPRO, State, source, local
                                      ,few);

	STRATA.createXMLStats(dPopulationStats_dMain
	                     ,'TaxPro'
						 ,'Base'
						 ,pVersion
						 ,''
						 ,zBaseStats
						 ,'view'
						 ,'Population');


					 
//output party DID stats	
				 
	dDIDstats              := table(group(sort(distribute(File_Base,hash( State)), State, source, local)
									  ,State, source, local) 
									  ,rDIDstatsDID,State, source, local,few);
    
	STRATA.createXMLStats(dDIDstats
	                     ,'TaxPro'
						 ,'Base'
						 ,pVersion
						 ,''
						 ,zDIDStats
						 ,'view'
					     ,'DIDStats');

zOut := parallel(zBaseStats,zDIDStats);
return zout; 
end;