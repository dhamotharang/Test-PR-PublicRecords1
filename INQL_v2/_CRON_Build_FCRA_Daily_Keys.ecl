// INQL_v2._CRON_Build_FCRA_Daily_Keys
// scheduler job name -> INQL FCRA Daily Build Keys Scheduler
		
import wk_ut,_Control,std;

THOR			:= INQL_v2._Constants.GROUPNAME;
fcra 			:= 'true';
pDaily 		:= 'true';
version 	:= (string8)std.date.today():INDEPENDENT;

wuname := INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' Keys*';
active_workunit := INQL_v2.GetActiveWU(wuname);

togo_from_roxie := true;  //need to check roxie before starting to build keys

ECL0 := '//INQL_v2._CRON_Build_FCRA_Daily_Keys\n'
+'//scheduler job name -> ' + INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' KEYS SCHEDULER\n'
+'\n';

ECL := if(active_workunit = false and togo_from_roxie
	,ECL0
+'wuname := \'' + INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' KEYS: ' + version + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'seq := sequential(\n'
+'									INQL_v2.proc_BuildKeys(\'' + version + '\',' + fcra + ',' + pDaily + ').all\n'
+'								 )\n'
+'								 : SUCCESS(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildSuccess,\'' + INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' Keys Complete\', thorlib.wuid())),\n'
+'								   FAILURE(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildFailure,\'' + INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' Keys Failed\', thorlib.wuid()))\n'
+'								 ;\n'
+'seq;\n'
	,if(active_workunit
		,ECL0
+'wuname := \'' + INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' KEYS is RUNNING right now\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
		,ECL0
+'wuname := \'' + INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' KEYS cannot start right now due to NOGO from Roxie\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
));

sthor := if(active_workunit = false and togo_from_roxie,'thor40','hthor');

#WORKUNIT('protect',true);
#WORKUNIT('name', INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' KEYS SCHEDULER');
wk_ut.CreateWuid(ECL,sthor,INQL_v2._Constants.FCRA_ESP):
													WHEN(INQL_v2._Constants.FCRA_DAILY_KEYS_EVENTNAME)
												 ,FAILURE(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildFailure
																		,'*** ALERT **** ' + INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' Keys Scheduler'
																		,INQL_v2.email_msg(workunit).NOC_MSG
													));