export out_STRATA_population_stats(pMain
                                  ,pVersion
								  ,zOut) := MACRO

import STRATA;

	#uniquename(rPopulationStats_pMain);
	#uniquename(dPopulationStats_pMain);
	#uniquename(zMainStats);

%rPopulationStats_pMain%
 :=
  record
    CountGroup                                           := count(group);
    pmain.st ; 
	pmain.name_type ;
	pmain.addr_type ; 

   orig_name_prefix_CountNonBlank                      := sum(group,if(pmain.orig_name_prefix<>'',1,0));
   orig_first_name_CountNonBlank                       := sum(group,if(pmain.orig_first_name<>'',1,0));
   orig_middle_name_CountNonBlank                      := sum(group,if(pmain.orig_middle_name<>'',1,0));
   orig_last_name_CountNonBlank                        := sum(group,if(pmain.orig_last_name<>'',1,0));
   orig_name_suffix_CountNonBlank                      := sum(group,if(pmain.orig_name_suffix<>'',1,0));
    ssn_CountNonBlank                                   := sum(group,if(pmain.ssn<>'',1,0));
    phone_CountNonBlank                                 := sum(group,if(pmain.phone<>'',1,0));
    orig_filing_dt_CountNonBlank                        := sum(group,if(pmain.orig_filing_dt<>'',1,0));
    last_activity_dt_CountNonBlank                      := sum(group,if(pmain.last_activity_dt<>'',1,0));
    orig_dob_dd_appended_CountNonBlank                  := sum(group,if(pmain.orig_dob_dd_appended<>'',1,0));
    orig_gender_CountNonBlank                           := sum(group,if(pmain.orig_gender<>'',1,0));
    alias1_CountNonBlank                                := sum(group,if(pmain.alias1<>'',1,0));
    alias2_CountNonBlank                                := sum(group,if(pmain.alias2<>'',1,0));
    alias3_CountNonBlank                                := sum(group,if(pmain.alias3<>'',1,0));
    orig_addr_street_blob_CountNonBlank                 := sum(group,if(pmain.orig_addr_street_blob<>'',1,0));
    orig_house_number_CountNonBlank                     := sum(group,if(pmain.orig_house_number<>'',1,0));
    orig_predir_CountNonBlank                           := sum(group,if(pmain.orig_predir<>'',1,0));
    orig_street_name_CountNonBlank                      := sum(group,if(pmain.orig_street_name<>'',1,0));
    orig_street_suffix_CountNonBlank                    := sum(group,if(pmain.orig_street_suffix<>'',1,0));
    orig_postdir_CountNonBlank                          := sum(group,if(pmain.orig_postdir<>'',1,0));
    orig_apt_no_CountNonBlank                           := sum(group,if(pmain.orig_apt_no<>'',1,0));
    orig_city_CountNonBlank                             := sum(group,if(pmain.orig_city<>'',1,0));
    orig_st_CountNonBlank                               := sum(group,if(pmain.orig_st<>'',1,0));
    orig_zip_CountNonBlank                              := sum(group,if(pmain.orig_zip<>'',1,0));
    orig_zip4_CountNonBlank                             := sum(group,if(pmain.orig_zip4<>'',1,0));
    orig_crrt_CountNonBlank                             := sum(group,if(pmain.orig_crrt<>'',1,0));
    effective_dt_CountNonBlank                          := sum(group,if(pmain.effective_dt<>'',1,0));
    prev1_addr_CountNonBlank                            := sum(group,if(pmain.prev1_addr<>'',1,0));
    prev1_addr_effective_dt_CountNonBlank               := sum(group,if(pmain.prev1_addr_effective_dt<>'',1,0));
    prev2_addr_CountNonBlank                            := sum(group,if(pmain.prev2_addr<>'',1,0));
    prev2_addr_effective_dt_CountNonBlank               := sum(group,if(pmain.prev2_addr_effective_dt<>'',1,0));
    prev3_addr_CountNonBlank                            := sum(group,if(pmain.prev3_addr<>'',1,0));
    prev3_addr_effective_dt_CountNonBlank               := sum(group,if(pmain.prev3_addr_effective_dt<>'',1,0));
    prev4_addr_CountNonBlank                            := sum(group,if(pmain.prev4_addr<>'',1,0));
    prev4_addr_effective_dt_CountNonBlank               := sum(group,if(pmain.prev4_addr_effective_dt<>'',1,0));
    prev5_addr_CountNonBlank                            := sum(group,if(pmain.prev5_addr<>'',1,0));
    prev5_addr_effective_dt_CountNonBlank               := sum(group,if(pmain.prev5_addr_effective_dt<>'',1,0));
    title_CountNonBlank                                 := sum(group,if(pmain.title<>'',1,0));
    fname_CountNonBlank                                 := sum(group,if(pmain.fname<>'',1,0));
    mname_CountNonBlank                                 := sum(group,if(pmain.mname<>'',1,0));
    lname_CountNonBlank                                 := sum(group,if(pmain.lname<>'',1,0));
    name_suffix_CountNonBlank                           := sum(group,if(pmain.name_suffix<>'',1,0));
    name_score_CountNonBlank                            := sum(group,if(pmain.name_score<>'',1,0));
    //name_type_CountNonBlank                             := sum(group,if(pmain.name_type<>'',1,0));
    prim_range_CountNonBlank                            := sum(group,if(pmain.prim_range<>'',1,0));
    predir_CountNonBlank                                := sum(group,if(pmain.predir<>'',1,0));
    prim_name_CountNonBlank                             := sum(group,if(pmain.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                           := sum(group,if(pmain.addr_suffix<>'',1,0));
    postdir_CountNonBlank                               := sum(group,if(pmain.postdir<>'',1,0));
    unit_desig_CountNonBlank                            := sum(group,if(pmain.unit_desig<>'',1,0));
    sec_range_CountNonBlank                             := sum(group,if(pmain.sec_range<>'',1,0));
    p_city_name_CountNonBlank                           := sum(group,if(pmain.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                           := sum(group,if(pmain.v_city_name<>'',1,0));
    
	//st_CountNonBlank                                    := sum(group,if(pmain.st<>'',1,0));
   
    zip_CountNonBlank                                   := sum(group,if(pmain.zip<>'',1,0));
    zip4_CountNonBlank                                  := sum(group,if(pmain.zip4<>'',1,0));
    cart_CountNonBlank                                  := sum(group,if(pmain.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                            := sum(group,if(pmain.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                   := sum(group,if(pmain.lot<>'',1,0));
    lot_order_CountNonBlank                             := sum(group,if(pmain.lot_order<>'',1,0));
    dbpc_CountNonBlank                                  := sum(group,if(pmain.dbpc<>'',1,0));
    chk_digit_CountNonBlank                             := sum(group,if(pmain.chk_digit<>'',1,0));
    rec_type_CountNonBlank                              := sum(group,if(pmain.rec_type<>'',1,0));
    county_CountNonBlank                                := sum(group,if(pmain.county<>'',1,0));
    geo_lat_CountNonBlank                               := sum(group,if(pmain.geo_lat<>'',1,0));
    geo_long_CountNonBlank                              := sum(group,if(pmain.geo_long<>'',1,0));
    msa_CountNonBlank                                   := sum(group,if(pmain.msa<>'',1,0));
    geo_blk_CountNonBlank                               := sum(group,if(pmain.geo_blk<>'',1,0));
    geo_match_CountNonBlank                             := sum(group,if(pmain.geo_match<>'',1,0));
    err_stat_CountNonBlank                              := sum(group,if(pmain.err_stat<>'',1,0));
    addr_type_CountNonBlank                             := sum(group,if(pmain.addr_type<>'',1,0));
	dwelling_type_CountNonBlank                         := sum(group,if(pmain.dwelling_type<>'',1,0));
    fips_county_CountNonBlank                           := sum(group,if(pmain.fips_county<>'',1,0));
    ncoa_cd_CountNonBlank                               := sum(group,if(pmain.ncoa_cd<>'',1,0));
    ncoa_dt_CountNonBlank                               := sum(group,if(pmain.ncoa_dt<>'',1,0));
    unique_id_CountNonBlank                             := sum(group,if(pmain.unique_id<>'',1,0));
    record_type_CountNonBlank                           := sum(group,if(pmain.record_type<>'',1,0));
    boca_id_CountNonZero                                := sum(group,if(pmain.boca_id<>0,1,0));
    which_ssn_CountNonBlank                             := sum(group,if(pmain.which_ssn<>'',1,0));
    did_CountNonZero                                    := sum(group,if(pmain.did<>0,1,0));
    append_ssn_CountNonBlank                            := sum(group,if(pmain.append_ssn<>'',1,0));
    
  end;


//output main stats
	%dPopulationStats_pMain% := table(pMain
	                                  ,%rPopulationStats_pMain%,st,name_type,addr_type
									  ,few);

	STRATA.createXMLStats(%dPopulationStats_pMain%
	                     ,'Infutor'
						 ,'tracker'
						 ,pVersion
						 ,''
						 ,%zMainStats%
						 ,'view'
						 ,'Population');


zOut := %zMainStats% 

ENDMACRO;
