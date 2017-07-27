export official_records_party
 :=
  record
	integer4	process_date;
	string2		vendor;
	string2		state_origin;
	string30	county_name_origin;
	string60	official_record_key;
	string25	doc_instrument_or_clerk_filing_num;
	integer4	doc_filed_date;
	string60	doc_type_desc;
	string5		entity_sequence;
	string15	entity_type_code;
	string50	entity_type_desc;
	string80	entity_name;
	string1		entity_name_format;
	standard.dob dob;
	standard.ssn ssn;
    standard.name	pname_1;
	string70 		cname_1;
    standard.name	pname_2;
	string70 		cname_2;
	standard.name	pname_3;
	string70 		cname_3;
  	standard.name	pname_4;
	string70 		cname_4;
    standard.name	pname_5;
	string70 		cname_5;
  end;