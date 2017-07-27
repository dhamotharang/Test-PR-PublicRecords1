EXPORT Layout_UCC_Initial_Party_Master := RECORD
INTEGER8 RecordID;         // Unique Record Identifier in UCC Party File
UNSIGNED6 BDID;            // Business DID
Layout_UCC_Expanded_Party;
STRING1 event_flag := '';  // 'O' - Original Filing Event
                           // 'N' - New Party Record for Event
                           // 'C' - Changed Record for Event
                           // 'D' - Dropped Record for Event
STRING1 current_flag;      // 'Y' - indicates party record is current (on latest filing)
END;