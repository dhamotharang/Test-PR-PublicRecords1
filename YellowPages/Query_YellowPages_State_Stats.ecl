// YellowPages Listing Stats by State
export Query_YellowPages_State_Stats(

	dataset(Layout_YellowPages_Base_V2_BIP	)	pBaseFile	= Files().Base.built

) := 
function

	YP_File := pBaseFile;

	Layout_YP_Slim := RECORD
	string2   st;
	STRING1   source;
	END;

	Layout_YP_Slim SlimYP(YellowPages.Layout_YellowPages_Base_V2_BIP L) := TRANSFORM
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

	return OUTPUT(YP_Stat);

end;