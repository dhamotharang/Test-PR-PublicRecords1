IMPORT STD;
// check to see if incremental build is running (want to wait for it to finish before starting full build delta )
wuList := NOTHOR(STD.System.Workunit.WorkunitList('',,,,Constants.IncBuildWUWilcard)(STD.Str.ToUpperCase(wuid) <> STD.Str.ToUpperCase(WORKUNIT)));
wuListRunning := wuList(STD.Str.ToUpperCase(state) IN Constants.WUStatusInProgress);
wuListRunning_IncBuild := wuListRunning(REGEXFIND(Constants.IncBuildWURegex, STD.Str.ToUpperCase(job)));
cntRunningIncBuild := COUNT(wuListRunning_IncBuild);
EXPORT IncBuildRunningCheck := cntRunningIncBuild > 0;
