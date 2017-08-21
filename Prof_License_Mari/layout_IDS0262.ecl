// IDS0262 / Idaho Bureau of Occupational Licenses / Real Estate Appraisers //

export layout_IDS0262 := RECORD
	string1			UNK_IDENTIFIER;
	string100   SORT_NAME;
	string100   BUS_NAME;
	string100   OWNER;
	string50    PROFESSION;
	string50    LIC_DESC;
	string30    LIC_NO;
	string30    LAST_NAME;
	string30    FIRST_NAME;
	string30    MID_NAME;
	string50    ADDRESS1;
	string50    ADDRESS2;
	string30    CITY;
	string30    COUNTY;
	string2     STATE;
	string10    POSTALCODE;
	string30    COUNTRY;
	string12		PHONE;				// XXX XXX-XXXX
	string30    ISSUED;				// M/D/YYYY
	string30    LICENSED_BY;
	string30		STATUS;
	string30		EXPIRES;			// M/D/YYYY
	string30    LIC_NO2;
	string10		SUPERVISOR;
	string30		SPECIALTY;
	string3			ACTION;
END;