export layout_fcra_deed := record
 string12  ln_fares_id;  // existing
 string1   vendor_source_flag; // new for riskview property report
 string18  county_name;// new for riskview property report
 string45  apnt_or_pin_number;// existing
  //combine buyers and borrowers and set flag to indicate which type
 //a record can never have both
 string1   buyer_or_borrower_ind; // new - 'O' for buyer, 'B' for borrower
 string80  name1; // existing
 string80  name2; // existing
 string70  mailing_street; // existing
 string6   mailing_unit_number; // existing
 string51  mailing_csz; // existing
 string80  seller1;// existing
 string80  seller2;// existing
 string70  seller_mailing_full_street_address;// existing
 string6   seller_mailing_address_unit_number;// existing
 string51  seller_mailing_address_citystatezip;// existing
 string70  property_full_street_address;// existing
 string6   property_address_unit_number;// existing
 string51  property_address_citystatezip;// existing
 string30  legal_city_municipality_township;// new for riskview property report
 string50  legal_subdivision_name;// new for riskview property report
 string100 legal_brief_description; // new for riskview property report
 string8   contract_date;// existing
 string8   recording_date;// existing
 string10  recorder_book_number;  // new, for use in FCRA Comp Report
 string10  recorder_page_number;  // new, for use in FCRA Comp Report
 string11  sales_price;// existing
 string1   sales_price_code;  // new, possible future use
 string11  first_td_loan_amount;// existing        
 string4   assessment_match_land_use_code;// new for riskview property report
 string5   first_td_loan_type_code;
 string4   type_financing;
 string8   first_td_due_date;
end;