import wk_ut,_Control;
EVERY_4_HOURS:='0 0-23/6 * * *';

ECL0:= 
 '//INQL_v2._CRON_Build_FCRA_Weekly_Controller\n'
+'//Controller job name -> ' + INQL_v2._Constants.FCRA_WEEKLY_BLD_CONTROLLERNAME + '\n'
+'wuname := \'' + INQL_v2._Constants.FCRA_WEEKLY_BLD_CONTROLLERNAME + '\';\n'
+'#WORKUNIT(\'name\', wuname)\n\n'
;

ECL :=
		ECL0
+'	NOTIFY(\'' + INQL_v2._Constants.FCRA_WEEKLY_KEYS_EVENTNAME + '\',\'*\');\n'
;

#WORKUNIT('protect',true);
#WORKUNIT('name', INQL_v2._Constants.FCRA_WEEKLY_BLD_CONTROLLERNAME);
wk_ut.CreateWuid(ECL,'hthor',INQL_v2._Constants.FCRA_ESP):
													 WHEN(cron(EVERY_4_HOURS))
													,FAILURE(FileServices.SendEmail(INQL_v2.email_notification_lists.BuildFailure
													,'*** ALERT **** ' + INQL_v2._Constants.FCRA_WEEKLY_BLD_CONTROLLERNAME
													,INQL_v2.email_msg(workunit).NOC_MSG
													));	