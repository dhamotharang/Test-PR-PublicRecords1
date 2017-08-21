#OPTION('multiplePersistInstances',FALSE);

// Jira DF-11862 - added isfast parameter to name persist file accordingly in order to run continuous delta in parallel to full
EXPORT fnCountsByStreetCounty(boolean isFast) := function

r1 := ln_propertyv2_addressenhancements.layouts.wide_rec;

dedup_function(dataset(recordof(r1)) ds) := function

 dupd := dedup(sort(distribute(ds,hash(prim_range,prim_name,st,county_name)),
                                       prim_range,prim_name,city_name,st,zip,county_name,local),
																	     prim_range,prim_name,city_name,st,zip,county_name,local);

 return dupd;

end;

//answer to "this STREET occurs how many times in the COUNTY?"
//intended to fill in the CSZ if the STREET only occurs once in the COUNTY
hdr_dupd_by_street_csz_county       := dedup_function(ln_propertyv2_addressenhancements.files.hdr_slim(dt_last_seen>201300));
hdr_unreg_dupd_by_street_csz_county := dedup_function(ln_propertyv2_addressenhancements.files.hdr_unreg_slim(dt_last_seen>201300));

																																																 
advo_dupd_by_street_csz_county := dedup(sort(distribute(ln_propertyv2_addressenhancements.files.advo_,hash(prim_range,prim_name,st,county_name)),
                                                                                                 prim_range,prim_name,city_name,st,zip,county_name,local),
																						                                                     prim_range,prim_name,city_name,st,zip,county_name,local);

hdr_dupd_by_street_csz_county_redist_resort       := sort(distribute(hdr_dupd_by_street_csz_county,      hash(prim_range,prim_name,st,county_name)),prim_range,prim_name,st,county_name,local);
hdr_unreg_dupd_by_street_csz_county_redist_resort := sort(distribute(hdr_unreg_dupd_by_street_csz_county,hash(prim_range,prim_name,st,county_name)),prim_range,prim_name,st,county_name,local);
advo_dupd_by_street_csz_county_redist_resort      := sort(distribute(advo_dupd_by_street_csz_county,     hash(prim_range,prim_name,st,county_name)),prim_range,prim_name,st,county_name,local);

r1 xform3_hdr(r1 le, r1 ri) := transform
 self.hdr_street_within_the_county_ct := le.hdr_street_within_the_county_ct+1;
 self := le;
end;

r1 xform3_hdr_unreg(r1 le, r1 ri) := transform
 self.hdr_unreg_street_within_the_county_ct := le.hdr_unreg_street_within_the_county_ct+1;
 self := le;
end;

r1 xform3_advo(r1 le, r1 ri) := transform
 self.advo_street_within_the_county_ct := le.advo_street_within_the_county_ct+1;
 self := le;
end;

hdr_street_frequencies_within_the_county       := rollup(hdr_dupd_by_street_csz_county_redist_resort,      left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.st=right.st and left.county_name=right.county_name,xform3_hdr(left,right),local);
hdr_unreg_street_frequencies_within_the_county := rollup(hdr_unreg_dupd_by_street_csz_county_redist_resort,left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.st=right.st and left.county_name=right.county_name,xform3_hdr_unreg(left,right),local);
advo_street_frequencies_within_the_county      := rollup(advo_dupd_by_street_csz_county_redist_resort,     left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.st=right.st and left.county_name=right.county_name,xform3_advo(left,right),local);

r1 xform7(r1 le, r1 ri) := transform
 self.addr_in_hdr_unreg                     := ri.addr_in_hdr_unreg;
 self.hdr_unreg_street_within_the_county_ct := ri.hdr_unreg_street_within_the_county_ct;
 self := le;
end;

j_hdr_and_hdr_unreg := join(hdr_street_frequencies_within_the_county,hdr_unreg_street_frequencies_within_the_county,left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.st=right.st and left.county_name=right.county_name,xform7(left,right),left outer,local);

r1 xform8(r1 le, r1 ri) := transform

 self.advo_street_within_the_county_ct := ri.advo_street_within_the_county_ct;

 self.addr_in_advo := ri.addr_in_advo;
 self.dt_last_seen := if(le.addr_in_hdr=true,le.dt_last_seen,ri.dt_last_seen);
 self.prim_range   := if(le.addr_in_hdr=true,le.prim_range,ri.prim_range);
 self.prim_name    := if(le.addr_in_hdr=true,le.prim_name,ri.prim_name);
 self.sec_range    := if(le.addr_in_hdr=true,le.sec_range,ri.sec_range);
 self.city_name    := if(le.addr_in_hdr=true,le.city_name,ri.city_name);
 self.st           := if(le.addr_in_hdr=true,le.st,ri.st);
 self.zip          := if(le.addr_in_hdr=true,le.zip,ri.zip);
 self.zip4         := if(le.addr_in_hdr=true,le.zip4,ri.zip4);
 self.county_name  := if(le.addr_in_hdr=true,le.county_name,ri.county_name);
 self              := le;
end;

j_hdr_hdr_unreg_and_advo_street := join(j_hdr_and_hdr_unreg,advo_street_frequencies_within_the_county,left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.st=right.st and left.county_name=right.county_name,xform8(left,right),full outer,local);

non_cl_recs  := distribute(ln_propertyv2_addressenhancements.files.hdr_non_cl_slim,hash(prim_range,prim_name,st,county_name));
non_okc_recs := distribute(ln_propertyv2_addressenhancements.files.hdr_non_okc_slim,hash(prim_range,prim_name,st,county_name));

r1 xform9(r1 le, non_cl_recs ri) := transform
 self.street_in_non_cl := if(le.prim_name=ri.prim_name and le.prim_range=ri.prim_range and le.st=ri.st and le.county_name=ri.county_name,true,false);
 self := le;
end;

j_flag_if_found_in_non_cl := join(j_hdr_hdr_unreg_and_advo_street,non_cl_recs,left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.st=right.st and left.county_name=right.county_name,xform9(left,right),left outer,keep(1),local);

r1 xform10(r1 le, non_okc_recs ri) := transform
 self.street_in_non_okc := if(le.prim_name=ri.prim_name and le.prim_range=ri.prim_range and le.st=ri.st and le.county_name=ri.county_name,true,false);
 self := le;
end;

j_flag_if_found_in_non_okc := join(j_flag_if_found_in_non_cl,non_okc_recs,left.prim_range=right.prim_range and left.prim_name=right.prim_name and left.st=right.st and left.county_name=right.county_name,xform10(left,right),left outer,keep(1),local);

project_to_slim_layout                := project(j_flag_if_found_in_non_okc,ln_propertyv2_addressenhancements.layouts.street_in_county) : persist('persist::street_counts_in_the_county'+if(isFast,'_d','f'));

return project_to_slim_layout;

end;