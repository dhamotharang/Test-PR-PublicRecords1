import autokeyB2;

export Proc_Build_AutoKeys(string filedate) := function

		c := GSA.Constants(filedate);
		ak_dataset := c.ak_dataset;
		ak_keyname := c.ak_keyname; // @version@
		ak_logical := c.ak_logical;
		ak_skipSet := c.ak_skipSet;
		ak_typeStr := c.ak_typeStr;

AutokeyB2.MAC_Build(ak_dataset,fname,mname,lname,
					blank, //ssn
					zero,  //dob
					zero,  //phone
					prim_name, prim_range, st, v_city_name, zip5, sec_range,
					zero,  //inStates
					zero,zero,zero,   //lname 1-3
					zero,zero,zero,   //city  1-3
					zero,zero,zero,   //rel fname 1-3
					zero,  //lookups				 
					did,
					//peron above, business below
					name,
					zero,  //fein, tax-id
					zero,  //phone
					prim_name, prim_range, st, v_city_name, zip5, sec_range,
					bdid,
					ak_keyname,
					ak_logical,
					build_auto_keys,
					false,  //diffing sets the UPDATE option during BUILDINDEX().
					ak_skipSet,
					true,  //use FakeIDs
					ak_typeStr,
					true,   //useOnlyRecordIDs
					,,zero); 
	
AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname,moveToQA);
	
akeys := sequential(build_auto_keys,
					moveToQA);
																		 
return akeys;														

end;
