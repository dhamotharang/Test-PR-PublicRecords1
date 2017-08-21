// USS0404 / Veterans Administration / Mortgage Lenders //

export layout_USS0404 := module
	export raw := RECORD
	string6   	LENDER_ID;
	string4  	 	BRANCH_UNIQUE_ID;
	// string10   	VA_LENDER_ID;
	// string10   STATE_UNIQUE_ID;
	string100   	ADDRESS1;
	string50   	ADDRESS2;	
	string50		CITY;
	string5		 	ZIP5;
	string4		 	ZIP4;
	string2		 	STATE;
  string200  	LENDER_NAME;
	// string10   BRANCH_STATE_CODE;
	END;
	
	export common := RECORD
	string6   	LENDER_ID;
	string4  	 	BRANCH_UNIQUE_ID;
	string20   	VA_LENDER_ID;
	string100		ADDRESS1;
	string100		ADDRESS2;
	string50		CITY;
	string5		 	ZIP5;
	string4		 	ZIP4;
	string2			STATE;
  string200  	LENDER_NAME;
	string10   	STATE_UNIQUE_ID;
	string10   	BRANCH_STATE_CODE;
	string8		 	LN_FILEDATE; 		//internal
	END;

END;	