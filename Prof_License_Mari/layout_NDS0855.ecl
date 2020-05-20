// NDS0855 / North Dakota Real Estate Commission / Real Estate //

export layout_NDS0855 := RECORD
	// string			filler1;			//new since 20140725
	// string			filler2;			//new since 20140725
	string35    FIRST_NAME;
	string10    MID_NAME;
	string35    LAST_NAME;
	string10    SUFFIX_NAME;
	string20		LICTYPE;
	string10		LICSTAT;	
	string10    RENEWALYEAR;
	string100   OFFICENAME;
	string20    PHONE;
	string100   ADDRESS1;
	string30    CITY;
	string30    STATE;
	string10    ZIP;
	string30		COUNTY;
END;
// export layout_NDS0855 := RECORD
	// string100   OFFICENAME;
	// string100   ORG_NAME;
	// string100   ADDRESS1;
	// string50    CITYSTZIP;
// END;