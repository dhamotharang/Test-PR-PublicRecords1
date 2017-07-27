UCC_Filings := UCC.File_UCC_Expanded_Filing;

Layout_UCC_Slim := RECORD
STRING2  file_state;
STRING6 filing_date;  //YYYYMM
END;

Layout_UCC_Slim SlimUCC(UCC.Layout_UCC_Expanded_Filing L) := TRANSFORM
SELF := L;
END;

UCC_Slim := PROJECT(UCC_Filings, SlimUCC(LEFT));

Layout_UCC_Stat := RECORD
UCC_Slim.file_state;
UCC_Slim.filing_date;
reccnt := COUNT(GROUP);
END;

UCC_Stat := TABLE(UCC_Slim, Layout_UCC_Stat, file_state, filing_date);

OUTPUT(CHOOSEN(UCC_Stat, 0));