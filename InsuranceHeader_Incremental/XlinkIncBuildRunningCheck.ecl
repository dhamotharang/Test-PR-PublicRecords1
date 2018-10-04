IMPORT STD;
// check to see if external linking specificities key build is running (want to wait for it to finish before starting incremental key build)
wuList := NOTHOR(STD.System.Workunit.WorkunitList('',,,,Constants.XlinkIncBuildWUWilcard)(STD.Str.ToUpperCase(wuid) <> STD.Str.ToUpperCase(WORKUNIT)));
wuListRunning := wuList(STD.Str.ToUpperCase(state) IN Constants.WUStatusInProgress);
wuListRunning_XlinkIncBuild := wuListRunning(REGEXFIND(Constants.XlinkIncBuildWURegex, STD.Str.ToUpperCase(job)));
cntRunningXlinkIncBuild := COUNT(wuListRunning_XlinkIncBuild);
EXPORT XlinkIncBuildRunningCheck := cntRunningXlinkIncBuild > 0;
