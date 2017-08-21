EXPORT Monitor := MODULE


  // Check if a WUID has been running over 20+ minutes
	EXPORT DeltasTimeIssues	() 		:= MODULE

			import Bair,STD;

			wuname := 'Bair DELTA Build All*';
			valid_state := ['submitted', 'compiling','running'];
			WorkunitList := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);			
			
			WorkunitTimings := STD.System.Workunit.WorkunitTimings(WorkunitList[1].wuid)(name = 'Total thor time');				
			String vSubject := '** WARNING ** '+ trim((string)WorkunitList[1].wuid,left,right) + ': has been running for '+(string)TRUNCATE(WorkunitTimings[1].duration/60000)+'+ Minutes';
			String vBody 		:= 'Workunit: ' + trim((string)WorkunitList[1].wuid,left,right) + '\n Job: ' + WorkunitList[1].job + '\nTotal Duration: '+ (string)TRUNCATE(WorkunitTimings[1].duration/60000) + '+ Minutes';
			
			//Change this if you want to update the recipient list
			vRecipients := Bair.Email_Notification_Lists.SchedFailure;
			
			export EmailNotification := if (WorkunitTimings[1].duration > bair._Constant.max_execution_time, fileservices.sendemail(vRecipients,	vSubject, vBody));
			
	END;
	
	// Check if no agency or Bair delta have been completed in the last 20 minutes 
	EXPORT DeltasNotRunning()	:= MODULE
			import Bair,STD,ut,lib_timelib;

			wuname := 'Bair DELTA Build All*';
			//valid_state := ['Completed'];
			WorkunitList := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname))(wuid <> thorlib.wuid() ), -wuid);			
			WorkunitTimings := STD.System.Workunit.WorkunitTimings(WorkunitList[1].wuid)(name = 'Total thor time');
			
			GetDate := (ut.getdate):INDEPENDENT;
			GetTime := ((UNSIGNED)ut.gettime()[1..4]):INDEPENDENT ;
			CurrentTime := map(GetTime<1000 and GetTime>=100=>(string)GetDate+'0'+(string)GetTime,
												 GetTime<100 and GetTime>=10 =>(string)GetDate+'00'+(string)GetTime,
												 GetTime<10 =>(string)GetDate+'000'+(string)GetTime,
												(string)GetDate+(string)GetTime
												);			
			
			WUTime := (UNSIGNED)((STRING)WorkunitList[1].wuid[2..9] + (STRING)WorkunitList[1].wuid[11..14]);            
			WUDuration :=  TRUNCATE((unsigned)WorkunitTimings[1].duration /60000);

			WUFinished := WUTime + WUDuration;
			
			CurrentTimeS := (STRING)CurrentTime;
			WUFinishedS := (STRING)WUFinished;

			CurrentTimeFromParts := lib_timelib.timelib.SecondsFromParts((integer)CurrentTimeS[1..4],(integer)CurrentTimeS[5..6],(integer)CurrentTimeS[7..8],(integer)CurrentTimeS[9..10],(integer)CurrentTimeS[11..12],0,false); 
			WUFinishedFromParts := lib_timelib.timelib.SecondsFromParts((integer)WUFinishedS[1..4],(integer)WUFinishedS[5..6],(integer)WUFinishedS[7..8],(integer)WUFinishedS[9..10],(integer)WUFinishedS[11..12],0,false); 

			TimeDiff := round((CurrentTimeFromParts-WUFinishedFromParts)/60);
	
			string WUFinishedSTZ  := (string)((integer)WUFinished - bair._Constant.timezone_diff);
			string CurrentTimeSTZ := (string)((integer)CurrentTime - bair._Constant.timezone_diff);				

			String vSubject := '** WARNING ** '+ trim((string)WorkunitList[1].wuid,left,right) + ': No Agency or Bair deltas have been completed in the last '+TimeDiff+' minutes';
			String vBody 		:= 'Last Workunit: ' + trim((string)WorkunitList[1].wuid,left,right) + '\n'
			 + 'Job: ' + WorkunitList[1].job + '\n' 
			 + 'Last WUID finished at: '+ WUFinishedSTZ[1..4]+'-'+WUFinishedSTZ[5..6]+'-'+WUFinishedSTZ[7..8]+' '+WUFinishedSTZ[9..10]+':'+WUFinishedSTZ[11..12] +'\n' 
			 + 'Current Time: ' + CurrentTimeSTZ[1..4]+'-'+CurrentTimeSTZ[5..6]+'-'+CurrentTimeSTZ[7..8]+' '+CurrentTimeSTZ[9..10]+':'+CurrentTimeSTZ[11..12];
			
			//Change this if you want to update the recipient list
			vRecipients := Bair.Email_Notification_Lists.SchedFailure;
			
			export EmailNotification := if (TimeDiff > bair._Constant.agencies_max_interval, fileservices.sendemail(vRecipients,	vSubject, vBody));

			
	END;			

END;