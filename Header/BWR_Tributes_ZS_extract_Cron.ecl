import ut,_Control;

wuname := 'Weekly Tributes SSA Death zip and state append';
#workunit('name', wuname)
#option('allowedClusters','thor400_20,thor400_92,thor400_84')

valid_state := ['blocked','running','wait'];

d := sort(WorkunitServices.WorkunitList('',,,'','')(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);
d_wu := d[1].wuid;
active_workunit :=  count(d) > 0;

doIt := Header.proc_Tributes_ZS_append : failure(
																							fileservices.sendemail(
																										'jose.bello@lexisnexis.com,michael.gould@lexisnexis.com',
																										wuname +' ' + ut.GetDate + ' Failed on '+ _Control.ThisEnvironment.Name,
																										workunit + '\n' + failmessage)
																									);


if(active_workunit
		,output('Workunit '+d_wu+' in Wait, Queued, or Running', named('Status'))
		,doIt
	);