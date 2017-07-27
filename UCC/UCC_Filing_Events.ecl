IMPORT ut;

UCC_Master_Distributed := UCC.UCC_Parties_Combined;

// Update debtor change and secured change flags
UCC_Debtor_Master_Dist := UCC_Master_Distributed(party_type = 'D');
UCC_Secured_Master_Dist := UCC_Master_Distributed(party_type <> 'D');
UCC_Filing_Events_Dist := UCC.UCC_Filing_Events_Temp;

// Add unique record id to filing events
Layout_Filing_Event_Seq := RECORD
INTEGER8 RecordID;
UCC.Layout_UCC_Event;
END;

Layout_Filing_Event_Seq InitFilingEvents(UCC.Layout_UCC_Event L) := TRANSFORM
SELF.RecordID := 0;
SELF := L;
END;

UCC_Filing_Events_Init := PROJECT(UCC_Filing_Events_Dist, InitFilingEvents(LEFT));

UT.MAC_Sequence_Records(UCC_Filing_Events_Init, RecordID, UCC_Filing_Events_Seq)

COUNT(UCC_Filing_Events_Seq);

// Join filing events to debtor master adds, changes, and drops, to update debtor flag
Layout_Filing_Event_Seq UpdateDebtorChange(Layout_Filing_Event_Seq L, UCC.Layout_UCC_Initial_Party_Master R) := TRANSFORM
SELF.debtor_change := IF(R.RecordID <> 0, 'Y', L.debtor_change);
SELF := L;
END;

UCC_Filing_Events_Debtor := JOIN(UCC_Filing_Events_Seq,
                                 UCC_Debtor_Master_Dist(event_flag<>'O'),
                                 LEFT.file_state = RIGHT.file_state AND
                                   LEFT.orig_filing_num = RIGHT.orig_filing_num AND
                                   LEFT.orig_filing_date = RIGHT.fk_orig_filing_date AND
                                   LEFT.filing_date = RIGHT.fk_filing_date AND
                                   LEFT.filing_type = RIGHT.fk_filing_type AND
                                   LEFT.document_num = RIGHT.fk_document_num,
                                 UpdateDebtorChange(LEFT, RIGHT),
                                 LEFT OUTER,
                                 LOCAL);

COUNT(UCC_Filing_Events_Debtor);

UCC_Filing_Events_Debtor_Sort := SORT(UCC_Filing_Events_Debtor, RecordID, -debtor_change, LOCAL);
UCC_Filing_Events_Debtor_Dedup := DEDUP(UCC_Filing_Events_Debtor_Sort, RecordID, LOCAL);

COUNT(UCC_Filing_Events_Debtor_Dedup);
COUNT(UCC_Filing_Events_Debtor_Dedup(debtor_change='Y'));

// Join updated events to secured master adds, changes, and drops, to update secured flag
Layout_Filing_Event_Seq UpdateSecuredChange(Layout_Filing_Event_Seq L, UCC.Layout_UCC_Initial_Party_Master R) := TRANSFORM
SELF.secured_change := IF(R.RecordID <> 0, 'Y', L.secured_change);
SELF := L;
END;

UCC_Filing_Events_Secured := JOIN(UCC_Filing_Events_Debtor_Dedup,
                                  UCC_Secured_Master_Dist(event_flag<>'O'),
                                  LEFT.file_state = RIGHT.file_state AND
                                    LEFT.orig_filing_num = RIGHT.orig_filing_num AND
                                    LEFT.orig_filing_date = RIGHT.fk_orig_filing_date AND
                                    LEFT.filing_date = RIGHT.fk_filing_date AND
                                    LEFT.filing_type = RIGHT.fk_filing_type AND
                                    LEFT.document_num = RIGHT.fk_document_num,
                                  UpdateSecuredChange(LEFT, RIGHT),
                                  LEFT OUTER,
                                  LOCAL);

COUNT(UCC_Filing_Events_Secured);

UCC_Filing_Events_Secured_Sort := SORT(UCC_Filing_Events_Secured, RecordID, -secured_change, LOCAL);
UCC_Filing_Events_Secured_Dedup := DEDUP(UCC_Filing_Events_Secured_Sort, RecordID, LOCAL);

COUNT(UCC_Filing_Events_Secured_Dedup);
COUNT(UCC_Filing_Events_Secured_Dedup(secured_change='Y'));

// Create UCC Filing Events Master, Project to remove RecordID
UCC.Layout_UCC_Event RemoveRecordID(Layout_Filing_Event_Seq L) := TRANSFORM
SELF := L;
END;

EXPORT UCC_Filing_Events := PROJECT(UCC_Filing_Events_Secured_Dedup, RemoveRecordID(LEFT)) : PERSIST('TEMP::UCC_Filing_Events');