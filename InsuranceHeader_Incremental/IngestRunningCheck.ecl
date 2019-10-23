IMPORT STD;
// check to see if ingest is already running (used to prevent multiple simultaneous ingests)
wuList := NOTHOR(STD.System.Workunit.WorkunitList('',,,,Constants.IngestWUWilcard)(STD.Str.ToUpperCase(wuid) <> STD.Str.ToUpperCase(WORKUNIT)));
wuListRunning := wuList(STD.Str.ToUpperCase(state) IN Constants.WUStatusInProgress);
wuListRunning_Ingest := wuListRunning(REGEXFIND(Constants.IngestWURegex, STD.Str.ToUpperCase(job)));
cntRunningIngest := COUNT(wuListRunning_Ingest);
EXPORT IngestRunningCheck := cntRunningIngest > 0;