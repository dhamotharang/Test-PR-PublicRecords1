IMPORT ut, DID_Add, didville, header_slimsort, fair_isaac, business_headerv2, header;

EXPORT BC_DID(
	
	 dataset(Layout_Business_Contacts_Temp)	pBc_init									= bc_init()
	,string																	pPersistname							= persistnames().BCDID
	,boolean																pShouldDoDidPatch					= true
	,boolean																pShouldRecalculatePersist	= true													


) :=
function

// Slim the Business Contacts for the DID process
Layout_Contact_Match InitContactsMatch(Layout_Business_Contacts_Temp L) := TRANSFORM
SELF.phone := (QSTRING10)IF(L.phone <> 0, INTFORMAT(L.phone, 10, 1), '');
SELF.ssn := (QSTRING9)IF(L.ssn <> 0, INTFORMAT(L.ssn, 9, 1), '');
SELF.zip := (QSTRING5)IF(L.zip <> 0, INTFORMAT(L.zip, 5, 1), '');
SELF := L;
END;

Business_Contacts_Match_Init := PROJECT(pBc_init, InitContactsMatch(LEFT));

// DID using the Flex Macro
Business_Contact_Matchset := ['A','S','P'];

// DID using the contact name, contact address
DID_Add.MAC_Match_Flex(
	 Business_Contacts_Match_Init, 
	 Business_Contact_Matchset,
	 ssn
	 ,NONE
	 ,fname
	 ,mname
	 ,lname
	 , name_suffix, 
	 prim_range
	 , prim_name
	 , sec_range
	 , zip
	 , state
	 , phone, 
	 did,
	 Layout_Contact_Match, 
	 TRUE
	 , did_score, 
     75,  //low score threshold
	 Business_Contacts_DID_orig
)

Business_HeaderV2.macFix_Contact_DIDs(
	 Business_Contacts_DID_orig
	,did
	,lname
	,true
	,did_score
	,true
	,true
	,ssn
	,Business_Contacts_DID_patched
);

business_contacts_did := if(pShouldDoDidPatch = true	,Business_Contacts_DID_patched
																											,Business_Contacts_DID_orig
													);
// Dedup by Unique ID
Business_Contacts_DID_Dist := DISTRIBUTE(Business_Contacts_DID, HASH(uid));
Business_Contacts_DID_Sort := SORT(Business_Contacts_DID_Dist, uid, -did_score, LOCAL);
Business_Contacts_DID_Dedup := DEDUP(Business_Contacts_DID_Sort, uid, LOCAL);

// Assign the DID's back based on unique id.
Layout_Business_Contacts_Temp AssignDID(pBC_Init l, Business_Contacts_DID_Dedup r) := TRANSFORM
	SELF.did := r.did;
	self.ssn := (unsigned4)r.ssn;
	SELF.contact_score := IF(r.did = 0, 1, 2 + IF(r.did_score > 95, 3, 2));
	SELF := l;
END;

Business_Contacts_With_DID := JOIN(pBC_Init, Business_Contacts_DID_Dedup,
		LEFT.uid = RIGHT.uid, AssignDID(LEFT, RIGHT), HASH)
		 : PERSIST(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, Business_Contacts_With_DID
																										, persists().BCDID
									);
return returndataset;

end;