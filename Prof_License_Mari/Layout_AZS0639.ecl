// AZS0639 Layout * Arizona State Banking Department / Mortgage Lenders//

export Layout_AZS0639	:= MODULE

export Mtg_Broker := RECORD
	string150  COMPANY,
	string150  DBA_NAME,
	string150  BRANCH_NAME,
	string20   LIC_NUM,
	string20   BR_NUM,
	string50   ADDRESS_1,
	string50   ADDRESS_2,
	string25   CITY,
	string5    ST,
	string10   ZIP_CODE,
	string15   PHONE,
	string50   CONTACT,
	string20   START_DATE,
	string20   EXPIRATION_DATE,
 END;
 
export Com_Agent := RECORD
	string150  COMPANY,
	string150  DBA_NAME,
	string150  BRANCH_NAME,
	string20   LIC_NUM,
	string20   BR_NUM,
	string50   ADDRESS_1,
	string50   ADDRESS_2,
	string25   CITY,
	string5    ST,
	string10   ZIP_CODE,
	string15   PHONE,
	string20   START_DATE,
	string20   EXPIRATION_DATE,
 END; 
END;