#OPTION('multiplePersistInstances',FALSE);

// Jira DF-11862 - added isfast parameter to name persist file accordingly in order to run continuous delta in parallel to full
EXPORT fnCountsByNameStreetCounty(boolean isFast) := function

r1 := ln_propertyv2_addressenhancements.layouts.wide_rec;

dedup_function(dataset(recordof(r1)) ds) := function

 dupd := dedup(sort(distribute(ds,hash(fname,lname,prim_range,prim_name,st,county_name)),
                                       fname,lname,prim_range,prim_name,city_name,st,zip,county_name,/*name_suffix,*/local),
																	     fname,lname,prim_range,prim_name,city_name,st,zip,county_name,/*name_suffix,*/local);
																														 
 return dupd;

end;

//answer to "this NAME and STREET is found how many times in the COUNTY?"
//intended to fill in the CSZ if the NAME has only 1 matching STREET in the COUNTY
hdr_dupd_by_name_street_csz_county       := dedup_function(ln_propertyv2_addressenhancements.files.hdr_slim);
hdr_unreg_dupd_by_name_street_csz_county := dedup_function(ln_propertyv2_addressenhancements.files.hdr_unreg_slim);

hdr_dupd_by_name_street_csz_county_redist_resort       := sort(distribute(hdr_dupd_by_name_street_csz_county,      hash(fname,lname,prim_range,prim_name,st,county_name)),fname,lname,prim_range,prim_name,st,county_name,local);
hdr_unreg_dupd_by_name_street_csz_county_redist_resort := sort(distribute(hdr_unreg_dupd_by_name_street_csz_county,hash(fname,lname,prim_range,prim_name,st,county_name)),fname,lname,prim_range,prim_name,st,county_name,local);

r1 xform2_hdr(r1 le, r1 ri) := transform
 self.hdr_name_street_within_the_county_ct := le.hdr_name_street_within_the_county_ct+1;
 self := le;
end;

r1 xform2_hdr_unreg(r1 le, r1 ri) := transform
 self.hdr_unreg_name_street_within_the_county_ct := le.hdr_unreg_name_street_within_the_county_ct+1;
 self := le;
end;

hdr_name_street_frequencies_within_the_county       := rollup(hdr_dupd_by_name_street_csz_county_redist_resort,      left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.st=right.st and left.county_name=right.county_name,xform2_hdr(left,right),local);
hdr_unreg_name_street_frequencies_within_the_county := rollup(hdr_unreg_dupd_by_name_street_csz_county_redist_resort,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.st=right.st and left.county_name=right.county_name,xform2_hdr_unreg(left,right),local);

r1 xform6(r1 le, r1 ri) := transform
 self.addr_in_hdr_unreg                          := ri.addr_in_hdr_unreg;
 self.hdr_unreg_name_street_within_the_county_ct := ri.hdr_unreg_name_street_within_the_county_ct;
 self := le;
end;

j_hdr_and_hdr_unreg_name_street := join(hdr_name_street_frequencies_within_the_county,hdr_unreg_name_street_frequencies_within_the_county,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.st=right.st and left.county_name=right.county_name,xform6(left,right),left outer,local);

non_cl_recs  := distribute(ln_propertyv2_addressenhancements.files.hdr_non_cl_slim,hash(fname,lname,prim_range,prim_name,st,county_name));
non_okc_recs := distribute(ln_propertyv2_addressenhancements.files.hdr_non_okc_slim,hash(fname,lname,prim_range,prim_name,st,county_name));

r1 xform7(r1 le, non_cl_recs ri) := transform
 self.name_street_in_non_cl := if(le.fname=ri.fname and le.lname=ri.lname and le.prim_name=ri.prim_name and le.prim_range=ri.prim_range and le.st=ri.st and le.county_name=ri.county_name,true,false);
 self := le;
end;

j_flag_if_found_in_cl := join(j_hdr_and_hdr_unreg_name_street,non_cl_recs,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.st=right.st and left.county_name=right.county_name,xform7(left,right),left outer,keep(1),local);

r1 xform8(r1 le, non_okc_recs ri) := transform
 self.name_street_in_non_okc := if(le.fname=ri.fname and le.lname=ri.lname and le.prim_name=ri.prim_name and le.prim_range=ri.prim_range and le.st=ri.st and le.county_name=ri.county_name,true,false);
 self := le;
end;

j_flag_if_found_in_non_okc := join(j_flag_if_found_in_cl,non_okc_recs,left.fname=right.fname and left.lname=right.lname and left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.st=right.st and left.county_name=right.county_name,xform8(left,right),left outer,keep(1),local);

project_to_slim_layout                := project(j_flag_if_found_in_non_okc,ln_propertyv2_addressenhancements.layouts.name_street_in_county) : persist('persist::name_street_counts_in_the_county'+if(isFast,'_d','f'));

return project_to_slim_layout;

end;