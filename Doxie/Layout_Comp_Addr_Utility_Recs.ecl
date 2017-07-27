import doxie;

EXPORT Layout_Comp_Addr_Utility_Recs := RECORD
  doxie.Layout_Comp_Addresses;
  STRING8	  util_connect_date := '';
  STRING30  util_type := '';
  UNSIGNED2 fdn_did_ind   := 0; // Added for the FDN project.
  UNSIGNED2 fdn_addr_ind  := 0; // Added for the FDN project.
  UNSIGNED2 fdn_phone_ind := 0; // Added for the FDN project.
	UNSIGNED2 fdn_listed_phone_ind := 0; // Added for the FDN project.
	
	string35 Address_type := ''; // For accurint comp report re-design	
END;
	
