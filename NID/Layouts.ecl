export Layouts := MODULE

	/**************************************************************************************
	 ** Layout of Name Cache
	 **************************************************************************************/
	export	rNameCache
	 :=
		record
			Common.xNID				NID := 0;
			unsigned1				derivation := 0;	// 0=original name, 1,2 = derived names
			string1					NameType;	// Business, Personal, Dual, Unknown
			Common.xNameString		Name := '';
			string20				fname;
			string20				mname;
			string20				lname;
			string5					suffix;
			string1					gender;
			string5					cln_title;
			string20				cln_fname;
			string20				cln_mname;
			string20				cln_lname;
			string5					cln_suffix;
			string5					cln_title2;
			string20				cln_fname2;
			string20				cln_mname2;
			string20				cln_lname2;
			string5					cln_suffix2;
		end
	 ;

	// the following layout is used for internal testing
	export rNameExtended := RECORD
		rNameCache;
		string12	fmt;
		string3		quality;
		string3		extension;
	END;


END;