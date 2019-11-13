﻿// TXS0636 / Texas Office of Consumer Credit Commissioner / Other Lenders //
EXPORT layout_TXS0636 := MODULE
	EXPORT raw := RECORD
  
STRING50   LICENSETYPE;
STRING10   MAST_FILE_NUMR;
STRING100  LICENSEE;      
STRING30   STATUS;
STRING70   MAST_ADDRESS;
STRING70   MAST_ADDRESS_2;
STRING25   MAST_CITY;
STRING5    MAST_STATE;
STRING10   MAST_ZIP_CODE;
STRING20   MAST_COUNTY;
STRING20   MASTER_PHONE;
STRING20   MASTER_FAX;
STRING20   LIC_NUMR;
STRING10   LICENSEDATE;
STRING100  DBA_OPER_NAME;
STRING70   ADDRESS;
STRING70   ADDRESS_2;
STRING25   CITY;
STRING5    STATE;
STRING10   ZIP_CODE;
STRING20   COUNTY;
STRING20   PHONE;
STRING20   FAX_NUMBER;
STRING10   DATE_CANCELLED;
STRING10   LAST_RENEWED_DATE;
STRING10   DATE_REVOKED;
STRING10   DATE_SURRENDERED;
	END;
	

	EXPORT src := RECORD
	STRING50   LICENSETYPE;
	STRING20   LIC_NUMR;
	STRING10   MAST_FILE_NUMR;
	STRING100  LICENSEE;
	STRING100  LICENSEE_ADDL;
	STRING100  DBA_OPER_NAME;
	STRING70   ADDRESS;
	STRING70   ADDRESS_2;
	STRING25   CITY;
	STRING5    STATE;
	STRING10   ZIP_CODE;
	STRING20   PHONE;
	STRING20   FAX_NUMBER;
	STRING20   COUNTY;
	STRING30   STATUS;
	STRING10   LICENSEDATE;
	STRING10   DATE_CANCELLED;
	STRING10   LAST_RENEWED_DATE;
	STRING10	 PRIM_BUS_TYPE;
	STRING10	 AUTHORIZATION_PRIMARY;
	
  //Master Informtion	
	STRING70   MAST_ADDRESS;
	STRING70   MAST_ADDRESS_2;
	STRING25   MAST_CITY;
	STRING5    MAST_STATE;
  STRING10   MAST_ZIP_CODE;
	STRING20   MAST_COUNTY;
	STRING20   MASTER_PHONE;
	STRING20   MASTER_FAX;
	STRING8		 LN_FILEDATE; 		//internal
	END;
	
END;	