﻿EXPORT BWR_BocaShell_w_params_slim(STRING neutralroxieIP, STRING fcra_roxieIP, INTEGER no_of_threads, INTEGER no_of_recs_to_run, STRING filetag) := function

import RiskWise, sghatti, ut, scoring_project_pip;

Timeout := 120;
Retry_time := 3;

bocashell_infile_name :=  Scoring_Project_PIP.Input_Sample_Names.bocashell_infile_name;																						
bocashell_41_cert_fcra_outfile_name := '~scoringqa::out::bs_41_tracking_edina_fcra_NO_EDINA_' + filetag + '_'  + ut.GetDate;
bocashell_41_cert_nonfcra_outfile_name := '~scoringqa::out::bs_41_tracking_edina_nonfcra_NO_EDINA_' + filetag + '_'  + ut.GetDate;

bocashell_50_cert_fcra_outfile_name := '~scoringqa::out::tracking::bocashell50::cert_bs_50_FCRA_NO_EDINA_' + filetag + '_'  + ut.GetDate;
bocashell_50_cert_nonfcra_outfile_name := '~scoringqa::out::tracking::bocashell50::cert_bs_50_nonFCRA_NO_EDINA_' + filetag + '_'  + ut.GetDate;

bocashell_cert_fcra_41 := Scoring_Project_Macros.BocaShell_50_FCRA_cert_MACRO( 41, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_infile_name,bocashell_41_cert_fcra_outfile_name,no_of_recs_to_run);
bocashell_cert_nonfcra_41 := Scoring_Project_Macros.BocaShell_50_nonFCRA_cert_MACRO( 41, neutralroxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_infile_name,bocashell_41_cert_nonfcra_outfile_name,no_of_recs_to_run);
bocashell_cert_fcra_50 := Scoring_Project_Macros.BocaShell_50_FCRA_cert_MACRO( 50, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_infile_name, bocashell_50_cert_fcra_outfile_name, no_of_recs_to_run);
bocashell_cert_nonfcra_50 := Scoring_Project_Macros.BocaShell_50_nonFCRA_cert_MACRO( 50, neutralroxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_infile_name,bocashell_50_cert_nonfcra_outfile_name, no_of_recs_to_run);

RETURN Sequential(
						bocashell_cert_fcra_41, 
						bocashell_cert_nonfcra_41
						// bocashell_cert_fcra_50,
						// bocashell_cert_nonfcra_50
						);
end;