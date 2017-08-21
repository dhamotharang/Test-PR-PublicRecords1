// Begin code to produce match candidates
import ut;
export match_candidates(dataset(layout_file_business_header) ih) := module
shared s := Specificities(ih).Specificities[1];
h00 := Specificities(ih).input_file;
shared thin_table := table(h00,{fein,phone,vendor_id,company_name,prim_range,zip,sec_range,zip4,CITY,unit_desig,county,prim_name,state,msa,SOURCE,addr_suffix,locale,address,RCID,BDID});// Already distributed by specificities module
//Prepare for field propagations ...
PrePropCounts := record
  real8 fein_pop := ave(group,if(thin_table.fein in SET(s.nulls_fein,fein),0,100));
  real8 phone_pop := ave(group,if(thin_table.phone in SET(s.nulls_phone,phone),0,100));
  real8 vendor_id_pop := ave(group,if(thin_table.vendor_id in SET(s.nulls_vendor_id,vendor_id),0,100));
  real8 company_name_pop := ave(group,if(thin_table.company_name in SET(s.nulls_company_name,company_name),0,100));
  real8 prim_range_pop := ave(group,if(thin_table.prim_range in SET(s.nulls_prim_range,prim_range),0,100));
  real8 zip_pop := ave(group,if(thin_table.zip in SET(s.nulls_zip,zip),0,100));
  real8 sec_range_pop := ave(group,if(thin_table.sec_range in SET(s.nulls_sec_range,sec_range),0,100));
  real8 zip4_pop := ave(group,if(thin_table.zip4 in SET(s.nulls_zip4,zip4),0,100));
  real8 CITY_pop := ave(group,if(thin_table.CITY in SET(s.nulls_CITY,CITY),0,100));
  real8 unit_desig_pop := ave(group,if(thin_table.unit_desig in SET(s.nulls_unit_desig,unit_desig),0,100));
  real8 county_pop := ave(group,if(thin_table.county in SET(s.nulls_county,county),0,100));
  real8 prim_name_pop := ave(group,if(thin_table.prim_name in SET(s.nulls_prim_name,prim_name),0,100));
  real8 state_pop := ave(group,if(thin_table.state in SET(s.nulls_state,state),0,100));
  real8 msa_pop := ave(group,if(thin_table.msa in SET(s.nulls_msa,msa),0,100));
  real8 SOURCE_pop := ave(group,if(thin_table.SOURCE in SET(s.nulls_SOURCE,SOURCE),0,100));
  real8 addr_suffix_pop := ave(group,if(thin_table.addr_suffix in SET(s.nulls_addr_suffix,addr_suffix),0,100));
  real8 locale_pop := ave(group,if(thin_table.locale in SET(s.nulls_locale,locale),0,100));
  real8 address_pop := ave(group,if(thin_table.address in SET(s.nulls_address,address),0,100));
end;
export PrePropogationStats := table(thin_table,PrePropCounts);
shared layout_withpropvars := record
  thin_table;
  boolean fein_prop := false;
  boolean phone_prop := false;
end;
shared with_bools := table(thin_table,layout_withpropvars);
mac_prop_field(with_bools(fein NOT IN SET(s.nulls_fein,fein)),fein,BDID,fein_props); // For every DID find the best FULL fein
layout_withpropvars take_fein(with_bools le,fein_props ri) := transform
  self.fein := if ( le.fein IN SET(s.nulls_fein,fein) and ri.BDID<>(typeof(ri.BDID))'', ri.fein, le.fein );
  self.fein_prop := if ( le.fein IN SET(s.nulls_fein,fein) and ri.fein NOT IN SET(s.nulls_fein,fein) and ri.BDID<>(typeof(ri.BDID))'', true, le.fein_prop );
  self := le;
  end;
shared pj0 := join(with_bools,fein_props,left.BDID=right.BDID,take_fein(left,right),local,left outer);
mac_prop_field(with_bools(phone NOT IN SET(s.nulls_phone,phone)),phone,BDID,phone_props); // For every DID find the best FULL phone
layout_withpropvars take_phone(with_bools le,phone_props ri) := transform
  self.phone := if ( le.phone IN SET(s.nulls_phone,phone) and ri.BDID<>(typeof(ri.BDID))'', ri.phone, le.phone );
  self.phone_prop := if ( le.phone IN SET(s.nulls_phone,phone) and ri.phone NOT IN SET(s.nulls_phone,phone) and ri.BDID<>(typeof(ri.BDID))'', true, le.phone_prop );
  self := le;
  end;
shared pj1 := join(pj0,phone_props,left.BDID=right.BDID,take_phone(left,right),local,left outer);
shared propogated := pj1 : persist('temp::Business_Header_Bdid_lift_BDID_file_business_header_mc_props'); // to allow to 'jump' over an exported value
PostPropCounts := record
  real8 fein_pop := ave(group,if(propogated.fein in SET(s.nulls_fein,fein),0,100));
  real8 phone_pop := ave(group,if(propogated.phone in SET(s.nulls_phone,phone),0,100));
  real8 vendor_id_pop := ave(group,if(propogated.vendor_id in SET(s.nulls_vendor_id,vendor_id),0,100));
  real8 company_name_pop := ave(group,if(propogated.company_name in SET(s.nulls_company_name,company_name),0,100));
  real8 prim_range_pop := ave(group,if(propogated.prim_range in SET(s.nulls_prim_range,prim_range),0,100));
  real8 zip_pop := ave(group,if(propogated.zip in SET(s.nulls_zip,zip),0,100));
  real8 sec_range_pop := ave(group,if(propogated.sec_range in SET(s.nulls_sec_range,sec_range),0,100));
  real8 zip4_pop := ave(group,if(propogated.zip4 in SET(s.nulls_zip4,zip4),0,100));
  real8 CITY_pop := ave(group,if(propogated.CITY in SET(s.nulls_CITY,CITY),0,100));
  real8 unit_desig_pop := ave(group,if(propogated.unit_desig in SET(s.nulls_unit_desig,unit_desig),0,100));
  real8 county_pop := ave(group,if(propogated.county in SET(s.nulls_county,county),0,100));
  real8 prim_name_pop := ave(group,if(propogated.prim_name in SET(s.nulls_prim_name,prim_name),0,100));
  real8 state_pop := ave(group,if(propogated.state in SET(s.nulls_state,state),0,100));
  real8 msa_pop := ave(group,if(propogated.msa in SET(s.nulls_msa,msa),0,100));
  real8 SOURCE_pop := ave(group,if(propogated.SOURCE in SET(s.nulls_SOURCE,SOURCE),0,100));
  real8 addr_suffix_pop := ave(group,if(propogated.addr_suffix in SET(s.nulls_addr_suffix,addr_suffix),0,100));
  real8 locale_pop := ave(group,if(propogated.locale in SET(s.nulls_locale,locale),0,100));
  real8 address_pop := ave(group,if(propogated.address in SET(s.nulls_address,address),0,100));
end;
export PostPropogationStats := table(propogated,PostPropCounts);
shared h0 := dedup( sort ( propogated, whole record, local ), whole record, local );// Only one copy of each record
export Layout_Matches := record//in this module for because of ,foward bug
  unsigned2 Rule;
  integer2 Conf;
  integer2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  integer2 Conf_Prop; // Confidense provided by propogated fields
  unsigned6 BDID1;
  unsigned6 BDID2;
  unsigned6 RCID1 := 0;
  unsigned6 RCID2 := 0;
end;
export Layout_Candidates := record,maxlength(31999) // A record to hold weights of each field value
  {h0} AND NOT [company_name]; // remove wordbag fields which need to be expanded
  unsigned2 fein_weight100 := 0; // Contains 100x the specificity
  unsigned2 phone_weight100 := 0; // Contains 100x the specificity
  unsigned2 vendor_id_weight100 := 0; // Contains 100x the specificity
  string240 company_name := h0.company_name; // Expanded wordbag field
  unsigned2 company_name_weight100 := 0; // Contains 100x the specificity
  unsigned2 prim_range_weight100 := 0; // Contains 100x the specificity
  unsigned prim_range_cnt := 0; // Number of instances with this particular field value
  unsigned prim_range_e1_cnt := 0; // Number of names instances matching this one by edit distance
  unsigned2 zip_weight100 := 0; // Contains 100x the specificity
  unsigned2 sec_range_weight100 := 0; // Contains 100x the specificity
  unsigned2 zip4_weight100 := 0; // Contains 100x the specificity
  unsigned2 CITY_weight100 := 0; // Contains 100x the specificity
  unsigned2 unit_desig_weight100 := 0; // Contains 100x the specificity
  unsigned2 county_weight100 := 0; // Contains 100x the specificity
  unsigned2 prim_name_weight100 := 0; // Contains 100x the specificity
  unsigned2 state_weight100 := 0; // Contains 100x the specificity
  unsigned2 msa_weight100 := 0; // Contains 100x the specificity
  unsigned2 SOURCE_weight100 := 0; // Contains 100x the specificity
  unsigned2 addr_suffix_weight100 := 0; // Contains 100x the specificity
  unsigned2 locale_weight100 := 0; // Contains 100x the specificity
  unsigned2 address_weight100 := 0; // Contains 100x the specificity
end;
h1 := table(h0,layout_candidates);
//Now add the weights of each field one by one
//Would also create auto-id fields here
layout_candidates add_addr_suffix(layout_candidates le,Specificities(ih).addr_suffix_values_persisted ri) := transform
  self.addr_suffix_weight100 := ri.field_specificity * 100;
  self := le;
end;
j17 := join(h1,Specificities(ih).addr_suffix_values_persisted,left.addr_suffix=right.addr_suffix,add_addr_suffix(left,right),lookup,left outer);
layout_candidates add_unit_desig(layout_candidates le,Specificities(ih).unit_desig_values_persisted ri) := transform
  self.unit_desig_weight100 := ri.field_specificity * 100;
  self := le;
end;
j16 := join(j17,Specificities(ih).unit_desig_values_persisted,left.unit_desig=right.unit_desig,add_unit_desig(left,right),lookup,left outer);
layout_candidates add_SOURCE(layout_candidates le,Specificities(ih).SOURCE_values_persisted ri) := transform
  self.SOURCE_weight100 := ri.field_specificity * 100;
  self := le;
end;
j15 := join(j16,Specificities(ih).SOURCE_values_persisted,left.SOURCE=right.SOURCE,add_SOURCE(left,right),lookup,left outer);
layout_candidates add_state(layout_candidates le,Specificities(ih).state_values_persisted ri) := transform
  self.state_weight100 := ri.field_specificity * 100;
  self := le;
end;
j14 := join(j15,Specificities(ih).state_values_persisted,left.state=right.state,add_state(left,right),lookup,left outer);
layout_candidates add_county(layout_candidates le,Specificities(ih).county_values_persisted ri) := transform
  self.county_weight100 := ri.field_specificity * 100;
  self := le;
end;
j13 := join(j14,Specificities(ih).county_values_persisted,left.county=right.county,add_county(left,right),lookup,left outer);
layout_candidates add_msa(layout_candidates le,Specificities(ih).msa_values_persisted ri) := transform
  self.msa_weight100 := ri.field_specificity * 100;
  self := le;
end;
j12 := join(j13,Specificities(ih).msa_values_persisted,left.msa=right.msa,add_msa(left,right),lookup,left outer);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri) := transform
  self.sec_range_weight100 := ri.field_specificity * 100;
  self := le;
end;
j11 := join(j12,Specificities(ih).sec_range_values_persisted,left.sec_range=right.sec_range,add_sec_range(left,right),lookup,left outer);
layout_candidates add_CITY(layout_candidates le,Specificities(ih).CITY_values_persisted ri) := transform
  self.CITY_weight100 := ri.field_specificity * 100;
  self := le;
end;
Business_Header_Bdid_lift.MAC_Choose_JoinType(j11,s.nulls_CITY,Specificities(ih).CITY_values_persisted,CITY,CITY_weight100,add_CITY,j10);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri) := transform
  self.prim_name_weight100 := ri.field_specificity * 100;
  self := le;
end;
MAC_Choose_JoinType(j10,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_prim_name,j9);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri) := transform
  self.prim_range_cnt := ri.cnt;
  self.prim_range_e1_cnt := ri.e1_cnt;
  self.prim_range_weight100 := ri.field_specificity * 100;
  self := le;
end;
MAC_Choose_JoinType(j9,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j8);
layout_candidates add_zip4(layout_candidates le,Specificities(ih).zip4_values_persisted ri) := transform
  self.zip4_weight100 := ri.field_specificity * 100;
  self := le;
end;
MAC_Choose_JoinType(j8,s.nulls_zip4,Specificities(ih).zip4_values_persisted,zip4,zip4_weight100,add_zip4,j7);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri) := transform
  self.zip_weight100 := ri.field_specificity * 100;
  self := le;
end;
MAC_Choose_JoinType(j7,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j6);
layout_candidates add_locale(layout_candidates le,Specificities(ih).locale_values_persisted ri) := transform
  self.locale_weight100 := ri.field_specificity * 100;
  self := le;
end;
MAC_Choose_JoinType(j6,s.nulls_locale,Specificities(ih).locale_values_persisted,locale,locale_weight100,add_locale,j5);
layout_candidates add_address(layout_candidates le,Specificities(ih).address_values_persisted ri) := transform
  self.address_weight100 := ri.field_specificity * 100;
  self := le;
end;
MAC_Choose_JoinType(j5,s.nulls_address,Specificities(ih).address_values_persisted,address,address_weight100,add_address,j4);
layout_candidates add_company_name(layout_candidates le,Specificities(ih).company_name_values_persisted ri) := transform
  self.company_name_weight100 := ri.field_specificity * 100;
  self.company_name := if( ri.field_specificity<>0 or ri.word<>'',self.company_name_weight100+' '+ri.word,le.company_name );// Copy in annotated wordstring
  self := le;
end;
MAC_Choose_JoinType(j4,s.nulls_company_name,Specificities(ih).company_name_values_persisted,company_name,company_name_weight100,add_company_name,j3);
layout_candidates add_phone(layout_candidates le,Specificities(ih).phone_values_persisted ri) := transform
  self.phone_weight100 := ri.field_specificity * 100;
  self := le;
end;
MAC_Choose_JoinType(j3,s.nulls_phone,Specificities(ih).phone_values_persisted,phone,phone_weight100,add_phone,j2);
layout_candidates add_vendor_id(layout_candidates le,Specificities(ih).vendor_id_values_persisted ri) := transform
  self.vendor_id_weight100 := ri.field_specificity * 100;
  self := le;
end;
MAC_Choose_JoinType(j2,s.nulls_vendor_id,Specificities(ih).vendor_id_values_persisted,vendor_id,vendor_id_weight100,add_vendor_id,j1);
layout_candidates add_fein(layout_candidates le,Specificities(ih).fein_values_persisted ri) := transform
  self.fein_weight100 := ri.field_specificity * 100;
  self := le;
end;
MAC_Choose_JoinType(j1,s.nulls_fein,Specificities(ih).fein_values_persisted,fein,fein_weight100,add_fein,j0);
shared Annotated := distribute(j0,BDID) : persist('temp::Business_Header_Bdid_lift_file_business_header_mc'); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.fein_weight100 + Annotated.vendor_id_weight100 + Annotated.phone_weight100 + Annotated.company_name_weight100 + Annotated.address_weight100 + Annotated.locale_weight100 + Annotated.county_weight100 + Annotated.SOURCE_weight100;
shared Linkable := TotalWeight >= 50;
export Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
export Candidates := Annotated(Linkable); //No point in trying to link records with too little data
end;
