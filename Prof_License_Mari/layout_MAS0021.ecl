// MAS0021 / Massachussets, Commonwealth of / Multiple Professions //
export layout_MAS0021 := MODULE
export raw := RECORD
	string     LIC_TYPE;
	string     TYPE_CLASS;
	// string  	 CURRENT;
	string     ORGNAME;
	string     FIRST_NAME;
	string     MID_NAME;
	string     LAST_NAME;
	string     NAME_SUFX;
	string     ADDRESS1_1;
	string     ADDRESS2_1;
	string     CITY_1;
	string     STATE_1;
	string     ZIPCODE;
	string     ISSUEDT;
	string     SLNUM;
	string     EXPDT;
	// string  	 CURRENT;	
	// string   STAT_CODE;
	string	   LICSTAT_DS;
	// string     LICSTAT_DS;
	// string	   FILLER;
	// string  	 FILLER1;   //Added for those records shifted 2 cells to the right 5//13
	// string  	 FILLER2;   //Added for those records shifted 3 cells to the right 5/14/13
END;

export common := RECORD
	string     LIC_TYPE;
	string     TYPE_CLASS;
	string	   CURRENT;
	string     ORGNAME;
	string     FIRST_NAME;
	string     MID_NAME;
	string     LAST_NAME;
	string     NAME_SUFX;
	string     ADDRESS1_1;
	string     ADDRESS2_1;
	string     CITY_1;
	string     STATE_1;
	string     ZIPCODE;
	string     ISSUEDT;
	string     SLNUM;
	string     EXPDT;
	string     STAT_CODE;
	string	   LICSTAT;
	string     LICSTAT_DS;	
	string	   FILLER;
	string  	 FILLER1;   //Added for those records shifted 2 cells to the right 5//13
	string  	 FILLER2;   //Added for those records shifted 3 cells to the right 5/14/13
END;

END;