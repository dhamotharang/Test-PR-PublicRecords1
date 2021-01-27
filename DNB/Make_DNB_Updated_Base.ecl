import ut, did_add;

#workunit('name', 'D&B Companies/Contacts Update ' + DNB.version);

// Output updated Companies base file
//output(DNB.DNB_Updated_Companies,,'BASE::DNB_Companies_' + DNB.version, overwrite);
ut.MAC_SF_BuildProcess(dnb.dnb_updated_companies,'~thor_data400::base::dnb_companies',do1,2);

// Output updated Contacts base file
dnb_contacts := DNB.DNB_Updated_Contacts;
dnb_matchset := ['A','P'];

// did the contacts
did_add.MAC_Match_Flex(dnb_contacts, dnb_matchset,						//see above
	 ssn_field, dob_field, fname, mname,lname, name_suffix,
	 company_prim_range, company_prim_name, company_sec_range, company_zip, company_st, company_phone10, //year_of_residence_field, not ready for release yet
	 did,
	 DNB.Layout_DNB_Contacts_Base,
	 false, DID_Score_field,	//these should default to zero in definition
	 75,	//dids with a score below here will be dropped
	 dnb_contacts_did)

count(dnb_contacts_did(did > 0));

//output(dnb_contacts_did,,'BASE::DNB_Contacts_' + DNB.version,overwrite);
ut.MAC_SF_BuildProcess(dnb_contacts_did,'~thor_data400::base::dnb_contacts',do2,2);

sequential(do1,do2);
