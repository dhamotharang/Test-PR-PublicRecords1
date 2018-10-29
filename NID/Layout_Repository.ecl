export Layout_Repository := 
		record
			Common.xNID				NID := 0;
			unsigned2				nameind := 0;
			unsigned1				derivation := 0;	// 0=original name, 1,2 = derived names
			string1					NameType;	// Business, Personal, Dual, Unknown
			string120				Name := '';
			string40				fname;
			string40				mname;
			string60				lname;
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
		end;