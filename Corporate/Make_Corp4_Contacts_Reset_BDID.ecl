IMPORT  ut;

#workunit('name', 'Corporate Contacts Base Reset BDID ' + corporate.Corp4_Reset_Date);

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

Corp4_Reset_Base := DATASET('~thor_Data400::BASE::Corp4_' + Corporate.Corp4_Reset_Date, Corporate.Layout_Corporate_Base, THOR);

Corp_BDID_List_Init := PROJECT(Corp4_Reset_Base(bdid <> 0, sos_ter_nbr <> ''), InitBDIDList(LEFT));

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

// Assign new BDIDs
Corp_Contacts_DID_Dist := DISTRIBUTE(Corporate.File_Corp4_Contacts_Base_DID, HASH(state_origin, sos_ter_nbr));

Corporate.Layout_Corp_Contacts_DID AssignBDID(Corporate.Layout_Corp_Contacts_DID L, Layout_Corp_BDID_List R) := TRANSFORM
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
                           
                           
OUTPUT(Corp_Contacts_BDID,,'BASE::Corp4_Contacts_DID_' + Corporate.Corp4_Reset_Date, OVERWRITE);