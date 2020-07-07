EXPORT layout_progressive_phone_common := RECORD
	BOOLEAN match_name;
	BOOLEAN match_street_address;
	BOOLEAN match_city;
	BOOLEAN match_state;
	BOOLEAN match_zip;
	BOOLEAN match_ssn;
	BOOLEAN match_did;
	BOOLEAN matches;
	Progressive_Phone.Layout_Progressive_Batch_Out_With_DID;
	DATASET({STRING3 src}) Phn_src_all;
END;