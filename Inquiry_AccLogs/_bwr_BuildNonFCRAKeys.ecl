import ut, data_services;

#workunit('name','Daily Build Inquiry Table Keys')

valid_state := ['blocked','compiled','submitted','running'];

wuname := 'Daily Build Inquiry Table Keys';

d := sort(WorkunitServices.WorkunitList('',,,'','')(wuid <> thorlib.wuid() and job = wuname and state in valid_state), -wuid);
active_workunit :=  count(d) > 0;

if(~active_workunit, inquiry_acclogs.ProcBuildKeys())
		: WHEN(CRON('0 0-8/2 * * *'))
			; 

/* Build takes 4hrs when no new historical is on logs thor
   Build takes 8hrs when historical is new on logs thor (Sunday only)
   Build takes 1.5Days when stats are run (Friday only)
*/