import wk_ut,_Control,std;
DAILY_AT_10_AM:='01 10 * * *';

emails 			:= 'debendra.kumar@lexisnexisrisk.com, john.freibaum@lexisnexisrisk.com, Sudhir.Kasavajjala@lexisnexisrisk.com, Jose.Bello@lexisnexisrisk.com, Wenhong.Ma@lexisnexisrisk.com';
groupname := 'thor120_50';
ESP 						:= '10.241.50.42';

ECL :=
 'wuname := \'NON-FCRA All File Monitors and Moves\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
+'emails := \'' + emails + '\';\n'
+'valid_state := [\'blocked\',\'running\',\'wait\',\'compiling\',\'compiled\',\'submitted\'];\n'
+'wunits := sort(nothor(WorkunitServices.WorkunitList(\'\',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);\n'
+'active_workunit := exists(wunits);\n\n'        
+'				//WEEKLY HISTORY BUILD\n'
+'				act1 := Inquiry_Acclogs.FN_FileMoves.WeeklyInquiryHistory():\n'
+'				FAILURE(fileservices.sendemail(emails,\'WeeklyInquiryHistory File Move FAILURE\',\'WeeklyInquiryHistory File Move failure, Review \'+workunit+FAILMESSAGE)),\n'
+'				SUCCESS(fileservices.sendemail(emails,\'WeeklyInquiryHistory File Move SUCCESS\',\'WeeklyInquiryHistory File Move success \'+workunit));\n'

+'				//PRODR3 MONITORING\n'
+'				act2 := Inquiry_Acclogs.FN_FileMoves.R3Monitoring(false):\n'
+'				FAILURE(fileservices.sendemail(emails,\'ProdR3Monitoring File Move FAILURE\',\'ProdR3Monitoring File Move failure, Review \'+workunit+FAILMESSAGE)),\n'
+'				SUCCESS(fileservices.sendemail(emails,\'ProdR3Monitoring File Move SUCCESS\',\'ProdR3Monitoring File Move success \'+workunit));\n'

+'				//CASE CONNECT\n'
+'				act3 := Inquiry_Acclogs.FN_FileMoves.CaseConnect():\n'
+'				FAILURE(fileservices.sendemail(emails,\'CaseConnect File Move FAILURE\',\'CaseConnect File Move failure, Review \'+workunit+FAILMESSAGE)),\n'
+'				SUCCESS(fileservices.sendemail(emails,\'CaseConnect File Move SUCCESS\',\'CaseConnect File Move success \'+workunit));\n'

+'				//DECONFLICTION\n'
+'				act4 := Inquiry_Acclogs.FN_FileMoves.Deconfliction():\n'
+'				FAILURE(fileservices.sendemail(emails,\'Deconfliction File Move FAILURE\',\'Deconfliction File Move failure, Review \'+workunit+FAILMESSAGE)),\n'
+'				SUCCESS(fileservices.sendemail(emails,\'Deconfliction File Move SUCCESS\',\'Deconfliction File Move success \'+workunit));\n'

+'				//SCORE AND ATTRIBUTE OUTCOME\n'
+'				act5 := Inquiry_Acclogs.FN_FileMoves.ScoreAndAttributeOutcome():\n'
+'				FAILURE(fileservices.sendemail(emails,\'ScoreAndAttributeOutcome File Move FAILURE\',\'ScoreAndAttributeOutcome File Move failure, Review \'+workunit+FAILMESSAGE)),\n'
+'				SUCCESS(fileservices.sendemail(emails,\'ScoreAndAttributeOutcome File Move SUCCESS\',\'ScoreAndAttributeOutcome File Move success \'+workunit));\n'
+'\n'
+'if(active_workunit = false,\n'
+'  parallel(\n'
+'  		act1,\n'
+'  		act2,\n'
+'  		act3,\n'
+'  		act4,\n'
+'  		act5\n'
+'	));\n'
;

wumonitor := 'Launch - All New File Monitors';
dmonitor := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wumonitor))(wuid <> thorlib.wuid()), -wuid);
dwu      := dmonitor[1].wuid;
active_monitor :=  dmonitor[1].state !='completed';

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Launch - All New File Monitors');
if (active_monitor=FALSE, wk_ut.CreateWuid(ECL,groupname,ESP),''):
							WHEN(cron(DAILY_AT_10_AM))
							,SUCCESS(FileServices.SendEmail(emails, 'NON-FCRA Logs Thor - All New File Monitor COMPLETED', thorlib.wuid() + '\n' + 'All File Monitor Completed'))
							,FAILURE(FileServices.SendEmail(emails, 'NON-FCRA Logs Thor - All New File Monitor FAILED', thorlib.wuid() + ' - ' + FAILMESSAGE)
			 );

