import DID_Add, ut;

raw := FBN_enhance1;

matchset := ['S','A','P'];
did_Add.MAC_Match_Flex
	(raw, matchset,						//see above
	 fed_tax_id, dob, fname, mname,lname, suffix,
	 prim_range, prim_name, sec_range, zip5, st, phone10, //year_of_residence_field, not ready for release yet
	 did,   			//if bool = false, then put junk in corresponding _field
	 FBN.Layout_FBN,
	 false, DID_Score_field,	//these should default to zero in definition
	 75,	//dids with a score below here will be dropped
	 wdid)


did_add.MAC_Add_SSN_By_DID(wdid, did, new_fed_tax_id, wdid_ssn_out)

EXPORT FBN_enhance2 := wdid_ssn_out : PERSIST('FBN::FBN_enhance2');
