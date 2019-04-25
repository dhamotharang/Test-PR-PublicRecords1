// EXPORT ScoringQA_Phone_Shells := 'todo';


import RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking, ut,sghatti,Gateway, Scoring_Project_ISS,Scoring_QA_Core_Testing, Std;
// filetag := Std.Date.Today() +'_Core_PhonesPlus_Second';
filetag := ut.GetDate;
// roxie_ip_cert := RiskWise.Shortcuts.Dev156; 
roxie_ip_cert := RiskWise.Shortcuts.core_97_roxieIP; 
// roxie_ip_cert := RiskWise.Shortcuts.prod_batch_neutral; 
Thread_ := 4;
timeout_ := 30;
// no_of_recs_to_run := 25000;  //slim down, else too big
no_of_recs_to_run := 5;  //slim down, else too big
Retry_ := 3;
model :='COLLECTIONSCORE_V3'; //'PHONESCORE_V2';//
Input_file_name := Scoring_Project_PIP.Input_Sample_Names.phone_shell_core_testing_copy;  

Output_file_name_Cert := '~ScoringQA::out::phone_shell_'+model+'_production_phone_shell_' + filetag;
// run := Scoring_QA_Core_Testing.PhoneShell_Macro(roxie_ip_cert, model, roxie_ip_cert, Thread_,timeout_,Retry_,Input_file_name,Output_file_name_Cert,no_of_recs_to_run);

Output_file_name_Cert2 := '~ScoringQA::out::phone_shell_'+model+'_version_10_' + filetag;
run2 := Scoring_QA_Core_Testing.Phone_shell_20_macro(roxie_ip_cert, model, roxie_ip_cert, Thread_,timeout_,Retry_,Input_file_name,Output_file_name_Cert2,no_of_recs_to_run,10);


Output_file_name_Cert3 := '~ScoringQA::out::phone_shell_'+model+'_version_20_' + filetag;
run3 := Scoring_QA_Core_Testing.Phone_shell_20_macro(roxie_ip_cert, model, roxie_ip_cert, Thread_,timeout_,Retry_,Input_file_name,Output_file_name_Cert3,no_of_recs_to_run,20);

sequential(run2,run3);
// run1;
// run2;
// run3;
