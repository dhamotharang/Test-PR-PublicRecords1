Import STD;

Export Send_Email( string pVersion, string contacts ) := Module

    Shared server           := 'http://prod_esp.br.seisint.com:8010';

	Shared subject          := 'Prod History Report Version:' + pVersion;
    
	Shared report           := 'You can find results here: ' + server +  '/?Widget=WUDetailsWidget&Wuid=' + workunit + '#/stub/Results-DL/Grid';

	Shared body_success     := 'Hello,' + '\n\n'
							+  'This is the most recent Dops History Report.' + '\n\n'
							+   report +  '\n\n' 
							+ ' For your notes, the workunit is: ' +  workunit + '\n\n' 
							+ ' Have a wonderful day!' + '\n\n' 
							+ ' The End.';

	Shared body_failure     := 'The report submitted failed. Take a look:' + '\n\n'
							+   report +  '\n\n' 
							+ ' For your notes, the workunit is: ' +  workunit + '\n\n' 
							+ ' Please try again when ready!' + '\n\n' 
							+ ' The End.';
          
    // If job is executed successfully, an email will be sent to users in the corresponding list
	Export build_success    := STD.System.Email.SendEmail(contacts, subject, body_success, contacts );
													
    // If job fails, an email will be sent to notify the users in corresponding list 
	Export build_failure    := STD.System.Email.SendEmail(contacts, subject, body_failure, contacts );

	End;