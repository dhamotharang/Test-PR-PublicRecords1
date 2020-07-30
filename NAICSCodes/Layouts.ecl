EXPORT Layouts := MODULE

EXPORT Sprayed_Input := RECORD
  string4  seq_number;
	string6  naics_code;
	string80 naics_description;
END;

EXPORT Sprayed_Input_DnbDmi := RECORD
	string6  naics_code;
	string80 naics_description;
END;

EXPORT naicsLookup := RECORD
	string6  naics_code;
	string80 naics_description;
END;

END;  //End Layouts