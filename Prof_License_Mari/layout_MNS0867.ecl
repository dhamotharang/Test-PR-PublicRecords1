// MNS0867 / Minnesotas Bookstore /	Real Estate Appraisers //

export layout_MNS0867 := RECORD
	string10   LICTYPE;
	string20   LICNUM;
	string30   LNAME;
	string30   FNAME;
	string30   MNAME;
	string10   JRSR;	
	string65   ADDRESS1;
	string65   ADDRESS2;
	string30   CITY;
	string2    STATE;
	string10   ZIPCODE;
	string10   FZIPCODE;
	string30   TELEPHONE;
	
	string1    LIMIT1;
	string10   LIMIT2;
	string10   LIMIT3;
	string10   LIMIT4;
	string10   LIMIT5;
	string10   LIMIT6;
	string10   LIMIT7;
	string10   LIMIT8;
	string10   CEEXEMPT;
	string2    CEHOURS;
	string10   CEDUEDATE;
	string10   RECIPRICAL;
	string10   RESIDENT;
	string20   ISSUEDT;
	string30   CURISSUEDT;
	string30   INTERRUPT_DT;
	string30   EXPDATE;
	string10   LICSTAT;
	string100  OFFICENAME;
	string20   CID;
	string10   COUNTY_CD;
	string10   COUNTY;
END;