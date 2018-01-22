EXPORT BWR_Phone_Shell_Collections := 'todo';


filetag := ut.GetDate+'_1';
roxie_ip_cert := RiskWise.Shortcuts.Staging_Neutral_RoxieIP; // Staging/Cert Roxie
roxie_ip_prod := RiskWise.Shortcuts.Prod_Batch_Neutral; // Production Roxie
Thread_ := 1;
timeout_ := 30;
records_ToRun := 25000;  //slim down, else too big
Retry_ := 3;
Input_file_name := data_services.foreign_prod + 'thor_200::out::inquiry_acclogs::inquiry_test::collections::internal_w20140218-105428';  //Used in Relatives Testing
// Input_file_name := '~bweiner::in::jul17_1p_pii.csv';  //Used in Relatives Testing
Output_file_name_Cert := '~ScoringQA::out::phone_shell_Cert_' + filetag;
Output_file_name_prod := '~ScoringQA::out::phone_shell_Prod_' + filetag;


Scoring_Project_PIP.Phone_Shell_Macro(roxie_ip_cert,  Thread_, timeout_, Retry_, Input_file_name, Output_file_name_Cert, records_ToRun);
Scoring_Project_PIP.Phone_Shell_Macro(roxie_ip_prod,  Thread_, timeout_, Retry_, Input_file_name, Output_file_name_prod, records_ToRun);

Scoring_Project_Macros.Phone_Shell_Cert_Tracking_Report; //automatically compares today vs yesterday


Scoring_Project_Macros.BWR_Phone_Shell_Compare('~scoringqa::out::phone_shell_cert_20180111_1.csv','~scoringqa::out::phone_shell_cert_20180112_1.csv');//depending on size might need to run on 50way