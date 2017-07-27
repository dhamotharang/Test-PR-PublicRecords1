export layout_fcra_assessment := record
	string12  ln_fares_id;
	string1   vendor_source_flag; // new for riskview property report
  string30	county_name;  // new for riskview property report
  string45	apna_or_pin_number;  // existing
  string80	assessee_name;  // existing
  string60	second_assessee_name; // new
  string1	assessee_name_type_code; // new
  string1	second_assessee_name_type_code; // new
  string1	mail_care_of_name_type_code;  // new
  string60	mailing_care_of_name; // new
  string80	mailing_full_street_address; // existing
  string6	mailing_unit_number;  // existing
  string51	mailing_city_state_zip;  // existing
  string60	property_full_street_address;  // existing
  string6	property_unit_number;  // existing
  string51  property_city_state_zip; // existing
  string30	legal_city_municipality_township;  // new for riskview property report
  string40	legal_subdivision_name; // new for riskview property report
  string130	legal_brief_description; // new for riskview property report
  string4	standardized_land_use_code; // new for riskview property report
  string1	owner_occupied; // new for riskview property report
  string20	recorder_document_number; // new, for use in FCRA Comp Report
  string10  recorder_book_number;  // new, for use in FCRA Comp Report
  string10  recorder_page_number;  // new, for use in FCRA Comp Report
  string8	recording_date;  // existing
  string8	sale_date;  // existing
  string11	sales_price;  // existing
  string11	mortgage_loan_amount;  // existing
  string60	mortgage_lender_name;  // new, for use in FCRA Comp Report
  string11	assessed_land_value; // new for riskview property report
  string11	assessed_improvement_value; // new for riskview property report
  string11	assessed_total_value;  // existing
  string4	assessed_value_year;  // existing
  string11	market_land_value; // new for riskview property report
  string11	market_improvement_value; // new for riskview property report
  string11	market_total_value;  // existing
  string4	market_value_year; // new for riskview property report
  string1	homestead_homeowner_exemption;  // new, for use in FCRA Comp Report
  string1	tax_exemption1_code; // new possible future use
  string18	tax_rate_code_area; // new possible future use
  string13	tax_amount; // new for riskview property report
  string4	tax_year; // new for riskview property report
  string30	land_acres; // new for riskview property report
  string30	land_square_footage; // new for riskview property report
  string30  land_dimensions; // new for riskview property report
  string9	building_area; // new for riskview property report
  string1	building_area_indicator; // new for riskview property report
  string4	year_built;  // existing
  string3	no_of_buildings; // new for riskview property report
  string5	no_of_stories; // new for riskview property report
  string5	no_of_units; // new for riskview property report
  string5	no_of_rooms; // new for riskview property report
  string5	no_of_bedrooms; // new for riskview property report
  string8	no_of_baths; // new for riskview property report
  string2	no_of_partial_baths; // new for riskview property report
  string3	garage_type_code; // new for riskview property report
  string5	parking_no_of_cars; // new for riskview property report
  string3	pool_code; // new for riskview property report
  string5	style_code; // new for riskview property report
  string3	type_construction_code; // new for riskview property report
  string3	exterior_walls_code; // new for riskview property report
  string3	foundation_code; // new for riskview property report
  string3	roof_cover_code; // new for riskview property report
  string5	roof_type_code; // new for riskview property report
  string3	heating_code; // new for riskview property report
  string3	heating_fuel_type_code; // new for riskview property report
  string3	air_conditioning_code; // new for riskview property report
  string1	air_conditioning_type_code; // new for riskview property report
  string1	elevator;  // new, possible future use
  string1	fireplace_indicator; // new for riskview property report
  string3	fireplace_number;  // new, for use in FCRA Comp Report
  string3	basement_code; // new for riskview property report
  string1	building_class_code; // new possible future use
end;