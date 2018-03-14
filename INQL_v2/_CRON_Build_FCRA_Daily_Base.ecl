﻿// INQL_v2._CRON_Build_FCRA_Daily_Base
// scheduler job name -> INQL FCRA Daily Build BASE Scheduler
		
import wk_ut,_Control,std;

THOR			:= INQL_v2._Constants.GROUPNAME;
fcra 			:= 'true';
pDaily 		:= 'true';
version 	:= (string8)std.date.today():INDEPENDENT;

wuname := INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' BASE*';
active_workunit := INQL_v2.GetActiveWU(wuname);

ECL0 := '//INQL_v2._CRON_Build_FCRA_Daily_Base\n'
+'//scheduler job name -> ' + INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' BASE SCHEDULER\n'
+'\n';

ECL := if(active_workunit = false
	,ECL0
+'wuname := \'' + INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' BASE: ' + version + '\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'seq := sequential(\n'
+'									INQL_v2.Build_all(\'' + version + '\',' + fcra + ',' + pDaily + ');\n'
+'								 )\n'
+'								 : SUCCESS(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildSuccess,\'' + INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' Base Complete\', thorlib.wuid())),\n'
+'								   FAILURE(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildFailure,\'' + INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' Base Failed\', thorlib.wuid()))\n'
+'								 ;\n'
+'seq;\n'
	,ECL0
+'wuname := \'' + INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' BASE is RUNNING right now\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
);

sthor := if(active_workunit = false,'thor40','hthor');

#WORKUNIT('protect',true);
#WORKUNIT('name', INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' BASE SCHEDULER');
wk_ut.CreateWuid(ECL,sthor,INQL_v2._Constants.FCRA_ESP):
													WHEN(INQL_v2._Constants.FCRA_DAILY_BASE_EVENTNAME)
												 ,FAILURE(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildFailure
																		,'*** ALERT **** ' + INQL_v2._Constants.FCRA_DAILY_BLD_SCHEDULERNAME + ' BASE Scheduler'
																		,INQL_v2.email_msg(workunit).NOC_MSG
													));