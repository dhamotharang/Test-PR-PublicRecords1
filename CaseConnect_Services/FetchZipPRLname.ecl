IMPORT ut, doxie, autokey;

export FetchZipPRLname (String keyNameRoot, boolean workHard,boolean aNoFail = true) := function
		
	companyIdSet := Functions.getCompanyIdSet();

	doxie.MAC_Header_Field_Declare ();
		
	i := autokey.Key_ZipPRLName(keyNameRoot);
			
	AutoKey.layout_fetch xt(i r) := TRANSFORM
			SELF := r;
	END;
			
	lname_len := LENGTH(TRIM(lname_value));
			
	boolean HasZip					:= zip_value<>[]; 			//first keyed value
	boolean HasPR						:= prange_Value <> ''; //second keyed value
	boolean HasNoPN 				:= pname_value=''; 		//without a pname, you really need this search
			
	boolean HasEnoughLname 	:= lname_len >= 2;						//third keyed condition
	boolean HasNoFname			:= fname_value = '';		//if you do have fname, another search will find you

	//previous version behavior was "HasZip AND HasPR AND HasNoPN"
	// - so, the idea was that you need this search when you dont have any street info
	// - now, we realize that we often get partial street info and partial last name.  so, in that case you need this search too.
	// - if fname is present, we'll asssume for now that another search will be able to find you.  and partial lname usually comes in with no fname.
	f_raw := i(HasZip AND HasPR AND (HasNoPN or (HasEnoughLname and HasNoFname)), 
				keyed(zip IN zip_value), 
				keyed(prim_Range = prange_Value), 
				keyed(lname[1..lname_len] = lname_value),
				lookups in CompanyIdSet);

	f := project(f_raw, xt(LEFT));
			
	noFail := aNoFail;
					
	AutoKey.mac_Limits(f,f_ret);
			
	RETURN f_ret;
end;