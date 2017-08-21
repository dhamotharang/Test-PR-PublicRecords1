EXPORT Layout_Targus_DA_Content := 
	RECORD
			, MAXLENGTH(50000)
				string1 	ACTION_CODE;			
				string  	RECORD_ID;
				string1 	RECORD_TYPE;
				string10  TELEPHONE;
				string1 	LISTING_TYPE;
				string		BUSINESS_NAME;
				string		BUSINESS_CAPTIONS;
				string  	CATEGORY;
				string		INDENT;
				string  	LAST_NAME;
				string		SUFFIX;
				string 		FIRST_NAME;
				string		MIDDLE_INITIAL;
				
				string  	PRIMARY_STREET_NUMBER;
				string		PRE_DIR;
				string  	PRIMARY_STREET_NAME;
				string  	PRIMARY_STREET_SUFFIX;
				string		POST_DIR;
				string		SECONDARY_ADDRESS_TYPE;
				string		SECONDARY_RANGE;
				string  	CITY;
				string  	STATE;
				string5  	ZIP_CODE;
				string4	  ZIP_PLUS4;
				
				string  	LATITUDE;
				string  	LONGITUDE;
				string		LAT_LONG_MATCH_LEVEL;
				string		filler := '';
				string  	ADD_DATE;
				string		OMIT_ADDRESS := '';
				
				string		RECORD_SOURCE := '';
				string		NAME_SOURCE := '';

	END;