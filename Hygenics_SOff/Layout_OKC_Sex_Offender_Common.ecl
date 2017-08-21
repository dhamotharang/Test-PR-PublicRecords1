import SexOffender, Address;

export Layout_OKC_Sex_Offender_Common := module

export prep  := record
	string8 	dt_first_reported;
	string8 	dt_last_reported;
	string60 	seisint_primary_key;
	unsigned8  	key;
	string2 	vendor_code;
	string1   	name_format;
	Hygenics_SOff.Layout_OKC_Fixed_Altered;
	string100 	append_Prep_Address1;
	string50 	append_Prep_Address2;
	unsigned8 	append_Rawaid;
end;

export interim := record
	string8 	dt_first_reported;
	string8 	dt_last_reported;
	string60 	seisint_primary_key;
	unsigned8  	key;
	string2 	vendor_code;
	string1   	name_format;
	Hygenics_SOff.Layout_OKC_Fixed_Altered;
	address.Layout_Clean182;
	unsigned8 	append_rawaid;
end;

export final := record
	string8 	dt_first_reported;
	string8 	dt_last_reported;
	string60 	seisint_primary_key;
	unsigned8  	key;
	string2 	vendor_code;
	string1   	name_type;
	Hygenics_SOff.Layout_OKC_Sex_Offender_Fixed;
	string5  title;
	string20 fname;
	string20 mname;
	string20 lname;
	string5  name_suffix;
	unsigned8 nid;
	string1  ntype;
	unsigned2 nindicator;
	address.Layout_Clean182;
	unsigned8 	rawaid;
	unsigned8 offender_persistent_id;
	unsigned8 offense_persistent_id;
end;

end;