Layout_BK_Slim := RECORD
unsigned6		  did;
string3           Record_Type;
END;

Layout_BK_Slim SlimBK(Bankrupt.Layout_BK_DID L) := TRANSFORM
SELF.record_type := L.rec_type;
self := l;
END;

BK_Slim := PROJECT(Bankrupt.clean_raw, SlimBK(LEFT));

Layout_BK_Stat := RECORD
BK_Slim.Record_Type;
Total := COUNT(GROUP);
DID := COUNT(GROUP, bk_slim.did!=0);
END;

BK_Stat := TABLE(BK_Slim, Layout_BK_Stat, Record_Type, FEW);

OUTPUT(BK_Stat);