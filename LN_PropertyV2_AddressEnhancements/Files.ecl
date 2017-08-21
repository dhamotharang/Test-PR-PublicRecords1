EXPORT Files := module

import header,doxie,ut,bipv2,advo,mdr,ln_propertyv2;

shared hdr     := pull(doxie.key_header)((integer)zip4>0);
shared ds_advo := advo.files().file_cleaned_base;

//resolve some inconsistencies between the property file and the county lookup applied to the header
shared recordof(hdr) xform0(hdr le) := transform

 string v_county1 := stringlib.stringfilterout(le.county_name,'.');
 string v_county2 := if(v_county1='MIAMI-DADE','DADE',v_county1);
 
 self.county_name := trim(v_county2); 
 self             := le;
end;

shared hdr_county_patch       := project(hdr,xform0(left));

shared ln_propertyv2_addressenhancements.Layouts.wide_rec xform_map_hdr(hdr_county_patch le) := transform
 //self.hdr_did_street_within_the_county_ct    := 1;
 self.hdr_name_street_within_the_county_ct   := 1;
 self.hdr_street_within_the_county_ct        := 1;
 self.hdr_name_primname_within_the_county_ct := 1;
 //self.hdr_name_within_the_county_ct          := 1;
 //self.hdr_did_csz_within_the_county_ct     := 1;
 self.addr_suffix                            := le.suffix;
 self.addr_in_hdr                            := true;
 self                                        := le;
end;

shared ln_propertyv2_addressenhancements.Layouts.wide_rec xform_map_hdr_unreg(hdr_county_patch le) := transform
 //self.hdr_unreg_did_street_within_the_county_ct    := 1;
 self.hdr_unreg_name_street_within_the_county_ct   := 1;
 self.hdr_unreg_street_within_the_county_ct        := 1;
 self.hdr_unreg_name_primname_within_the_county_ct := 1;
 //self.hdr_unreg_name_within_the_county_ct          := 1;
 //self.hdr_unreg_did_csz_within_the_county_ct     := 1;
 self.addr_suffix                                  := le.suffix;
 self.addr_in_hdr_unreg                            := true;                  
 self                                              := le;
end;

//shared ln_propertyv2_addressenhancements.Layouts.wide_rec xform_map_hdr_cl(hdr_county_patch le) := transform
// self.hdr_cl_did_street_within_the_county_ct  := 1;
// self.hdr_cl_name_street_within_the_county_ct := 1;
// self.hdr_cl_street_within_the_county_ct      := 1;
// self.hdr_cl_did_csz_within_the_county_ct     := 1;
// self.addr_in_hdr_cl                          := true;                  
// self                                         := le;
//end;

shared ln_propertyv2_addressenhancements.Layouts.wide_rec xform_map_advo(ds_advo le, ln_propertyv2.File_FIPS_Lookup ri) := transform
 self.advo_street_within_the_county_ct := 1;
 self.dt_last_seen := (unsigned3)(le.date_last_seen[1..6]);
 self.prim_range   := le.prim_range;
 self.prim_name    := le.prim_name;
 self.addr_suffix  := le.addr_suffix;
 self.sec_range    := le.sec_range;
 self.city_name    := le.p_city_name;//p_city produces better results than v_city
 self.st           := le.st;
 self.zip          := le.zip;
 self.zip4         := le.zip4;
 self.county_name  := ri.county_alpha;
 self.addr_in_advo := true;
 self              := [];
end;

export hdr_slim       := project(hdr_county_patch,xform_map_hdr(left));
export hdr_unreg_slim := project(hdr_county_patch,xform_map_hdr_unreg(left))(src not in mdr.sourcetools.set_dppa and src not in mdr.sourcetools.set_glb);
//export hdr_cl_slim    := project(hdr_county_patch,xform_map_hdr(left))(src in ['FA','FP','FR','NT']);
//export hdr_okc_slim   := project(hdr_county_patch,xform_map_hdr(left))(src in ['LA','LP']);
export hdr_non_cl_slim    := project(hdr_county_patch,xform_map_hdr(left))(src not in ['FA','FP','FR','NT']);
export hdr_non_okc_slim   := project(hdr_county_patch,xform_map_hdr(left))(src not in ['LA','LP']);
export advo_          := dedup(sort(distribute(join(ds_advo,ln_propertyv2.File_FIPS_Lookup,left.fips_county=right.state_code and left.county=right.county_code,xform_map_advo(left,right),lookup),hash(prim_range,prim_name,st,county_name)),prim_range,prim_name,sec_range,city_name,st,zip,zip4,county_name,-dt_last_seen,local),prim_range,prim_name,sec_range,city_name,st,zip,zip4,county_name,local);

end;