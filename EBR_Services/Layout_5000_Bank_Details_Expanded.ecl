import ebr;

export Layout_5000_Bank_Details_Expanded :=
RECORD
	ebr.Layout_5000_Bank_Details_In;
	string4 timezone;
	string18 county_name := '';
END;