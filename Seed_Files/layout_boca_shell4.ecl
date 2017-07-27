import iesp, Risk_Indicators;

export layout_boca_shell4 := RECORD
	string20 dataset_name;
	string30 acctNo;
	string15 fname;
	string20 lname;
	string9  zip;
	string9  ssn;
	string10 hphone;
	
	Risk_Indicators.layout_bocashell_4temp;	
END;