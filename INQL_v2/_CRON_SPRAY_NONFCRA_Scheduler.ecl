// INQL_v2._CRON_Build_FCRA_Daily_Base
// scheduler job name -> INQL FCRA Daily Build BASE Scheduler
		
import wk_ut,_Control,std;

THOR			:= INQL_v2._Constants.GROUPNAME;
fcra 			:= 'true';
pDaily 		:= 'true';
version 	:= (string8)std.date.today():INDEPENDENT;

wuname := INQL_v2._Constants.NON_FCRA_SPRAY_SCHEDULERNAME;
active_workunit := INQL_v2.GetActiveWU(wuname);

ECL0 := '//INQL_v2._CRON_Build_FCRA_Daily_Base\n'
+'//scheduler job name -> ' + INQL_v2._Constants.NON_FCRA_SPRAY_SCHEDULERNAME + '\n'
+'\n';

ECL := if(active_workunit = false
	,ECL0
+'wuname := \'' + INQL_v2._Constants.NON_FCRA_SPRAY_SCHEDULERNAME + ';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'seq := sequential(\n'
+'									INQL_v2.fspray_nonfcra_daily_files._spray\n'
+'								 )\n'
+'								 : SUCCESS(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildSuccess,\'' + INQL_v2._Constants.NON_FCRA_SPRAY_SCHEDULERNAME + ' Complete\', thorlib.wuid())),\n'
+'								   FAILURE(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildFailure,\'' + INQL_v2._Constants.NON_FCRA_SPRAY_SCHEDULERNAME + ' Failed\', thorlib.wuid()))\n'
+'								 ;\n'
+'seq;\n'
	,ECL0
+'wuname := \'' + INQL_v2._Constants.NON_FCRA_SPRAY_SCHEDULERNAME + ' is RUNNING right now\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
);

#WORKUNIT('protect',true);
#WORKUNIT('name', INQL_v2._Constants.NON_FCRA_SPRAY_SCHEDULERNAME);
wk_ut.CreateWuid(ECL,'hthor',INQL_v2._Constants.FCRA_ESP):
													WHEN(INQL_v2._Constants.NON_FCRA_SPRAY_EVENTNAME)
												 ,FAILURE(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildFailure
																		,'*** ALERT **** ' + INQL_v2._Constants.NON_FCRA_SPRAY_SCHEDULERNAME
																		,INQL_v2.email_msg(workunit).NOC_MSG
													));