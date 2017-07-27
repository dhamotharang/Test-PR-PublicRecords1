EXPORT PersonByCompany_BatchService_Layouts := MODULE

	EXPORT Input := RECORD
		STRING20   acctno;
		qSTRING5   title;
		qSTRING20  fname;
		qSTRING20  mname;
		qSTRING20  lname;
		qSTRING5   suffix;
		qSTRING10  prim_range;
		qSTRING2   predir;
		qSTRING28  prim_name;
		qSTRING4   addr_suffix;
		qSTRING2   postdir;
		qSTRING10  unit_desig;
		qSTRING8   sec_range;
		qSTRING25  p_city_name;
		qSTRING2   st;
		qSTRING5   z5;
		qSTRING4   zip4;
		qSTRING9   ssn;
		qSTRING8   dob;
		qSTRING16  phone;
		qSTRING120 email;
		qSTRING120 bureau_company_name;
		qSTRING120 client_company_name;
	END;
	
	EXPORT Final := RECORD
		STRING20  acctno;
		BOOLEAN   from_phone;
		BOOLEAN   from_email;
		BOOLEAN   from_paw;
		BOOLEAN   from_bureau_name;
		BOOLEAN   from_client_name;
		STRING120 company_name;
		STRING10  prim_range;
		STRING2   predir;
		STRING28  prim_name;
		STRING4   addr_suffix;
		STRING2   postdir;
		STRING10  unit_desig;
		STRING8   sec_range;
		STRING25  city;
		STRING2   state;
		STRING5   zip;
		STRING4   zip4;
		STRING10  phone;
		STRING9   fein;
	END;

END;
