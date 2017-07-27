UCC_Filings := UCC.File_UCC_Filing_Events;

Layout_UCC_Slim := RECORD
STRING2  file_state;
END;

Layout_UCC_Slim SlimUCC(UCC.Layout_UCC_Event L) := TRANSFORM
SELF := L;
END;

UCC_Slim := PROJECT(UCC_Filings, SlimUCC(LEFT));

Layout_UCC_Stat := RECORD
UCC_Slim.file_state;
reccnt := COUNT(GROUP);
END;

UCC_Stat := TABLE(UCC_Slim, Layout_UCC_Stat, file_state, FEW);

OUTPUT(UCC_Stat);