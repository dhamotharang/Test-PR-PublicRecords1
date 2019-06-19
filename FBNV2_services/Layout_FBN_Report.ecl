import FBNV2;

export Layout_FBN_Report := RECORD
	boolean isDeepDive;
	unsigned2 penalt;
	FBNV2.Layout_Common.Business and not [orig_fein, global_sid, record_sid];
	string10 Orig_Fein;
	string25 state;
	string25 county_name;
	dataset(Layout_Contact) Contacts {maxcount(25)};
END;