IMPORT STD;
// check to see if external linking incremental key build is running (want to wait for it to finish before starting specificities key build)
wuList := NOTHOR(STD.System.Workunit.WorkunitList('',,,,Constants.XlinkSpecWUWilcard)(STD.Str.ToUpperCase(wuid) <> STD.Str.ToUpperCase(WORKUNIT)));
wuListRunning := wuList(STD.Str.ToUpperCase(state) IN Constants.WUStatusInProgress);
wuListRunning_XlinkSpec := wuListRunning(REGEXFIND(Constants.XlinkSpecWURegex, STD.Str.ToUpperCase(job)));
cntRunningXlinkSpec := COUNT(wuListRunning_XlinkSpec);
EXPORT XlinkSpecRunningCheck := cntRunningXlinkSpec > 0;
