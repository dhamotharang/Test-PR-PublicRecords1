/*
This processes a daily file with building the keys
It is intended for files received over a weekend
*/

EXPORT ProcessDailyUpdate(string version) := FUNCTION
		mstr := DISTRIBUTE(Gong_Neustar.File_Master,hash(record_id));
		daily := Gong_Neustar.GetDaily(version);
		
		m := Gong_Neustar.ProcessDailyFile(mstr, daily, version);
		return SEQUENTIAL(
		  OUTPUT(m,,gong_Neustar.Constants.lfnMaster + version,COMPRESSED,OVERWRITE),
		  gong_Neustar.Promotions.Master(gong_Neustar.Constants.lfnMaster + version)
);
END;