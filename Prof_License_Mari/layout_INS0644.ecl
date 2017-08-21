// INS0644 / Indiana Department of Financial Institutions / Other Lenders //

export layout_INS0644 := MODULE

	export Corp	:= RECORD, MAXLENGTH(441)
		string30   SLNUM,
		string150  ORG_NAME,
		string30   CITY,
		string80	 ADDRESS1,
		string30   STATE,
		string30   ZIP,
		string30   COUNTY,
		string30   TELE,
		string40   OFFTYPE,
		// string1		 LF,
	END;

	export Branch	:= RECORD, MAXLENGTH(441)
		string150  ORG_NAME,
		string30	 IN_CITY,
		string30	 IN_PHONE,
		string30   COUNTY,
		string80	 ADDRESS1,
		string30   CITY,
		string30   STATE,
		string30   TELE,
		string30   OFFTYPE,
		// string1	   LF,
	END;

END;