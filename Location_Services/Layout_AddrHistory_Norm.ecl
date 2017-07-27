import risk_indicators;

export Layout_AddrHistory_Norm := record, maxlength(200000)
	unsigned4	seq;
	string2	source; // 'B1', 'B2', 'S1', 'S2' == buyer/seller 1/2
	unsigned6	did;
	string20	fname;
	string20	mname;
	string20	lname;
	string5	name_suffix;
	dataset(layout_name) akas;
	string8	dob;
	unsigned1	age;
	string1	deceased;
	string8	DOD;
	unsigned1	ageAtDeath;
	string30	deathcounty;
	string2	deathstate;
	string10	deathverificationcode;
	dataset(layout_addr_search) Search_Addr;
	unsigned2	prop_owned;
	unsigned2	prop_sold;
	string8	prop_hist_Early_date;
	dataset(layout_address_hist) Current_Address;
	dataset(layout_address_hist) Address_History;
	dataset(layout_prop_owned) Current_Property;
	dataset(layout_prev_property) Previous_Property;
	dataset(layout_rel) related_subjects;
end;
