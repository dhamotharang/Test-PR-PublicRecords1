EXPORT Layout_UCC_Parties_Slim := RECORD
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