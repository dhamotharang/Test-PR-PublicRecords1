IMPORT InsuranceHeader_RemoteLinking,Std;
EXPORT proc_remoteLinking_Master(STRING version) := FUNCTION

	// run iteration
	version_use := (string)Std.Date.Today();
	buildkeys := InsuranceHeader_RemoteLinking.proc_SpecKeyBuild(version_use);
	promoteQA := InsuranceHeader_RemoteLinking.proc_specPromote(version_use,TRUE);
	promoteFinal := InsuranceHeader_RemoteLinking.proc_specPromote(version_use,FALSE);

	RETURN SEQUENTIAL(buildkeys,promoteQA,promoteFinal);
	
END;