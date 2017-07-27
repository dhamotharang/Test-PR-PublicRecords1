IMPORT Header, Header_Slimsort, didville, ut, DID_Add, Companies;

#workunit('name', 'Corporate Contacts Reset DID ' + corporate.Corp4_Reset_Date);

Layout_Contact_Seq := RECORD
UNSIGNED6 uid := 0;
UNSIGNED6 bdid;
Corporate.Layout_Corp_Contacts_Base;
END;

Layout_Contact_Seq InitContacts(Corporate.Layout_Corp_Contacts_DID L) := TRANSFORM
SELF := L;
END;

Corp_Contacts_Init := PROJECT(Corporate.File_Corp4_Contacts_Base_DID, InitContacts(LEFT));
COUNT(Corp_Contacts_Init);

// Assign a unique sequence number to the contact records
ut.MAC_Sequence_Records(Corp_Contacts_Init, uid, Corp_Contacts_Init_Seq)

// Project Contacts to Slim Match Layout
Layout_Contact_Match := RECORD
UNSIGNED6 uid;
UNSIGNED6 did := 0;               // Regular did
UNSIGNED1 did_score := 0;         // Regular did score
string2   state_origin;
string32  sos_ter_nbr;
string20  fname;
string20  mname;
string100  lname;
string5   name_suffix;
string10  prim_range;
string28  prim_name;
string8   sec_range;
string5   zip5;
string2   state;
END;

Layout_Contact_Match InitContactMatch(Layout_Contact_Seq L) := TRANSFORM
SELF := L;
END;

Corp_Contacts_Match_Init := PROJECT(Corp_Contacts_Init_Seq, InitContactMatch(LEFT));
COUNT(Corp_Contacts_Match_Init);

// Combine with Company Records using Company Current Address
Corp_Companies_Dist := DISTRIBUTE(Corporate.File_Corp4_Base, HASH(TRIM(state_origin), TRIM(sos_ter_nbr)));
Corp_Contacts_Match_Init_Dist := DISTRIBUTE(Corp_Contacts_Match_Init, HASH(TRIM(state_origin), TRIM(sos_ter_nbr)));

Layout_Contact_Match MatchContactToCompany(Corporate.Layout_Corporate_Base L, Layout_Contact_Match R, INTEGER1 addr_type) := TRANSFORM
SELF.prim_range := CHOOSE(addr_type, L.prim_range, L.prior_prim_range);
SELF.prim_name := CHOOSE(addr_type, L.prim_name, L.prior_prim_name);
SELF.sec_range := CHOOSE(addr_type, L.sec_range, L.prior_sec_range);
SELF.zip5 := CHOOSE(addr_type, L.zip5, L.prior_zip5);
SELF := R;
END;

Corp_Contacts_CompAddrCurrent := JOIN(Corp_Companies_Dist((INTEGER)zip5 <> 0, prim_name <> ''),
                                      Corp_Contacts_Match_Init_Dist,
                                      LEFT.state_origin = RIGHT.state_origin AND
                                      LEFT.sos_ter_nbr = RIGHT.sos_ter_nbr,
                                      MatchContactToCompany(LEFT, RIGHT, 1),
                                      LOCAL);

Corp_Contacts_CompAddrPrior := JOIN(Corp_Companies_Dist((INTEGER)prior_zip5 <> 0, prior_prim_name <> ''),
                                      Corp_Contacts_Match_Init_Dist,
                                      LEFT.state_origin = RIGHT.state_origin AND
                                      LEFT.sos_ter_nbr = RIGHT.sos_ter_nbr,
                                      MatchContactToCompany(LEFT, RIGHT, 2),
                                      LOCAL);

Corp_Contacts_Match_Combined := Corp_Contacts_Match_Init + Corp_Contacts_CompAddrCurrent + Corp_Contacts_CompAddrPrior;

// Match to Headers by Name and Address
Corp_Matchset := ['A'];

DID_Add.MAC_Match_Flex(Corp_Contacts_Match_Combined, Corp_Matchset,
	 ssn_field, dob_field, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, state, phone_field,
	 did,
	 Layout_Contact_Match, 
	 TRUE, did_score,
	 75,
	 Corp_Contacts_Match_DID)

Corp_Contacts_Match_DID_Dist := DISTRIBUTE(Corp_Contacts_Match_DID, HASH(uid));
Corp_Contacts_Match_DID_Sort := SORT(Corp_Contacts_Match_DID_Dist, uid, -did_score, LOCAL);
Corp_Contacts_Match_DID_Dedup := DEDUP(Corp_Contacts_Match_DID_Sort, uid, LOCAL);

COUNT(Corp_Contacts_Match_DID_Dedup);
COUNT(Corp_Contacts_Match_DID_Dedup(did<>0));

// Assign DIDs
Corp_Contacts_Init_Dist := DISTRIBUTE(Corp_Contacts_Init_Seq, HASH(uid));

Corporate.Layout_Corp_Contacts_DID AssignDIDs(Layout_Contact_Seq L, Layout_Contact_Match R) := TRANSFORM
SELF.did := R.did;
SELF := L;
END;

Corp_Contacts_DID := JOIN(Corp_Contacts_Init_Dist,
                          Corp_Contacts_Match_DID_Dedup,
                          LEFT.uid = RIGHT.uid,
                          AssignDIDs(LEFT, RIGHT),
                          LOCAL);

                          
OUTPUT(Corp_Contacts_DID,,'BASE::Corp4_Contacts_DID_' + Corporate.Corp4_Reset_Date, OVERWRITE);

// Copy Existing Corp4 Base file using reset date
OUTPUT(Corporate.File_Corp4_Base,,'BASE::Corp4_' + Corporate.Corp4_Reset_Date, OVERWRITE);