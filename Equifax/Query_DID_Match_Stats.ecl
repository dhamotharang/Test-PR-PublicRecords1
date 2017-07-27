UNSIGNED1 threshhold := 75;

Layout_DID_List := RECORD
unsigned6 did;
STRING16  cid;
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

// Select records with both DID and CID for analysis
DID_List_Select := DID_List_Init(did<>0, cid<>'');

// Stat to determine how many records matched to more than 1 DID, CID pair
Layout_DID_CID_Stat := RECORD
DID_List_Select.did;
DID_List_Select.cid;
reccnt := COUNT(GROUP);
END;

DID_CID_Pair_Stat := TABLE(DID_List_Select, Layout_DID_CID_Stat, did, cid);

COUNT(DID_CID_Pair_Stat(reccnt > 1));
OUTPUT(DID_CID_Pair_Stat(reccnt > 1),,'TMTEMP::Equifax_DID_CID_Pairs', OVERWRITE);

// Determine how many DIDs match more than 1 unique CID
DID_List_Dedup := DEDUP(DID_List_Select, did, cid, ALL);

Layout_DID_Stat := RECORD
DID_List_Dedup.did;
reccnt := COUNT(GROUP);
END;

DID_Stat := TABLE(DID_List_Dedup, Layout_DID_Stat, did);
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

OUTPUT(DID_Stat_Out,,'TMTEMP::Equifax_DID_Stat', OVERWRITE);

// Determine how many duplicate CIDs match more than 1 unique DID
Layout_CID_Stat := RECORD
DID_List_Dedup.cid;
reccnt := COUNT(GROUP);
END;

CID_Stat := TABLE(DID_List_Dedup, Layout_CID_Stat, cid);
COUNT(CID_Stat(reccnt>1));

// Join to get matching records
Equifax.Layout_DID_Test_Match SelectCIDs(Equifax.Layout_DID_Test_Match L, Layout_CID_Stat R) := TRANSFORM
SELF := L;
END;

CID_Stat_Out := JOIN(Equifax.File_DID_Test_Match,
                     CID_Stat(reccnt>1),
                     LEFT.cid = RIGHT.cid,
                     SelectCIDs(LEFT, RIGHT),
                     LOOKUP);



OUTPUT(CID_Stat_Out,,'TMTEMP::Equifax_CID_Stat', OVERWRITE);