EXPORT layouts := MODULE
EXPORT Party := RECORD
	
	string60	official_record_key;
	string2		state_origin;
	string30	county_name;
	string8		doc_filed_dt;
	string60	doc_type_desc;
	string50	entity_type_desc;
  string80	entity_nm;
  string5		title1;
  string20	fname1;
  string20	mname1;
  string20	lname1;
  string5		suffix1;
  string70 	cname1;
  string1		master_party_type_cd;

  END;
	
	EXPORT Document := RECORD
	
	string60	official_record_key;
	string2		state_origin;
	string30	county_name;
  string25	doc_instrument_or_clerk_filing_num;
	string8		doc_filed_dt;
  string60	doc_type_desc;
	string60	legal_desc_1;
  string6		doc_page_count;
  string30	doc_amend_desc;
  string8		execution_dt;
	string25	consideration_amt;
  string10	transfer_;
  string10	mortgage;
  string10	intangible_tax_amt;
  string10	book_num;
  string10	page_num;
  string60	book_type_desc;
	string25	prior_doc_file_num;
  string60	prior_doc_type_desc;
  string10	prior_book_num;
  string10	prior_page_num;
  string60	prior_book_type_desc;

  END;
	
	// An interim record layout with just the fields needed to build the autokeys
EXPORT ak_rec := record
	string60  official_record_key;
	string20  fname;
	string20  mname;
	string20  lname;
	string70  cname;
	string25  city;
	string2		per_state;
	string2		bus_state;
	unsigned1 zero             := 0;
	unsigned6 zeroDID          := 0;
	unsigned6 zeroBDID         := 0;
	string1   blank            := '';
	string1   blank_prim_name  := '';
	string1   blank_prim_range := '';
	string1   blank_st         := '';
	string1   blank_city       := '';
	string1   blank_zip5       := '';
	string1   blank_sec_range  := '';
END;

	END;
  
  