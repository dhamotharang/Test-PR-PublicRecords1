// MTS0398 / Montana Department of Labor and Industry /	Multiple Professions //

export layout_MTS0398 := RECORD
	string50   LAST_NAME;
	string30   FIRST_NAME;
	string30   MID_NAME;
	string10   NAME_SUFX;
	string50   OFFICENAME;
	string25   SLNUM;
	string50   LIC;	
	string50	 APRN_ENDORSEMENT;     //Advanced Pratice Registered Nurse. Not applicable for Real Estate Professionals.
	string30   LICSTAT;
	string10   EXPDT;
	string10   ISSUEDT;
	string50   ADDRESS1_1;
	string50   ADDRESS2_1;
	string50   ADDRESS3_1;
	string25   CITY_1;
	string5    STATE_1;
	string10   ZIP;
	string30   COUNTRY_1;				//Increase the string len from 10 to 30 to prevent it from truncating United States
END;
/*
export layout_MTS0398 := RECORD
	string50   LAST_NAME;
	string30   FIRST_NAME;
	string15   SLNUM;
	string50   LIC;	
	string25   LICSTAT;
	string10   EXPDT;
	string10   ISSUEDT;
	string10   INDICATOR;
	string50   ADDRESS1_1;
	string50   ADDRESS2_1;
	string50   ADDRESS3_1;
	string25   CITY_1;
	string5    STATE_1;
	string10   ZIP;
	string10   ZIP4;
	string30   FORGN_ADD;
	string10   COUNTRY_1;
	string10   BOARD;
	string30   MID_NAME;
	string10   NAME_SUFX;
	string50   SCHOOL;
	string50   SPEC1;
	string50   SPEC2;
	string50   SPEC3;
	string50   SPEC4;
	string50   SPEC5;
	string10   CREDENTIAL;
	string10   NAME_PREFX;
	string10   PRNTSTATUS;
	string10   REG_TYPE;
	string10   PRNTDT;
	string10   DUPDT;
	string10   CEREQIND;
	string10   CEREQDT;
	string10   CEMETIND;
	string10   PIN;
	string10   REG_CODE;
	string50   OFFICENAME;
END;
*/