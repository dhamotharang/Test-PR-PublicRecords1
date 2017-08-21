Import property;

// Query to create a crosstab with counts by county name from the
// Fares_Assessor property file

#workunit('name','Combined Property Deeds County Stats');

layout_Deed := RECORD
  string14 ln_fares_id;
  string8 process_date;
  string5 vendor_source_flag;
  string1 from_file;
  string5 fips_code;
  string2 state;
  string18 county_name;
  string1 record_type;
  string45 apnt_or_pin_number;
  string4 multi_apn_flag;
  string39 tax_id_number;
  string10 excise_tax_number;
  string80 buyer1;
  string2 buyer1_id_code;
  string80 buyer2;
  string2 buyer2_id_code;
  string2 buyer_vesting_code;
  string1 buyer_addendum_flag;
  string10 phone_number;
  string150 visf_buyer_address;
  string40 buyer_mailing_address_care_of_name;
  string70 buyer_mailing_full_street_address;
  string6 buyer_mailing_address_unit_number;
  string51 buyer_mailing_address_citystatezip;
  string80 borrower1;
  string2 borrower1_id_code;
  string80 borrower2;
  string2 borrower2_id_code;
  string2 borrower_vesting_code;
  string70 borrower_mailing_full_street_address;
  string6 borrower_mailing_unit_number;
  string51 borrower_mailing_citystatezip;
  string1 borrower_address_code;
  string80 seller1;
  string2 seller1_id_code;
  string80 seller2;
  string2 seller2_id_code;
  string1 seller_addendum_flag;
  string150 visf_seller_address;
  string70 seller_mailing_full_street_address;
  string6 seller_mailing_address_unit_number;
  string51 seller_mailing_address_citystatezip;
  string150 visf_property_address;
  string70 property_full_street_address;
  string6 property_address_unit_number;
  string51 property_address_citystatezip;
  string1 property_address_code;
  string10 hawaii_property_address_unit_number;
  string2 legal_lot_code;
  string10 legal_lot_number;
  string7 legal_block;
  string7 legal_section;
  string7 legal_district;
  string7 legal_land_lot;
  string6 legal_unit;
  string30 legal_city_municipality_township;
  string50 legal_subdivision_name;
  string7 legal_phase_number;
  string10 legal_tract_number;
  string30 legal_sec_twn_rng_mer;
  string100 legal_brief_description;
  string20 recorder_map_reference;
  string1 complete_legal_description_code;
  string8 contract_date;
  string8 recording_date;
  string20 document_number;
  string3 document_type_code;
  string20 loan_number;
  string10 recorder_book_number;
  string10 recorder_page_number;
  string19 concurrent_mortgage_book_page_document_number;
  string11 sales_price;
  string1 sales_price_code;
  string7 city_transfer_tax;
  string7 county_transfer_tax;
  string7 total_transfer_tax;
  string11 first_td_loan_amount;
  string11 second_td_loan_amount;
  string1 first_td_lender_type_code;
  string5 second_td_lender_type_code;
  string5 first_td_loan_type_code;
  string4 type_financing;
  string4 first_td_interest_rate;
  string8 first_td_due_date;
  string60 title_company_name;
  string3 partial_interest_transferred;
  string5 loan_term_months;
  string5 loan_term_years;
  string40 lender_name;
  string6 lender_name_id;
  string40 lender_dba_aka_name;
  string60 lender_full_street_address;
  string6 lender_address_unit_number;
  string41 lender_address_citystatezip;
  string4 assessment_match_land_use_code;
  string3 property_use_code;
  string1 condo_code;
  string1 timeshare_flag;
  string10 land_lot_size;
  string51 hawaii_legal;
  string6 hawaii_tct;
  string4 hawaii_condo_cpr_code;
  string30 hawaii_condo_name;
  string1 filler_except_hawaii;
  string1 rate_change_frequency;
  string4 change_index;
  string15 adjustable_rate_index;
  string1 adjustable_rate_rider;
  string1 graduated_payment_rider;
  string1 balloon_rider;
  string1 fixed_step_rate_rider;
  string1 condominium_rider;
  string1 planned_unit_development_rider;
  string1 rate_improvement_rider;
  string1 assumability_rider;
  string1 prepayment_rider;
  string1 one_four_family_rider;
  string1 biweekly_payment_rider;
  string1 second_home_rider;
  string3 data_source_code;
  string1 dummy_seg;
  string1 lexis_number;
  string1 page_number;
  string1 township;
  string1 land_use_code;
  string1 audit_trail;
  string1 audit1;
  string1 audit2;
  string1 audit3;
  string1 file_code;
  string1 fs_profile;
  string1 on_lexis;
  string1 report_number;
  string12 source;
  string12 content;
  string21 lxdseg;
  string1 okcty_deed_filler;
  string12 okcty_deed_reserved;
  string29 okcty_deed_reserved2;
  string71 okcty_mort_filler;
  string68 okcty_mort_filler2;
  string45 fares_unformatted_apn;
  string1 fares_corporate_indicator;
  string3 fares_transaction_type;
  string60 fares_lender_address;
  string8 fares_mortgage_date;
  string6 fares_mortgage_deed_type;
  string4 fares_mortgage_term_code;
  string5 fares_mortgage_term;
  string9 fares_building_square_feet;
  string1 fares_foreclosure;
  string1 fares_refi_flag;
  string1 fares_equity_flag;
  string60 fares_iris_apn;
  string1 addl_name_flag;
 END;


d := dataset('~thor_data400::out::ln_property::built::deed', Layout_Deed, thor);


// Project Deeds File  to Slim Records
Layout_Property_County_Codes := RECORD
	STRING2  state;
	STRING3  fips_county_code;
	STRING5  vendor_source_flag;
	
END;

Layout_Property_County_Codes GetCountyCodes(Layout_Deed L) := TRANSFORM
	SELF.state := Property.Map_FIPS_Code_to_State(L.fips_code[1..2]);
	SELF.fips_county_code := if(L.fips_code = '12025', '086',L.fips_code[3..5]);  // Last 3 characters are the FIPS county code
	SELF := L;
END;

Combined_Assessor_County_Codes := PROJECT(d, GetCountyCodes(LEFT));

// Crosstab to count occurrences of each unique county code
Layout_County_Code_Stat := RECORD
	Combined_Assessor_County_Codes.state;
	Combined_Assessor_County_Codes.fips_county_code;
	Combined_Assessor_County_Codes.vendor_source_flag;
	reccnt := COUNT(GROUP);
END;

County_Codes_Stat := TABLE(Combined_Assessor_County_Codes(stringlib.stringfilter(fips_county_code, '0123456789') = fips_county_code), Layout_County_Code_Stat, state, fips_county_code, vendor_source_flag, FEW);

Layout_County_Names := RECORD
	Layout_County_Code_Stat;
	STRING18 county_name;
END;

// Join to County Code Name file to get names
Layout_County_Names GetCountyNames(Layout_County_Code_Stat L, Property.Layout_County_Code_Names R) := TRANSFORM
	SELF.county_name := R.county_name;
	SELF := L;
END;

Query_Combined_Deeds_County_Stat := JOIN(County_Codes_Stat,
                                 Property.File_County_Code_Names,
                                 LEFT.state = RIGHT.state AND
                                   (INTEGER)LEFT.fips_county_code = (INTEGER)RIGHT.fips_county_code,
                                 GetCountyNames(LEFT, RIGHT));

OUTPUT(CHOOSEN(Query_Combined_Deeds_County_Stat(county_name<>'' AND state <>''),ALL));
