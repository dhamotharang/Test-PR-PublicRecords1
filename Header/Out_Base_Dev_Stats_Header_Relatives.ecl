import ut,strata;

export out_base_dev_stats_header_relatives(string filedate,string emailListStrataBuilders) := MODULE

SHARED ds_hdr_in    := header.File_Header_In().eq_uid_monthly;
SHARED ds_hdr       := header.file_headers;
SHARED ds_relatives := header.File_Relatives_v3;

SHARED rPopulationStats_file_header_in
 :=
  record
    string3  grouping                                         := 'ALL';
    CountGroup := count(group);
    first_name_CountNonBlank                                  := sum(group,if(ds_hdr_in.first_name<>'',1,0));
    middle_initial_CountNonBlank                              := sum(group,if(ds_hdr_in.middle_initial<>'',1,0));
    last_name_CountNonBlank                                   := sum(group,if(ds_hdr_in.last_name<>'',1,0));
    suffix_CountNonBlank                                      := sum(group,if(ds_hdr_in.suffix<>'',1,0));
    former_first_name_CountNonBlank                           := sum(group,if(ds_hdr_in.former_first_name<>'',1,0));
    former_middle_initial_CountNonBlank                       := sum(group,if(ds_hdr_in.former_middle_initial<>'',1,0));
    former_last_name_CountNonBlank                            := sum(group,if(ds_hdr_in.former_last_name<>'',1,0));
    former_suffix_CountNonBlank                               := sum(group,if(ds_hdr_in.former_suffix<>'',1,0));
    former_first_name2_CountNonBlank                          := sum(group,if(ds_hdr_in.former_first_name2<>'',1,0));
    former_middle_initial2_CountNonBlank                      := sum(group,if(ds_hdr_in.former_middle_initial2<>'',1,0));
    former_last_name2_CountNonBlank                           := sum(group,if(ds_hdr_in.former_last_name2<>'',1,0));
    former_suffix2_CountNonBlank                              := sum(group,if(ds_hdr_in.former_suffix2<>'',1,0));
    aka_first_name_CountNonBlank                              := sum(group,if(ds_hdr_in.aka_first_name<>'',1,0));
    aka_middle_initial_CountNonBlank                          := sum(group,if(ds_hdr_in.aka_middle_initial<>'',1,0));
    aka_last_name_CountNonBlank                               := sum(group,if(ds_hdr_in.aka_last_name<>'',1,0));
    aka_suffix_CountNonBlank                                  := sum(group,if(ds_hdr_in.aka_suffix<>'',1,0));
    current_address_CountNonBlank                             := sum(group,if(ds_hdr_in.current_address<>'',1,0));
    current_city_CountNonBlank                                := sum(group,if(ds_hdr_in.current_city<>'',1,0));
    current_state_CountNonBlank                               := sum(group,if(ds_hdr_in.current_state<>'',1,0));
    current_zip_CountNonBlank                                 := sum(group,if(ds_hdr_in.current_zip<>'',1,0));
    current_address_date_reported_CountNonBlank               := sum(group,if(ds_hdr_in.current_address_date_reported<>'',1,0));
    former1_address_CountNonBlank                             := sum(group,if(ds_hdr_in.former1_address<>'',1,0));
    former1_city_CountNonBlank                                := sum(group,if(ds_hdr_in.former1_city<>'',1,0));
    former1_state_CountNonBlank                               := sum(group,if(ds_hdr_in.former1_state<>'',1,0));
    former1_zip_CountNonBlank                                 := sum(group,if(ds_hdr_in.former1_zip<>'',1,0));
    former1_address_date_reported_CountNonBlank               := sum(group,if(ds_hdr_in.former1_address_date_reported<>'',1,0));
    former2_address_CountNonBlank                             := sum(group,if(ds_hdr_in.former2_address<>'',1,0));
    former2_city_CountNonBlank                                := sum(group,if(ds_hdr_in.former2_city<>'',1,0));
    former2_state_CountNonBlank                               := sum(group,if(ds_hdr_in.former2_state<>'',1,0));
    former2_zip_CountNonBlank                                 := sum(group,if(ds_hdr_in.former2_zip<>'',1,0));
    former2_address_date_reported_CountNonBlank               := sum(group,if(ds_hdr_in.former2_address_date_reported<>'',1,0));
    blank1_CountNonBlank                                      := sum(group,if(ds_hdr_in.blank1<>'',1,0));
    ssn_CountNonBlank                                         := sum(group,if(ds_hdr_in.ssn<>'',1,0));
    cid_CountNonBlank                                         := sum(group,if(ds_hdr_in.cid<>'',1,0));
    //blank2_CountNonBlank                                      := sum(group,if(ds_hdr_in.blank2<>'',1,0));
    //blank3_CountNonBlank                                      := sum(group,if(ds_hdr_in.blank3<>'',1,0));
end;

SHARED rPopulationStats_file_headers
 :=
  record
    CountGroup := count(group);
    did_CountNonZero                                     := sum(group,if(ds_hdr.did<>0,1,0));
    rid_CountNonZero                                     := sum(group,if(ds_hdr.rid<>0,1,0));
    pflag1_CountNonBlank                                 := sum(group,if(ds_hdr.pflag1<>'',1,0));
    pflag2_CountNonBlank                                 := sum(group,if(ds_hdr.pflag2<>'',1,0));
    pflag3_CountNonBlank                                 := sum(group,if(ds_hdr.pflag3<>'',1,0));
    ds_hdr.src;
	//src_CountNonBlank                                    := sum(group,if(ds_hdr.src<>'',1,0));
    dt_first_seen_CountNonZero                           := sum(group,if(ds_hdr.dt_first_seen<>0,1,0));
    dt_last_seen_CountNonZero                            := sum(group,if(ds_hdr.dt_last_seen<>0,1,0));
    dt_vendor_last_reported_CountNonZero                 := sum(group,if(ds_hdr.dt_vendor_last_reported<>0,1,0));
    dt_vendor_first_reported_CountNonZero                := sum(group,if(ds_hdr.dt_vendor_first_reported<>0,1,0));
    dt_nonglb_last_seen_CountNonZero                     := sum(group,if(ds_hdr.dt_nonglb_last_seen<>0,1,0));
    rec_type_CountNonBlank                               := sum(group,if(ds_hdr.rec_type<>'',1,0));
    vendor_id_CountNonBlank                              := sum(group,if(ds_hdr.vendor_id<>'',1,0));
    phone_CountNonBlank                                  := sum(group,if(ds_hdr.phone<>'',1,0));
    ssn_CountNonBlank                                    := sum(group,if(ds_hdr.ssn<>'',1,0));
    dob_CountNonZero                                     := sum(group,if(ds_hdr.dob<>0,1,0));
    title_CountNonBlank                                  := sum(group,if(ds_hdr.title<>'',1,0));
    fname_CountNonBlank                                  := sum(group,if(ds_hdr.fname<>'',1,0));
    mname_CountNonBlank                                  := sum(group,if(ds_hdr.mname<>'',1,0));
    lname_CountNonBlank                                  := sum(group,if(ds_hdr.lname<>'',1,0));
    name_suffix_CountNonBlank                            := sum(group,if(ds_hdr.name_suffix<>'',1,0));
    prim_range_CountNonBlank                             := sum(group,if(ds_hdr.prim_range<>'',1,0));
    predir_CountNonBlank                                 := sum(group,if(ds_hdr.predir<>'',1,0));
    prim_name_CountNonBlank                              := sum(group,if(ds_hdr.prim_name<>'',1,0));
    suffix_CountNonBlank                                 := sum(group,if(ds_hdr.suffix<>'',1,0));
    postdir_CountNonBlank                                := sum(group,if(ds_hdr.postdir<>'',1,0));
    unit_desig_CountNonBlank                             := sum(group,if(ds_hdr.unit_desig<>'',1,0));
    sec_range_CountNonBlank                              := sum(group,if(ds_hdr.sec_range<>'',1,0));
    city_name_CountNonBlank                              := sum(group,if(ds_hdr.city_name<>'',1,0));
    st_CountNonBlank                                     := sum(group,if(ds_hdr.st<>'',1,0));
    zip_CountNonBlank                                    := sum(group,if(ds_hdr.zip<>'',1,0));
    zip4_CountNonBlank                                   := sum(group,if(ds_hdr.zip4<>'',1,0));
    county_CountNonBlank                                 := sum(group,if(ds_hdr.county<>'',1,0));
    geo_blk_CountNonBlank                                := sum(group,if(ds_hdr.geo_blk<>'',1,0));
    cbsa_CountNonBlank                                   := sum(group,if(ds_hdr.cbsa<>'',1,0));
    tnt_CountNonBlank                                    := sum(group,if(ds_hdr.tnt<>'',1,0));
    valid_SSN_CountNonBlank                              := sum(group,if(ds_hdr.valid_SSN<>'',1,0));
    jflag1_CountNonBlank                                 := sum(group,if(ds_hdr.jflag1<>'',1,0));
    jflag2_CountNonBlank                                 := sum(group,if(ds_hdr.jflag2<>'',1,0));
    jflag3_CountNonBlank                                 := sum(group,if(ds_hdr.jflag3<>'',1,0));
end;

SHARED rPopulationStats_ds_relatives
 :=
  record
    string3  grouping                           := 'ALL';
    CountGroup := count(group);
    person1_CountNonZero                        := sum(group,if(ds_relatives.person1<>0,1,0));
    person2_CountNonZero                        := sum(group,if(ds_relatives.person2<>0,1,0));
    recent_cohabit_CountNonZero                 := sum(group,if(ds_relatives.recent_cohabit<>0,1,0));
    zip_CountNonZero                            := sum(group,if(ds_relatives.zip<>0,1,0));
    prim_range_CountNonZero                     := sum(group,if(ds_relatives.prim_range<>0,1,0));
    same_lname_CountTrue                        := sum(group,if(ds_relatives.same_lname=TRUE,1,0));
    number_cohabits_CountNonZero                := sum(group,if(ds_relatives.number_cohabits<>0,1,0));
end;

SHARED tStats_hdr_in    := table(ds_hdr_in,   rPopulationStats_file_header_in,  few);
SHARED tStats_hdr       := table(ds_hdr,      rPopulationStats_file_headers,src,few);
SHARED tStats_relatives := table(ds_relatives,rPopulationStats_ds_relatives,    few);

SHARED zOrig_Stats_hdr_in    := output(choosen(tStats_hdr_in,   all));
SHARED zOrig_Stats_hdr       := output(choosen(tStats_hdr,      all));
SHARED zOrig_Stats_relatives := output(choosen(tStats_relatives,all));

STRATA.createXMLStats(tStats_hdr_in,   'Credit Header','Data',filedate,emailListStrataBuilders,zPopulation_Stats_hdr_in,   'View','Population')

EXPORT ingest_report := parallel(zOrig_Stats_hdr_in,
                                  zPopulation_Stats_hdr_in
                                 );

STRATA.createXMLStats(tStats_hdr,      'Header',       'Data',filedate,emailListStrataBuilders,zPopulation_Stats_hdr,      'View','Population')
STRATA.createXMLStats(tStats_relatives,'Relatives',    'Data',filedate,emailListStrataBuilders,zPopulation_Stats_relatives,'View','Population')

EXPORT hdr_reports := parallel(zOrig_Stats_hdr,
                               zOrig_Stats_relatives,
                               zPopulation_Stats_hdr,
                               zPopulation_Stats_relatives,
                               );

end;									  