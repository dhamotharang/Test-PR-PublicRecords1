import ut, did_add;

#workunit('name', 'D&B Contacts Reset DID ' + DNB.DNB_Reset_Date);

dnb_contacts := DNB.File_DNB_Contacts_Base;

dnb_matchset := ['A','P'];

// Clear existing dids
typeof(dnb_contacts) InitDNBContacts(dnb_contacts l) := transform
self.did := 0;
self := l;
end;

dnb_contacts_init := project(dnb_contacts, InitDNBContacts(left));

// did the contacts
did_add.MAC_Match_Flex(dnb_contacts_init, dnb_matchset,						//see above
	 ssn_field, dob_field, fname, mname,lname, name_suffix,
	 company_prim_range, company_prim_name, company_sec_range, company_zip, company_st, company_phone10, //year_of_residence_field, not ready for release yet
	 did,
	 DNB.Layout_DNB_Contacts_Base,
	 false, DID_Score_field,	//these should default to zero in definition
	 75,	//dids with a score below here will be dropped
	 dnb_contacts_did)

//output(dnb_contacts_did,,'BASE::DNB_Contacts_' + DNB.DNB_Reset_Date, overwrite);
ut.MAC_SF_BuildProcess(dnb_contacts_did,'~thor_data400::base::dnb_contacts',do1,2);

// Copy current DNB Base file
//output(DNB.File_DNB_Base,,'BASE::DNB_Companies_' + DNB.DNB_Reset_Date, overwrite);

df := dnb.File_DNB_Base;

dfrec := record
	df;
end;

dfrec make_a_copy(df L) := transform
	self := L;
end;

df2 := project(df,make_a_copy(LEFT));

ut.MAC_SF_BuildProcess(df2,'~thor_data400::base::dnb_companies',do2,2);

sequential(do1,do2);
