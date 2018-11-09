
// layout of file feed from Neustar
EXPORT Layout_Neustar := RECORD
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
/*
NOTE: the UNLICENSED field is now the Data Source, which may have one of the following values:
1 Amacai Data/DA Public Data
2 PRIVATE (Non Pub) DA Data
6 Time Warner Public (in DA) Data
9 Comtel Public (in DA) Data
12 Other MSO Public
15 SuddenLink Public
18 Comcast Business Pub
21 Cox Public
24 MediacomPub
*/
