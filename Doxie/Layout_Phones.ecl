import Risk_Indicators;

export Layout_Phones :=
RECORD
	unsigned1 match_type;
	integer gong_score;
	STRING10 phone10;
	STRING4  timezone;
	boolean listed;
	unsigned6 bdid;
	unsigned6 did;
	STRING1 listing_type_res;
	STRING1 listing_type_bus;
	STRING1 listing_type_gov;
	STRING1 listing_type_cell;
	string30 new_type;
	STRING30 carrier;
	STRING25 carrier_city;
	STRING2 carrier_state;
	STRING12 PhoneType; 
	unsigned3 phone_first_seen;
	unsigned3 phone_last_seen;
	STRING120 listed_name {MAXLENGTH(120)};
	STRING254 caption_text {MAXLENGTH(254)};
	// Added for the FDN project.  Added here since mutiple basic & "advanced" person search 
	// related attributes in the PersonSearch_Services & doxie folders use this layout for their 
	// "Phones" child dataset record layout.
  unsigned2 fdn_phone_ind := 0;
END;
