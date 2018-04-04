// Kansas Real Estate Agents, Brokers, & Firms
export layout_KSS0903 := MODULE
EXPORT raw := RECORD
	string  LAST_NAME;
	string  FIRST_NAME;
	string  MIDDLE_NAME;
	string  SUFFIX;
	string  EMAIL;
	string	LICENSE_TYPE;
	string	LICENSE_NUMBER;	
	string	ORIG_ISSUE_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	string	LAST_RENEW_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	string	EXPIRATION_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	string	SUM_OF_HOURS;
	string	LICENSE_STATUS;
	string	STATUS_CODE;
	string	COMPANY_LICENSE_NUMBER;	
	string	COMPANY_NAME;		
	string	BUSINESS_PHONE;
	string	BUSINESS_FAX;
	string	ADDRESS;
	string	CITY;
	string	STATE;
	string	ZIP;
	// the vendor stop provide individual/home addresses and provide the business address
	/*
	string	ADDRESS;
	string	CITY;
	// string	COUNTY_CODE;
	string	STATE;
	string	ZIP;	
	// string	EMAIL;
	string	LICENSE_TYPE;
	string	LICENSE_NUMBER;	
	string	ORIG_ISSUE_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	string	LAST_RENEW_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	string	EXPIRATION_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
  string	LICENSE_STATUS;
	string	COMPANY_LICENSE_NUMBER;	
	string	COMPANY_NAME;	
	string	BUSINESS_PHONE;
	string	BUSINESS_FAX;
	string	BUSINESS_ADDRESS;
	string	BUSINESS_CITY;
	string	BUSINESS_STATE;
	string	BUSINESS_ZIP;
	*/
END;


EXPORT Common := RECORD
	string  LAST_NAME;
	string  FIRST_NAME;
	string  MIDDLE_NAME;
	string  SUFFIX;
	string	FULLNAME;
	string	ADDRESS;
	string	CITY;
	string	COUNTY_CODE;
	string	STATE;
	string	ZIP;
	string	EMAIL;
	string	LICENSE_TYPE;
	string	LICENSE_NUMBER;
	string	ORIG_ISSUE_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	string	LAST_RENEW_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	string	EXPIRATION_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	string	SUM_OF_HOURS;
  string	LICENSE_STATUS;
	string	STATUS_CODE;
	string	LIC_ORIGIN_CODE;
	string	BRKR_ORIGIN_CODE;
	string	COMPANY_LICENSE_NUMBER;
	string	COMPANY_NAME;
	string	BUSINESS_PHONE;
	string	BUSINESS_FAX;
 END;

 END;
