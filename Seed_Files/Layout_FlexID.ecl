import iesp;

export Layout_FlexID := RECORD
	string20 dataset_name;
	string30 acctNo;
	string20 fname;
	string20 lname;
	string5 zipCode;
	string9 ssn;
	string10 phone10;
	iesp.flexid.t_VerifiedElementSummary - DOBMatchLevel VerifiedElementSummary;	// already has this field in the CIID test seed results
	iesp.flexid.t_ValidElementSummary  ValidElementSummary ;
	string9 VerifiedSSN;
END;