// Bankruptcy Filing Type Crosstab
Layout_BK_Slim := RECORD
string5           Court_Code;
string4           Year_Filed;
END;

Layout_BK_Slim SlimBK(Bankrupt.Layout_BK L) := TRANSFORM
SELF.Year_Filed := L.Date_Filed[1..4];
SELF := L;
END;

BK_Slim := PROJECT(Bankrupt.File_BK, SlimBK(LEFT));

Layout_BK_Stat := RECORD
BK_Slim.Court_Code;
BK_Slim.Year_Filed;
reccnt := COUNT(GROUP);
END;

BK_Stat := TABLE(BK_Slim, Layout_BK_Stat, Court_Code, Year_Filed);

OUTPUT(CHOOSEN(BK_Stat,0));