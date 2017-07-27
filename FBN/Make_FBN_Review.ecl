// Determine Distribution of FBNs by file_st, filing_num, filing_dt

Layout_FBN_Slim := RECORD
STRING2  file_st;
STRING20 filing_num;
STRING8  filing_dt;
END;

Layout_FBN_Slim SlimFBN(FBN.Layout_FBN L) := TRANSFORM
SELF := L;
END;

FBN_Slim := PROJECT(FBN.File_FBN, SlimFBN(LEFT));

Layout_FBN_Stat := RECORD
FBN_Slim.file_st;
FBN_Slim.filing_num;
FBN_Slim.filing_dt;
cnt := COUNT(GROUP);
END;

FBN_Stat := TABLE(FBN_Slim, Layout_FBN_Stat, file_st, filing_num, filing_dt);

// Review FBNs with 45 or more records
FBN_To_Review := FBN_Stat(cnt >=45);

OUTPUT(CHOOSEN(FBN_To_Review,0));

// Join to FBN File to select records
FBN.Layout_FBN_Review SelectFBN(FBN.Layout_FBN L, Layout_FBN_Stat R) := TRANSFORM
SELF.record_count := INTFORMAT(R.cnt, 4, 1);
SELF.name_typ := IF(L.name_typ = 'A', 'R', L.name_typ);
SELF := L;
END;

FBN_Review := JOIN(FBN.File_FBN,
                   FBN_To_Review,
                   LEFT.file_st = RIGHT.file_st AND
                     LEFT.filing_num = RIGHT.filing_num AND
                     LEFT.filing_dt = RIGHT.filing_dt,
                   SelectFBN(LEFT, RIGHT),
                   LOOKUP);

OUTPUT(FBN_Review,,'OUT::FBN_Review', OVERWRITE);