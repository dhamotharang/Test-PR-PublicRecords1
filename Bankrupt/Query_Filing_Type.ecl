// Bankruptcy Filing Type Crosstab
Layout_BK_Slim := RECORD
string1           Filing_Type;
END;

Layout_BK_Slim SlimBK(Bankrupt.Layout_BK L) := TRANSFORM
SELF := L;
END;

BK_Slim := PROJECT(Bankrupt.File_BK, SlimBK(LEFT));

Layout_BK_Stat := RECORD
BK_Slim.Filing_Type;
reccnt := COUNT(GROUP);
END;

BK_Stat := TABLE(BK_Slim, Layout_BK_Stat, Filing_Type, FEW);

OUTPUT(BK_Stat);