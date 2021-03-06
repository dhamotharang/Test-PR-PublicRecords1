export Layout_AVM_Deed := record
string12 avm_property_id;
string12 ln_fares_id;
string8  process_date;
string45 unformatted_apn;
string12 GEOLINK;
string18 fips_county_name;
// base deed record data
string18   county_name;
string45   apnt_or_pin_number;
string70   property_full_street_address;
string6    property_address_unit_number;
string51   property_address_citystatezip;
string1    property_address_code;
string2    legal_lot_code;
string10   legal_lot_number;
string7    legal_block;
string7    legal_section;
string7    legal_district;
string7    legal_land_lot;
string6    legal_unit;
string30   legal_city_municipality_township;
string50   legal_subdivision_name;
string7    legal_phase_number;
string10   legal_tract_number;
string30   legal_sec_twn_rng_mer;
string100  legal_brief_description; 
string8    recording_date;
string20   document_number;
string3    document_type_code;
string10   recorder_book_number;
string10   recorder_page_number;
string11   sales_price;
string1    sales_price_code;
string7    city_transfer_tax;
string7    county_transfer_tax;
string7    total_transfer_tax;
string11    first_td_loan_amount;
string11   second_td_loan_amount;
string1     first_td_lender_type_code;
string5    second_td_lender_type_code; 
string5    first_td_loan_type_code;
string4    type_financing;
string4    first_td_interest_rate;
string8    first_td_due_date;
string60   title_company_name;
string3    partial_interest_transferred;
string5    loan_term_months;
string5    loan_term_years;
string40   lender_name;
string6    lender_name_id;
string4    assessment_match_land_use_code;
string3    property_use_code;
string1    condo_code;
string1    timeshare_flag;
string10   land_lot_size;
string1    rate_change_frequency;
string4    change_index;
string15   adjustable_rate_index;
string1    adjustable_rate_rider;
string1    graduated_payment_rider;
string1    balloon_rider;
string1    fixed_step_rate_rider;
string1    condominium_rider;
string1    planned_unit_development_rider;
string1    rate_improvement_rider;
string1    assumability_rider;
string1    prepayment_rider;
string1    one_four_family_rider;
string1    biweekly_payment_rider;
string1    second_home_rider;
string1    township;
string1    land_use_code;
// clean address fields
string10  prim_range;
string2   predir;
string28  prim_name;
string4   suffix;
string2   postdir;
string8   sec_range;
string25  p_city_name;
string25  v_city_name;
string2   st;
string5   zip;
string4   zip4;
string5   county;
string10  geo_lat;
string11  geo_long;
string4   msa;
string7   geo_blk;
end;