import address;

EXPORT mapping_reunion_tax(unsigned1 mode = 1, STRING sVersion = reunion.constants.sVersion) := MODULE

tax := reunion.assessments(mode, sVersion).all;

reunion.layouts.l_tax t1(tax le) := transform
 self.main_adl                   := intformat(le.did,12,1);
 self.state                      := le.state_code;
 self.county                     := le.county_name;
 self.apn                        := le.apna_or_pin_number;
 self.owner1                     := le.assessee_name;
 self.owner2                     := le.second_assessee_name;
 self.property_street            := address.Addr1FromComponents(le.pro_prim_range,le.pro_predir,le.pro_prim_name,le.pro_suffix,le.pro_postdir,le.pro_unit_desig,le.pro_sec_range);
 self.property_city              := le.pro_v_city_name;
 self.property_st                := le.pro_st;
 self.property_zip               := le.pro_zip+if(le.pro_zip4<>'','-'+le.pro_zip4,'');
 self.owner_street               := address.Addr1FromComponents(le.own_prim_range,le.own_predir,le.own_prim_name,le.own_suffix,le.own_postdir,le.own_unit_desig,le.own_sec_range);
 self.owner_city                 := le.own_v_city_name;
 self.owner_st                   := le.own_st;
 self.owner_zip                  := le.own_zip+if(le.own_zip4<>'','-'+le.own_zip4,'');
 self.tax_year                   := le.tax_year;
 self.tax_amount                 := le.tax_amount;
 self.total_assessed_value       := le.assessed_total_value;
 self.assessed_improvement_value := le.assessed_improvement_value;
 self.assessed_land_value        := le.assessed_land_value;
 self.assessment_year            := le.assessed_value_year;
 self.total_market_value         := le.market_total_value;
 self.market_improvement_value   := le.market_improvement_value;
 self.market_land_value          := le.market_land_value;
 self.market_value_year          := le.market_value_year;
 self.recorder_book              := le.recorder_book_number;
 self.recorder_page              := le.recorder_page_number;
 self.document_number            := le.recorder_document_number;
 self.document_type              := le.document_type;
 self.recording_date             := le.recording_date;
 self.sale_date                  := le.sale_date;
 self.sale_price                 := le.sales_price;
 self.exemption                  := le.homestead_homeowner_exemption;
 self.land_use                   := if(le.standardized_land_use_code_decoded<>'',le.standardized_land_use_code_decoded,le.county_land_use_description);
 self.subdivision_name           := le.legal_subdivision_name;
 self.year_built                 := le.year_built;
 self.stories                    := le.no_of_stories;
 self.bedrooms                   := le.no_of_bedrooms;
 self.baths                      := le.no_of_baths;
 self.total_rooms                := le.no_of_rooms;
 self.fireplace_indicator        := if(le.fireplace_indicator='Y' or le.fireplace_number<>'','Y','');
 self.garage_type                := le.garage_decoded;
 self.garage_size                := le.parking_no_of_cars;
 self.pool_spa                   := le.pool_decoded;
 self.style                      := le.style_decoded;
 self.air_conditioning           := le.air_conditioning_decoded;
 self.heating                    := le.heating_decoded;
 self.construction               := le.construction_decoded;
 self.basement                   := le.basement_decoded;
 self.exterior_walls             := le.exterior_walls_decoded;
 self.foundation                 := le.foundation_decoded;
 self.roof                       := le.roof_cover_decoded;
 self.elevator                   := le.elevator_decoded;
 self.property_lot_size          := if(le.land_acres<>'',le.land_acres,if(le.land_square_footage<>'',le.land_square_footage,if(le.land_dimensions<>'',le.land_dimensions,'')));
 self.building_area              := le.building_area;
 self.legal_description          := le.legal_brief_description;
end;

p1      := project(tax ,t1(left));
//p1_dist := distribute(p1,hash(main_adl));
//p1_dupd := dedup(p1_dist,record,all,local);
// restrict to most recent assessment year
EXPORT all := DEDUP(SORT(DISTRIBUTE(p1, HASH32(main_adl, property_street, property_zip)),
						main_adl, property_street, property_zip, -assessment_year, LOCAL), main_adl, property_street, property_zip, LOCAL);


END;