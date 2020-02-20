EXPORT DDT_DailyReport(string historydate = '', string email) := function

		Import std;
		
		// environment = 'P' or 'Q'
		// location [optional] = 'B' or 'Q' or '' or '*'
		// cluster [optional] = 'N' or 'F' or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
		// datasetname [optional] = dataset name from dops

		//Get the deployed datasets from DOPS.  Will pick up everything current
		qa_ddt_ds := Scoring_Project_DailyTracking.DDT_GetDeployedDatasets('Q', 'B', '', '');
		prod_ddt_ds := Scoring_Project_DailyTracking.DDT_GetDeployedDatasets('P', 'B', '', '');
		full_ds := qa_ddt_ds + prod_ddt_ds;

		WriteCertHistoryFile := if(std.file.fileexists('~scoringqa::out::DDT_CERT_NonFCRA_Master_' + (String8)std.date.today())= false, Scoring_Project_DailyTracking.DDT_NonFCRA_HistoryTracking(qa_ddt_ds));

		// Generate report
		// Dataset with data
		// environment = 'P' or 'Q'
		// location [optional] = 'B' or 'Q' or '' or '*'
		// cluster [optional] = 'N' or 'F' or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
		// date deployed = <blank> if previous day, 'all' for all data, else a date can be input.  Note that a dataset will not return if it has been redeployed on a subsequent date

		// historydate := '20140922';
		// historydate := 'all';
		// historydate := '';

		qa_nonFCRA_results 		:= 	Scoring_Project_DailyTracking.DDT_CompileReport( full_ds,'Q', 'B', 'N', historydate);
		qa_FCRA_results 			:= 	Scoring_Project_DailyTracking.DDT_CompileReport( full_ds,'Q', 'B', 'F', historydate);
		prod_nonFCRA_results 	:= 	Scoring_Project_DailyTracking.DDT_CompileReport( full_ds,'P', 'B', 'N', historydate);
		prod_FCRA_results 		:= 	Scoring_Project_DailyTracking.DDT_CompileReport( full_ds,'P', 'B', 'F', historydate);

	
		
		cert_results 		:= 	Scoring_Project_DailyTracking.DDT_StaleReport( full_ds,'Q', 'B', 'all', 'all');
		prod_results 		:=  Scoring_Project_DailyTracking.DDT_StaleReport( full_ds,'P', 'B', 'all', 'all');
		
	      				
					
		prod_head := 	'****************************************************************************************' + '\n' +
      									  'Prod Stale Dataset Tracking' + '\n' +      								
      									  '****************************************************************************************'+ '\n' ;	
    Cert_head := 	'****************************************************************************************' + '\n' +
      									  'Cert Stale Dataset Tracking' + '\n' +      							
      									  '****************************************************************************************'+ '\n' ;	
      
      	
					
		stale_results := prod_head +  Prod_results +'\n' + Cert_head + Cert_results;
														
    
      

		main_head := 	'*************************************************************************************' + '\n' +
									'Data Deployment Tracking Report' + '\n' +
									'This report is produced by Scoring QA. Please send comments to Scoring_QA@risk.lexisnexis.com' + '\n' +
									'*************************************************************************************';
									

	


		final_results := 	main_head + '\n' +
											qa_nonFCRA_results + '\n' +
											qa_FCRA_results + '\n' +
											prod_nonFCRA_results + '\n' +
											prod_FCRA_results + '\n' + stale_results ;
		
		// return FileServices.SendEmail('nathan.koubsky@lexisnexis.com; todd.steil@lexisnexis.com', 'TEST: Data Deployment Tracking Report - ' + ut.getdate, final_results):
		// return FileServices.SendEmail('nathan.koubsky@lexisnexis.com', 'TEST: Data Deployment Tracking Report - ' + ut.getdate, final_results):
		// email := FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.DDT_general_list, 'TEST: Data Deployment Tracking Report', final_results):
		email_send := FileServices.SendEmail(email, 'Data Deployment Tracking Report', final_results):
																	FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.DDT_fail_list,'DDT tracking job failed','The failed workunit is: ' + WORKUNIT + '; ' + FAILMESSAGE));

		seq := sequential(WriteCertHistoryFile, email_send);

		return seq;
end;