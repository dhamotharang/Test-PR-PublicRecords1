IMPORT $, dx_common, AID, BIPV2, Header;

EXPORT Layouts := MODULE

//Layout for LinkID key
  EXPORT BIP_layout := RECORD
    STRING70 foreclosure_id;
    STRING20 name_first;
    STRING20 name_middle;
    STRING20 name_last;
    STRING5 name_suffix;
    UNSIGNED6 did := 0;
    UNSIGNED1 did_score := 0;
    UNSIGNED6 bdid := 0;
    UNSIGNED1 bdid_score := 0;
    STRING9 ssn := '';
    STRING60 name_Company;
    STRING10 site_prim_range;
    STRING2 site_predir;
    STRING28 site_prim_name;
    STRING4 site_addr_suffix;
    STRING2 site_postdir;
    STRING10 site_unit_desig;
    STRING8 site_sec_range;
    STRING25 site_p_city_name;
    STRING25 site_v_city_name;
    STRING2 site_st;
    STRING5 site_zip;
    STRING4 site_zip4;
    UNSIGNED zero :=0;
    STRING1 blank :='';
    BIPV2.IDlayouts.l_xlink_ids; //Added for BIP PROJECT
    UNSIGNED8 source_rec_id :=0; //Added for BIP PROJECT
    STRING2 source;
  END;
  
  //Keys
  EXPORT i_address := RECORD
    STRING70 foreclosure_id;
    STRING2 state;
    STRING3 county;
    STRING18 batch_date_and_seq_nbr;
    STRING3 deed_category;
    STRING55 deed_desc;
    STRING3 document_type;
    STRING55 document_desc;
    STRING8 recording_date;
    STRING4 document_year;
    STRING12 document_nbr;
    STRING6 document_book;
    STRING6 document_pages;
    STRING5 title_company_code;
    STRING60 title_company_name;
    STRING60 attorney_name;
    STRING10 attorney_phone_nbr;
    STRING30 first_defendant_borrower_owner_first_name;
    STRING30 first_defendant_borrower_owner_last_name;
    STRING30 first_defendant_borrower_company_name;
    STRING30 second_defendant_borrower_owner_first_name;
    STRING30 second_defendant_borrower_owner_last_name;
    STRING30 second_defendant_borrower_company_name;
    STRING30 third_defendant_borrower_owner_first_name;
    STRING30 third_defendant_borrower_owner_last_name;
    STRING30 third_defendant_borrower_company_name;
    STRING30 fourth_defendant_borrower_owner_first_name;
    STRING30 fourth_defendant_borrower_owner_last_name;
    STRING30 fourth_defendant_borrower_company_name;
    STRING1 defendant_borrower_owner_et_al_indicator;
    STRING10 et_al_desc;
    STRING10 date_of_default;
    STRING11 amount_of_default;
    STRING10 filing_date;
    STRING20 court_case_nbr;
    STRING1 lis_pendens_type;
    STRING30 plaintiff_1;
    STRING30 plaintiff_2;
    STRING11 final_judgment_amount;
    STRING10 auction_date;
    STRING10 auction_time;
    STRING30 street_address_of_auction_call;
    STRING25 city_of_auction_call;
    STRING2 state_of_auction_call;
    STRING11 opening_bid;
    STRING4 tax_year;
    STRING11 sales_price;
    STRING1 situs_address_indicator_1;
    STRING5 situs_house_number_prefix_1;
    STRING10 situs_house_number_1;
    STRING10 situs_house_number_suffix_1;
    STRING30 situs_street_name_1;
    STRING5 situs_mode_1;
    STRING2 situs_direction_1;
    STRING2 situs_quadrant_1;
    STRING6 apartment_unit;
    STRING40 property_city_1;
    STRING2 property_state_1;
    STRING9 property_address_zip_code_1;
    STRING4 carrier_code;
    STRING60 full_site_address_unparsed_1;
    STRING30 lender_beneficiary_first_name;
    STRING30 lender_beneficiary_last_name;
    STRING30 lender_beneficiary_company_name;
    STRING60 lender_beneficiary_mailing_address;
    STRING40 lender_beneficiary_city;
    STRING2 lender_beneficiary_state;
    STRING9 lender_beneficiary_zip;
    STRING10 lender_phone;
    STRING30 trustee_name;
    STRING60 trustee_mailing_address;
    STRING40 trustee_city;
    STRING2 trustee_state;
    STRING9 trustee_zip;
    STRING10 trustee_phone;
    STRING20 trustee_sale_number;
    STRING8 original_loan_date;
    STRING8 original_loan_recording_date;
    STRING11 original_loan_amount;
    STRING12 original_document_number;
    STRING6 original_recording_book;
    STRING6 original_recording_page;
    STRING45 parcel_number_parcel_id;
    STRING45 parcel_number_unmatched_id;
    STRING8 last_full_sale_transfer_date;
    STRING11 transfer_value;
    STRING1 situs_address_indicator_2;
    STRING5 situs_house_number_prefix_2;
    STRING10 situs_house_number_2;
    STRING10 situs_house_number_suffix_2;
    STRING30 situs_street_name_2;
    STRING5 situs_mode_2;
    STRING2 situs_direction_2;
    STRING2 situs_quadrant_2;
    STRING6 apartment_unit_2;
    STRING40 property_city_2;
    STRING2 property_state_2;
    STRING9 property_address_zip_code_2;
    STRING4 carrier_code_2;
    STRING60 full_site_address_unparsed_2;
    STRING3 property_indicator;
    STRING55 property_desc;
    STRING4 use_code;
    STRING55 use_desc;
    STRING5 number_of_units;
    STRING9 living_area_square_feet;
    STRING5 number_of_bedrooms;
    STRING5 number_of_bathrooms;
    STRING3 number_of_garages;
    STRING10 zoning_code;
    STRING9 lot_size;
    STRING4 year_built;
    STRING11 current_land_value;
    STRING11 current_improvement_value;
    STRING3 section;
    STRING3 township;
    STRING3 foreclosure_range;
    STRING5 lot_orig;
    STRING5 block;
    STRING30 tract_subdivision_name;
    STRING6 map_book;
    STRING6 map_page;
    STRING5 unit_nbr;
    STRING250 expanded_legal;
    STRING250 legal_2;
    STRING250 legal_3;
    STRING50 legal_4;
    STRING5 name1_prefix;
    STRING20 name1_first;
    STRING20 name1_middle;
    STRING20 name1_last;
    STRING5 name1_suffix;
    STRING3 name1_score;
    STRING60 name1_company;
    STRING5 name2_prefix;
    STRING20 name2_first;
    STRING20 name2_middle;
    STRING20 name2_last;
    STRING5 name2_suffix;
    STRING3 name2_score;
    STRING60 name2_company;
    STRING10 situs1_prim_range;
    STRING2 situs1_predir;
    STRING28 situs1_prim_name;
    STRING4 situs1_addr_suffix;
    STRING2 situs1_postdir;
    STRING10 situs1_unit_desig;
    STRING8 situs1_sec_range;
    STRING25 situs1_p_city_name;
    STRING25 situs1_v_city_name;
    STRING2 situs1_st;
    STRING5 situs1_zip;
    STRING4 situs1_zip4;
    STRING4 situs1_cart;
    STRING1 situs1_cr_sort_sz;
    STRING4 situs1_lot;
    STRING1 situs1_lot_order;
    STRING2 situs1_dpbc;
    STRING1 situs1_chk_digit;
    STRING2 situs1_record_type;
    STRING2 situs1_ace_fips_st;
    STRING3 situs1_fipscounty;
    STRING10 situs1_geo_lat;
    STRING11 situs1_geo_long;
    STRING4 situs1_msa;
    STRING7 situs1_geo_blk;
    STRING1 situs1_geo_match;
    STRING4 situs1_err_stat;
    STRING8 process_date;
    STRING1 lender_type;
    STRING55 lender_type_desc;
    STRING10 loan_amount;
    STRING1 loan_type;
    STRING60 loan_type_desc;
    STRING2 source; //FR = CL, 'B7' = BK_NOD, 'I5' = BK_REO
    dx_common.layout_metadata; //Includes the CCPA fields so removed them from original base layout definition
  END;
  
  EXPORT i_bdid := RECORD
    UNSIGNED6 bdid;
    STRING70 fid;
  END;
  
  EXPORT i_did := RECORD
    UNSIGNED6 did;
    STRING70 fid;
  END;
  
  EXPORT i_LinkIDs := RECORD
    BIPV2.IDlayouts.l_key_ids;
    BIP_layout - BIPV2.IDlayouts.l_xlink_ids;
  END;
  
  EXPORT i_ParcelNum := RECORD
    STRING45 parcel_number_parcel_id;
    STRING70 fid;
  END;
  
  EXPORT i_FID := RECORD
    STRING70 fid;
    $.Layout_Fares_Foreclosure;
  END;
  
  EXPORT i_FID_Linkids := RECORD
    STRING70 fid;
    $.Layout_Fares_Foreclosure;
    BIPV2.IDlayouts.l_xlink_ids name1;
    BIPV2.IDlayouts.l_xlink_ids name2;
    BIPV2.IDlayouts.l_xlink_ids name3;
    BIPV2.IDlayouts.l_xlink_ids name4;
  END;
  
  //Delta RID key
  EXPORT i_Delta_Rid := RECORD
    dx_common.layout_ridkey;
  END;
  
  EXPORT i_Autokey := RECORD
    STRING70 foreclosure_id;
    STRING20 name_first;
    STRING20 name_middle;
    STRING20 name_last;
    STRING5 name_suffix;
    UNSIGNED6 did := 0;
    UNSIGNED1 did_score := 0;
    UNSIGNED6 bdid := 0;
    UNSIGNED1 bdid_score := 0;
    STRING9 ssn := '';
    STRING60 name_Company;
    STRING10 site_prim_range;
    STRING2 site_predir;
    STRING28 site_prim_name;
    STRING4 site_addr_suffix;
    STRING2 site_postdir;
    STRING10 site_unit_desig;
    STRING8 site_sec_range;
    STRING25 site_p_city_name;
    STRING25 site_v_city_name;
    STRING2 site_st;
    STRING5 site_zip;
    STRING4 site_zip4;
    STRING2 source;
    UNSIGNED1 zero :=0;
    STRING1 blank :='';
    dx_common.layout_metadata; //Added for delta PROJECT DF-28049
  END;

END;
