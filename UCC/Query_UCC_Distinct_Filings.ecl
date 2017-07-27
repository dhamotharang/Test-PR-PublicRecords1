UCC_Filings := UCC.File_UCC_Expanded_Filing;

Layout_UCC_Slim := RECORD
STRING2  file_state;
STRING18 orig_filing_num;
END;

Layout_UCC_Slim SlimUCC(UCC.Layout_UCC_Expanded_Filing L) := TRANSFORM
SELF := L;
END;

UCC_Slim := PROJECT(UCC_Filings, SlimUCC(LEFT));
UCC_Slim_Dedup := DEDUP(UCC_Slim, file_state, orig_filing_num, ALL);

Layout_UCC_Stat := RECORD
UCC_Slim_Dedup.file_state;
reccnt := COUNT(GROUP);
END;

UCC_Stat := TABLE(UCC_Slim_Dedup, Layout_UCC_Stat, file_state, FEW);

OUTPUT(UCC_Stat);