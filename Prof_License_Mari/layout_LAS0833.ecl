// LAS0833 / Louisiana Real Estate Appraiser Board / Real Estate Appraisers//
export layout_LAS0833 := record, maxlength(2000)
	string30    SLNUM;
	string150   ORG_NAME;
	string50    LIC;
	string50    LICSTAT;
	// string20    STATREASON;
	string50    ADDRESS1_1;
	string50    ADDRESS2_1;
	string30    CITY_1;
	string2     STATE_1;
	string10    ZIP;
	string30    COUNTY;
	string30    TELE_1;
	string100   EMAIL_1;
	//Added for 20130417
	string15		APPLICATION_DT;
	string15    ISSUEDT;
	string15    CURISSUEDT;
	string15    EXPDT;
	string100   CONTACT;
	string50    ADDRESS1_2;
	string50    ADDRESS2_2;
	string50    ADDRESS3_2;
	string30    CITY_2;
	string10    STATE_2;
	string10    ZIP_2;

END;

/* export layout_LAS0833 := RECORD
   	string100  ORG_NAME;
   	string75   LICTYPE;
   	string30   LICSTAT;
   	string30   ISSUEDT;
   	string30   CURISSUEDT;
   	string30   EXPDT;
   	string150  CONTACT;
   	string30	 LASTUPDT;
   	string1		 CR;
   END;
*/