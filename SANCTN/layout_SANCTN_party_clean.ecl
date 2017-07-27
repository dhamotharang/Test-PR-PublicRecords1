IMPORT standard;

export layout_SANCTN_party_clean := record
	SANCTN.layout_SANCTN_party_in;
    string255      party_text := '';
    Standard.Name;
	string45       cname;
	Standard.L_Address.detailed;
	// unsigned6 	   did := 0;
	// string3 	   did_score := '';
end;
