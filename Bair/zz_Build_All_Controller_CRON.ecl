import Bair, ut,wk_ut;

ECL:=
'wumonitor := \'Bair Build All Monitor\';\n'
+'#WORKUNIT(\'name\', wumonitor);\n'
+'wunameB := \'Bair DELTA Build All - BAIR*?\';\n'
+'wunameA := \'Bair DELTA Build All - AGENCIES*?\';\n'
+'wunameC := \'Bair COMPOSITE Delta Build and Deploy*?\';\n'
+'wunameBL := \'Bair BOOLEAN Delta Build and Deploy*?\';\n'
+'wunameF := \'Bair FULL BUILD*?\';\n'
+'wunameException := [\'Bair Build All Monitor\',\'Bair Build All Controller\',\'Bair Build All Scheduler\'];\n'
+'valid_state := [\'blocked\',\'running\',\'wait\',\'submitted\',\'compiling\',\'compiled\'];\n' 
+'dupdwusA := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wunameA))(wuid <> thorlib.wuid() and state in valid_state and job not in wunameException), -wuid);\n'
+'dupdwusB := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wunameB))(wuid <> thorlib.wuid() and state in valid_state and job not in wunameException), -wuid);\n'
+'dupdwusC := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wunameC))(wuid <> thorlib.wuid() and state in valid_state and job not in wunameException), -wuid);\n'
+'dupdwusBL := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wunameBL))(wuid <> thorlib.wuid() and state in valid_state and job not in wunameException), -wuid);\n'
+'dupdwusF := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wunameF))(wuid <> thorlib.wuid() and state in valid_state and job not in wunameException), -wuid);\n'
+'deltawuname := \'Bair DELTA BUILD*?\';\n'
 +'ddeltawus := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=deltawuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);\n'
+'d := dupdwusA + dupdwusB + dupdwusC + dupdwusBL + dupdwusF+ ddeltawus;\n'
+'d_wu := d[1].wuid;\n'
+'active_workunit :=  exists(d);\n'
+'if(active_workunit = false, NOTIFY(\'Bair Build All Scheduler\',\'*\'));\n'
;


callMonitor:= wk_ut.CreateWuid(ECL,'hthor',Bair._Constant.cronIP);// 

wumonitor 				:= 'Bair Build All Monitor';
dmonitor 					:= sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wumonitor))(wuid <> thorlib.wuid()), -wuid);
dwu      					:= dmonitor[1].wuid;
active_monitor 		:= dmonitor[1].state !='completed';
dontCallMonitor		:= 'Monitor in Progress';
dsubmitted		 		:= sort(nothor(WorkunitServices.WorkunitList('', NAMED username:='fincarnacao', NAMED state:='submitted'))(wuid <> thorlib.wuid()), -wuid);
pendingSubmitted 	:= Count(dsubmitted) > 2;

CRONController 		:= if (active_monitor = TRUE or pendingSubmitted = TRUE, dontCallMonitor, callMonitor);

CRONController;

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Bair Build All Controller');
CRONController: when(cron('0-59/2 * *	*	*'))
														,FAILURE(fileservices.sendemail('fernando.incarnacao@lexisnexis.com;debendra.kumar@lexisnexis.com;jose.bello@lexisnexis.com;'
																		,'Bair Build All Controller'
																		,'Build All Controller failure\n'
																		+'Build All Controller \n'
																		+'See '+workunit+'\n\n'
																		+FAILMESSAGE
																		));	