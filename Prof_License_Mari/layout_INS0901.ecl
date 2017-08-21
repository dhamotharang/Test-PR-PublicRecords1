// INS0901 / Indiana Real Estate //

export layout_INS0901 := RECORD
	string100	FULL_NAME;
	string30	FIRST_NAME;
	string30	LAST_NAME;
	string100 ADDRESS1;		//Majority of the time this contains the office name
  string100	ADDRESS2;
	string30  CITY;
	string2   STATE;
	string10  ZIP;
	string30  COUNTY;
	string30  SLNUM;
	string80  LIC_TYPE;
	string50  LICSTAT;
	string30  ISSUEDT;	//MM/DD/YYYY
  string30  EXPDT;		//MM/DD/YYYY
END;