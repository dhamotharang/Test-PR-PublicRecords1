// NES0859 / Nebraska Real Property Appraiser Board / Real Estate Appraisers //

EXPORT layout_NES0859 := MODULE

	EXPORT raw := RECORD
		string30   LIC_TYPE;
		string100  ORG_NAME;
		string150  OFFICENAME;
		string100  ADDRESS1_1;
		string30   CITY_1;
		string30   STATE_1;
		string10   ZIP;
		string30   TELE_1;
		string100  EMAIL_1;
		string1		 CRLF;
	END;

	EXPORT src := 	RECORD
		raw;
		STRING8 ln_filedate;
	END;
END;	