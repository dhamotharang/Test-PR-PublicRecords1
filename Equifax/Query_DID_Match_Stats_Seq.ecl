UNSIGNED1 threshhold := 75;

Layout_DID_List := RECORD
unsigned6 did;
STRING12 seq;
END;

Layout_DID_List InitDIDList(Equifax.Layout_DID_Test_Match L) := TRANSFORM
SELF.did := IF(L.did <> 0 AND L.did_score >= threshhold, L.did, 0);
SELF := L;
END;

DID_List_Init := PROJECT(Equifax.File_DID_Test_Match, InitDIDList(LEFT));

COUNT(DID_List_Init);

// Make sure no duplicate sequence numbers
DID_List_Seq_Dedup := DEDUP(DID_List_Init, seq, ALL);
COUNT(DID_List_Seq_Dedup);

Layout_DID_Stat := RECORD
DID_List_Init.did;
reccnt := COUNT(GROUP);
END;

DID_Stat := TABLE(DID_List_Init, Layout_DID_Stat, did);
COUNT(DID_Stat(reccnt>1));

// Join to get Matching records
Equifax.Layout_DID_Test_Match SelectDIDs(Equifax.Layout_DID_Test_Match L, Layout_DID_Stat R) := TRANSFORM
SELF := L;
END;

DID_Stat_Out := JOIN(Equifax.File_DID_Test_Match,
                     DID_Stat(reccnt>1),
                     LEFT.did = RIGHT.did,
                     SelectDIDs(LEFT, RIGHT),
                     LOOKUP);

OUTPUT(DID_Stat_Out,,'TMTEMP::Equifax_DID_Seq_Stat', OVERWRITE);