#workunit ('name', 'Business Header State Source Stats ' + Business_Header.version);

BH_File := Business_Header.File_Business_Header;

Layout_BH_Slim := RECORD
unsigned6 bdid;
string2   source;
string2   state;
END;

Layout_BH_Slim SlimBH(Business_Header.Layout_Business_Header_Base L) := TRANSFORM
SELF := L;
END;

BH_Slim := PROJECT(BH_File, SlimBH(LEFT));

BH_Slim_Dedup := DEDUP(BH_Slim, bdid, source, state, ALL);

Layout_BH_Stat := RECORD
BH_Slim_Dedup.state;
BH_Slim_Dedup.source;
cnt := COUNT(GROUP);
END;

BH_Stats := TABLE(BH_Slim_Dedup, Layout_BH_Stat, state, source, FEW);

OUTPUT(BH_Stats,ALL);