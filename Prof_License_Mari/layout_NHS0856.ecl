// NHS0856 / New Hampshire Real Estate Commission / Real Estate //

export layout_NHS0856 := RECORD
	string50   LICTYPE;
	string30   SLNUM;
	string10	 ISSUEDT;	//M/DD/YYYY
	string10   EXPDT;		//M/DD/YYYY
	string30   LICSTAT;
	string35   LAST_NAME;
	string35   FIRST_NAME;
	string10   MID_NAME;
	// string50   HOME_ADDRESS1;	
	// string50   HOME_ADDRESS2;
	// string30   HOME_CITY;
	// string30   HOME_STATE;
	// string10   HOME_ZIP;
	// string20	 PHONE;    //field removed 3/25/13 Cathy Tio
	// string100	 EMAIL;
	string150	 OFFICENAME;	//Contains DBA name
	string100   ADDRESS1;	
	string50   ADDRESS2;
	string30   CITY;
	string30   STATE;
	string10   ZIP;

END;