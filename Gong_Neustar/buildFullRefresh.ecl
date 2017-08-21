EXPORT buildFullRefresh(string version) := FUNCTION


	lfn := gong_Neustar.Constants.lfnMaster + 'full::' + version;
	monthly := GetMonthly(version);

	m1 := Gong_Neustar.ProcessFullRefresh(monthly,version);
	mstr := gong_neustar.MergeFullRefresh(m1, Gong_Neustar.File_Master);
	
	SEQUENTIAL(
		BuildScrubsReport(monthly, version+'f'),
		OUTPUT(mstr,,lfn,COMPRESSED,OVERWRITE),
		gong_Neustar.Promotions.Master(lfn)
	);
	return version;
END;
	