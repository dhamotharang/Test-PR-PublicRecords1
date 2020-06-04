import ln_propertyv2, D2C_Customers;

EXPORT assessments(unsigned1 mode = 1, STRING sVersion = reunion.constants.sVersion) := MODULE

ds_tax  := ln_propertyv2.File_Assessment(vendor_source_flag in ['D','O']);

r1 := record
 ds_tax.vendor_source_flag;
 ds_tax.ln_fares_id;
 ds_tax.current_record;
 ds_tax.state_code;
 ds_tax.county_name;
 ds_tax.apna_or_pin_number;
 ds_tax.assessee_name;
 ds_tax.second_assessee_name;
 ds_tax.tax_year;
 ds_tax.tax_amount;
 ds_tax.assessed_land_value;
 ds_tax.assessed_improvement_value;
 ds_tax.assessed_total_value;
 ds_tax.assessed_value_year;
 ds_tax.market_land_value;
 ds_tax.market_improvement_value;
 ds_tax.market_total_value;
 ds_tax.market_value_year;  
 ds_tax.recorder_book_number;
 ds_tax.recorder_page_number;
 ds_tax.recorder_document_number;
 ds_tax.document_type;
 ds_tax.recording_date;
 ds_tax.sale_date;
 ds_tax.sales_price;
 ds_tax.homestead_homeowner_exemption;
 ds_tax.county_land_use_description;
 ds_tax.standardized_land_use_code;
 ds_tax.legal_brief_description;
 ds_tax.legal_subdivision_name;
 ds_tax.year_built;
 ds_tax.no_of_stories;
 ds_tax.no_of_bedrooms;
 ds_tax.no_of_baths;
 ds_tax.no_of_rooms;
 ds_tax.fireplace_indicator;
 ds_tax.fireplace_number;
 ds_tax.garage_type_code;
 ds_tax.parking_no_of_cars; 
 ds_tax.pool_code;
 ds_tax.style_code;
 ds_tax.air_conditioning_code;
 ds_tax.heating_code;
 ds_tax.type_construction_code;
 ds_tax.basement_code;
 ds_tax.exterior_walls_code;
 ds_tax.foundation_code;
 ds_tax.roof_cover_code;
 ds_tax.roof_type_code;
 ds_tax.elevator;
 ds_tax.land_acres;
 ds_tax.land_square_footage;
 ds_tax.land_dimensions;
 ds_tax.building_area;
 string80 standardized_land_use_code_decoded :='';
 string30 stories_decoded                    :='';
 string30 garage_decoded                     :='';
 string30 pool_decoded                       :='';
 string30 style_decoded                      :='';
 string30 air_conditioning_decoded           :='';
 string30 heating_decoded                    :='';
 string30 construction_decoded               :='';
 string30 basement_decoded                   :='';
 string30 exterior_walls_decoded             :='';
 string30 foundation_decoded                 :='';
 string30 roof_cover_decoded                 :='';
 string30 roof_type_decoded                  :='';
 string10 elevator_decoded                   :='';
end;

r1 t1(ds_tax le) := transform
 self.standardized_land_use_code_decoded := reunion.lookups.lookup_tax_land_use        (le.standardized_land_use_code);
 self.stories_decoded                    := reunion.lookups.lookup_tax_stories         (le.no_of_stories);
 self.garage_decoded                     := reunion.lookups.lookup_tax_garage          (le.garage_type_code);
 self.pool_decoded                       := reunion.lookups.lookup_tax_pool            (le.pool_code);
 self.style_decoded                      := reunion.lookups.lookup_tax_style           (le.style_code);
 self.air_conditioning_decoded           := reunion.lookups.lookup_tax_air_conditioning(le.air_conditioning_code);
 self.heating_decoded                    := reunion.lookups.lookup_tax_heating         (le.heating_code);
 self.construction_decoded               := reunion.lookups.lookup_tax_construction    (le.type_construction_code);
 self.basement_decoded                   := reunion.lookups.lookup_tax_basement        (le.basement_code);
 self.exterior_walls_decoded             := reunion.lookups.lookup_tax_exterior_walls  (le.exterior_walls_code);
 self.foundation_decoded                 := reunion.lookups.lookup_tax_foundation      (le.foundation_code);
 self.roof_cover_decoded                 := reunion.lookups.lookup_tax_roof_cover      (le.roof_cover_code);
 self.elevator_decoded                   := reunion.lookups.lookup_tax_elevator        (le.elevator);
 self := le;
end;

p1        := distribute(project(ds_tax,t1(left)),hash(ln_fares_id));
srch_dist := distribute(reunion.property_search2(mode, sVersion)(ln_fares_id2[2]='A' and D2C_Customers.SRC_Allowed.Check(21, ln_fares_id2)),hash(ln_fares_id2));

r2 := record
 p1;
 srch_dist;
end;

r2 t3(p1 le, srch_dist ri) := transform
 self := le;
 self := ri;
end;

j1 := join(p1,srch_dist,left.ln_fares_id=right.ln_fares_id2,t3(left,right),local);
					
current_owners := ln_propertyv2.key_addr_fid_prep(source_code='OP' and owner=true and ln_owner=true and ln_fares_id[2]='A');

j1_dist             := distribute(j1,            hash(ln_fares_id));
current_owners_dist := distribute(current_owners,hash(ln_fares_id));

recordof(j1_dist) t4(j1_dist le, current_owners_dist ri) := transform
 self := le;
end;

j2 := join(j1_dist,current_owners_dist,
           left.ln_fares_id= right.ln_fares_id and
		   left.lname      = right.lname,
		   t4(left,right),
		   keep(1),
		   local
		  );

EXPORT all := j2 : persist('persist::reunion_assessments::' + reunion.Constants.sMode(mode));

END;