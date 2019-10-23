import std;
wuname := 'FCRA_ExperianCred - Generate Extracts';
#workunit('name', wuname)
#option('allowedClusters','thor400_20,thor400_92,thor400_84')
string version := (STRING8)Std.Date.Today();

valid_state := ['blocked','running','wait'];

d := sort(WorkunitServices.WorkunitList('',,,'','')(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);
d_wu := d[1].wuid;
active_workunit :=  count(d) > 0;

doIt := FCRA_ExperianCred.Proc_build_extracts(version);

if(active_workunit
		,output('Workunit '+d_wu+' in Wait, Queued, or Running', named('Status'))
		,doIt
	)
		: WHEN(CRON('0 22 * * *')); //daily at 6pm