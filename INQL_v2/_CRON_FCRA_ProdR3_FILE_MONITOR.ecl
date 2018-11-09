// queued job name -> Launch - All New File Monitors
// DAILY_AT_10_AM

import wk_ut,_Control,std;
DAILY_AT_10_AM:='01 10 * * *';

emails 			:= 'debendra.kumar@lexisnexisrisk.com, john.freibaum@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Jose.Bello@lexisnexisrisk.com, Wenhong.Ma@lexisnexisrisk.com';
groupname := 'fcra_logs_thor';
ESP 						:= '10.173.52.3';

ECL:=
 'wuname := \'FCRA All File Monitors and Moves\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'emails := \'' + emails + '\';\n'
+'valid_state := [\'blocked\',\'running\',\'wait\',\'compiling\',\'compiled\',\'submitted\'];\n'
+'wunits := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);\n'
+'active_workunit := exists(wunits);\n'  
+'				//PRODR3 MONITORING\n'
+'				act1 := Inquiry_Acclogs.FN_FileMoves.R3Monitoring(true):\n'
+'				FAILURE(fileservices.sendemail(emails,\'ProdR3Monitoring File Move FAILURE\',\'ProdR3Monitoring File Move failure, Review \'+workunit+FAILMESSAGE)),\n'
+'				SUCCESS(fileservices.sendemail(emails,\'ProdR3Monitoring File Move SUCCESS\',\'ProdR3Monitoring File Move success \'+workunit));\n'
+'				//SCORE AND ATTRIBUTE OUTCOME\n'
+'				act2 := Inquiry_Acclogs.FN_FileMoves.FCRA_ScoreAndAttributeOutcome():\n'
+'				FAILURE(fileservices.sendemail(emails,\'ScoreAndAttributeOutcome File Move FAILURE\',\'ScoreAndAttributeOutcome File Move failure, Review \'+workunit+FAILMESSAGE)),\n'
+'				SUCCESS(fileservices.sendemail(emails,\'ScoreAndAttributeOutcome File Move SUCCESS\',\'ScoreAndAttributeOutcome File Move success \'+workunit));\n'
+'\n'      
+'if(active_workunit = false,\n'
+'  parallel(\n'
+'  		act1,\n'
+'  		act2\n'
+'	));\n'
;

wumonitor := 'Launch - All New File Monitors';
dmonitor 	:= sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wumonitor))(wuid <> thorlib.wuid()), -wuid);
dwu      	:= dmonitor[1].wuid;
active_monitor :=  dmonitor[1].state !='completed';

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Launch - All New File Monitors');
if (active_monitor=FALSE, wk_ut.CreateWuid(ECL,groupname,ESP),''):
							WHEN(cron(DAILY_AT_10_AM))
							,SUCCESS(FileServices.SendEmail(emails, 'FCRA Logs Thor - All New File Monitor COMPLETED', thorlib.wuid() + '\n' + 'All File Monitor Completed'))
							,FAILURE(FileServices.SendEmail(emails, 'FCRA Logs Thor - All New File Monitor FAILED', thorlib.wuid() + ' - ' + FAILMESSAGE)
				);