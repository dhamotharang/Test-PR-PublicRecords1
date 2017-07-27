import iesp;

export Layout_Boca_Shell := RECORD
	string20 dataset_name;
	string30 acctNo;
	string15 fname;
	string20 lname;
	string9  zip;
	string9  ssn;
	string10 hphone;
	string30 cmpy;
	
	iesp.bocashelliss.t_BocaShellISS;	

END;