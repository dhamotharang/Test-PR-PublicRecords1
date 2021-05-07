EXPORT layouts := MODULE

  EXPORT Party := RECORD
    STRING60 official_record_key;
    STRING2 state_origin;
    STRING30 county_name;
    STRING8 doc_filed_dt;
    STRING60 doc_type_desc;
    STRING50 entity_type_desc;
    STRING80 entity_nm;
    STRING5 title1;
    STRING20 fname1;
    STRING20 mname1;
    STRING20 lname1;
    STRING5 suffix1;
    STRING70 cname1;
    STRING1 master_party_type_cd;
  END;
  
  EXPORT Document := RECORD
    STRING60 official_record_key;
    STRING2 state_origin;
    STRING30 county_name;
    STRING25 doc_instrument_or_clerk_filing_num;
    STRING8 doc_filed_dt;
    STRING60 doc_type_desc;
    STRING60 legal_desc_1;
    STRING6 doc_page_count;
    STRING30 doc_amend_desc;
    STRING8 execution_dt;
    STRING25 consideration_amt;
    STRING10 transfer_;
    STRING10 mortgage;
    STRING10 intangible_tax_amt;
    STRING10 book_num;
    STRING10 page_num;
    STRING60 book_type_desc;
    STRING25 prior_doc_file_num;
    STRING60 prior_doc_type_desc;
    STRING10 prior_book_num;
    STRING10 prior_page_num;
    STRING60 prior_book_type_desc;
  END;
  
  // An interim record layout with just the fields needed to build the autokeys
  EXPORT ak_rec := RECORD
    STRING60 official_record_key;
    STRING20 fname;
    STRING20 mname;
    STRING20 lname;
    STRING70 cname;
    STRING25 city;
    STRING2 per_state;
    STRING2 bus_state;
    UNSIGNED1 zero := 0;
    UNSIGNED6 zeroDID := 0;
    UNSIGNED6 zeroBDID := 0;
    STRING1 blank := '';
    STRING1 blank_prim_name := '';
    STRING1 blank_prim_range := '';
    STRING1 blank_st := '';
    STRING1 blank_city := '';
    STRING1 blank_zip5 := '';
    STRING1 blank_sec_range := '';
  END;

END;
