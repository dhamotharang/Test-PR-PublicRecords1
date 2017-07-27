IMPORT Equifax;

// Query to determine match distribution in buckets of a specific size

UNSIGNED1 threshhold := 75;

Layout_DID_Match_Slim := RECORD
INTEGER2 bucket;
unsigned6 did;
STRING16  cid;
END;

Layout_DID_Match_Slim SlimMatchRecords(Equifax.Layout_DID_Test_Match L) := TRANSFORM
SELF.bucket := ((INTEGER)L.seq * 2) DIV 100000;  // bucket size is 50000
SELF.did := IF(L.did <> 0 AND L.did_score >= threshhold, L.did, 0);
SELF := L;
END;

DID_Match_Slim := PROJECT(Equifax.File_DID_Test_Match, SlimMatchRecords(LEFT));

COUNT(DID_Match_Slim);

Layout_Match_Stat := RECORD
DID_Match_Slim.bucket;
did_match := SUM(GROUP, IF(DID_Match_Slim.did <> 0, 1, 0));
cid_match := SUM(GROUP, IF(DID_Match_Slim.cid <> '', 1, 0));
record_count := COUNT(GROUP);
END;

Match_Stat := TABLE(DID_Match_Slim, Layout_Match_Stat, bucket, FEW);

OUTPUT(CHOOSEN(Match_Stat,0));