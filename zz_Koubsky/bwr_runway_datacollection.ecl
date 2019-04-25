// EXPORT bwr_runway_datacollection := 'todo';

IMPORT Scoring_Project_Macros, riskwise;

INTEGER bs_version := 41; // bs_version, 
STRING nonfcraroxie_IP := riskwise.shortcuts.staging_neutral_roxieIP; // nonfcraroxie_IP, 
INTEGER Thread := 1; // Thread, 
INTEGER Timeout := 120; // Timeout, 
INTEGER Retry := 3; // Retry, 
// STRING Input_file_name := '~scoringqa::out::bs_41_tracking_edina_nonfcra_no_edina_ben_baseline_bs41_20140606'; // Input_file_name, 
// STRING Input_file_name := '~scoringqa::out::bs_41_tracking_edina_nonfcra_no_edina_ben_test_bs41_20140606'; // Input_file_name, 
STRING Input_file_name := '~scoringqa::out::bs_41_tracking_edina_nonfcra_no_edina_ben_testfile_crim_bs41_20140609'; // Input_file_name, 
// STRING Output_file_name := '~nkoubsky::out::LAB_runway_baseline_' + thorlib.wuid(); // Output_file_name, 
STRING Output_file_name := '~nkoubsky::out::LAB_runway_secondrun_' + thorlib.wuid(); // Output_file_name, 
INTEGER records_ToRun := 25000; // records_ToRun																						

Scoring_Project_Macros.Runway_NonFCRA_Macro(
																						bs_version, 
																						nonfcraroxie_IP, 
																						nonfcraroxie_IP, 
																						Thread, 
																						Timeout, 
																						Retry, 
																						Input_file_name, 
																						Output_file_name, 
																						records_ToRun																						
																						);