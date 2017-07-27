IMPORT ut;

Layout_Business_Contacts_Temp TakeHdrContact(Layout_Business_Contacts_Temp r) := TRANSFORM
	SELF := r;
END;

// Take only the equifax employer records for which we have no matching
// business contacts.
New_Eq_Contacts := JOIN(
		DISTRIBUTE(BC_DID(did != 0), HASH(did)), 
		DISTRIBUTE(Eq_Contacts, HASH(did)),
	LEFT.did = RIGHT.did AND
	(
	 (LEFT.bdid = RIGHT.bdid AND LEFT.bdid != 0) OR
	 ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) < 10
	), TakeHdrContact(RIGHT), RIGHT ONLY, LOCAL);

Business_Contacts_With_Eq := BC_DID
			 + New_Eq_Contacts;

Business_Contacts_With_Eq_Dist := 
	DISTRIBUTE(Business_Contacts_With_Eq(bdid != 0), HASH(bdid));

// Take only the header contacts for which we have no matching business contact
New_Header_Contacts := JOIN(
		Business_Contacts_With_Eq_Dist, 
		DISTRIBUTE(Header_Contacts, HASH(bdid)),
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
Emps := Business_Contacts_With_Eq 
			+ New_Header_Contacts;

ut.MAC_Sequence_Records(Emps, uid, Emps_Seq)

EXPORT BC_Extra := Emps_Seq : PERSIST('TEMP::BC_Extra');