import SexOffender, Address;

export Layout_OKC_Sex_Offender_Common := module

export prep  := record
	string8 	dt_first_reported;
	string8 	dt_last_reported;
	string16 	seisint_primary_key;
	unsigned8  	key;
	string2 	vendor_code;
	string1   	name_type;
	OKC_Sexual_Offenders.Layout_OKC_Fixed;
	string100 	append_Prep_Address1;
	string50 	append_Prep_Address2;
	unsigned8 	append_Rawaid;
end;

export interim := record
	string8 	dt_first_reported;
	string8 	dt_last_reported;
	string16 	seisint_primary_key;
	unsigned8  	key;
	string2 	vendor_code;
	string1   	name_type;
	OKC_Sexual_Offenders.Layout_OKC_Fixed;
	address.Layout_Clean182;
	unsigned8 	append_rawaid;
end;

export final := record
	string8 	dt_first_reported;
	string8 	dt_last_reported;
	string16 	seisint_primary_key;
	unsigned8  	key;
	string2 	vendor_code;
	string1   	name_type;
	OKC_Sexual_Offenders.Layout_OKC_Fixed;
	address.Layout_Clean_Name;
	address.Layout_Clean182;
	unsigned8 	rawaid;
end;

end;