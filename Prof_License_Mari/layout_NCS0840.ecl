// NCS0840 / North Carolina Real Estate Commission / Real Estate //

export layout_NCS0840 := RECORD
	string30    ID;
	string150   NAME;
	string30    LICTYPE;		// (Broker, Provisional Broker, etc)
	string150   CO;					// Company Nmae
	string100   ADD1;				// Company Address
	string30    CITY;				// Company City
	string10    STATE;			// Company State
	string10    ZIP;				// Company Zip
	string50    BIC;				// Broker IN Charge
//Update 20150622	
	// string10    F0;					// Filler Field
	// string100   R_ADD1;			// No Longer Used So Now Filler
	// string30    R_CITY;			// No Longer Used So Now Filler
	// string10    R_STATE;		// No Longer Used So Now Filler
	// string10    R_ZIP;			// No Longer Used So Now Filler
	// string50    ADD2;				// No Longer Used So Now Filler
	string30    COUNTY;			
	// string10    F1;					// Filler Field
	string30    STATUS;			
	string30    FAX;				
	string100   EMAIL;
	string30		PHONE;
	string30    BIC_INDIC;	// Broker In Charge Indicator("Y" for BICs)
	string150   F22;				// Education Commnets
	string150   F23;				// Education Commnets
	string150   F24;				// Education Commnets
	string150   F25;				// Education Commnets
	string150   F26;				// Filler Field
	string150   F27;				// Filler Field
	string150   F28;				// Filler Field
	string150   F29;				// Filler Field
	string150   F30;				// Filler Field
	string150   F31;				// Filler Field
	string150   F32;				// Filler Field
	string150   F33;				// Filler Field
	string150   F34;				//New filler field  3/29/13
	string10    CT;
END;