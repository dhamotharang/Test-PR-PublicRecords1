IMPORT ut;

//************************************************************************
// Create UCC Dropped Party Master
//************************************************************************

UCC_Parties_Dist := UCC.UCC_Parties_Sequenced;

Layout_UCC_Parties_Slim SlimUCCPartiesRecord(UCC.Layout_UCC_Initial_Party_Master L) := TRANSFORM
SELF.name := ut.CleanCompany(L.name);  // Use Clean Company Name for Determining Adds and Drops
SELF := L;
END;

UCC_Parties_Slim_Dist := PROJECT(UCC_Parties_Dist, SlimUCCPartiesRecord(LEFT));


// Join Last Parties to set event flag to last
Layout_UCC_Parties_Slim SetLastEvent(Layout_UCC_Parties_Slim L, Layout_UCC_Parties_Slim R) := TRANSFORM
SELF.event_flag := IF(R.RecordID <> 0, 'L', L.event_flag);
SELF := L;
END;

UCC_Parties := JOIN(UCC_Parties_Slim_Dist,
                    UCC.UCC_Last_Parties,
                    LEFT.RecordID = RIGHT.RecordID,
                    SetLastEvent(LEFT, RIGHT),
                    LEFT OUTER,
                    LOCAL);

COUNT(UCC_Parties);

// Group in reverse order to determine dropped parties
// A party that appears as new in reverse order had been dropped
UCC_Parties_Sort := SORT(UCC_Parties, file_state, orig_filing_num, party_type, name,
                          -event_flag, -fk_filing_date, LOCAL);
UCC_Parties_Grpd := GROUP(UCC_Parties_Sort, file_state, orig_filing_num, party_type, name, LOCAL);

// Iterate to set event flag
Layout_UCC_Parties_Slim UpdateEventFlag(Layout_UCC_Parties_Slim L, Layout_UCC_Parties_Slim R) := TRANSFORM
SELF.event_flag := MAP(L.RecordID = 0 AND R.event_flag = '' => 'D',
                       R.event_flag);
SELF := R;
END;

UCC_Parties_Events := GROUP(ITERATE(UCC_Parties_Grpd, UpdateEventFlag(LEFT, RIGHT)));

UCC_Parties_Dropped := UCC_Parties_Events(event_flag = 'D');
COUNT(UCC_Parties_Dropped);

// Join Dropped Parties to Events to get filing information where party was dropped
// Party could be dropped on same date but different filing type
UCC_Events_Dist := DISTRIBUTE(UCC.UCC_Filing_Events_Temp, HASH(file_state, orig_filing_num));

Layout_UCC_Parties_Slim CombineDropEvent(Layout_UCC_Parties_Slim L, UCC.Layout_UCC_Event R) := TRANSFORM
SELF.fk_filing_date := IF(R.filing_date <> '', R.filing_date, L.fk_filing_date);
SELF.contrib_num := IF(R.contrib_num1 <> '', R.contrib_num1, L.contrib_num);
SELF.fk_document_num := IF(R.document_num <> '', R.document_num, L.fk_document_num);
SELF := L;
END;

UCC_Parties_Dropped_Event := JOIN(UCC_Parties_Dropped,
                                  UCC_Events_Dist,
                                  LEFT.file_state = RIGHT.file_state AND
                                    LEFT.orig_filing_num = RIGHT.orig_filing_num AND
                                    LEFT.fk_filing_date < RIGHT.filing_date,
                                  CombineDropEvent(LEFT, RIGHT),
                                  LEFT OUTER,
                                  LOCAL);

UCC_Parties_Dropped_Event_Sort := SORT(UCC_Parties_Dropped_Event, RecordID, fk_filing_date, LOCAL);
UCC_Parties_Dropped_Event_Dedup := DEDUP(UCC_Parties_Dropped_Event_Sort, RecordID, LOCAL);

COUNT(UCC_Parties_Dropped_Event_Dedup);

// Join to Full Record to Create a Drop Record
UCC.Layout_UCC_Initial_Party_Master CopyEventFlag(UCC.Layout_UCC_Initial_Party_Master L, Layout_UCC_Parties_Slim R) := TRANSFORM
SELF.event_flag := R.event_flag;
SELF.contrib_num := R.contrib_num;
SELF.fk_document_num := R.fk_document_num;
SELF.fk_filing_date := R.fk_filing_date;
SELF := L;
END;

UCC_Parties_Dropped_Event_Full := JOIN(UCC_Parties_Dist,
                                       UCC_Parties_Dropped_Event_Dedup,
                                       LEFT.RecordID = RIGHT.RecordId,
                                       CopyEventFlag(LEFT, RIGHT),
                                       LOCAL);

COUNT(UCC_Parties_Dropped_Event_Full);

EXPORT UCC_Dropped_Parties := UCC_Parties_Dropped_Event_Full : PERSIST('TEMP::UCC_Dropped_Parties');