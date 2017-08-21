ds := header.File_Headers(trim(prim_name)='NONE') : persist('header_prim_name_equals_none');

output(choosen(enth(ds,1,100,1),500),named('none_sample'));

rec := record
 ds.src;
 src_ct := count(group);
end;

t_out := sort(table(ds,rec,src,few),-src_ct);
output(t_out,all,named('src_distribution'));

prim_range_stat_rec := record
 ds.src;
 ds.prim_range;
 src_prim_range_ct := count(group);
end;

t_prim_range_stats := sort(table(ds,prim_range_stat_rec,src,prim_range),-src_prim_range_ct)(src_prim_range_ct>=25);
output(t_prim_range_stats,all,named('src_prim_range_largest_occurrences'));

city_stat_rec := record
 ds.src;
 ds.city_name;
 src_city_ct := count(group);
end;

t_city_stats := sort(table(ds,city_stat_rec,src,city_name),-src_city_ct)(src_city_ct>=25);
output(t_city_stats,all,named('src_city_largest_occurrences'));

population_rec
 :=
  record
    CountGroup := count(group);
    did_CountNonZero                                     := sum(group,if(ds.did<>0,1,0));
    rid_CountNonZero                                     := sum(group,if(ds.rid<>0,1,0));
    pflag1_CountNonBlank                                 := sum(group,if(ds.pflag1<>'',1,0));
    pflag2_CountNonBlank                                 := sum(group,if(ds.pflag2<>'',1,0));
    pflag3_CountNonBlank                                 := sum(group,if(ds.pflag3<>'',1,0));
    ds.src;
	//src_CountNonBlank                                    := sum(group,if(ds.src<>'',1,0));
    dt_first_seen_CountNonZero                           := sum(group,if(ds.dt_first_seen<>0,1,0));
    dt_last_seen_CountNonZero                            := sum(group,if(ds.dt_last_seen<>0,1,0));
    dt_vendor_last_reported_CountNonZero                 := sum(group,if(ds.dt_vendor_last_reported<>0,1,0));
    dt_vendor_first_reported_CountNonZero                := sum(group,if(ds.dt_vendor_first_reported<>0,1,0));
    dt_nonglb_last_seen_CountNonZero                     := sum(group,if(ds.dt_nonglb_last_seen<>0,1,0));
    rec_type_CountNonBlank                               := sum(group,if(ds.rec_type<>'',1,0));
    vendor_id_CountNonBlank                              := sum(group,if(ds.vendor_id<>'',1,0));
    phone_CountNonBlank                                  := sum(group,if(ds.phone<>'',1,0));
    ssn_CountNonBlank                                    := sum(group,if(ds.ssn<>'',1,0));
    dob_CountNonZero                                     := sum(group,if(ds.dob<>0,1,0));
    title_CountNonBlank                                  := sum(group,if(ds.title<>'',1,0));
    fname_CountNonBlank                                  := sum(group,if(ds.fname<>'',1,0));
    mname_CountNonBlank                                  := sum(group,if(ds.mname<>'',1,0));
    lname_CountNonBlank                                  := sum(group,if(ds.lname<>'',1,0));
    name_suffix_CountNonBlank                            := sum(group,if(ds.name_suffix<>'',1,0));
    prim_range_CountNonBlank                             := sum(group,if(ds.prim_range<>'',1,0));
    predir_CountNonBlank                                 := sum(group,if(ds.predir<>'',1,0));
    prim_name_CountNonBlank                              := sum(group,if(ds.prim_name<>'',1,0));
    suffix_CountNonBlank                                 := sum(group,if(ds.suffix<>'',1,0));
    postdir_CountNonBlank                                := sum(group,if(ds.postdir<>'',1,0));
    unit_desig_CountNonBlank                             := sum(group,if(ds.unit_desig<>'',1,0));
    sec_range_CountNonBlank                              := sum(group,if(ds.sec_range<>'',1,0));
    city_name_CountNonBlank                              := sum(group,if(ds.city_name<>'',1,0));
    st_CountNonBlank                                     := sum(group,if(ds.st<>'',1,0));
    zip_CountNonBlank                                    := sum(group,if(ds.zip<>'',1,0));
    zip4_CountNonBlank                                   := sum(group,if(ds.zip4<>'',1,0));
    county_CountNonBlank                                 := sum(group,if(ds.county<>'',1,0));
    geo_blk_CountNonBlank                                := sum(group,if(ds.geo_blk<>'',1,0));
    cbsa_CountNonBlank                                   := sum(group,if(ds.cbsa<>'',1,0));
    tnt_CountNonBlank                                    := sum(group,if(ds.tnt<>'',1,0));
    valid_SSN_CountNonBlank                              := sum(group,if(ds.valid_SSN<>'',1,0));
    jflag1_CountNonBlank                                 := sum(group,if(ds.jflag1<>'',1,0));
    jflag2_CountNonBlank                                 := sum(group,if(ds.jflag2<>'',1,0));
    jflag3_CountNonBlank                                 := sum(group,if(ds.jflag3<>'',1,0));
end;

t_out2 := sort(table(ds,population_rec,src,few),-countgroup);
output(t_out2,all,named('population_stats'));