IMPORT standard;

EXPORT layout_SANCTN_party_clean_orig := RECORD
	SANCTN.layout_SANCTN_party_in;
  string255      party_text := '';
  Standard.Name;
	string45       cname;
	Standard.L_Address.detailed;
	
END;	