// UTS0682 / Utah Department of Financial Institutions / Mortgage Lenders //

export Layout_UTS0682 := MODULE
export mortgage := RECORD
	string75   NAME;
	string50   ADDRESS;
	string50   PO_BOX;
	string25   CITY;
	string5    STATE;
	string10   ZIP;
	string50   CONTACT;
	string15   ISSUE_DATE;
	string15   RENEWAL_DATE;
	string6    LENDER;
	string6    BROKER;
	string8    SERVICER;
	string25   PHONE;
END;


export financial := RECORD
	string30		NAME_TYPE;
	string75		NAME;
	string50		ADDRESS;
	string50	 	PO_BOX;
	string25		CITY;
	string5			STATE;
	string10		ZIP;
	string25   	PHONE;
	string50   	CONTACT;
	string30		TITLE;
END;


export common := RECORD
	string30	NAME_TYPE;
	string75  NAME;
	string50  ADDRESS;
	string50  PO_BOX;
	string25  CITY;
	string5   STATE;
	string10  ZIP;
	string50  CONTACT;
	string15  ISSUE_DATE;
	string15  RENEWAL_DATE;
	string6   LENDER;
	string6   BROKER;
	string8   SERVICER;
	string25  PHONE;
	string30	TITLE;
	string3		FILE_TYPE;			//internal field - MTG(Mortgage Files); FIN(Financial Instituation)
	string8 	LN_FILEDATE; 		//internal field
END;

END;