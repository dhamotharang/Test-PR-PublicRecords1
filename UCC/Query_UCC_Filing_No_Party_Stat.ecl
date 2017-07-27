UCC_Summary := UCC.File_UCC_Filing_Summary;

Layout_UCC_Summary_Slim := RECORD
STRING2  file_state;
END;

Layout_UCC_Summary_Slim SlimUCCSummary(UCC.Layout_UCC_Filing_Summary L) := TRANSFORM
SELF := L;
END;

// Determine how many filings have no parties
UCC_Summary_Slim := PROJECT(UCC_Summary((INTEGER)debtor_count=0, (INTEGER)secured_count=0), SlimUCCSummary(LEFT));

Layout_UCC_Stat := RECORD
UCC_Summary_Slim.file_state;
reccnt := COUNT(GROUP);
END;

UCC_Stat := TABLE(UCC_Summary_Slim, Layout_UCC_Stat, file_state, FEW);

OUTPUT(UCC_Stat);