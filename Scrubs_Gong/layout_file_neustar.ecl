
// layout of file feed from Neustar

EXPORT layout_file_neustar := RECORD
				string1 	ACTION_CODE;			
				string  	RECORD_ID;
				string1 	RECORD_TYPE;
				string10  TELEPHONE;
				string1 	LISTING_TYPE;
				string		BUSINESS_NAME := '';
				string		BUSINESS_CAPTIONS := '';
				string  	CATEGORY := '';
				integer2	INDENT;
				string  	LAST_NAME := '';
				string		SUFFIX_NAME := '';
				string 		FIRST_NAME := '';
				string		MIDDLE_NAME := '';
				string  	PRIMARY_STREET_NUMBER;
				string		PRE_DIR;
				string  	PRIMARY_STREET_NAME;
				string  	PRIMARY_STREET_SUFFIX;
				string		POST_DIR;
				string		SECONDARY_ADDRESS_TYPE;
				string		SECONDARY_RANGE;
				string  	CITY;
				string  	STATE;
				string  	ZIP_CODE;
				string	  ZIP_PLUS4;
				string  	LATITUDE;
				string  	LONGITUDE;
				string		LAT_LONG_MATCH_LEVEL;
				string  	UNLICENSED;
				string  	ADD_DATE;
				string  	OMIT_ADDRESS;
				string  	DATA_SOURCE;					// AB=Directory Assistance,  all others are not
				string		unknownField := '';		// undocumented field
				string5		TransactionID;				// not used by us
				string		Original_Suffix := '';
				string		Original_First_Name := '';
				string		Original_Middle_Name := '';
				string		Original_Last_Name := '';
				string		Original_Address := '';
				string		Original_Last_Line := '';
				string255 filename{virtual (logicalfilename)};
		END;
