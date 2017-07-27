import ln_property;

export ln_property_valid_state := [
'AK','AL','AR','AS','AZ','CA','CO','CT','DC','DE',
'FL','FM','GA','GU','HI','IA','ID','IL','IN','KS',
'KY','LA','MA','MD','ME','MH','MI','MN','MO','MP',
'MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY',
'OH','OK','ON','OR','PA','PR','PW','RI','SC','SD',
'TN','TX','UM','UT','VA','VI','VT','WA','WI','WV',
'WY'];

in_file := ln_property.File_Assessment(state_code in ln_property_valid_state and vendor_source_flag in ['DAYTN','OKCTY'],
                                       new_record_type_code <> 'PP');

fNonzero(string Input) :=
 if(length(trim(stringlib.stringfilter(Input,'0')))=length(trim(Input)),'',Input);
 
LN_Property.Layout_Property_Common_Model_BASE t1(LN_Property.Layout_Property_Common_Model_BASE l) := transform
 self.county_name := stringlib.stringtouppercase(l.county_name);
 self := l;
end;

p1 := project(in_file,t1(left));

assr_hist_dist := p1;
//assr_hist_dist := distribute(p1,hash(fips_code,state_code,county_name));
//d := distribute(p1,hash(fips_code,state_code,county_name));

assr_counts_rec :=  record
assr_total := count(group);
assr_hist_dist.state_code;
assr_hist_dist.county_name;
//has_state_code                       := count(group,trim(assr_hist_dist.state_code)!='');
//has_county_name                      := count(group,trim(assr_hist_dist.county_name)!='');
has_apn                              := count(group,trim(fNonzero(assr_hist_dist.apna_or_pin_number))!='');
has_assessee_name                    := count(group,trim(assr_hist_dist.assessee_name)!='');
has_second_assessee_name             := count(group,trim(assr_hist_dist.second_assessee_name)!='');
has_assessee_ownership_rights_code   := count(group,trim(assr_hist_dist.assessee_ownership_rights_code)!='');
has_assessee_relationship_code       := count(group,trim(assr_hist_dist.assessee_relationship_code)!='');
has_assessee_phone_number            := count(group,trim(fNonzero(assr_hist_dist.assessee_phone_number))!='');
has_contract_owner                   := count(group,trim(assr_hist_dist.contract_owner)!='');
has_mailing_care_of_name             := count(group,trim(assr_hist_dist.mailing_care_of_name)!='');
has_mailing_full_street_address      := count(group,trim(assr_hist_dist.mailing_full_street_address)!='');
has_mailing_city_state_zip           := count(group,trim(assr_hist_dist.mailing_city_state_zip)!='');
has_property_full_street_address     := count(group,trim(assr_hist_dist.property_full_street_address)!='');
has_property_city_state_zip          := count(group,trim(assr_hist_dist.property_city_state_zip)!='');
has_legal_lot_code                   := count(group,trim(assr_hist_dist.legal_lot_code)!='');
has_legal_lot_number                 := count(group,trim(assr_hist_dist.legal_lot_number)!='');
has_legal_block                      := count(group,trim(assr_hist_dist.legal_block)!='');
has_legal_section                    := count(group,trim(assr_hist_dist.legal_section)!='');
has_legal_district                   := count(group,trim(assr_hist_dist.legal_district)!='');
has_legal_land_lot                   := count(group,trim(assr_hist_dist.legal_land_lot)!='');
has_legal_unit                       := count(group,trim(assr_hist_dist.legal_unit)!='');
has_legal_city_municipality_township := count(group,trim(assr_hist_dist.legal_city_municipality_township)!='');
has_legal_subdivision_name           := count(group,trim(assr_hist_dist.legal_subdivision_name)!='');
has_legal_phase_number               := count(group,trim(assr_hist_dist.legal_phase_number)!='');
has_legal_tract_number               := count(group,trim(assr_hist_dist.legal_tract_number)!='');
has_legal_assessor_map_ref           := count(group,trim(assr_hist_dist.legal_assessor_map_ref)!='');
has_census_tract                     := count(group,trim(assr_hist_dist.census_tract)!='');
has_record_type_code                 := count(group,trim(assr_hist_dist.record_type_code)!='');
has_legal_brief_description          := count(group,trim(assr_hist_dist.legal_brief_description)!='');
has_legal_sec_twn_rng_mer            := count(group,trim(assr_hist_dist.legal_sec_twn_rng_mer)!='');
has_county_land_use_description      := count(group,trim(assr_hist_dist.county_land_use_description)!='');
has_standardized_land_use_code       := count(group,trim(assr_hist_dist.standardized_land_use_code)!='');
has_timeshare_code                   := count(group,trim(assr_hist_dist.timeshare_code)!='');
has_zoning                           := count(group,trim(assr_hist_dist.zoning)!='');
has_owner_occupied                   := count(group,trim(assr_hist_dist.owner_occupied)!='');
has_recording_date                   := count(group,trim(fNonzero(assr_hist_dist.recording_date))!='');
has_recorder_document_number         := count(group,trim(fNonzero(assr_hist_dist.recorder_document_number))!='');
has_recorder_book_number             := count(group,trim(fNonzero(assr_hist_dist.recorder_book_number))!='');
has_recorder_page_number             := count(group,trim(fNonzero(assr_hist_dist.recorder_page_number))!='');
has_document_type                    := count(group,trim(assr_hist_dist.document_type)!='');
has_sales_price                      := count(group,trim(fNonzero(assr_hist_dist.sales_price))!='');
has_sales_price_code                 := count(group,trim(assr_hist_dist.sales_price_code)!='');
has_prior_recording_date             := count(group,trim(fNonzero(assr_hist_dist.prior_recording_date))!='');
has_prior_sales_price                := count(group,trim(fNonzero(assr_hist_dist.prior_sales_price))!='');
has_prior_sales_price_code           := count(group,trim(assr_hist_dist.prior_sales_price_code)!='');
has_assessed_land_value              := count(group,trim(fNonzero(assr_hist_dist.assessed_land_value))!='');
has_assessed_improvement_value       := count(group,trim(fNonzero(assr_hist_dist.assessed_improvement_value))!='');
has_assessed_total_value             := count(group,trim(fNonzero(assr_hist_dist.assessed_total_value))!='');
has_assessed_value_year              := count(group,trim(fNonzero(assr_hist_dist.assessed_value_year))!='');
has_market_land_value                := count(group,trim(fNonzero(assr_hist_dist.market_land_value))!='');
has_market_improvement_value         := count(group,trim(fNonzero(assr_hist_dist.market_improvement_value))!='');
has_market_total_value               := count(group,trim(fNonzero(assr_hist_dist.market_total_value))!='');
has_market_value_year                := count(group,trim(fNonzero(assr_hist_dist.market_value_year))!='');
has_homestead_homeowner_exemption    := count(group,trim(assr_hist_dist.homestead_homeowner_exemption)!='');
has_tax_exemption1_code              := count(group,trim(assr_hist_dist.tax_exemption1_code)!='');
has_tax_exemption2_code              := count(group,trim(assr_hist_dist.tax_exemption2_code)!='');
has_tax_exemption3_code              := count(group,trim(assr_hist_dist.tax_exemption3_code)!='');
has_tax_exemption4_code              := count(group,trim(assr_hist_dist.tax_exemption4_code)!='');
has_tax_rate_code_area               := count(group,trim(assr_hist_dist.tax_rate_code_area)!='');
has_tax_amount                       := count(group,trim(fNonzero(assr_hist_dist.tax_amount))!='');
has_tax_year                         := count(group,trim(fNonzero(assr_hist_dist.tax_year))!='');
has_tax_delinquent_year              := count(group,trim(fNonzero(assr_hist_dist.tax_delinquent_year))!='');
has_year_built                       := count(group,trim(fNonzero(assr_hist_dist.year_built))!='');
has_no_of_buildings                  := count(group,trim(fNonzero(assr_hist_dist.no_of_buildings))!='');
has_no_of_stories                    := count(group,trim(fNonzero(assr_hist_dist.no_of_stories))!='');
has_style_code                       := count(group,trim(assr_hist_dist.style_code)!='');
has_no_of_units                      := count(group,trim(fNonzero(assr_hist_dist.no_of_units))!='');
has_air_conditioning_code            := count(group,trim(assr_hist_dist.air_conditioning_code)!='');
has_no_of_bedrooms                   := count(group,trim(fNonzero(assr_hist_dist.no_of_bedrooms))!='');
has_heating_code                     := count(group,trim(assr_hist_dist.heating_code)!='');
has_no_of_baths                      := count(group,trim(fNonzero(assr_hist_dist.no_of_baths))!='');
has_type_construction_code           := count(group,trim(assr_hist_dist.type_construction_code)!='');
has_no_of_partial_baths              := count(group,trim(fNonzero(assr_hist_dist.no_of_partial_baths))!='');
has_basement_code                    := count(group,trim(assr_hist_dist.basement_code)!='');
has_no_of_rooms                      := count(group,trim(fNonzero(assr_hist_dist.no_of_rooms))!='');
has_exterior_walls_code              := count(group,trim(assr_hist_dist.exterior_walls_code)!='');
has_fireplace_indicator              := count(group,trim(assr_hist_dist.fireplace_indicator)!='');
has_fireplace_number                 := count(group,trim(assr_hist_dist.fireplace_number)!='');
has_foundation_code                  := count(group,trim(assr_hist_dist.foundation_code)!='');
has_garage_type_code                 := count(group,trim(assr_hist_dist.garage_type_code)!='');
has_roof_cover_code                  := count(group,trim(assr_hist_dist.roof_cover_code)!='');
has_parking_no_of_cars               := count(group,trim(fNonzero(assr_hist_dist.parking_no_of_cars))!='');
has_elevator                         := count(group,trim(assr_hist_dist.elevator)!='');
has_pool_code                        := count(group,trim(assr_hist_dist.pool_code)!='');
has_land_acres                       := count(group,trim(fNonzero(assr_hist_dist.land_acres))!='');
has_land_square_footage              := count(group,trim(fNonzero(assr_hist_dist.land_square_footage))!='');
has_land_dimensions                  := count(group,trim(fNonzero(assr_hist_dist.land_dimensions))!='');
has_building_area                    := count(group,trim(fNonzero(assr_hist_dist.building_area))!='');
has_building_class_code              := count(group,trim(assr_hist_dist.building_class_code)!='');
has_comments                         := count(group,trim(assr_hist_dist.comments)!='');

end;

results := sort(table(assr_hist_dist,assr_counts_rec,state_code,county_name,few),state_code,county_name);
output(results,all);
