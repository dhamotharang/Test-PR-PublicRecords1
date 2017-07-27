#workunit ('name', 'Business Header State Source Stats ' + Business_Header.version);

BH_File := Business_Header.File_Business_Header;

Layout_BH_Slim := RECORD
string2   source;
string2   state;
END;

Layout_BH_Slim SlimBH(Business_Header.Layout_Business_Header_Base L) := TRANSFORM
SELF := L;
END;

BH_Slim := PROJECT(BH_File, SlimBH(LEFT));

Layout_BH_Stat := RECORD
BH_Slim.state;
BH_Slim.source;
cnt := COUNT(GROUP);
END;

BH_Stats := TABLE(BH_Slim, Layout_BH_Stat, state, source, FEW);

OUTPUT(BH_Stats,ALL);