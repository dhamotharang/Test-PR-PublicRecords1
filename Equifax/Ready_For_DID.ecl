// Remove duplicate sequence numbers from test input file
Layout_SeqNum := RECORD
STRING12 seq;
END;

Layout_SeqNum InitSeqNum(Equifax.Layout_DID_Test_In L) := TRANSFORM
SELF := L;
END;

SeqNum_Init := PROJECT(Equifax.File_DID_Test_In, InitSeqNum(LEFT));

Layout_SeqNum_Stat := RECORD
SeqNum_Init.seq;
reccnt := COUNT(GROUP);
END;

SeqNum_Stat := TABLE(SeqNum_Init, Layout_SeqNum_Stat, seq);

COUNT(SeqNum_Stat(reccnt > 1));

// Join back to input file to keep only non-duplicates
Equifax.Layout_DID_Test_In SelectDups(Equifax.Layout_DID_Test_In L, Layout_SeqNum_Stat R) := TRANSFORM
SELF := L;
END;

Test_Input := JOIN(Equifax.File_DID_Test_In,
                    SeqNum_Stat(reccnt > 1),
                    (INTEGER)LEFT.seq = (INTEGER)RIGHT.seq,
                    SelectDups(LEFT, RIGHT),
                    LOOKUP,
                    LEFT ONLY);

COUNT(Test_Input);


// Initialize Equifax DID Test File
/*
Layout_DID_Test_Temp := RECORD
string6 dob_YYYYMM;
Equifax.Layout_DID_Test_Match;
END;
*/

Layout_DID_Test_Temp InitDIDTest(Equifax.Layout_DID_Test_In L) := TRANSFORM
SELF.did := 0;
SELF.PreGLB_did := 0;
SELF.did_score := 0;
SELF.PreGLB_did_score := 0;
SELF.cid := '';
SELF.dob_YYYYMM := IF(L.dob <>'',
                      (STRING6)('19' + L.dob[3..4] + L.dob[1..2]),
                      L.dob);
SELF := L;
END;

DID_Test_Init := PROJECT(Test_Input, InitDIDTest(LEFT));

// Join Input file to Seq/CID file to append CID to input
Layout_DID_Test_Temp AppendCID(Layout_DID_Test_Temp L, Equifax.Layout_Seq_CID R) := TRANSFORM
SELF.cid := R.cid;
SELF := L;
END;

DID_Test_Init_Dist := DISTRIBUTE(DID_Test_Init, HASH((INTEGER)seq));
SeqNum_CID_Dist := DISTRIBUTE(Equifax.File_SeqNum_CID, HASH((INTEGER)seq_num));

DID_Test_CID := JOIN(DID_Test_Init_Dist,
                     SeqNum_CID_Dist,
                     (INTEGER)LEFT.seq = (INTEGER)RIGHT.seq_num,
                     AppendCID(LEFT, RIGHT),
                     LEFT OUTER,
                     LOCAL);

export Ready_For_DID := DID_Test_CID;
