import strata, ut;

ds := SDA_SDAA.File_SDAA_Base+SDA_SDAA.File_SDA_Base;

rPopulationStats_SDA_SDAA
 :=
  record
    string3  grouping                                := 'ALL';
    CountGroup                                       := count(group); 
    bdid_CountNonZero                                := sum(group,if(ds.bdid<>0,1,0));
    did_CountNonZero                                 := sum(group,if(ds.did<>0,1,0));
    contact_score_CountNonZero                       := sum(group,if(ds.contact_score<>0,1,0));
    vendor_id_CountNonBlank                          := sum(group,if(ds.vendor_id<>'',1,0));
    dt_first_seen_CountNonZero                       := sum(group,if(ds.dt_first_seen<>0,1,0));
    dt_last_seen_CountNonZero                        := sum(group,if(ds.dt_last_seen<>0,1,0));
    source_CountNonBlank                             := sum(group,if(ds.source<>'',1,0));
    record_type_CountNonBlank                        := sum(group,if(ds.record_type<>'',1,0));
    from_hdr_CountNonBlank                           := sum(group,if(ds.from_hdr<>'',1,0));
    company_title_CountNonBlank                      := sum(group,if(ds.company_title<>'',1,0));
    company_department_CountNonBlank                 := sum(group,if(ds.company_department<>'',1,0));
    title_CountNonBlank                              := sum(group,if(ds.title<>'',1,0));
    fname_CountNonBlank                              := sum(group,if(ds.fname<>'',1,0));
    mname_CountNonBlank                              := sum(group,if(ds.mname<>'',1,0));
    lname_CountNonBlank                              := sum(group,if(ds.lname<>'',1,0));
    name_suffix_CountNonBlank                        := sum(group,if(ds.name_suffix<>'',1,0));
    name_score_CountNonBlank                         := sum(group,if(ds.name_score<>'',1,0));
    prim_range_CountNonBlank                         := sum(group,if(ds.prim_range<>'',1,0));
    predir_CountNonBlank                             := sum(group,if(ds.predir<>'',1,0));
    prim_name_CountNonBlank                          := sum(group,if(ds.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                        := sum(group,if(ds.addr_suffix<>'',1,0));
    postdir_CountNonBlank                            := sum(group,if(ds.postdir<>'',1,0));
    unit_desig_CountNonBlank                         := sum(group,if(ds.unit_desig<>'',1,0));
    sec_range_CountNonBlank                          := sum(group,if(ds.sec_range<>'',1,0));
    city_CountNonBlank                               := sum(group,if(ds.city<>'',1,0));
    state_CountNonBlank                              := sum(group,if(ds.state<>'',1,0));
    zip_CountNonZero                                 := sum(group,if(ds.zip<>0,1,0));
    zip4_CountNonZero                                := sum(group,if(ds.zip4<>0,1,0));
    county_CountNonBlank                             := sum(group,if(ds.county<>'',1,0));
    msa_CountNonBlank                                := sum(group,if(ds.msa<>'',1,0));
    geo_lat_CountNonBlank                            := sum(group,if(ds.geo_lat<>'',1,0));
    geo_long_CountNonBlank                           := sum(group,if(ds.geo_long<>'',1,0));
    phone_CountNonZero                               := sum(group,if(ds.phone<>0,1,0));
    email_address_CountNonBlank                      := sum(group,if(ds.email_address<>'',1,0));
    ssn_CountNonZero                                 := sum(group,if(ds.ssn<>0,1,0));
    company_source_group_CountNonBlank               := sum(group,if(ds.company_source_group<>'',1,0));
    company_name_CountNonBlank                       := sum(group,if(ds.company_name<>'',1,0));
    company_prim_range_CountNonBlank                 := sum(group,if(ds.company_prim_range<>'',1,0));
    company_predir_CountNonBlank                     := sum(group,if(ds.company_predir<>'',1,0));
    company_prim_name_CountNonBlank                  := sum(group,if(ds.company_prim_name<>'',1,0));
    company_addr_suffix_CountNonBlank                := sum(group,if(ds.company_addr_suffix<>'',1,0));
    company_postdir_CountNonBlank                    := sum(group,if(ds.company_postdir<>'',1,0));
    company_unit_desig_CountNonBlank                 := sum(group,if(ds.company_unit_desig<>'',1,0));
    company_sec_range_CountNonBlank                  := sum(group,if(ds.company_sec_range<>'',1,0));
    company_city_CountNonBlank                       := sum(group,if(ds.company_city<>'',1,0));
    company_state_CountNonBlank                      := sum(group,if(ds.company_state<>'',1,0));
    company_zip_CountNonZero                         := sum(group,if(ds.company_zip<>0,1,0));
    company_zip4_CountNonZero                        := sum(group,if(ds.company_zip4<>0,1,0));
    company_phone_CountNonZero                       := sum(group,if(ds.company_phone<>0,1,0));
    company_fein_CountNonZero                        := sum(group,if(ds.company_fein<>0,1,0));
		DotID_CountNonZeros															 := sum(group,if(ds.DotID<>0,1,0));
		DotScore_CountNonZeros													 := sum(group,if(ds.DotScore<>0,1,0));
		DotWeight_CountNonZeros													 := sum(group,if(ds.DotWeight<>0,1,0));
		EmpID_CountNonZeros															 := sum(group,if(ds.EmpID<>0,1,0));
 		EmpScore_CountNonZeros													 := sum(group,if(ds.EmpScore<>0,1,0));
		EmpWeight_CountNonZeros													 := sum(group,if(ds.EmpWeight<>0,1,0));
		POWID_CountNonZeros															 := sum(group,if(ds.POWID<>0,1,0));
		POWScore_CountNonZeros													 := sum(group,if(ds.POWScore<>0,1,0));
		POWWeight_CountNonZeros													 := sum(group,if(ds.POWWeight<>0,1,0));
		ProxID_CountNonZeros														 := sum(group,if(ds.ProxID<>0,1,0));
		ProxScore_CountNonZeros													 := sum(group,if(ds.ProxScore<>0,1,0));
		ProxWeight_CountNonZeros												 := sum(group,if(ds.ProxWeight<>0,1,0));		
		SELEID_CountNonZeros														 := sum(group,if(ds.SELEID<>0,1,0));
		SELEScore_CountNonZeros													 := sum(group,if(ds.SELEScore<>0,1,0));
		SELEWeight_CountNonZeros												 := sum(group,if(ds.SELEWeight<>0,1,0));
		OrgID_CountNonZeros															 := sum(group,if(ds.OrgID<>0,1,0));
		OrgScore_CountNonZeros													 := sum(group,if(ds.OrgScore<>0,1,0));
		OrgWeight_CountNonZeros													 := sum(group,if(ds.OrgWeight<>0,1,0));
		UltID_CountNonZeros															 := sum(group,if(ds.UltID<>0,1,0));
		UltScore_CountNonZeros													 := sum(group,if(ds.UltScore<>0,1,0));
		UltWeight_CountNonZeros													 := sum(group,if(ds.UltWeight<>0,1,0));		
  end;

  
tStats := table(ds,rPopulationStats_SDA_SDAA,few);

strata.createXMLStats(tStats,'SDA SDAA','datav2',ut.getdate,'',resultsOut);

export Strata_Pop_SDA_SDAA_Base := resultsOut;