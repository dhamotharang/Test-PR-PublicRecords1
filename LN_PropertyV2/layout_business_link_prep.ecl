IMPORT Business_Header;

EXPORT layout_business_link_prep := RECORD
	Business_Header.Layout_Business_Linking.Company_;
	STRING5		title;
	STRING20	fname;
	STRING20	mname;
	STRING20	lname;
	STRING5		name_suffix;
	STRING3		partial_interest_transferred;
	STRING2		source_code;
	STRING12	ln_fares_id;
END;