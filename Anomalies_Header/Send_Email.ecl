Import STD, _Control, VersionControl;

Export Send_Email := Module

    Shared server      := 'http://dataland_esp.br.seisint.com:8010';


	Shared subject          := 'Header Anomalies Report Version: 20200427';


	Shared report          := 'All results can found here: ' + server +  '/?Widget=WUDetailsWidget&Wuid=' + workunit + '#/stub/Results-DL/Grid';


	Shared body_success     := 'This is the report you submitted:' + '\n\n'
							+   report +  '\n\n' 
							+ ' For your notes, the workunit is: ' +  workunit + '\n\n' 
							+ ' Have a wonderful day!' + '\n\n' 
							+ ' The End.';

	Shared body_failure     := 'This is the report you submitted:' + '\n\n'
							+   report +  '\n\n' 
							+ ' For your notes, the workunit is: ' +  workunit + '\n\n' 
							+ ' Have a wonderful day!' + '\n\n' 
							+ ' The End.';
          

	Export Build_Success    := STD.System.Email.SendEmail(Mailing_List.Developer, Subject, body_success );
													

	Export Build_Failure    := STD.System.Email.SendEmail(Mailing_List.Developer, Subject, body_failure );

	End;