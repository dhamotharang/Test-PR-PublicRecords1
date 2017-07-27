export layout_header_records := record
  unsigned2 penalt;
  doxie.key_header;
  unsigned1 num_compares;
	//gong history fields
	string1 listing_type_res := '';	
    string1 listing_type_bus := '';
    string1 listing_type_gov := '';
	string1 listing_type_cell:= '';
	string30 new_type := '';
	STRING30 carrier := '';
	STRING25 carrier_city:= '';
	STRING2 carrier_state:= '';
	STRING12 PhoneType:= ''; 
	unsigned3 phone_first_seen := 0;
	unsigned3 phone_last_seen := 0;
	string254 caption_text := '';
	unsigned6	bdid := 0;
	unsigned6 linked_did := 0;
	boolean includedByHHID := false;
	string4 timezone :='';
	string4 listed_timezone :='';
	string1 publish_code:= '';
	string5 listed_name_prefix:= '';
  string20 listed_name_first:= '';
  string20 listed_name_middle:= '';
  string20 listed_name_last:= '';
  string5 listed_name_suffix:= '';
end;