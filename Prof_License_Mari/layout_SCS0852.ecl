﻿// SCS0852 / South Carolina Real Estate Commission / Real Estate //

EXPORT layout_SCS0852 := MODULE

	EXPORT rActiveAgent := 
		RECORD
			STRING  BOARD_NAME;
			STRING  LAST_NAME;
			STRING  FIRST_NAME;
			STRING  MID_NAME;
			STRING	SUB_CATEGORY;
			STRING  LIC_TYPE;
			STRING  LIC_NUM;
			STRING  EFFECTIVE_DATE;			//fmt MM/DD/YYYY
			STRING  FIRST_ISSUE_DATE;		//fmt MM/DD/YYYY
			STRING  EXPIRATION_DATE;		//fmt MM/DD/YYYY
			STRING  OFFICE_NAME;			  
			STRING  ADDRESS1;
			STRING  ADDRESS2;
			STRING  CITY;	
			STRING  STATE;	
			STRING  ZIP;
			STRING  ZIP_MAIN;
			STRING  LICSTAT;
			STRING  SUPCREDNUM;
			STRING  OFF_SLNUM;
		END;
	
	export rInActiveAgent := 
		RECORD
			STRING  BOARD_NAME;
			STRING  LAST_NAME;
			STRING  FIRST_NAME;
			STRING  MID_NAME;
			STRING	SUB_CATEGORY;
			STRING  LIC_TYPE;
			STRING  LIC_NUM;
			STRING  EFFECTIVE_DATE;			//fmt MM/DD/YYYY
			STRING  FIRST_ISSUE_DATE;		//fmt MM/DD/YYYY
			STRING  EXPIRATION_DATE;		//fmt MM/DD/YYYY
			// STRING  OFFICE_NAME,			  
			// STRING  ADDRESS1,
			// STRING  ADDRESS2,
			// STRING  CITY,	
			// STRING  STATE,	
			// STRING  ZIP,
			// STRING  ZIP_MAIN,
			STRING  LICSTAT;
			STRING  SUPCREDNUM;
			STRING  OFF_SLNUM;
			
		END;
	
END;



// export layout_SCS0852 := RECORD
	// STRING150  ORG_NAME;
	// STRING50   ADDRESS1_2;
	// STRING50   ADDRESS2_2;
	// STRING30   CITY_2;
	// STRING10   STATE_2;
	// STRING10   ZIP_2;
	// STRING30   SLNUM;
	// STRING50   PROF;
	// STRING30   ISSUEDT;
	// STRING30   EXPDT;
	// STRING30   LIC_TYPE;
	// STRING100  OFFICENAME;
	// STRING50   ADDRESS1_1;	
	// STRING50   ADDRESS2_1;
	// STRING30   CITY_1;	
	// STRING10   STATE_1;
	// STRING10   ZIP;
	// STRING30   LICSTAT;
	// STRING30   SUPCREDNUM;
	// STRING30   OFF_SLNUM;
// END;