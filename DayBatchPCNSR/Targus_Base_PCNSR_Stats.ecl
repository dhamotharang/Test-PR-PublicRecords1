import ut,strata,targus;

/*Strata Stats for PCNSR are now generated using the Targus (White Pages) base file, 
since the PCNSR keys are built using this base file.*/

export Targus_Base_PCNSR_Stats(string filedate) := function

ds := Targus.File_consumer_base;

rPopulationStats_File_consumer_base
 :=
  record
		string3  grouping                                     := 'ALL';
    CountGroup                                            := count(group);		    
    dt_first_seen_CountNonZero                            := sum(group,if(ds.dt_first_seen<>0,1,0));
    dt_last_seen_CountNonZero                             := sum(group,if(ds.dt_last_seen<>0,1,0));
    dt_vendor_last_reported_CountNonZero                  := sum(group,if(ds.dt_vendor_last_reported<>0,1,0));
    dt_vendor_first_reported_CountNonZero                 := sum(group,if(ds.dt_vendor_first_reported<>0,1,0));
    rec_type_CountNonBlank                                := sum(group,if(ds.rec_type<>'',1,0));
    hhid_CountNonZero                                     := sum(group,if(ds.hhid<>0,1,0));
    did_CountNonZero                                      := sum(group,if(ds.did<>0,1,0));
    did_score_CountNonZero                                := sum(group,if(ds.did_score<>0,1,0));
    fname_CountNonBlank                                   := sum(group,if(ds.fname<>'',1,0));
    minit_CountNonBlank                                   := sum(group,if(ds.minit<>'',1,0));
    lname_CountNonBlank                                   := sum(group,if(ds.lname<>'',1,0));
    name_suffix_CountNonBlank                             := sum(group,if(ds.name_suffix<>'',1,0));
    prim_range_CountNonBlank                              := sum(group,if(ds.prim_range<>'',1,0));
    predir_CountNonBlank                                  := sum(group,if(ds.predir<>'',1,0));
    prim_name_CountNonBlank                               := sum(group,if(ds.prim_name<>'',1,0));
    suffix_CountNonBlank                                  := sum(group,if(ds.suffix<>'',1,0));
    postdir_CountNonBlank                                 := sum(group,if(ds.postdir<>'',1,0));
    unit_desig_CountNonBlank                              := sum(group,if(ds.unit_desig<>'',1,0));
    sec_range_CountNonBlank                               := sum(group,if(ds.sec_range<>'',1,0));
    city_name_CountNonBlank                               := sum(group,if(ds.city_name<>'',1,0));
    st_CountNonBlank                                      := sum(group,if(ds.st<>'',1,0));
    zip4_CountNonBlank                                    := sum(group,if(ds.zip4<>'',1,0));
    county_CountNonBlank                                  := sum(group,if(ds.county<>'',1,0));
    cbsa_CountNonBlank                                    := sum(group,if(ds.cbsa<>'',1,0));
    geo_blk_CountNonBlank                                 := sum(group,if(ds.geo_blk<>'',1,0));
    CleanName_CountNonBlank                               := sum(group,if(ds.CleanName<>'',1,0));
    CleanAddress_CountNonBlank                            := sum(group,if(ds.CleanAddress<>'',1,0));
    record_id_CountNonBlank                               := sum(group,if(ds.record_id<>'',1,0));
    pubdate_CountNonBlank                                 := sum(group,if(ds.pubdate<>'',1,0));
    filler_CountNonBlank                                  := sum(group,if(ds.filler<>'',1,0));
    yppa_code_CountNonBlank                               := sum(group,if(ds.yppa_code<>'',1,0));
    book_code_CountNonBlank                               := sum(group,if(ds.book_code<>'',1,0));
    page_number_CountNonBlank                             := sum(group,if(ds.page_number<>'',1,0));
    record_number_CountNonBlank                           := sum(group,if(ds.record_number<>'',1,0));
    phone_number_CountNonBlank                            := sum(group,if(ds.phone_number<>'',1,0));
    phone_type_CountNonBlank                              := sum(group,if(ds.phone_type<>'',1,0));
    record_type_CountNonBlank                             := sum(group,if(ds.record_type<>'',1,0));
    no_solicitation_code_CountNonBlank                    := sum(group,if(ds.no_solicitation_code<>'',1,0));
    title_CountNonBlank                                   := sum(group,if(ds.title<>'',1,0));
    first_name_CountNonBlank                              := sum(group,if(ds.first_name<>'',1,0));
    middle_name_CountNonBlank                             := sum(group,if(ds.middle_name<>'',1,0));
    last_name_CountNonBlank                               := sum(group,if(ds.last_name<>'',1,0));
    last_name_suffix_CountNonBlank                        := sum(group,if(ds.last_name_suffix<>'',1,0));
    job_title_CountNonBlank                               := sum(group,if(ds.job_title<>'',1,0));
    secondary_name_title_CountNonBlank                    := sum(group,if(ds.secondary_name_title<>'',1,0));
    secondary_first_name_CountNonBlank                    := sum(group,if(ds.secondary_first_name<>'',1,0));
    secondary_middle_name_CountNonBlank                   := sum(group,if(ds.secondary_middle_name<>'',1,0));
    secondary_name_suffix_CountNonBlank                   := sum(group,if(ds.secondary_name_suffix<>'',1,0));
    house_number_CountNonBlank                            := sum(group,if(ds.house_number<>'',1,0));
    pre_direction_CountNonBlank                           := sum(group,if(ds.pre_direction<>'',1,0));
    street_name_CountNonBlank                             := sum(group,if(ds.street_name<>'',1,0));
    street_type_CountNonBlank                             := sum(group,if(ds.street_type<>'',1,0));
    post_direction_CountNonBlank                          := sum(group,if(ds.post_direction<>'',1,0));
    apt_type_CountNonBlank                                := sum(group,if(ds.apt_type<>'',1,0));
    apt_number_CountNonBlank                              := sum(group,if(ds.apt_number<>'',1,0));
    box_number_CountNonBlank                              := sum(group,if(ds.box_number<>'',1,0));
    expanded_pub_city_name_CountNonBlank                  := sum(group,if(ds.expanded_pub_city_name<>'',1,0));
    postal_city_name_CountNonBlank                        := sum(group,if(ds.postal_city_name<>'',1,0));
    state_CountNonBlank                                   := sum(group,if(ds.state<>'',1,0));
    zip_CountNonBlank                                     := sum(group,if(ds.zip<>'',1,0));
    plus4_CountNonBlank                                   := sum(group,if(ds.plus4<>'',1,0));
    delivery_point_code_CountNonBlank                     := sum(group,if(ds.delivery_point_code<>'',1,0));
    carrier_route_CountNonBlank                           := sum(group,if(ds.carrier_route<>'',1,0));
    county_code__CountNonBlank                            := sum(group,if(ds.county_code_<>'',1,0));
    gnrl_address_return_code_CountNonBlank                := sum(group,if(ds.gnrl_address_return_code<>'',1,0));
    house_number_usage_flag_CountNonBlank                 := sum(group,if(ds.house_number_usage_flag<>'',1,0));
    pre_direction_usage_flag_CountNonBlank                := sum(group,if(ds.pre_direction_usage_flag<>'',1,0));
    street_name_usage_flag_CountNonBlank                  := sum(group,if(ds.street_name_usage_flag<>'',1,0));
    street_type_usage_flag_CountNonBlank                  := sum(group,if(ds.street_type_usage_flag<>'',1,0));
    post_direction_usage_flag_CountNonBlank               := sum(group,if(ds.post_direction_usage_flag<>'',1,0));
    apt_number_usage_flag_CountNonBlank                   := sum(group,if(ds.apt_number_usage_flag<>'',1,0));
    validation_date_CountNonBlank                         := sum(group,if(ds.validation_date<>'',1,0));
    validation_flag_CountNonBlank                         := sum(group,if(ds.validation_flag<>'',1,0));
    filler1_CountNonBlank                                 := sum(group,if(ds.filler1<>'',1,0));
    
    
  end;
  
tStats := table(ds,rPopulationStats_File_consumer_base,few);

//strata.createXMLStats(tStats,'PCNSR','data',ut.GetDate,'',resultsOut);
  strata.createXMLStats(tStats,'PCNSRv2','data',filedate,'',resultsOut);
//export Targus_Base_PCNSR_Stats := resultsOut;
return resultsOut;
end;

