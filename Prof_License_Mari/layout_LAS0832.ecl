export layout_LAS0832 := record, maxlength(2000)
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
	//New field added in 20130314 delivery
	string15		APP_DT;
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
