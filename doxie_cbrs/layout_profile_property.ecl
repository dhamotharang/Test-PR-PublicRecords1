EXPORT layout_profile_property := RECORD

  UNSIGNED6 bdid := 0;
  BOOLEAN byBDID; //because some recs may be by both
  BOOLEAN byAddress;

  STRING12 ln_fares_id;
  INTEGER3 address_seq_no := -1;
  BOOLEAN current := FALSE;
  STRING1 source_code;
  STRING8 compare_date := '';
  STRING1 refi_flag := '';
  STRING8 record_type := '';
  /*
  string45 uapn;
  string45 fapn;
  string12 book_page;*/
  
  //string10 Lot_Number := '';
  STRING60 Name_Owner_1 := '';
  STRING60 Name_Owner_2 := '';
  
  STRING70 property_full_street_address;
  STRING6 property_address_unit_number;
  STRING51 property_address_citystatezip;
  STRING18 property_county;
  /*
  string70 buyer_mailing_full_street_address;
  string6 buyer_mailing_address_unit_number;
  string51 buyer_mailing_address_citystatezip;
  string18 buyer_mailing_county;
  */
  STRING40 land_usage := '';
  //string40 Subdivision_Name := '';
  STRING11 Total_Value := '';
  STRING11 Land_Value := '';
  STRING11 Improvement_Value := '';
  STRING9 Land_Size := '';
  STRING7 building_size := '';
  STRING4 Year_Built := '';
  STRING11 Sale_Price := '';
  STRING250 Legal_Description := '';
  
  STRING8 sale_date := '';
  STRING60 Name_of_Seller := '';/*
  STRING11 Loan_Amount := '';
  STRING4 Loan_Term_Code := '';
  STRING5 Loan_Term := '';
  STRING8 Loan_Due_Date := '';
  STRING35 Loan_Type := '';
  STRING6 Loan_Deed_Type := '';
  STRING6 Loan_Deed_Sub_Type := '';
  
  STRING60 Lender_Name := '';
  
  //more fields both
  STRING9 building_square_feet := '';
  STRING8 recording_date := '';
  STRING60 title_company_name := '';
  STRING12 document_number := '';
  
  //dees only
  STRING40 document_type := '';
  STRING40 transaction_type := '';
  
  
     //asses only
  STRING4 tax_year := '';
  STRING11 tax_amount := '';
  STRING11 mkt_total_val := '';
  STRING11 mkt_land_val := '';
  STRING11 mkt_improvement_val := '';
  STRING7 living_square_feet := '';
  STRING3 stories_number := '';
  STRING3 foundation := '';
  STRING5 bedrooms := '';
  STRING5 full_baths := '';
  STRING5 half_baths := '';
  STRING11 assd_total_val := '';
    
  DATASET(doxie_ln.layout_addl_buyer) other_buyers;
  DATASET(doxie_ln.layout_addl_seller) other_sellers;*/
END;
