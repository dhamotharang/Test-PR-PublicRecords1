EXPORT Monitor := MODULE

	EXPORT FindTimeIssues	() 		:= MODULE

			import Bair,STD;

			wuname := 'Bair Importer - Importing*';
			valid_state := ['submitted', 'compiling','running'];
			WorkunitList := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid);			
			
			WorkunitTimings := STD.System.Workunit.WorkunitTimings(WorkunitList[1].wuid)(name = 'Total thor time');				
			String vSubject := '** WARNING ** '+ trim((string)WorkunitList[1].wuid,left,right) + ': has been running for '+(string)TRUNCATE(WorkunitTimings[1].duration/60000)+'+ Minutes';
			String vBody 		:= 'Workunit: ' + trim((string)WorkunitList[1].wuid,left,right) + '\n Job: ' + WorkunitList[1].job + '\nTotal Duration: '+ (string)TRUNCATE(WorkunitTimings[1].duration/60000) + '+ Minutes';
			
			//Change this if you want to update the recipient list
			vRecipients := Bair.Email_Notification_Lists.SchedFailure;
			
			export EmailNotification := if (WorkunitTimings[1].duration > bair_importer._Constants.max_execution_time, fileservices.sendemail(vRecipients,	vSubject, vBody));
			
	END;
	
	
	EXPORT CheckGeoMaxCalls	() 		:= MODULE
	
			import Bair,ut;
			
			xcount := sum(dataset(bair_importer._Constants.bair_geocoding_log,bair_importer.layouts.Bair_Geocoding_Log,thor,opt),counts); 
			
			String vSubject := '** WARNING ** : Geocoding API has been called ' + xcount + ' times in the last 24 hours';
			String vBody 		:= 'Bair Importer has called the Google Geocoding API ' + xcount + ' times in the last 24 hours';
			
			//Change this if you want to update the recipient list
			vRecipients := Bair.Email_Notification_Lists.SchedFailure;

			export EmailNotification := if (xcount >= bair_importer._Constants.notify_after_calls, fileservices.sendemail(vRecipients,	vSubject, vBody	));
	END;
	
EXPORT CleanUpScript()  := FUNCTION
	
		import wk_ut,Bair;
		deletionLayout := RECORD
			STRING ECL := '';
		END;
			
		OrphanPreppeds	:= nothor(FileServices.LogicalFileList('*in::prepped*',true,false));

		deletionLayout generateDeletionECL(OrphanPreppeds l) := transform
			SELF.ECL := 'NOTHOR(FileServices.DeleteLogicalFile(\'~' + l.name + '\', TRUE));';
		end;

		headerRow := DATASET([{'#workunit(\'name\', \'Bair Importer - File Cleanup Process\');'}], deletionLayout);

		final := project(OrphanPreppeds(regexfind('2016-06-17',modified)), generateDeletionECL(left)); 
													
		combined := ROLLUP((headerRow + final), TRUE, TRANSFORM(deletionLayout, SELF.ECL := LEFT.ECL + '\n' + RIGHT.ECL;));											
														
		wu := wk_ut.CreateWuid(combined[1].ecl,'hthor',Bair._ESP);

		return wu;
	END;	

END;