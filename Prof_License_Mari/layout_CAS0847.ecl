// CAS0847 / California Dept of Real Estate /Mortgage Lenders //
EXPORT layout_CAS0847 := RECORD
	STRING30   LAST_NAME;
	STRING30   FIRST_NAME;
	STRING30   MID_NAME;
	STRING150  MAIL_ADDRESS;
	STRING30   MAIL_CITY;
	STRING2    MAIL_STATE;
	STRING10   MAIL_ZIP;
	STRING30   COUNTY;
	STRING30   PHONE;
	STRING30   DATE_EXPIRED;
	STRING10   LIC_LEV;
	STRING30   LIC_NUM;
	STRING30   NEXT_RENEWAL;
END;

/* export layout_CAS0847 := RECORD
   	string30   FIRST_NAME;
   	string30   LAST_NAME;
   	string30   MID_NAME;
   	string100  FULL_NAME;
   	string100  COMPANY_NAME;
   	string30   PHONE;
   	string150  MAIL_ADDRESS;
   	string30   MAIL_CITY;
   	string2    MAIL_STATE;
   	string10   MAIL_ZIP;
   	string30   COUNTY;
   	string30   APP_TYPE;
   	string10   LIC_LEV;
   	string30   LIC_NUM;
   	string30   LICENSE_STATUS;
   	string30   ISSUE_DATE;
   	string30   DATE_EXPIRED;
   	string30   RENEWAL_ISSUED;
   	string30   RENEWAL_EXPIRES;
   	string254  COMPLIANCE;
   	string30   LAST_UPDATED;
   	string225  Filler;
   	string1	   LF;
   END;
*/