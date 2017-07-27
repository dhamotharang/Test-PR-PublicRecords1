Old_UCC_Expanded_Filing := DATASET('~thor_data400::BASE::UCC_Filing_20020514', UCC.Layout_UCC_Expanded_Filing, THOR, unsorted);
New_UCC_Expanded_Filing := DATASET('~thor_data400::IN::ucc_filing_upd20020625_NC_fix2', UCC.Layout_UCC_Expanded_Filing, THOR, unsorted);

Layout_UCC_Slim := RECORD
STRING2  file_state;
STRING18 orig_filing_num;
STRING8  filing_date;
STRING4  filing_type;
STRING18 document_num;
END;

Layout_UCC_Slim SlimUCC(UCC.Layout_UCC_Expanded_Filing L) := TRANSFORM
SELF := L;
END;

Old_UCC_Slim := PROJECT(Old_UCC_Expanded_Filing(file_state='NC'), SlimUCC(LEFT));
Old_UCC_Slim_Dedup := DEDUP(Old_UCC_Slim, file_state, orig_filing_num, filing_date, filing_type, document_num, ALL);
COUNT(Old_UCC_Slim_Dedup);

New_UCC_Slim := PROJECT(New_UCC_Expanded_Filing(file_state='NC'), SlimUCC(LEFT));
New_UCC_Slim_Dedup := DEDUP(New_UCC_Slim, file_state, orig_filing_num, filing_date, filing_type, document_num, ALL);
COUNT(New_UCC_Slim_Dedup);

// Join old and new
Old_UCC_Slim_Dedup_Dist := DISTRIBUTE(Old_UCC_Slim_Dedup, HASH(file_state, orig_filing_num, filing_date));
New_UCC_Slim_Dedup_Dist := DISTRIBUTE(New_UCC_Slim_Dedup, HASH(file_state, orig_filing_num, filing_date));


Layout_UCC_Slim MatchOldNew(Layout_UCC_Slim L, Layout_UCC_Slim R) := TRANSFORM
SELF := L;
END;

Old_UCC_Missing := JOIN(Old_UCC_Slim_Dedup_Dist,
                        New_UCC_Slim_Dedup_Dist,
                        LEFT.file_state = RIGHT.file_state AND
                         LEFT.orig_filing_num = RIGHT.orig_filing_num AND
                         LEFT.filing_date = RIGHT.filing_date AND
                         LEFT.filing_type = RIGHT.filing_type AND
                         LEFT.document_num = RIGHT.document_num,
                        MatchOldNew(LEFT, RIGHT),
                        LEFT ONLY,
                        LOCAL);

COUNT(Old_UCC_Missing);
OUTPUT(Old_UCC_Missing,,'TMTEMP::UCC_Missing');