import RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking;
import sghatti,Gateway, scoring_qa;
import ut ;


roxieIP_cert := RiskWise.shortcuts.QA_neutral_roxieIP; //  cert
roxieIP_prod := RiskWise.shortcuts.prod_batch_neutral; //  prod


//**** RUNTIME SETTINGS ******
gateway_ip := '';
no_of_threads := 1;
Timeout := 25;
Retry_time := 3;
no_of_recs_to_run :=500;


filetag_cert := ut.GetDate  +'_Cert'; 
filetag_prod := ut.GetDate  +'_Prod'; 

message:=output('IT61 Paro Failed');



IT61_Scores_Paro_msn605_infile    								:= scoring_project_pip.Input_Sample_Names.IT61_Scores_BATCH_Paro_msn605_rsn804_infile;                       //Added 4/6/2016
IT61_Scores_Paro_msn605_outfile_cert 							:= scoring_project_pip.Output_Sample_Names.IT61_Scores_BATCH_Paro_msn605_rsn804_outfile + filetag_cert  ;    //Added 4/6/2016
IT61_Scores_Paro_msn605_outfile_prod 							:= scoring_project_pip.Output_Sample_Names.IT61_Scores_BATCH_Paro_msn605_rsn804_outfile + filetag_prod  ;    //Added 4/6/2016

// Runs it60 & 61 change trib code in macro
IT61_Scores_Paro_msn605_Cert_macro 								:= Scoring_Project_PIP.Paro_IT60_Batch_Cert_Macro(roxieIP_cert, gateway_ip,no_of_threads,Timeout,Retry_time,IT61_Scores_Paro_msn605_infile,IT61_Scores_Paro_msn605_outfile_cert,no_of_recs_to_run):RECOVERY(message,10);
IT61_Scores_Paro_msn605_Prod_macro 								:= Scoring_Project_PIP.Paro_IT60_Batch_Prod_Macro(roxieIP_prod, gateway_ip,no_of_threads,Timeout,Retry_time,IT61_Scores_Paro_msn605_infile,IT61_Scores_Paro_msn605_outfile_prod,no_of_recs_to_run):RECOVERY(message,10);


IT61_Scores_Paro_msn605_Cert_macro;
IT61_Scores_Paro_msn605_Prod_macro;



string cert := IT61_Scores_Paro_msn605_outfile_cert;
string prod := IT61_Scores_Paro_msn605_outfile_prod;

layout := Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_IT61_Paro_Global_Layout;


file1 := dataset(cert, layout, thor);
file2 := dataset(prod, layout, thor);


clean_ds_baseline := file1(errorcode='');
clean_ds_new := file2(errorcode='');


// Scoring_Project_PIP.COMPARE_DSETS_MACRO( clean_ds_baseline, clean_ds_new, ['acctno'], 0);
// Scoring_Project_PIP.CROSSTAB_MACRO(clean_ds_baseline, clean_ds_new, ['acctno'], 'score');


j1 := join(file1, file2, left.acctno = right.acctno
						and abs((integer)left.score - (integer)right.score) > 45,
					 transform({dataset(layout) res}, self.res := left + right));
					 
j1_cnt := count(j1);

boolean flag := if(j1_cnt >5, 1, 0);

output('**** USE THE FOLLOWING OUTPUT TO DETERMINE IF TOMTOM CLEANER NEEDS INVESTIGATION FOR SCORING PRODUCTS ****');
output(if(flag = true, 'Potential Issue: Investigate TomTom Cleaner!', 'Good: No Significant Shifts'), named('Final_TomTom_Cleaner_result'));
if(flag = true, output(choosen(j1, 25), named('Score_Diff_Greater_45_PTS')));


EXPORT Paro_IT61_60_Cert_Prod_Compare := 'todo';