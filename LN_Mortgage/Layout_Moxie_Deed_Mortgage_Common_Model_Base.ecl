export Layout_Moxie_Deed_Mortgage_Common_Model_Base := 

RECORD

string14   ln_fares_id;
string8    process_date;
string5    vendor_source_flag;
string1    from_file;
string5    fips_code;
string2    state;
string18   county_name;
string1    record_type;

//string100  visf_apn;
string45   apnt_or_pin_number;
string4    multi_apn_flag; //Expanded from 1 to 4 to accomodate Fares (multi_apn_count) length.
string39   tax_id_number;
string10   excise_tax_number;

//string1500 visf_buyer1;
//string500  visf_buyer2;
//Created 1 name field to include both first/last or corporation name - less parsing.
string80   buyer1;
//string40   buyer1_first_middle_name;
//string40   buyer1_last_or_corp_name;
string2    buyer1_id_code;
string80   buyer2;
//string40   buyer2_first_middle_name;
//string40   buyer2_last_or_corp_name;
string2    buyer2_id_code;
string2    buyer_vesting_code;
string1    buyer_addendum_flag;
string10   phone_number;

string150  visf_buyer_address;
string40   buyer_mailing_address_care_of_name;
string70   buyer_mailing_full_street_address;
string6    buyer_mailing_address_unit_number;
string51   buyer_mailing_address_citystatezip;
//string40   buyer_mailing_address_city;
//string2    buyer_mailing_address_state;
//string9    buyer_mailing_address_zip;
//string5    buyer_mailing_address_zip_code;
//string4    buyer_mailing_address_zip_4;

string80   borrower1;
//string40   borrower1_first_middle_name;
//string40   borrower1_last_or_corp_name;
string2    borrower1_id_code;
string80   borrower2;
//string40   borrower2_first_middle_name;
//string40   borrower2_last_or_corp_name;
string2    borrower2_id_code;
string2    borrower_vesting_code;

string70   borrower_mailing_full_street_address;
string6    borrower_mailing_unit_number;
string51   borrower_mailing_citystatezip;
//string40   borrower_mailing_city_name;
//string2    borrower_mailing_state_code;
//string9    borrower_mailing_zip;
//string5    borrower_mailing_zip_code;
//string4    borrower_mailing_zip_4;
string1    borrower_address_code;

//string1500 visf_seller1;
//string500  visf_seller2;
string80   seller1;
//string40   seller1_first_middle_name;
//string40   seller1_last_or_corp_name;
string2    seller1_id_code;
string80   seller2;
//string40   seller2_first_middle_name;
//string40   seller2_last_or_corp_name;
string2    seller2_id_code;
string1    seller_addendum_flag;

string150  visf_seller_address;
string70   seller_mailing_full_street_address;
string6    seller_mailing_address_unit_number;
string51   seller_mailing_address_citystatezip;
//string40   seller_mailing_address_city;
//string2    seller_mailing_address_state;
//string9    seller_mailing_address_zip;
//string5    seller_mailing_address_zip_code;
//string4    seller_mailing_address_zip_4;

string150  visf_property_address;
string70   property_full_street_address;
string6    property_address_unit_number;
string51   property_address_citystatezip;
//string40   property_address_city;
//string2    property_address_state;
//string9    property_address_zip;
//string5    property_address_zip_code;
//string4    property_address_zip_4;
string1    property_address_code;
string10   hawaii_property_address_unit_number;

//string500  visf_brief_legal;
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
string20   recorder_map_reference;
string1    complete_legal_description_code;

string8    contract_date;
string8    recording_date;
string20   document_number;
string3    document_type_code;
string20   loan_number;
//string21   visf_book_page;
string10   recorder_book_number;
string10   recorder_page_number;
string19   concurrent_mortgage_book_page_document_number;
//string150  visf_sale_price;
string11   sales_price;
string1    sales_price_code;
//string200  visf_tax;
string7    city_transfer_tax;
string7    county_transfer_tax;
string7    total_transfer_tax;
//string100  visf_loan_amount;
string11    first_td_loan_amount;        //Expanded from 9 to 11 to accomodates Fares (mortgage_amount) length.
string11   second_td_loan_amount;        //Expanded from 9 to 11 to accomodate Fares (2nd_mortgage_amount) length.
string1     first_td_lender_type_code;
string5    second_td_lender_type_code;   //Expanded from 1 to 5 to accomodate Fares (2nd_mortgage_loan_type_code) length.
//string100  visf_mortgage_type;
string5    first_td_loan_type_code;      //Expanded from 1 to 5 to accomodate Fares (mortgage_loan_type_code) length.
string4    type_financing;
string4    first_td_interest_rate;
string8    first_td_due_date;
string60   title_company_name;           //Expanded from 50 to 60 to accomodate Fares (title_company_name) length.
string3    partial_interest_transferred; //Expanded from 2 to 3 to accomodate Fares (partial_transfer_percentage) length.
string5    loan_term_months;             //Expanded from 3 to 5 to accomodate Fares (mortgage_term) length.
string5    loan_term_years;              //Expanded from 3 to 5 to accomodate Fares (mortgage_term) length.

string40   lender_name;                  //Expanded from 40 to 60 to accomodate Fares (lender_last_name & lender_first_name) fields.
string6    lender_name_id;
string40   lender_dba_aka_name;

string60   lender_full_street_address;
string6    lender_address_unit_number;
string41   lender_address_citystatezip;
//string30   lender_address_city;
//string2    lender_address_state;
//string9    lender_address_zip;
//string5    lender_address_zip_code;
//string4    lender_address_zip_4;

//string100  visf_land_use;
string4    assessment_match_land_use_code;
string3    property_use_code;
string1    condo_code;
string1    timeshare_flag;
string10   land_lot_size;

string51   hawaii_legal;
string6    hawaii_tct;
string4    hawaii_condo_cpr_code;
string30   hawaii_condo_name;
string1    filler_except_hawaii;

//string100  visf_rider;
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

string3    data_source_code;
//string8    data_entry_date;
//string4    data_entry_operator_code;
//string1    main_record_id_code;
//string1    assessment_record_match_flag;
//string10   date_last_trans;
//string20   accession_number;
//string50   legend;
//string100  copyright;
//string50   publication;
//string50   adf;
//string50   vdi;
//string6    file_name;
//string1    text;
//string1    prior_info;
//string500  msa;
//string15   cite_id;

string1    dummy_seg;
string1    lexis_number;
string1    page_number;
string1    township;
string1    land_use_code;
string1    audit_trail;
string1    audit1;
string1    audit2;
string1    audit3;
string1    file_code;
string1    fs_profile;
string1    on_lexis;
string1    report_number;
string12   source;
string12   content;
string21   lxdseg;

string1    OKCTY_DEED_filler;
string12   OKCTY_DEED_reserved;
string29   OKCTY_DEED_reserved2;
string71   OKCTY_MORT_filler;
string68   OKCTY_MORT_filler2;

//string12   fares_id;
//string3    fares_fips_sub_code;
//string6    fares_municipality_code;
//string45   fares_original_apn;
string45   fares_unformatted_apn;
//string3    fares_apn_sequence_number;
string1    fares_corporate_indicator;
//string1    fares_etal_indicator;
//string3    fares_owner_relationship_rights_code;
//string2    fares_owner_relationship_type;
//string4    fares_owner_mailing_address_carrier_code;
//string4    fares_owner_mailing_address_match_code;
//string4    fares_property_address_carrier_code;
//string12   fares_transaction_batch_id;
//string5    fares_transaction_batch_sequence;
//string4    fares_document_year;
//fares_seller_name should be removed b/c it is mapped to seller1.
//string60   fares_seller_name;
string3    fares_transaction_type;
string60   fares_lender_address;
//string10   fares_mortgage_company_code;
//string3    fares_sales_transaction_code;
//string1    fares_multi_apn;
//string5    fares_title_company_code;
//string1    fares_residential_model_indicator;
string8    fares_mortgage_date;
//LAN document_type_code appears to be equivalent of 2 Fares fields (document_type & mortgage_deed_type)
string6    fares_mortgage_deed_type;
string4    fares_mortgage_term_code;
string5    fares_mortgage_term;
//string11   fares_mortgage_assumption_amount;
//string5    fares_second_mortgage_loan_type_code;
//string6    fares_2nd_deed_type;
//string4    fares_prior_doc_year;
//string12   fares_prior_doc_number;
//string12   fares_prior_book_page;
//string1    fares_prior_sales_deed_category_code;
//string8    fares_prior_recording_date;
//string8    fares_prior_sales_date;
//string11   fares_prior_sales_price;
//string1    fares_prior_sales_code;
//string3    fares_prior_sales_transaction_code;
//string1    fares_prior_multi_apn_flag;
//string4    fares_prior_multi_apn_count;
//string11   fares_prior_mortgage_amount;
//string1    fares_prior_deed_type;
//string1    fares_absentee_indicator;
string9    fares_building_square_feet;
//string1    fares_partial_interest_indicator;
//string2    fares_pri_cat_code;
//string1    fares_seller_carry_back;
//string1    fares_private_party_lender;
//string1    fares_construction_loan;
//string1    fares_resale_new_construction;
//string1    fares_inter_family;
//string1    fares_cash_mortgage_purchase;
string1    fares_foreclosure;
string1    fares_refi_flag;
string1    fares_equity_flag;
//string6    fares_census_tract;
//string1    fares_census_block_group;
//string2    fares_census_block;
//string1    fares_census_block_suffix;
//string8    fares_latitude;
//string9    fares_longitude;
string60   fares_iris_apn;

string1    addl_name_flag;

END;


















