// YellowPages Listing Stats by State

YP_File := Files().Base.QA;

Layout_YP_Slim := RECORD
string2   st;
STRING1   source;
string6   pub_date;
END;

Layout_YP_Slim SlimYP(YellowPages.Layout_YellowPages_Base_V2_bip L) := TRANSFORM
self.pub_date := L.pub_date[3..6]+L.pub_date[1..2];
SELF := L;
END;

YP_Slim := PROJECT(YP_File, SlimYP(LEFT));

Layout_YP_Stat := RECORD
YP_Slim.st;
From_YP := COUNT(GROUP, YP_Slim.source = 'Y');
From_GB := COUNT(GROUP, YP_Slim.source = 'G');
latest_pub_date := max(group, (unsigned4)yp_slim.pub_date);
Total_Cnt := COUNT(GROUP);
END;

YP_Stat := TABLE(YP_Slim, Layout_YP_Stat, st, FEW);

export Query_QA_Stats := OUTPUT(YP_Stat);
