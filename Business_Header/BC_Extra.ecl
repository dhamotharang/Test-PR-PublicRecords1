IMPORT ut, watchdog,business_headerv2;

EXPORT BC_Extra(
	 dataset(Layout_Business_Contacts_Temp)	pBc_Did										= bc_Did							()
	,dataset(Layout_Business_Contacts_Temp)	peq_contacts							= eq_contacts					()
	,dataset(Layout_Business_Contacts_Temp)	pHeader_Contacts					= Header_Contacts			()
	,dataset(Layout_Business_Contacts_Temp)	pPhonesPlus_Contacts			= PhonesPlus_Contacts	()
	,string																	pPersistname							= persistnames().BCExtra
	,boolean																pShouldRecalculatePersist	= true													

) := 
function

Layout_Business_Contacts_Temp TakeHdrContact(Layout_Business_Contacts_Temp r) := TRANSFORM
	SELF := r;
END;

// Take only the equifax employer records for which we have no matching
// business contacts.
New_Eq_Contacts := JOIN(
		DISTRIBUTE(pBC_DID(did != 0), HASH(did)), 
		DISTRIBUTE(peq_contacts, HASH(did)),
	LEFT.did = RIGHT.did AND
	(
	 (LEFT.bdid = RIGHT.bdid AND LEFT.bdid != 0) OR
	 ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) < 10
	), TakeHdrContact(RIGHT), RIGHT ONLY, LOCAL);

Business_Contacts_With_Eq := 	pBC_DID
														+ New_Eq_Contacts
														;

Business_Contacts_With_Eq_Dist := 
	DISTRIBUTE(Business_Contacts_With_Eq(bdid != 0), HASH(bdid));

// Take only the header contacts for which we have no matching business contact
New_Header_Contacts := JOIN(
		Business_Contacts_With_Eq_Dist, 
		DISTRIBUTE(pHeader_Contacts, HASH(bdid)),
	LEFT.bdid = RIGHT.bdid AND
	(
	 LEFT.did = RIGHT.did OR
	 (
		ut.NNEQ(LEFT.name_suffix, RIGHT.name_suffix) AND
		ut.NameMatch(	LEFT.fname, LEFT.mname, LEFT.lname,
						RIGHT.fname, RIGHT.mname, RIGHT.lname) < 2
	 )
	), TakeHdrContact(RIGHT), RIGHT ONLY, LOCAL);
	
Business_Contacts_With_Eq_header := Business_Contacts_With_Eq
			 + New_Header_Contacts;

Business_Contacts_With_Eq_header_Dist := 
	DISTRIBUTE(Business_Contacts_With_Eq_header(bdid != 0), HASH(bdid));

// Take only the PhonesPlus contacts for which we have no matching business contact
New_PhonesPlus_Contacts := JOIN(
		Business_Contacts_With_Eq_header_Dist, 
		DISTRIBUTE(pPhonesPlus_Contacts, HASH(bdid)),
	LEFT.bdid = RIGHT.bdid AND
	(
	 LEFT.did = RIGHT.did OR
	 (
		ut.NNEQ(LEFT.name_suffix, RIGHT.name_suffix) AND
		ut.NameMatch(	LEFT.fname, LEFT.mname, LEFT.lname,
						RIGHT.fname, RIGHT.mname, RIGHT.lname) < 2
	 )
	), TakeHdrContact(RIGHT), RIGHT ONLY, LOCAL);


// Combine with header contacts, and re-sequence.
Emps := Business_Contacts_With_Eq_header 
			+ New_PhonesPlus_Contacts;

ut.MAC_Sequence_Records(Emps, uid, Emps_Seq)

emps_seq_persist := Emps_Seq : PERSIST(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, emps_seq_persist
																										, persists().BCExtra
									);
return returndataset;

end;