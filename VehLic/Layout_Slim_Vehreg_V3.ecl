export layout_slim_vehreg_v3 := record
	unsigned4 	seq_no;
	integer2 		node := 0;
	string5 		rec_source;	//make this 'own_1'..'reg_2'
	string9 		FEID_SSN;
	string13 		DRIVER_LICENSE_NUMBER;
	string8 		DOB;
	string10 		prim_range;
	string28 		prim_name;
	string8 		sec_range;
     string2 		st;
	string5 		zip5;
	string20 		fname;
	string20 		mname;
	string20 		lname;
	string5 		name_suffix;
	string68		company_name;
	unsigned6		BDID := 0;
	unsigned6 	DID := 0;
	unsigned6 	preGLB_DID := 0;
	string9 		ssn := '';
end;