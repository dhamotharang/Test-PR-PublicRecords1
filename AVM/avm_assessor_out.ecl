import ln_property;

// Assessor year select
assessor_year_list := ['2000','2001','2002','2003','2004','2005','2006'];

ln_property_valid_state := [
'AK','AL','AR','AS','AZ','CA','CO','CT','DC','DE',
'FL','FM','GA','GU','HI','IA','ID','IL','IN','KS',
'KY','LA','MA','MD','ME','MH','MI','MN','MO','MP',
'MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY',
'OH','OK','ON','OR','PA','PR','PW','RI','SC','SD',
'TN','TX','UM','UT','VA','VI','VT','WA','WI','WV',
'WY'];

assessor_base := ln_property.File_Assessment;
//assessor_base := dataset('~thor_data400::base::ln_property::20060804::assessor', LN_Property.Layout_Property_Common_Model_BASE, flat);
assessor_file := assessor_base(state_code in ln_property_valid_state,
                               vendor_source_flag in ['DAYTN','OKCTY'],
						 assessed_value_year in assessor_year_list,
						 new_record_type_code <> 'PP');

// avm search file
avm_search_base := avm_search;
//avm_search_base := dataset('~thor_dell400_2::temp::avm_search', Layout_AVM_Search, flat);
sfa := avm_search_base(ln_fares_id[1] in ['D','O'], ln_fares_id[2] = 'A');

// Filter out bad characters from fields
valid_chars := ' !"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_\'abcdefghijklmnopqrstuvwxyz{|}~';

// Format output assessor records
Layout_AVM_Assessor FormatAssessorOut(assessor_file l, sfa r) := transform
self.avm_property_id := intformat(r.avm_property_id, 12, 1);
self.fips_county_name := Stringlib.StringFilter(r.county_name, valid_chars);
self.county_name := Stringlib.StringFilter(l.county_name, valid_chars);
self.apna_or_pin_number := Stringlib.StringFilter(l.apna_or_pin_number, valid_chars);
self.property_full_street_address := Stringlib.StringFilter(l.property_full_street_address, valid_chars);
self.property_unit_number := Stringlib.StringFilter(l.property_unit_number, valid_chars);
self.property_city_state_zip := Stringlib.StringFilter(l.property_city_state_zip, valid_chars);
self.property_country_code := Stringlib.StringFilter(l.property_country_code, valid_chars);
self.property_address_code := Stringlib.StringFilter(l.property_address_code, valid_chars);
self.legal_lot_code := Stringlib.StringFilter(l.legal_lot_code, valid_chars);
self.legal_lot_number := Stringlib.StringFilter(l.legal_lot_number, valid_chars);
self.legal_land_lot := Stringlib.StringFilter(l.legal_land_lot, valid_chars);
self.legal_block := Stringlib.StringFilter(l.legal_block, valid_chars);
self.legal_section := Stringlib.StringFilter(l.legal_section, valid_chars);
self.legal_district := Stringlib.StringFilter(l.legal_district, valid_chars);
self.legal_unit := Stringlib.StringFilter(l.legal_unit, valid_chars);
self.legal_city_municipality_township := Stringlib.StringFilter(l.legal_city_municipality_township, valid_chars);
self.legal_subdivision_name := Stringlib.StringFilter(l.legal_subdivision_name, valid_chars);
self.legal_phase_number := Stringlib.StringFilter(l.legal_phase_number, valid_chars);
self.legal_tract_number := Stringlib.StringFilter(l.legal_tract_number, valid_chars);
self.legal_sec_twn_rng_mer := Stringlib.StringFilter(l.legal_sec_twn_rng_mer, valid_chars);
self.legal_brief_description := Stringlib.StringFilter(l.legal_brief_description, valid_chars);
self.legal_assessor_map_ref := Stringlib.StringFilter(l.legal_assessor_map_ref, valid_chars);
self.census_tract := Stringlib.StringFilter(l.census_tract, valid_chars);
self.record_type_code := Stringlib.StringFilter(l.record_type_code, valid_chars);
self.ownership_type_code := Stringlib.StringFilter(l.ownership_type_code, valid_chars);
self.new_record_type_code := Stringlib.StringFilter(l.new_record_type_code, valid_chars);
self.county_land_use_code := Stringlib.StringFilter(l.county_land_use_code, valid_chars);
self.county_land_use_description := Stringlib.StringFilter(l.county_land_use_description, valid_chars);
self.standardized_land_use_code := Stringlib.StringFilter(l.standardized_land_use_code, valid_chars);
self.timeshare_code := Stringlib.StringFilter(l.timeshare_code, valid_chars);
self.zoning := Stringlib.StringFilter(l.zoning, valid_chars);
self.owner_occupied := Stringlib.StringFilter(l.owner_occupied, valid_chars);
self.recorder_document_number := Stringlib.StringFilter(l.recorder_document_number, valid_chars);
self.recorder_book_number := Stringlib.StringFilter(l.recorder_book_number, valid_chars);
self.recorder_page_number := Stringlib.StringFilter(l.recorder_page_number, valid_chars);
self.transfer_date := Stringlib.StringFilter(l.transfer_date, valid_chars);
self.recording_date := Stringlib.StringFilter(l.recording_date , valid_chars);
self.sale_date := Stringlib.StringFilter(l.sale_date, valid_chars);
self.document_type := Stringlib.StringFilter(l.document_type, valid_chars);
self.sales_price := Stringlib.StringFilter(l.sales_price, valid_chars);
self.sales_price_code := Stringlib.StringFilter(l.sales_price_code, valid_chars);
self.mortgage_loan_amount := Stringlib.StringFilter(l.mortgage_loan_amount, valid_chars);
self.mortgage_loan_type_code := Stringlib.StringFilter(l.mortgage_loan_type_code, valid_chars);
self.mortgage_lender_name := Stringlib.StringFilter(l.mortgage_lender_name, valid_chars);
self.mortgage_lender_type_code := Stringlib.StringFilter(l.mortgage_lender_type_code, valid_chars);
self.prior_transfer_date := Stringlib.StringFilter(l.prior_transfer_date, valid_chars);
self.prior_recording_date := Stringlib.StringFilter(l.prior_recording_date, valid_chars);
self.prior_sales_price := Stringlib.StringFilter(l.prior_sales_price, valid_chars);
self.prior_sales_price_code := Stringlib.StringFilter(l.prior_sales_price_code, valid_chars);
self.assessed_land_value := Stringlib.StringFilter(l.assessed_land_value, valid_chars);
self.assessed_improvement_value := Stringlib.StringFilter(l.assessed_improvement_value, valid_chars);
self.assessed_total_value := Stringlib.StringFilter(l.assessed_total_value, valid_chars);
self.assessed_value_year := Stringlib.StringFilter(l.assessed_value_year, valid_chars);
self.market_land_value := Stringlib.StringFilter(l.market_land_value, valid_chars);
self.market_improvement_value := Stringlib.StringFilter(l.market_improvement_value, valid_chars);
self.market_total_value := Stringlib.StringFilter(l.market_total_value, valid_chars);
self.market_value_year := Stringlib.StringFilter(l.market_value_year, valid_chars);
self.homestead_homeowner_exemption := Stringlib.StringFilter(l.homestead_homeowner_exemption, valid_chars);
self.tax_exemption1_code := Stringlib.StringFilter(l.tax_exemption1_code, valid_chars);
self.tax_exemption2_code := Stringlib.StringFilter(l.tax_exemption2_code, valid_chars);
self.tax_exemption3_code := Stringlib.StringFilter(l.tax_exemption3_code, valid_chars);
self.tax_exemption4_code := Stringlib.StringFilter(l.tax_exemption4_code, valid_chars);
self.tax_rate_code_area := Stringlib.StringFilter(l.tax_rate_code_area, valid_chars);
self.tax_amount := Stringlib.StringFilter(l.tax_amount, valid_chars);
self.tax_year := Stringlib.StringFilter(l.tax_year, valid_chars);
self.tax_delinquent_year := Stringlib.StringFilter(l.tax_delinquent_year, valid_chars);
self.year_built := Stringlib.StringFilter(l.year_built, valid_chars);
self.no_of_buildings := Stringlib.StringFilter(l.no_of_buildings, valid_chars);
self.no_of_stories := Stringlib.StringFilter(l.no_of_stories, valid_chars);
self.style_code := Stringlib.StringFilter(l.style_code, valid_chars);
self.no_of_units := Stringlib.StringFilter(l.no_of_units, valid_chars);
self.air_conditioning_code := Stringlib.StringFilter(l.air_conditioning_code, valid_chars);
self.no_of_bedrooms := Stringlib.StringFilter(l.air_conditioning_code, valid_chars);
self.heating_code := Stringlib.StringFilter(l.heating_code, valid_chars);
self.no_of_baths := Stringlib.StringFilter(l.no_of_baths, valid_chars);
self.type_construction_code := Stringlib.StringFilter(l.type_construction_code, valid_chars);
self.no_of_partial_baths := Stringlib.StringFilter(l.no_of_partial_baths, valid_chars);
self.basement_code := Stringlib.StringFilter(l.basement_code, valid_chars);
self.no_of_rooms := Stringlib.StringFilter(l.no_of_rooms, valid_chars);
self.exterior_walls_code := Stringlib.StringFilter(l.exterior_walls_code, valid_chars);
self.fireplace_indicator := Stringlib.StringFilter(l.fireplace_indicator, valid_chars);
self.fireplace_number := Stringlib.StringFilter(l.fireplace_number, valid_chars);
self.foundation_code := Stringlib.StringFilter(l.foundation_code, valid_chars);
self.garage_type_code := Stringlib.StringFilter(l.garage_type_code, valid_chars);
self.roof_cover_code := Stringlib.StringFilter(l.roof_cover_code, valid_chars);
self.parking_no_of_cars := Stringlib.StringFilter(l.parking_no_of_cars, valid_chars);
self.elevator := Stringlib.StringFilter(l.elevator, valid_chars);
self.pool_code := Stringlib.StringFilter(l.pool_code, valid_chars);
self.land_acres := Stringlib.StringFilter(l.land_acres, valid_chars);
self.land_square_footage := Stringlib.StringFilter(l.land_square_footage, valid_chars);
self.land_dimensions := Stringlib.StringFilter(l.land_dimensions, valid_chars);
self.building_area := Stringlib.StringFilter(l.building_area, valid_chars);
self.building_class_code := Stringlib.StringFilter(l.building_class_code, valid_chars);
self.comments := Stringlib.StringFilter(l.comments, valid_chars);
self.prim_name := Stringlib.StringFilter(r.prim_name, valid_chars);
self.prim_range := Stringlib.StringFilter(r.prim_range, valid_chars);
self.sec_range := Stringlib.StringFilter(r.sec_range, valid_chars);
self := l;
self := r;
end;

avm_assessor_init := join(assessor_file,
                          sfa,
					 left.ln_fares_id = right.ln_fares_id,
					 FormatAssessorOut(left, right),
					 hash);
					 
avm_assessor_sort := sort(avm_assessor_init, avm_property_id);
                          
export avm_assessor_out := avm_assessor_sort : persist('TEMP::avm_assessor_out');