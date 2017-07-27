IMPORT ut;

//************************************************************************
// Create UCC Debtor and Secured/Assignee Temps for Initial Filing Event
//************************************************************************

// Add Unique Record ID to UCC Party File, Initialize Current Flag
UCC.Layout_UCC_Initial_Party_Master InitInitialPartyMaster(UCC.Layout_UCC_Expanded_Party L) := TRANSFORM
SELF.RecordID := 0;
SELF.BDID := 0;
SELF.current_flag := 'N';
SELF := L;
END;

UCC_Initial_Party_Master_Init := PROJECT(UCC.UCC_Updated_Party_Fixed, InitInitialPartyMaster(LEFT));

// Set Unique Record IDs For Source File
UT.MAC_Sequence_Records(UCC_Initial_Party_Master_Init,RecordID,UCC_Initial_Party_Master_Seq)

//Filter out header record if any
UCC_Initial_Party_Master :=  UCC_Initial_Party_Master_Seq(NOT(RecordID=1 AND Stringlib.StringFind(orig_filing_num, 'INDAR',1)<>0));

UCC_Parties_Dist := DISTRIBUTE(UCC_Initial_Party_Master(UCC.Check_Valid_State_Filing_Date(file_state, fk_filing_date)),
                               HASH(file_state, orig_filing_num));


// Project to slim record
Layout_Parties_Slim := RECORD
INTEGER8 RecordID;         // Unique Record Identifier in UCC Party File
STRING2   file_state;
STRING8   contrib_num;
STRING18  orig_filing_num;
STRING1   party_type;
STRING10  prim_range;
STRING28  prim_name;
STRING8   sec_range;
STRING5   zip5;
STRING4   zip4;
STRING10  ssn;
STRING200 name;
STRING4   fk_filing_type;
STRING8   fk_filing_date;
STRING8   fk_orig_filing_date;
STRING18  fk_document_num;
STRING1 event_flag;
END;

Layout_Parties_Slim SlimUCCPartiesRecord(UCC.Layout_UCC_Initial_Party_Master L) := TRANSFORM
SELF.name := ut.CleanCompany(L.name);  // Use Clean Company Name for Determining Adds and Drops
SELF := L;
END;

UCC_Parties_Slim_Dist := PROJECT(UCC_Parties_Dist, SlimUCCPartiesRecord(LEFT));
COUNT(UCC_Parties_Slim_Dist);

// Sort and group parties by original filing number and file state.  Grouping makes
// the series of sorts and dedups more efficient
UCC_Parties_Slim_Sort_1 := SORT(UCC_Parties_Slim_Dist, file_state, orig_filing_num, LOCAL);
UCC_Parties_Slim_Grpd := GROUP(UCC_Parties_Slim_Sort_1, file_state, orig_filing_num, LOCAL);

// Dedup to get Initial Filing Events from Parties
// Insure blank filing types are sorted last within the filing date
UCC_Parties_Sort_1 := SORT(UCC_Parties_Slim_Grpd, fk_filing_date, IF(fk_filing_type<>'', 0, 1),
                             fk_filing_type);

// First dedup will keep all party records associated with the initial filing date and type
UCC_Parties_Dedup_1 := DEDUP(UCC_Parties_Sort_1,
                             (LEFT.fk_filing_date <> RIGHT.fk_filing_date OR
                              LEFT.fk_filing_type <> RIGHT.fk_filing_type));

COUNT(UCC_Parties_Dedup_1);

// Second dedup discards multiple party type - name address combinations which result
// from multiple contributors or document filings and keep lowest numbered
// document and contributor with an ssn.  Keep unique addresses.  Keep records with SSN.
UCC_Parties_Sort_2 := SORT(UCC_Parties_Dedup_1, party_type, name,
                             zip5, prim_range, prim_name, IF(ssn<> '', 0, 1), fk_document_num, contrib_num);
UCC_Parties_Dedup_2 := DEDUP(UCC_Parties_Sort_2, party_type, name, zip5, prim_range, prim_name);

COUNT(UCC_Parties_Dedup_2);

// Third dedup discards blank addresses where name exists with an address
UCC_Parties_Sort_3 := SORT(UCC_Parties_Dedup_2, party_type, name, IF(zip5 <> '', 0, 1));

UCC_Initial_Parties := GROUP(DEDUP(UCC_Parties_Sort_3,
                             LEFT.party_type = RIGHT.party_type AND
                             LEFT.name = RIGHT.name AND
                             RIGHT.zip5 = ''));


COUNT(UCC_Initial_Parties);

// Join Initial Parties to set event flag to original
Layout_Parties_Slim SetOriginalEvent(Layout_Parties_Slim L, Layout_Parties_Slim R) := TRANSFORM
SELF.event_flag := IF(R.RecordID <> 0, 'O', L.event_flag);
SELF := L;
END;

UCC_Parties := JOIN(UCC_Parties_Slim_Dist,
                    UCC_Initial_Parties,
                    LEFT.RecordID = RIGHT.RecordID,
                    SetOriginalEvent(LEFT, RIGHT),
                    LEFT OUTER,
                    LOCAL);

COUNT(UCC_Parties);

// Group to determine new and changed parties
UCC_Parties_Sort := SORT(UCC_Parties, file_state, orig_filing_num, party_type, name,
                           -event_flag, fk_filing_date, LOCAL);
UCC_Parties_Grpd := GROUP(UCC_Parties_Sort, file_state, orig_filing_num, party_type, name, LOCAL);

// Iterate to set event flag
Layout_Parties_Slim UpdateEventFlag(Layout_Parties_Slim L, Layout_Parties_Slim R) := TRANSFORM
SELF.event_flag := MAP(L.RecordID = 0 AND R.event_flag = '' => 'N',
                       L.RecordID <> 0 AND R.event_flag = '' AND
                       ((L.prim_range <> R.prim_range AND R.prim_range <> '') OR
                        (L.prim_name <> R.prim_name AND R.prim_name <> '') OR
                        (L.sec_range <> R.sec_range AND R.sec_range <> '') OR
                        (L.zip5 <> R.zip5 AND R.zip5 <> '') OR
                        (L.zip4 <> R.zip4 AND R.zip4 <> '')) => 'C',
                       R.event_flag);
SELF := R;
END;

UCC_Parties_Events := GROUP(ITERATE(UCC_Parties_Grpd, UpdateEventFlag(LEFT, RIGHT)));

COUNT(UCC_Parties_Events(event_flag='N'));
COUNT(UCC_Parties_Events(event_flag='C'));

// Join Changed Partes to Original Parties and keep only changes where
// name and address does not match an Original party.  Need to do this because
// Original parties can contain same name with a different address
Layout_Parties_Slim ReduceChanges(Layout_Parties_Slim L, Layout_Parties_Slim R) := TRANSFORM
SELF := R;
END;

UCC_Parties_Changes := JOIN(UCC_Parties_Events(event_flag = 'O'),
                            UCC_Parties_Events(event_flag = 'C'),
                            LEFT.file_state = RIGHT.file_state AND
                              LEFT.orig_filing_num = RIGHT.orig_filing_num AND
                              LEFT.party_type = RIGHT.party_type AND
                              LEFT.name = RIGHT.name AND
                              LEFT.zip5 = RIGHT.zip5 AND
                              LEFT.prim_range = RIGHT.prim_range AND
                              LEFT.prim_name = RIGHT.prim_name,
                            ReduceChanges(LEFT, RIGHT),
                            RIGHT ONLY,
                            LOCAL);

COUNT(UCC_Parties_Changes);

// Dedup Changed Records by Name and Address in date order and keep only first
// matching change.  This cleans up where we started with more than one event
// on the initial date with same name and different addresses
UCC_Parties_Changes_Sort := SORT(UCC_Parties_Changes, file_state, orig_filing_num, party_type, name,
                                  prim_range, prim_name, zip5, fk_filing_date, LOCAL);

UCC_Parties_Changes_Dedup := DEDUP(UCC_Parties_Changes, file_state, orig_filing_num, party_type, name,
                                  prim_range, prim_name, zip5, LOCAL);

COUNT(UCC_Parties_Changes_Dedup);


// Combine Changes with Original and New Parties, discard any changes with blank zip5
UCC_Parties_Changes_Combined := UCC_Parties_Events(event_flag <> 'C') + UCC_Parties_Changes_Dedup(zip5 <> '');
                            

// Join to Full Record to Update Event Flag
UCC.Layout_UCC_Initial_Party_Master CopyEventFlag(UCC.Layout_UCC_Initial_Party_Master L, Layout_Parties_Slim R) := TRANSFORM
SELF.event_flag := R.event_flag;
SELF := L;
END;

UCC_Parties_Events_Full := JOIN(UCC_Parties_Dist,
                                UCC_Parties_Changes_Combined,
                                LEFT.RecordID = RIGHT.RecordId,
                                CopyEventFlag(LEFT, RIGHT),
                                LEFT OUTER,
                                LOCAL);

COUNT(UCC_Parties_Events_Full(event_flag<>''));

EXPORT UCC_Debtor_Secured_Temp := UCC_Parties_Events_Full(event_flag<>'') : PERSIST('TEMP::UCC_Debtor_Secured');