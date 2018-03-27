// Renamed this to CreateEmptyForeclosureKeys instead of the old bad name: CopyEmptyFiles 
// Moved from PRTE2 down to PRTE2_Foreclosure

// quick create 4 empty foreclosure keys:
EXPORT   CreateEmptyForeclosureKeys  (string filedate)   :=              FUNCTION

FN1 := '~prte::key::foreclosure::' + filedate + '::index_geo12';
FN2 := '~prte::key::foreclosure::' + filedate + '::index_geo11';
FN3 := '~prte::key::foreclosure::' + filedate + '::index_fips';
FN4 := '~prte::key::foreclosure::' + filedate + '::address';

r1 := RECORD
  string12 geo12;
  decimal5_2 geo12_index;
  unsigned5 geo12_prop_count;
  unsigned5 geo12_fc_count;
 END;
d1:=dataset([],r1);
i1:=index(d1,{geo12},{d1},FN1);
build1  := build(i1,update);

r2  := RECORD
  string11 geo11;
  decimal5_2 geo11_index;
  unsigned5 geo11_prop_count;
  unsigned5 geo11_fc_count;
 END;
d2:=dataset([],r2);
i2:=index(d2,{geo11},{d2},FN2);
build2  := build(i2,update);


r3  := RECORD
  string5 fips;
  decimal5_2 fips_index;
  unsigned5 fips_prop_count;
  unsigned5 fips_fc_count;
 END;
 
d3:=dataset([],r3);
i3:=index(d3,{fips},{d3},FN3);
build3  := build(i3,update);


r4  := RECORD
  string5 situs1_zip;
  string10 situs1_prim_range;
  string28 situs1_prim_name;
  string4 situs1_addr_suffix;
  string2 situs1_predir;
  string70 foreclosure_id;
  string2 state;
  string3 county;
  string18 batch_date_and_seq_nbr;
  string3 deed_category;
  string55 deed_desc;
  string3 document_type;
  string40 document_desc;
  string8 recording_date;
  string4 document_year;
  string12 document_nbr;
  string6 document_book;
  string6 document_pages;
  string5 title_company_code;
  string60 title_company_name;
  string60 attorney_name;
  string10 attorney_phone_nbr;
  string30 first_defendant_borrower_owner_first_name;
  string30 first_defendant_borrower_owner_last_name;
  string30 first_defendant_borrower_company_name;
  string30 second_defendant_borrower_owner_first_name;
  string30 second_defendant_borrower_owner_last_name;
  string30 second_defendant_borrower_company_name;
  string30 third_defendant_borrower_owner_first_name;
  string30 third_defendant_borrower_owner_last_name;
  string30 third_defendant_borrower_company_name;
  string30 fourth_defendant_borrower_owner_first_name;
  string30 fourth_defendant_borrower_owner_last_name;
  string30 fourth_defendant_borrower_company_name;
  string1 defendant_borrower_owner_et_al_indicator;
  string10 et_al_desc;
  string10 date_of_default;
  string11 amount_of_default;
  string10 filing_date;
  string20 court_case_nbr;
  string1 lis_pendens_type;
  string30 plaintiff_1;
  string30 plaintiff_2;
  string11 final_judgment_amount;
  string10 auction_date;
  string10 auction_time;
  string30 street_address_of_auction_call;
  string25 city_of_auction_call;
  string2 state_of_auction_call;
  string11 opening_bid;
  string4 tax_year;
  string11 sales_price;
  string1 situs_address_indicator_1;
  string5 situs_house_number_prefix_1;
  string10 situs_house_number_1;
  string10 situs_house_number_suffix_1;
  string30 situs_street_name_1;
  string5 situs_mode_1;
  string2 situs_direction_1;
  string2 situs_quadrant_1;
  string6 apartment_unit;
  string40 property_city_1;
  string2 property_state_1;
  string9 property_address_zip_code_1;
  string4 carrier_code;
  string60 full_site_address_unparsed_1;
  string30 lender_beneficiary_first_name;
  string30 lender_beneficiary_last_name;
  string30 lender_beneficiary_company_name;
  string60 lender_beneficiary_mailing_address;
  string40 lender_beneficiary_city;
  string2 lender_beneficiary_state;
  string9 lender_beneficiary_zip;
  string10 lender_phone;
  string30 trustee_name;
  string60 trustee_mailing_address;
  string40 trustee_city;
  string2 trustee_state;
  string9 trustee_zip;
  string10 trustee_phone;
  string20 trustee_sale_number;
  string8 original_loan_date;
  string8 original_loan_recording_date;
  string11 original_loan_amount;
  string12 original_document_number;
  string6 original_recording_book;
  string6 original_recording_page;
  string45 parcel_number_parcel_id;
  string45 parcel_number_unmatched_id;
  string8 last_full_sale_transfer_date;
  string11 transfer_value;
  string1 situs_address_indicator_2;
  string5 situs_house_number_prefix_2;
  string10 situs_house_number_2;
  string10 situs_house_number_suffix_2;
  string30 situs_street_name_2;
  string5 situs_mode_2;
  string2 situs_direction_2;
  string2 situs_quadrant_2;
  string6 apartment_unit_2;
  string40 property_city_2;
  string2 property_state_2;
  string9 property_address_zip_code_2;
  string4 carrier_code_2;
  string60 full_site_address_unparsed_2;
  string2 property_indicator;
  string55 property_desc;
  string3 use_code;
  string55 use_desc;
  string5 number_of_units;
  string9 living_area_square_feet;
  string5 number_of_bedrooms;
  string5 number_of_bathrooms;
  string3 number_of_garages;
  string10 zoning_code;
  string9 lot_size;
  string4 year_built;
  string11 current_land_value;
  string11 current_improvement_value;
  string3 section;
  string3 township;
  string3 foreclosure_range;
  string5 lot_orig;
  string5 block;
  string30 tract_subdivision_name;
  string6 map_book;
  string6 map_page;
  string5 unit_nbr;
  string250 expanded_legal;
  string250 legal_2;
  string250 legal_3;
  string50 legal_4;
  string5 name1_prefix;
  string20 name1_first;
  string20 name1_middle;
  string20 name1_last;
  string5 name1_suffix;
  string3 name1_score;
  string60 name1_company;
  string5 name2_prefix;
  string20 name2_first;
  string20 name2_middle;
  string20 name2_last;
  string5 name2_suffix;
  string3 name2_score;
  string60 name2_company;
  string2 situs1_postdir;
  string10 situs1_unit_desig;
  string8 situs1_sec_range;
  string25 situs1_p_city_name;
  string25 situs1_v_city_name;
  string2 situs1_st;
  string4 situs1_zip4;
  string4 situs1_cart;
  string1 situs1_cr_sort_sz;
  string4 situs1_lot;
  string1 situs1_lot_order;
  string2 situs1_dpbc;
  string1 situs1_chk_digit;
  string2 situs1_record_type;
  string2 situs1_ace_fips_st;
  string3 situs1_fipscounty;
  string10 situs1_geo_lat;
  string11 situs1_geo_long;
  string4 situs1_msa;
  string7 situs1_geo_blk;
  string1 situs1_geo_match;
  string4 situs1_err_stat;
  string8 process_date;
  unsigned8 __internal_fpos__;
END;
d4:=dataset([],r4);
i4:=index(d4,{situs1_zip,situs1_prim_range,situs1_prim_name,situs1_addr_suffix,situs1_predir},{d4},FN4);
build4  := build(i4,update);
CopyFiles   := SEQUENTIAL (
								build1,
								build2,
								build3,
								build4 
               );
RETURN CopyFiles;	
END;
