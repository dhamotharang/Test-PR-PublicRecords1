import codes, ln_propertyv2, address;

export PrepFile(dataset(recordof(ln_propertyv2.File_Search_DID)) ds_srch,
//export PrepFile(dataset(recordof(LN_PropertyV2.layout_deed_mortgage_property_search_mod)) ds_srch,
                dataset(recordof(ln_propertyv2.File_Assessment)) ds_assr,
								dataset(recordof(ln_propertyv2.File_Deed))       ds_deed,
// Jira DF-11862 - added isfast parameter to name persist file accordingly in order to run continuous delta in parallel to full
								boolean isFast
					     ) := function

codesv3 := codes.File_Codes_V3_In(file_name='FARES_2580' and field_name='LAND_USE' and field_name2 in ['FAR_F','OKCTY']);

r1 := ln_propertyv2_addressenhancements.layouts.prep_rec;

r1 xform_map_tax(ds_assr le) := transform
 self.vendor_source_flag       := le.vendor_source_flag;
 self.ln_fares_id              := le.ln_fares_id;
 self.apn                      := le.apna_or_pin_number;
 self.apn_unformatted          := le.fares_unformatted_apn;
 self.state                    := le.state_code;
 self.county                   := le.county_name;
 self.fips                     := le.fips_code;
 self.mailing_street           := le.mailing_full_street_address;
 self.mailing_unit_nbr         := le.mailing_unit_number;
 self.mailing_csz              := le.mailing_city_state_zip;
 self.property_street          := le.property_full_street_address;
 self.property_unit_nbr        := le.property_unit_number;
 self.property_csz             := le.property_city_state_zip;
 self.property_country_code    := le.property_country_code;
 self.property_address_code    := le.property_address_code;
 self.prop_addr_propagated_ind := le.prop_addr_propagated_ind;
 self.owner_name               := le.assessee_name;
 self.standardized_land_use_code := le.standardized_land_use_code;
 self.sluc                     := '';
end;

r1 xform_map_deed(ds_deed le) := transform
 self.vendor_source_flag       := le.vendor_source_flag;
 self.ln_fares_id              := le.ln_fares_id;
 self.apn                      := le.apnt_or_pin_number;
 self.apn_unformatted          := le.fares_unformatted_apn;
 self.state                    := le.state;
 self.county                   := le.county_name;
 self.fips                     := le.fips_code;
 self.mailing_street           := le.mailing_street;
 self.mailing_unit_nbr         := le.mailing_unit_number;
 self.mailing_csz              := le.mailing_csz;
 self.property_street          := le.property_full_street_address;
 self.property_unit_nbr        := le.property_address_unit_number;
 self.property_csz             := le.property_address_citystatezip;
 self.property_country_code    := '';
 self.property_address_code    := le.property_address_code;
 self.prop_addr_propagated_ind := le.prop_addr_propagated_ind;
 self.owner_name               := le.name1;
 self.standardized_land_use_code := '';
 self.sluc                     := '';
end;

p_tax  := project(ds_assr,xform_map_tax(left));
p_deed := project(ds_deed,xform_map_deed(left));

concat_tax_deed := p_tax + p_deed;
candidates      := concat_tax_deed(property_csz='' and prop_addr_propagated_ind='' and state<>'' and county<>'');

r1 xform0(candidates le, codesv3 ri) := transform
 self.sluc := ri.long_desc;
 self := le;
end;

recs_with_land_use := join(candidates,codesv3,left.standardized_land_use_code=right.code,xform0(left,right),left outer,lookup);

ds_srch_mail := ds_srch(source_code[2]<>'P');
ds_srch_prop := ds_srch(source_code[2] ='P');

recs_with_land_use_dist := distribute(recs_with_land_use,hash(ln_fares_id));
ds_srch_mail_dist       := distribute(ds_srch_mail,hash(ln_fares_id));
ds_srch_prop_dist       := distribute(ds_srch_prop,hash(ln_fares_id));
/*
r1 xform1(recs_with_land_use le, ds_srch_mail_dist ri) := transform

 self.mailing_address_did              := ri.did;
 self.mailing_address_fname            := ri.fname;
 self.mailing_address_mname            := ri.mname;
 self.mailing_address_lname            := ri.lname;
 self.mailing_address_name_suffix      := ri.name_suffix;
 self.mailing_address_name_type        := ri.name_type; 
 self.mailing_address_party_type       := ri.source_code[1];
 self.mailing_address_append_prepaddr1 := ri.append_prepaddr1;
 self.mailing_address_append_prepaddr2 := ri.append_prepaddr2;
 self.mailing_address_prim_range       := ri.prim_range;
 self.mailing_address_prim_name        := ri.prim_name;
 self.mailing_address_sec_range        := ri.sec_range;
 self.mailing_address_v_city_name      := ri.v_city_name;
 self.mailing_address_st               := ri.st;
 self.mailing_address_zip              := ri.zip;
 self.mailing_address_err_stat         := ri.err_stat;
 self := le;
 self := ri;
end;
*/
r1 xform2(r1 le, ds_srch_prop_dist ri) := transform
 self.property_address_did              := ri.did;
 self.property_address_fname            := ri.fname;
 self.property_address_mname            := ri.mname;
 self.property_address_lname            := ri.lname;
 self.property_address_name_suffix      := ri.name_suffix;
 self.property_address_name_type        := ri.name_type; 
 self.property_address_party_type       := ri.source_code[1];
 self.property_address_append_prepaddr1 := ri.append_prepaddr1;
 self.property_address_append_prepaddr2 := ri.append_prepaddr2;
 self.property_address_prim_range       := ri.prim_range;
 self.property_address_prim_name        := ri.prim_name;
 self.property_address_addr_suffix      := ri.suffix;
 self.property_address_sec_range        := ri.sec_range;
 self.property_address_v_city_name      := ri.v_city_name;
 self.property_address_st               := ri.st;
 self.property_address_zip              := ri.zip;
 self.property_address_err_stat         := ri.err_stat;
 self.property_address_prim_name_all_numeric := self.property_address_prim_name<>'' and trim(self.property_address_prim_name)=trim(stringlib.stringfilter(self.property_address_prim_name,'0123456789'));
 self := le;
end;

//j1 := join(recs_with_land_use_dist,ds_srch_mail_dist,left.ln_fares_id=right.ln_fares_id,xform1(left,right),left outer,local);
//j2 := join(j1                     ,ds_srch_prop_dist,left.ln_fares_id=right.ln_fares_id,xform2(left,right),left outer,local) : persist('persist::jet_epic_addr2'+if(isFast,'_d','f'));

j2 := join(recs_with_land_use_dist,ds_srch_prop_dist,left.ln_fares_id=right.ln_fares_id,xform2(left,right),left outer,local);

return j2;

end;