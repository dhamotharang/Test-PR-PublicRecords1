EXPORT Layout_Header := RECORD
	integer4		LINK_ID;		//	NUMBER(9)	9-digit unique number assigned by Cortera to a company in its database.
	string100		NAME;				//	VARCHAR2(100)	Business/Company name 
	string100		ALTERNATE_BUSINESS_NAME;	//	VARCHAR2(100)	Alternate name on file 
	string80		ADDRESS;		//	VARCHAR2(80)	Address 
	string80		ADDRESS2;		//	VARCHAR2(80)	Address 2 line
	string80		CITY;				//	VARCHAR2(80)	City 
	string50		STATE;			//	VARCHAR2(50)	State 
	string2			COUNTRY;		//	VARCHAR2(2)	Two character Country Code 
	string20		POSTALCODE;	//	VARCHAR2(20)	Zip/Postal Code 
	string30		PHONE;			//	VARCHAR2(30)	Phone
	string30		FAX;				//	VARCHAR2(30)	Fax
	string10		LATITUDE;		//	VARCHAR2(10)	Latitude 
	string11		LONGITUDE;	//	VARCHAR2(11)	Longitude 
	string200		URL;				//	VARCHAR2(200)	Website
	string9			FEIN;				//	VARCHAR2(9)	FEIN
	string1			POSITION_TYPE;	//	CHAR(1)	Location in the corporate hierarchy.  Possible Values: 'S' - Single Location, 'B' - Branch, 'H' - Headquarters
	integer4		ULTIMATE_LINKID;	//	NUMBER(20)	9-digit unique number of the ultimate parent location.
	string100		ULTIMATE_NAME;	//	VARCHAR2(100)	Name of the ultimate parent
	string8			LOC_DATE_LAST_SEEN;	//	YYYYMMDD	Date of last update to the location
	string20		PRIMARY_SIC;		//	VARCHAR2(20)	Primary SIC for the business
	string100		SIC_DESC;		//	VARCHAR2(100)	SIC description
	string20		PRIMARY_NAICS;	//	VARCHAR2(20)	Primary NAICS for the business
	string200		NAICS_DESC;		//	VARCHAR2(200)	NAICS description
	string10		SEGMENT_ID;		//	NUMBER(10)	Cortera defined segment ID for the business
	string255		SEGMENT_DESC;	//	VARCHAR2(255)	Cortera defined segment for the business
	string4			YEAR_START;		//	VARCHAR2(4)	Year business started
	string1			OWNERSHIP;		//	CHAR(1)	Possible Values: 'P' - Public,  'V' - Private
	string10		TOTAL_EMPLOYEES;	//	VARCHAR2(10)	Total employees for the family
	string30		EMPLOYEE_RANGE;		//VARCHAR2(30)	Employee range
	string15		TOTAL_SALES;		//	VARCHAR2(15)	Estimated total annual sales for the family
	string50		SALES_RANGE;		//	VARCHAR2(50)	Estimate sales range
	string250		EXECUTIVE_NAME1;	//	VARCHAR2(250)	Executive Name
	string250		TITLE1;				//	VARCHAR2(250)	Executive Title
	string250		EXECUTIVE_NAME2;	//	VARCHAR2(250)	Executive Name
	string250		TITLE2;				// VARCHAR2(250)	Executive Title
	string250		EXECUTIVE_NAME3;	//	VARCHAR2(250)	Executive Name
	string250		TITLE3;				//	VARCHAR2(250)	Executive Title
	string250		EXECUTIVE_NAME4;	//	VARCHAR2(250)	Executive Name
	string250		TITLE4;				//	VARCHAR2(250)	Executive Title
	string250		EXECUTIVE_NAME5;		//	VARCHAR2(250)	Executive Name
	string250		TITLE5;				//	VARCHAR2(250)	Executive Title
	string250		EXECUTIVE_NAME6;	//	VARCHAR2(250)	Executive Name
	string250		TITLE6;				//	VARCHAR2(250)	Executive Title
	string250		EXECUTIVE_NAME7;	//	VARCHAR2(250)	Executive Name
	string250		TITLE7;				//	VARCHAR2(250)	Executive Title
	string250		EXECUTIVE_NAME8;	//	VARCHAR2(250)	Executive Name
	string250		TITLE8;				//	VARCHAR2(250)	Executive Title
	string250		EXECUTIVE_NAME9;	//	VARCHAR2(250)	Executive Name
	string250		TITLE9;					//	VARCHAR2(250)	Executive Title
	string250		EXECUTIVE_NAME10;	//	VARCHAR2(250)	Executive Name
	string250		TITLE10;		//	VARCHAR2(250)	Executive Title
	string1			STATUS;			//	CHAR(1)	Possible Values: 'A' - Active, 'D' - Dormant  (Dormant means we have not seen any activity within 30 months)
	string1			IS_CLOSED;		//	CHAR(1)	Possible Values: 'Y' - Yes
	string9			CLOSED_DATE;
	unsigned4   FIRST_SEEN;  // NEW FIELD - Need to be excluded from the keys
END;