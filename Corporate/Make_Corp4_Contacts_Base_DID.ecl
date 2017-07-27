IMPORT Header, Header_Slimsort, didville, ut, DID_Add, Companies;

#workunit('name', 'Corporate Contacts Base Creation ' + corporate.Corp4_Build_Date);

//**********************************************
// Add DIDs to Corp Contacts Base
//**********************************************

Layout_Contact_Seq := RECORD
UNSIGNED6 uid := 0;
Corporate.Layout_Corp_Contacts_Base;
END;

Layout_Contact_Seq InitContacts(Corporate.Layout_Corp_Contacts_Base L) := TRANSFORM
SELF := L;
END;

Corp_Contacts_Init := PROJECT(Corporate.Corp4_Contacts_Temp, InitContacts(LEFT));
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

// Workaround for local spill problem
Layout_Corp_Contacts_DID_Temp := RECORD
UNSIGNED6 uid;
Corporate.Layout_Corp_Contacts_DID;
END;

Layout_Corp_Contacts_DID_Temp AssignDIDs(Layout_Contact_Seq L, Layout_Contact_Match R) := TRANSFORM
SELF.bdid := 0;
SELF.did := R.did;
SELF := L;
END;

Corp_Contacts_DID := JOIN(Corp_Contacts_Init_Dist,
                          Corp_Contacts_Match_DID_Dedup,
                          LEFT.uid = RIGHT.uid,
                          AssignDIDs(LEFT, RIGHT),
                          LOCAL);

// Workaround for local spill problem
Corp_Contacts_DID_Dedup := DEDUP(Corp_Contacts_DID, uid, ALL);

// Determine if contact date range overlaps company date range
BOOLEAN ValidDateRange(STRING8 contact_dt_first_seen,
                       STRING8 contact_dt_last_seen,
                       STRING8 company_dt_first_seen,
                       STRING8 company_dt_last_seen) :=
    (contact_dt_first_seen >= company_dt_first_seen AND
        contact_dt_first_seen <= company_dt_last_seen) OR
    (contact_dt_last_seen >= company_dt_first_seen AND
        contact_dt_last_seen <= company_dt_last_seen) OR
    (company_dt_first_seen >= contact_dt_first_seen AND
        company_dt_last_seen <= contact_dt_last_seen);

// Assign BDIDs
Layout_Corp_BDID_List := RECORD
UNSIGNED6 bdid;
STRING2   state_origin;
STRING32  sos_ter_nbr;
STRING8   dt_first_seen;
STRING8   dt_last_seen;
END;

Layout_Corp_BDID_List InitBDIDList(Corporate.Layout_Corporate_Base L) := TRANSFORM
SELF := L;
END;

Corp_BDID_List_Init := PROJECT(Corporate.File_Corp4_Base(bdid <> 0, sos_ter_nbr <> ''), InitBDIDList(LEFT));

// Rollup dates by bdid, state of origin, and corporate charter
Corp_BDID_List_Dist := DISTRIBUTE(Corp_BDID_List_Init, HASH(state_origin, sos_ter_nbr));
Corp_BDID_List_Sort := SORT(Corp_BDID_List_Dist, state_origin, sos_ter_nbr, bdid, local);

Layout_Corp_BDID_List RollupBDIDList(Layout_Corp_BDID_List l, Layout_Corp_BDID_List r) := transform
self.dt_first_seen := map(l.dt_first_seen = ''
                           or (l.dt_first_seen <> '' and r.dt_first_seen <> '' and r.dt_first_seen < l.dt_first_seen) => r.dt_first_seen,
                          l.dt_first_seen);
self.dt_last_seen := map(l.dt_last_seen = ''
                           or (l.dt_last_seen <> '' and r.dt_last_seen <> '' AND r.dt_last_seen > l.dt_last_seen) => r.dt_last_seen,
                          l.dt_last_seen);
self := l;
end;

Corp_BDID_List_Rollup := ROLLUP(Corp_BDID_List_Sort,
                                LEFT.state_origin = RIGHT.state_origin AND
                                LEFT.sos_ter_nbr = RIGHT.sos_ter_nbr AND
                                LEFT.bdid = RIGHT.bdid,
                                RollupBDIDList(LEFT, RIGHT),
                                LOCAL);

// Assign New BDIDs
Corp_Contacts_DID_Dist := DISTRIBUTE(Corp_Contacts_DID_Dedup, HASH(state_origin, sos_ter_nbr));

Corporate.Layout_Corp_Contacts_DID AssignBDID(Layout_Corp_Contacts_DID_Temp L, Layout_Corp_BDID_List R) := TRANSFORM
SELF.bdid := R.bdid;
// Make sure contact dates match company dates
SELF.dt_first_seen := R.dt_first_seen;
SELF.dt_last_seen := R.dt_last_seen;
SELF := L;
END;

Corp_Contacts_BDID := JOIN(Corp_Contacts_DID_Dist,
                           Corp_BDID_List_Rollup,
                           LEFT.state_origin = RIGHT.state_origin AND
                             LEFT.sos_ter_nbr = RIGHT.sos_ter_nbr AND
                             ValidDateRange(LEFT.dt_first_seen,
                                            LEFT.dt_last_seen,
                                            RIGHT.dt_first_seen,
                                            RIGHT.dt_last_seen),
                           AssignBDID(LEFT, RIGHT),
                           LEFT OUTER,
                           LOCAL);
                           
OUTPUT(Corp_Contacts_BDID,,'BASE::Corp4_Contacts_DID_' + Corporate.Corp4_Build_Date, OVERWRITE);