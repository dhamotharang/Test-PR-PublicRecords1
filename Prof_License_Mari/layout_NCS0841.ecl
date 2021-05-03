// NCS0841 / North Carolina Appraisal Board	/ Real Estate Appraisers //

export layout_NCS0841 := MODULE
	export raw := RECORD
	string30   LICENSEID;
	string50   LASTNAME;
	string30   FIRSTNAME;
	string30   LICTYPE;
	string30   NR;
	string150  FIRMNAME;	
	string100  ADDRESS;
	string30   CITY;
	string2    STATE;
	string10   ZIP;
	string30   COUNTY;
	string30   PHONE1;
	string50	 EMAIL;
END;

export src := RECORD
	raw;
	string8  LN_filedate;
END;

END;	