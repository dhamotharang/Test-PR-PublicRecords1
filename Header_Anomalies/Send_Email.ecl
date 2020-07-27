Import STD;

Export Send_Email := Module

    Shared server           := 'http://dataland_esp.br.seisint.com:8010';


	Shared subject          := 'Header Anomalies Report Version: 20200427';

    
	Shared report           := 'All results can found here: ' + server +  '/?Widget=WUDetailsWidget&Wuid=' + workunit + '#/stub/Results-DL/Grid';


	Shared body_success     := 'This is the report you submitted:' + '\n\n'
							+   report +  '\n\n' 
							+ ' For your notes, the workunit is: ' +  workunit + '\n\n' 
							+ ' Have a wonderful day!' + '\n\n' 
							+ ' The End.';

	Shared body_failure     := 'The report you submitted failed. Take a look:' + '\n\n'
							+   report +  '\n\n' 
							+ ' For your notes, the workunit is: ' +  workunit + '\n\n' 
							+ ' Please try again when ready!' + '\n\n' 
							+ ' The End.';
          
    // If job is executed successfully, an email will be sent to users in the corresponding list
	Export build_success    := STD.System.Email.SendEmail(Mailing_List.developer, subject, body_success );
													
    // If job fails, an email will be sent to notify the users in corresponding list 
	Export build_failure    := STD.System.Email.SendEmail(Mailing_List.developer, subject, body_failure );

	End;