import business_header;

export layout_business_prep := 
record
	Business_header.Layout_Business_Header;
	string5		title;
	string20	fname;
	string20	mname;
	string20	lname;
	string5		name_suffix;
	string2		source_code;
	string3		partial_interest_transferred;
end;
