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

// Join back to input file to select dups
Equifax.Layout_DID_Test_In SelectDups(Equifax.Layout_DID_Test_In L, Layout_SeqNum_Stat R) := TRANSFORM
SELF := L;
END;

SeqNum_Dups := JOIN(Equifax.File_DID_Test_In,
                    SeqNum_Stat(reccnt > 1),
                    (INTEGER)LEFT.seq = (INTEGER)RIGHT.seq,
                    SelectDups(LEFT, RIGHT),
                    LOOKUP);

OUTPUT(SeqNum_Dups,,'TMTEMP::Equifax_Seq_Dups');