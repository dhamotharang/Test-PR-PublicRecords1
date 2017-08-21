// Bair._CRON_Build_pload_Controller
// scheduler job nane -> Bair Build All Controller
// queued job nane -> Bair Build All Monitor
// EVERY_TWO_MINUTES:
	// if any 'Bair Build All Monitor' not completed in queue, do nothing
		// else spin Bair.Build_All_Scheduler_CRON by notifying the scheduler -> Bair Build All Scheduler
// Expected execution time -> 30 seconds

import ut,wk_ut;
EVERY_TWO_MINUTES:='0-59/2 * *	*	*';

ECL:=
 '//Bair._CRON_Build_pload_Controller\n'
+'//scheduler job nane -> Bair Build All Controller\n'
+'//queued job nane -> Bair Build All Monitor\n'
+'//EVERY_TWO_MINUTES:\n'
+'// if any \'Bair Build All Monitor\' not completed in queue, do nothing\n'
+'// else spin Bair.Build_All_Scheduler_CRON by notifying the scheduler -> Bair Build All Scheduler\n'
+'\n'
+'//Expected execution time -> 30 seconds\n'
+'\n'
+'#WORKUNIT(\'name\', \'Bair Build All Monitor\');\n'
+'wunameB := \'Bair DELTA Build All - BAIR*?\';\n'
+'wunameA := \'Bair DELTA Build All - AGENCIES*?\';\n'
+'wunameBL := \'Bair BOOLEAN Delta Build and Deploy*?\';\n'
+'wunameException := [\'Bair Build All Monitor\',\'Bair Build All Controller\',\'Bair Build All Scheduler\'];\n'
+'valid_state := [\'blocked\',\'running\',\'wait\',\'submitted\',\'compiling\',\'compiled\'];\n'
+'dupdwusA := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wunameA))(wuid <> thorlib.wuid() and state in valid_state and job not in wunameException), -wuid);\n'
+'dupdwusB := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wunameB))(wuid <> thorlib.wuid() and state in valid_state and job not in wunameException), -wuid);\n'
+'dupdwusBL := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wunameBL))(wuid <> thorlib.wuid() and state in valid_state and job not in wunameException), -wuid);\n'

+'deltawuname := \'Bair DELTA BUILD*?\';\n'
+'ddeltawus := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=deltawuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);\n'
+'d := dupdwusA + dupdwusB + dupdwusBL + ddeltawus;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit = false, NOTIFY(\'Bair Build All Scheduler\',\'*\'));\n'
;

wumonitor := 'Bair Build All Monitor';
dmonitor := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wumonitor))(wuid <> thorlib.wuid()), -wuid);
dwu      := dmonitor[1].wuid;
active_monitor :=  dmonitor[1].state !='completed';

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Build All Controller');
if (active_monitor=FALSE,wk_ut.CreateWuid(ECL,'hthor',Bair._ESP),''):
													WHEN(cron(EVERY_TWO_MINUTES))
													,FAILURE(fileservices.sendemail(Bair.Email_Notification_Lists.SchedFailure
													,'*** ALERT **** Bair Build All Controller Scheduler Failure'
													,Bair.email_msg(workunit).NOC_MSG
													));