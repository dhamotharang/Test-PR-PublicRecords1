// AZS0813 Layout * Arizona Department of Real Estate / Real Estate /

export layout_AZS0813 := MODULE

export individual := RECORD
	string30   LAST_NAME,	
	string30   FIRST_NAME,	
	string30   MIDDLE_NAME,	
	string30   ORIGINAL_DATE,	
	string30   EXPIRE_DATE,	
	string30   LIC_NUMBER,	
	string30   LIC_CATEGORY,	
	string50   LIC_TYPE,	
	string30   LIC_STATUS,	
	string50   EMPLOYMENT_TYPE,	
	string100  EMPLOYER_LEGAL_NAME,	
	string100  EMPLOYER_DBA,	
	string30   EMPLOYER_LIC_NUMBER,	
	string30   EMPLOYER_PHONE,	
	string30   EMPLOYER_FAX,
	string50   MAILING_ADDRESS1,
	string50   MAILING_ADDRESS2,
	string30   MAILING_CITY,
	string2    MAILING_STATE,
	string10   MAILING_ZIP,
	string30   COUNTY,
	string10   LAST_MODIFIED,
END;

export entity := RECORD
	string30   LIC_NUMBER,
	string100  LEGAL_NAME,	
	string100  DBA,
	string30   ORIGINAL_DATE,	
	string30   EXPIRE_DATE,
	string30   LIC_STATUS,
	string50   LIC_TYPE,
	string30   LIC_CATEGORY,
	string30   PHONE,	
	string30   FAX,
	string50   ADDRESS1,
	string50   ADDRESS2,
	string30   CITY,
	string2    STATE,
	string10   ZIP,
	string30   COUNTY,
	string30   BROKER_LIC_NUMBER,
	string10   LAST_MODIFIED,
END;

END;