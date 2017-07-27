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

FBN_Stat_Sort := SORT(FBN_Stat, -cnt);

OUTPUT(CHOOSEN(FBN_Stat_Sort,1000));

// Determine Frequency of FBN Distribution
Layout_FBN_Freq := RECORD
FBN_Stat.cnt;
freq := COUNT(GROUP);
END;

FBN_Freq := TABLE(FBN_Stat, Layout_FBN_Freq, cnt, FEW);

OUTPUT(CHOOSEN(FBN_Freq, 0));