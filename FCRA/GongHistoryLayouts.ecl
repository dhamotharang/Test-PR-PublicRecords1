import risk_indicators;

export GongHistoryLayouts := MODULE


export Layout_fcragongslim := record
	unsigned6 adl;
	unsigned6 hhid;
	string20  name_first;
	string20  name_middle;
	string20  name_last;
	string65  address;
	string25  p_city_name;
	string2   st;
	string5   z5;
	string4   z4;
	string10  phone10;
	string1		omit_address;
	string1		omit_phone;
	string1		omit_locality;
	string1   listing_type_bus;
	string1   listing_type_res;
	string1   listing_type_gov;
	string1   publish_code;
	string8   dt_first_seen;
	string8   dt_last_seen;
end;


export Layout_GongHistoryFCRA := RECORD
	string30 account_number;
	Layout_fcragongslim gong;
END;


export Layout_GongHistoryFCRAout := record, maxlength(25000)
	string30 account_number;
	dataset(Layout_fcragongslim) gong;
	unsigned1 gongcount;
end;


export Layout_TestSeed := RECORD
	string20 dataset_name;
	string30 acctNo;
	string15 fname;
	string20 lname;
	string9  zip;
	string9  ssn;
	string10 hphone;
	Layout_GongHistoryFCRA;
end;

END;