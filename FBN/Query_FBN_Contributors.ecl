// Crosstab of FBN Contributor Numbers and File State
Layout_FBN_Slim := RECORD
STRING2  file_st;
STRING6  contrib_no;
END;

Layout_FBN_Slim SlimFBN(FBN.Layout_FBN L) := TRANSFORM
SELF := L;
END;

FBN_Slim := PROJECT(FBN.File_FBN, SlimFBN(LEFT));

Layout_FBN_Stat := RECORD
FBN_Slim.contrib_no;
FBN_Slim.file_st;
INTEGER4 reccnt := COUNT(GROUP);
END;

FBN_Stat := TABLE(FBN_Slim, Layout_FBN_Stat, contrib_no, file_st, FEW);

OUTPUT(CHOOSEN(FBN_Stat, 0));