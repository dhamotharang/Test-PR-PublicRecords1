// Jira DF-11862 - added isfast parameter to name persist file accordingly in order to run continuous delta in parallel to full
EXPORT fnJoinOnStreetCounty(dataset(recordof(ln_propertyv2_addressenhancements.PrepFile)) in_ds_by_street, boolean isFast) := function

hdr_frequencies_by_street_county_dist      := distribute(ln_propertyv2_addressenhancements.fnCountsByStreetCounty(isfast),hash(prim_range,prim_name,st,county_name));

    street_candidates      := in_ds_by_street(property_address_prim_range<>'' and property_address_prim_name<>'');
    street_candidates_dist := distribute(street_candidates,hash(property_address_prim_range,property_address_prim_name,state,county));
not_street_candidates      := in_ds_by_street(~(property_address_prim_range<>'' and property_address_prim_name<>''));

r1 := ln_propertyv2_addressenhancements.layouts.prep_rec;

r1 xform_by_street_county(r1 le, hdr_frequencies_by_street_county_dist ri) := transform

 boolean source_ok := (le.vendor_source_flag in ['F','S'] and ri.street_in_non_okc=true)
                      or
											(le.vendor_source_flag in ['D','O'] and ri.street_in_non_cl=true)
											;
 //self.doesnt_violate_source_restrictions := if(source_ok=true,'Y','N');											
 self.matched_by_street := if(
                              le.property_address_prim_range=ri.prim_range 
                          and le.property_address_prim_name =ri.prim_name
										      and le.state                      =ri.st 
										      and le.county                     =ri.county_name
										      and (
													     (ri.addr_in_hdr=true and ri.addr_in_advo=false and ri.hdr_street_within_the_county_ct=1 and ri.hdr_unreg_street_within_the_county_ct=1 and source_ok)
													      or
															 (ri.addr_in_hdr=false and ri.addr_in_advo=true and ri.advo_street_within_the_county_ct=1)
															  or
															 (ri.addr_in_hdr=true and ri.addr_in_advo=true and ri.hdr_street_within_the_county_ct=1 and ri.advo_street_within_the_county_ct=1)
															),
										      constants.street,'');
 self.appended_city_name_by_street := if(self.matched_by_street=constants.street,ri.city_name,'');
 self.appended_st_by_street        := if(self.matched_by_street=constants.street,ri.st,'');
 self.appended_zip_by_street       := if(self.matched_by_street=constants.street,ri.zip,'');
 self.hdr_street_within_the_county_ct       := (string)ri.hdr_street_within_the_county_ct;
 self.hdr_unreg_street_within_the_county_ct := (string)ri.hdr_unreg_street_within_the_county_ct;
 self.advo_street_within_the_county_ct      := (string)ri.advo_street_within_the_county_ct;
 self.matched_any := if(le.matched_any='Y' or self.matched_by_street<>'','Y','');
 self.property_address_append_prepaddr2_from_hdr := if(le.matched_by_name_street<>'',le.property_address_append_prepaddr2_from_hdr,if(self.matched_by_street=constants.street,stringlib.stringcleanspaces(trim(self.appended_city_name_by_street,left,right)+', '+self.appended_st_by_street+' '+self.appended_zip_by_street),''));
 self := le;
end;

j_by_street_county := join(street_candidates_dist,hdr_frequencies_by_street_county_dist,
                                            left.property_address_prim_range=right.prim_range
                                        and left.property_address_prim_name =right.prim_name
																				and left.state                      =right.st
																				and left.county                     =right.county_name
																				,xform_by_street_county(left,right),left outer,keep(1),local
																				);

r1 xform_assign_matched_how_back_to_all_records_by_street(r1 le, r1 ri) := transform
 self.matched_by_street                          := if(le.ln_fares_id=ri.ln_fares_id,ri.matched_by_street+'P','');//to capture that this was propagated
 self.appended_city_name_by_street               := ri.appended_city_name_by_street;
 self.appended_st_by_street                      := ri.appended_st_by_street;
 self.appended_zip_by_street                     := ri.appended_zip_by_street;
 self.hdr_street_within_the_county_ct            := ri.hdr_street_within_the_county_ct;
 self.hdr_unreg_street_within_the_county_ct      := ri.hdr_unreg_street_within_the_county_ct;
 self.matched_any                                := if(le.matched_any<>'',le.matched_any,ri.matched_any);
 self.property_address_append_prepaddr2_from_hdr := if(le.property_address_append_prepaddr2_from_hdr<>'',le.property_address_append_prepaddr2_from_hdr,ri.property_address_append_prepaddr2_from_hdr);
 self             := le;
end;

j_assign_matched_how_back_to_all_records_on_street_attempt := join(distribute(j_by_street_county(matched_by_street=''),hash(ln_fares_id)),distribute(j_by_street_county(matched_by_street=constants.street),hash(ln_fares_id)),left.ln_fares_id=right.ln_fares_id,xform_assign_matched_how_back_to_all_records_by_street(left,right),left outer,keep(1),local);
concat_final := j_assign_matched_how_back_to_all_records_on_street_attempt
              + j_by_street_county(matched_by_street=constants.street)
							+ not_street_candidates;

return concat_final;

end;