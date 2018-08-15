﻿// Kansas Real Estate Agents, Brokers, & Firms
EXPORT layout_KSS0903 := MODULE
EXPORT raw := RECORD
	// STRING  LAST_NAME;
	// STRING  FIRST_NAME;
	// STRING  MIDDLE_NAME;
	STRING  FULLNAME;
	// STRING  SUFFIX;
	STRING  EMAIL;	
	STRING	LICENSE_NUMBER;		
	STRING	LICENSE_TYPE;
	STRING	ORIG_ISSUE_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	STRING	LAST_RENEW_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	STRING	EXPIRATION_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	STRING	LICENSE_STATUS;
	STRING	SUM_OF_HOURS;	
	// STRING	STATUS_CODE;
	STRING	COMPANY_LICENSE_NUMBER;	
	STRING	COMPANY_NAME;		
	STRING	BUSINESS_PHONE;
	STRING	BUSINESS_FAX;	
	STRING	ADDRESS;
	// STRING	ADDRESS_2;
	STRING	CITY;
	STRING	STATE;
	STRING	ZIP;
	// STRING	COUNTY_CODE;

	// the vendor stop provide individual/home addresses and provide the business address
	/*
	STRING	ADDRESS;
	STRING	CITY;
	STRING	COUNTY_CODE;
	STRING	STATE;
	STRING	ZIP;	
	// STRING	EMAIL;
	STRING	LICENSE_TYPE;
	STRING	LICENSE_NUMBER;	
	STRING	ORIG_ISSUE_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	STRING	LAST_RENEW_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	STRING	EXPIRATION_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
  STRING	LICENSE_STATUS;
	STRING	COMPANY_LICENSE_NUMBER;	
	STRING	COMPANY_NAME;	
	STRING	BUSINESS_PHONE;
	STRING	BUSINESS_FAX;
	STRING	BUSINESS_ADDRESS;
	STRING	BUSINESS_CITY;
	STRING	BUSINESS_STATE;
	STRING	BUSINESS_ZIP;
	*/
END;


EXPORT Common := RECORD
	STRING  LAST_NAME;
	STRING  FIRST_NAME;
	STRING  MIDDLE_NAME;
	STRING  SUFFIX;
	STRING	FULLNAME;
	STRING	ADDRESS;
	STRING	CITY;
	STRING	COUNTY_CODE;
	STRING	STATE;
	STRING	ZIP;
	STRING	EMAIL;
	STRING	LICENSE_TYPE;
	STRING	LICENSE_NUMBER;
	STRING	ORIG_ISSUE_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	STRING	LAST_RENEW_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	STRING	EXPIRATION_DATE;		//fmt: YYYYMMDD, MM/DD/YYYY
	STRING	SUM_OF_HOURS;
  STRING	LICENSE_STATUS;
	STRING	STATUS_CODE;
	STRING	LIC_ORIGIN_CODE;
	STRING	BRKR_ORIGIN_CODE;
	STRING	COMPANY_LICENSE_NUMBER;
	STRING	COMPANY_NAME;
	STRING	BUSINESS_PHONE;
	STRING	BUSINESS_FAX;
 END;

 END;