IMPORT ut, DID_Add, didville, header_slimsort, fair_isaac;

// Slim the Business Contacts for the DID process
Layout_Contact_Match InitContactsMatch(Layout_Business_Contacts_Temp L) := TRANSFORM
SELF.phone := (QSTRING10)IF(L.phone <> 0, INTFORMAT(L.phone, 10, 1), '');
SELF.ssn := (QSTRING9)IF(L.ssn <> 0, INTFORMAT(L.ssn, 9, 1), '');
SELF.zip := (QSTRING5)IF(L.zip <> 0, INTFORMAT(L.zip, 5, 1), '');
SELF := L;
END;

Business_Contacts_Match_Init := PROJECT(BC_Init, InitContactsMatch(LEFT));

// DID using the Flex Macro
Business_Contact_Matchset := ['A','S','P'];

// DID using the contact name, contact address
DID_Add.MAC_Match_Flex(Business_Contacts_Match_Init, 
	 Business_Contact_Matchset,
	 ssn, NONE, fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, state, phone, 
	 did,
	 Layout_Contact_Match, 
	 TRUE, did_score, 
     75,  //low score threshold
	 Business_Contacts_DID)

// Dedup by Unique ID
Business_Contacts_DID_Dist := DISTRIBUTE(Business_Contacts_DID, HASH(uid));
Business_Contacts_DID_Sort := SORT(Business_Contacts_DID_Dist, uid, -did_score, LOCAL);
Business_Contacts_DID_Dedup := DEDUP(Business_Contacts_DID_Sort, uid, LOCAL);

// Assign the DID's back based on unique id.
Layout_Business_Contacts_Temp AssignDID(BC_Init l, Business_Contacts_DID_Dedup r) := TRANSFORM
	SELF.did := r.did;
	SELF.contact_score := IF(r.did = 0, 1, 2 + IF(r.did_score > 95, 3, 2));
	SELF := l;
END;

Business_Contacts_With_DID := JOIN(BC_Init, Business_Contacts_DID_Dedup,
		LEFT.uid = RIGHT.uid, AssignDID(LEFT, RIGHT), HASH);

EXPORT BC_DID := Business_Contacts_With_DID : PERSIST('TEMP::BC_DID');