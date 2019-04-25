#Workunit('name', 'Personal Score Tracker');


IMPORT Riskwise, STD, Scoring_Project_Macros, scoring_project_pip, zz_Koubsky; 


Timeout := 120;
Retry_time := 3;
neutralroxieIP := RiskWise.shortcuts.staging_neutral_roxieIP;      // Staging/Cert
fcra_roxieIP :=riskwise.shortcuts.staging_fcra_roxieIP;
InputSampleName := '~ScoringQA::IN::Personal_Score_Tracker';

no_of_threads := 1;
no_of_recs_to_run := 0;
filetag := '1';


bocashell_41_fcra_outfile_name := '~scoringqa::out::bs_41_fcra_NO_EDINA::PersonalScoreTracker_' + (String8)Std.Date.Today() + '_' + filetag;
bocashell_50_fcra_outfile_name := '~scoringqa::out::bs_50_FCRA_NO_EDINA::PersonalScoreTracker_' + (String8)Std.Date.Today() + '_' + filetag;
fcra_41_runway_out_file := '~scoringqa::out::bs_41_fcra_runway_file::PersonalScoreTracker_' + (String8)Std.Date.Today() + '_' + filetag;
fcra_50_runway_out_file := '~scoringqa::out::bs_50_fcra_runway_file::PersonalScoreTracker_' + (String8)Std.Date.Today() + '_' + filetag;

bocashell_41_fcra := Scoring_Project_PIP.BocaShell_41_FCRA_cert_MACRO(41, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time, InputSampleName, bocashell_41_fcra_outfile_name,no_of_recs_to_run);
bocashell_50_fcra := Scoring_Project_PIP.BocaShell_50_FCRA_cert_MACRO(50, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time, InputSampleName, bocashell_50_fcra_outfile_name,no_of_recs_to_run);



fcra_41_runway := Scoring_Project_Macros.Runway_Cert_FCRA_Macro(41, neutralroxieIP, no_of_threads, Timeout, Retry_time, bocashell_41_fcra_outfile_name, fcra_41_runway_out_file, no_of_recs_to_run);
fcra_50_runway := Scoring_Project_Macros.Runway_Cert_FCRA_Macro(50, neutralroxieIP, no_of_threads, Timeout, Retry_time, bocashell_50_fcra_outfile_name, fcra_50_runway_out_file, no_of_recs_to_run);

fcra_41_runway_file := output(fcra_41_runway, named('fcra_41_runway_file'));
fcra_50_runway_file := output(fcra_50_runway, named('fcra_50_runway_file'));

FCRA_41_Runway_stats := zz_Koubsky.macro_get_stats(fcra_41_runway);
FCRA_50_Runway_stats := zz_Koubsky.macro_get_stats(fcra_50_runway);

Runway_41_Results_statistics:= output(choosen(FCRA_41_Runway_stats, all), named('Runway_41_Results_statistics'));
Runway_50_Results_statistics:= output(choosen(FCRA_50_Runway_stats, all), named('Runway_50_Results_statistics'));


// Final := SEQUENTIAL(bocashell_41_fcra, bocashell_50_fcra, fcra_41_runway_file, fcra_50_runway_file, Runway_41_Results_statistics, Runway_50_Results_statistics);
Final := SEQUENTIAL(bocashell_41_fcra, bocashell_50_fcra, fcra_41_runway_file, fcra_50_runway_file);


Final;

