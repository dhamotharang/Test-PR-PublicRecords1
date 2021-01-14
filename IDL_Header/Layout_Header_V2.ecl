﻿EXPORT Layout_Header_v2 := RECORD
	UNSIGNED8 	RID;
	UNSIGNED8 	DID;
	STRING9			SRC;// Contains product abbreiviation and ambest
	UNSIGNED8		SOURCE_RID;

	UNSIGNED4		DT_FIRST_SEEN;
	UNSIGNED4		DT_LAST_SEEN;
	UNSIGNED4		DT_VENDOR_FIRST_REPORTED;
	UNSIGNED4		DT_VENDOR_LAST_REPORTED;

	STRING1			AMBIGUOUS;
	STRING1			CONSUMER_DISCLOSURE;
	Unsigned2		CleavePenalty;
	STRING1			SSN_IND;		// G=good; F=fatfingers(typo; one or two digits off in the same positions); R=relative; B=bad; O=other
	STRING1			DOB_IND;		// C=correct, L=correct but low quality, I=invalid, T=typo, B=bad, U=undetermined
	STRING1			DLNO_IND;   // 1=Current, 2=Former1, 3=Former2, ....
	STRING2     FNAME_IND;
	STRING2     MNAME_IND;
	STRING2     LNAME_IND;
	STRING2			ADDR_IND;		// 1=Current, 2=Former1, 3=Former2, ....
	STRING1			BEST_ADDR_IND;
	STRING2     PHONE_IND;
	STRING1			PHONE_TYPE;	//DF-28025
	STRING2			EMAIL_IND;	//DF-28025
	STRING1			EMAIL_TYPE; //DF-28025

	STRING10		PHONE;
	STRING9			SSN;
	UNSIGNED4		DOB;
	STRING25		DL_NBR;
	STRING2			DL_STATE;
	STRING5			TITLE;
	STRING20		FNAME;
	STRING20		MNAME;
	STRING28		LNAME; 
	STRING5			SNAME;			// ['SR', 'JR', '1', '2', '3', '4', '5', '6', '7', '8']
	STRING5     OCCUPATION;
	STRING1			GENDER;
	STRING1			DERIVED_GENDER;
	
	UNSIGNED8 	ADDRESS_ID;
	STRING4			ADDR_ERROR_CODE;
	STRING10		PRIM_RANGE;
	STRING2			PREDIR;
	STRING28		PRIM_NAME;
	STRING4			ADDR_SUFFIX;
	STRING2			POSTDIR;
	STRING10		UNIT_DESIG;
	STRING8			SEC_RANGE;
	STRING25		CITY;
	STRING2			ST;
	STRING5			ZIP;
	STRING4			ZIP4;
	STRING5			AddressStatus;
	STRING3			AddressType;
	UNSIGNED INTEGER6 BOCA_DID;
	STRING18    VENDOR_ID;
	STRING60		Email; //DF-28025
END;

