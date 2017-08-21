import address;

export Layout_MFind_Search := RECORD
	boolean isDeepDive;
	unsigned2 penalt;
	string84		TRIM_VID;
	unsigned6   did;
	string 		MIL_BRANCH;
	string 		CURR_NAME_GENDER;
	address.Layout_Clean_Name;
	address.Layout_Clean182;
END;

