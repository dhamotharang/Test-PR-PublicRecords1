// YellowPages Listing Stats by State
#workunit('name', 'Yellow Pages Stats by State ' + yellowpages.YellowPages_Build_Date);
YP_File := YellowPages.File_YellowPages_Base;

Layout_YP_Slim := RECORD
string2   st;
STRING1   source;
END;

Layout_YP_Slim SlimYP(YellowPages.Layout_YellowPages_Base L) := TRANSFORM
SELF := L;
END;

YP_Slim := PROJECT(YP_File, SlimYP(LEFT));

Layout_YP_Stat := RECORD
YP_Slim.st;
From_YP := COUNT(GROUP, YP_Slim.source = 'Y');
From_GB := COUNT(GROUP, YP_Slim.source = 'G');
Total_Cnt := COUNT(GROUP);
END;

YP_Stat := TABLE(YP_Slim, Layout_YP_Stat, st, FEW);

OUTPUT(YP_Stat);