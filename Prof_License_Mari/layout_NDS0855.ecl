// NDS0855 / North Dakota Real Estate Commission / Real Estate //

export layout_NDS0855 := RECORD
	string			filler1;			//new since 20140725
	// string			filler2;			//new since 20140725
	string100   ORG_NAME;
	string10		LICSTAT;
	string20		LICTYPE;
	string100   OFFICENAME;
	string100   ADDRESS1;
	string50    CITYSTZIP;
	string30		COUNTY;
	string20		PHONE;
END;
// export layout_NDS0855 := RECORD
	// string100   OFFICENAME;
	// string100   ORG_NAME;
	// string100   ADDRESS1;
	// string50    CITYSTZIP;
// END;