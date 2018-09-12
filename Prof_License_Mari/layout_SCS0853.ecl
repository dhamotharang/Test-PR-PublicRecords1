﻿// SCS0853 / SOUTH CAROLINA REAL ESTATE APPRAISERS BOARD / REAL ESTATE APPRAISERS //
EXPORT LAYOUT_SCS0853 := MODULE

EXPORT CURRENT	:= RECORD
	STRING50	 LICENSE_DESC;
	STRING30   BOARD;						//SUB_CATEGORY
	// STRING5    TITLE;
	// STRING30   LAST_NAME;
	// STRING30   MID_NAME;
	// STRING30   FIRST_NAME;
	STRING100  FULL_NAME;				//BUSINESS NAME
	// STRING100  OFFICENAME;          
	STRING50   BUS_ADDRESS_1;
	STRING50   BUS_ADDRESS_2;
	STRING30   BUS_CITY;
	STRING30   BUS_STATE;
	STRING30   BUS_ZIP;
	// STRING30   BUS_PHONE;
	STRING30   ISSUEDT;
	STRING30   EXPDT;
	STRING10   CRED_PREFX;
	STRING30   SLNUM;
	STRING30   STATUS;
END;


EXPORT COMMON := RECORD
	STRING50	 LICENSE_DESC;
	STRING5    TITLE;
	STRING30   BOARD;						//SUB_CATEGORY
	STRING10	 SUB_CAT;
	STRING10   CRED_PREFX;
	STRING30   LIC_TYPE;
	STRING30   SLNUM;
	STRING30   STATUS;
	STRING30   EXPDT;
	STRING30   ISSUEDT;
	STRING30   CURISSUEDT;
	STRING30   EXPDT_1007;
	STRING30   LAST_NAME;
	STRING30   FIRST_NAME;
	STRING30   MID_NAME;
	STRING100  FULL_NAME;						//BUSINESS NAME
	STRING100  OFFICENAME;
	STRING50   BUS_ADDRESS_1;
	STRING50   BUS_ADDRESS_2;
	STRING30   BUS_CITY;
	STRING50   BUS_COUNTY;
	STRING30   BUS_STATE;
	STRING30   BUS_ZIP;
	STRING30   BUS_PHONE;
	STRING50   MAIN_ADDRESS_1;
	STRING50   MAIN_ADDRESS_2;
	STRING30   MAIN_CITY;
	STRING30   MAIN_STATE;
	STRING30   MAIN_ZIP;
	STRING		 FILLER1;
	STRING8		 LN_FILEDATE;	
	
END;

END;