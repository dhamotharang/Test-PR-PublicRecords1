import std, address;

EXPORT ProcessOSFICanada := FUNCTION
	return sort(GlobalWatchLists_Preprocess.ProcessOSFICanadaEnt + GlobalWatchLists_Preprocess.ProcessOSFICanadaInd, pty_key, local);
END;

