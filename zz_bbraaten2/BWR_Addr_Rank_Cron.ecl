// EXPORT BWR_Addr_Rank_Cron := 'todo';

import RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking, sghatti,Gateway, ut;

		yesterday := ut.date_math(ut.getdate, -1);
		// yesterday := '20170322';
		
		output(yesterday);
		qa_ddt_ds := Scoring_Project_DailyTracking.DDT_GetDeployedDatasets('Q', 'B', '', '');
output(qa_ddt_ds, all);

header_check := qa_ddt_ds(datasetname = 'PersonHeaderKeys');
header_check_2 := header_check(cluster = 'N');
headersort := sort(header_check_2, -buildversion);

output(headersort);

date_form(string rel_date) := function
				a := Stringlib.StringFind(rel_date, '/', 1);
				b := Stringlib.StringFind(rel_date, '/', 2);
				c := b + 4;
				mo := intformat((integer)rel_date[1..(a-1)], 2, 1);
				dom := intformat((integer)rel_date[(a+1)..(b-1)], 2, 1);
				yr := intformat((integer)rel_date[(b+1)..c], 4, 1);
				return yr + mo + dom;
		end;


get_header_dt := date_form(headersort[1].releasedate) = yesterday;

output(get_header_dt);

string build_v := (string)headersort[1].buildversion;
output(build_v);
			
RoxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; 
// RoxieIP := RiskWise.shortcuts.prod_batch_neutral; 



//**** RUNTIME SETTINGS ******
gateway_ip := '';
no_of_threads := 2;
// no_of_threads := 20;
Timeout := 15;
Retry_time := 3;
no_of_recs_to_run := 0;
filetag := ut.GetDate  +'_1'; 
inputfile :=  '~bbraaten::scoringqa::address_rank_input_file_20161111';

outputfile := '~scoringqa::header_'+ build_v+'_didville_best_addr_'+ filetag;
// outputfile := '~bbraaten::test_'+ build_v+'_didville_best_addr_'+ filetag;


didville 	:= zz_bbraaten2.Didville_Best_Addr_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,inputfile,outputfile,no_of_recs_to_run);
// didville 	:= zz_bbraaten2.Didville_Best_Addr_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,inputfile,outputfile,no_of_recs_to_run):RECOVERY(message,10);

		
		
if(get_header_dt = true, didville, output('Header was not updated')):  WHEN(CRON('05 20 * * *')), 
FAILURE(FileServices.SendEmail( 'bridgett.braaten@lexisnexis.com','Didville Best Addr job failed','The failed workunit is:' + workunit + FailMessage));

