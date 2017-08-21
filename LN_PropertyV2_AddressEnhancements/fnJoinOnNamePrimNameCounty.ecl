// Jira DF-11862 - added isfast parameter to name persist file accordingly in order to run continuous delta in parallel to full
EXPORT fnJoinOnNamePrimNameCounty(dataset(recordof(ln_propertyv2_addressenhancements.PrepFile)) in_ds_by_name_primname, boolean isFast) := function

hdr_frequencies_by_name_primname_county_dist := distribute(ln_propertyv2_addressenhancements.fnCountsByNamePrimNameCounty(isfast),hash(prim_name,st,county_name,fname,lname));

name_primname_candidates      := in_ds_by_name_primname(matched_any='' and property_address_fname<>'' and property_address_lname<>'' and property_address_prim_range='' and property_address_prim_name<>'');
name_primname_candidates_dist := distribute(name_primname_candidates,hash(property_address_prim_name,state,county,property_address_fname,property_address_lname));
not_name_primname_candidates  := in_ds_by_name_primname(~(matched_any='' and property_address_fname<>'' and property_address_lname<>'' and property_address_prim_range='' and property_address_prim_name<>''));

r1 := ln_propertyv2_addressenhancements.layouts.prep_rec;
																				
r1 xform_by_name_primname_county(r1 le, hdr_frequencies_by_name_primname_county_dist ri) := transform

 boolean source_ok := (le.vendor_source_flag in ['F','S'] and ri.name_primname_in_non_okc=true)
                      or
											(le.vendor_source_flag in ['D','O'] and ri.name_primname_in_non_cl=true)
											;

 //self.doesnt_violate_source_restrictions := if(source_ok=true,'Y','N');											
 self.matched_by_name_primname := if(source_ok
                                 and le.property_address_prim_name   =ri.prim_name
										             and le.state                        =ri.st 
										             and le.county                       =ri.county_name
                                 and le.property_address_fname       =ri.fname 
										             and le.property_address_lname       =ri.lname
										             and ri.hdr_name_primname_within_the_county_ct =1//see comment for DIDStreetCounty
																 and ri.hdr_unreg_name_primname_within_the_county_ct =1
										             ,constants.name_primname,'');
 self.appended_prim_range_by_name_primname  := if(self.matched_by_name_primname=constants.name_primname,ri.prim_range,''); 
 self.appended_addr_suffix_by_name_primname := if(self.matched_by_name_primname=constants.name_primname,ri.addr_suffix,''); 
 self.appended_city_name_by_name_primname   := if(self.matched_by_name_primname=constants.name_primname,ri.city_name,'');
 self.appended_st_by_name_primname          := if(self.matched_by_name_primname=constants.name_primname,ri.st,'');
 self.appended_zip_by_name_primname         := if(self.matched_by_name_primname=constants.name_primname,ri.zip,'');
 self.hdr_name_primname_within_the_county_ct       := (string)ri.hdr_name_primname_within_the_county_ct;
 self.hdr_unreg_name_primname_within_the_county_ct := (string)ri.hdr_unreg_name_primname_within_the_county_ct; 
 self.matched_any := if(le.matched_any='Y' or self.matched_by_name_primname<>'','Y','');
 self.property_address_append_prepaddr1_from_hdr := if(self.matched_by_name_primname=constants.name_primname,stringlib.stringcleanspaces(self.appended_prim_range_by_name_primname+' '+le.property_address_prim_name+' '+self.appended_addr_suffix_by_name_primname),'');
 self.property_address_append_prepaddr2_from_hdr := if(self.matched_by_name_primname=constants.name_primname,stringlib.stringcleanspaces(trim(self.appended_city_name_by_name_primname,left,right)+', '+self.appended_st_by_name_primname+' '+self.appended_zip_by_name_primname),'');
 self := le;
end;

j_by_name_primname_county := join(name_primname_candidates_dist,hdr_frequencies_by_name_primname_county_dist,
                                            left.property_address_prim_name =right.prim_name
																				and left.state                      =right.st
																				and left.county                     =right.county_name
																				and left.property_address_fname     =right.fname
																				and left.property_address_lname     =right.lname
																				,xform_by_name_primname_county(left,right),left outer,keep(1),local
																				);

r1 xform_assign_matched_how_back_to_all_records_by_name_primname(r1 le, r1 ri) := transform
 self.matched_by_name_primname                     := if(le.ln_fares_id=ri.ln_fares_id,ri.matched_by_name_primname+'P','');//to capture that this was propagated
 self.appended_prim_range_by_name_primname         := ri.appended_prim_range_by_name_primname; 
 self.appended_addr_suffix_by_name_primname        := ri.appended_addr_suffix_by_name_primname; 
 self.appended_city_name_by_name_primname          := ri.appended_city_name_by_name_primname;
 self.appended_st_by_name_primname                 := ri.appended_st_by_name_primname;
 self.appended_zip_by_name_primname                := ri.appended_zip_by_name_primname;
 self.hdr_name_primname_within_the_county_ct       := ri.hdr_name_primname_within_the_county_ct;
 self.hdr_unreg_name_primname_within_the_county_ct := ri.hdr_unreg_name_primname_within_the_county_ct;
 self.matched_any                                  := if(le.matched_any<>'',le.matched_any,ri.matched_any);
 self.property_address_append_prepaddr1_from_hdr   := ri.property_address_append_prepaddr1_from_hdr;
 self.property_address_append_prepaddr2_from_hdr   := ri.property_address_append_prepaddr2_from_hdr;
 self             := le;
end;

j_assign_matched_how_back_to_all_records_on_name_primname_attempt := join(distribute(j_by_name_primname_county(matched_by_name_primname=''),hash(ln_fares_id)),distribute(j_by_name_primname_county(matched_by_name_primname=constants.name_primname),hash(ln_fares_id)),left.ln_fares_id=right.ln_fares_id,xform_assign_matched_how_back_to_all_records_by_name_primname(left,right),left outer,keep(1),local);

recs_for_name_primname_attempt := j_assign_matched_how_back_to_all_records_on_name_primname_attempt
                                + j_by_name_primname_county(matched_by_name_primname=constants.name_primname)
																+ not_name_primname_candidates;

return recs_for_name_primname_attempt;

end;