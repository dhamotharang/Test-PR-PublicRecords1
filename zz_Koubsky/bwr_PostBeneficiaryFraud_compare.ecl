/* *****************************************************
This bwr runs two regressions for PostBeneficiaryFraud
against selected environments.

Run on infinband_hthor if hitting prod

If running on a one-way use 30 threads
If running on a 50-way use 1 thread
***************************************************** */

IMPORT riskwise, ut;

// ****** Baseline Run Settings ******
// roxieIP_1 := riskwise.shortcuts.prod_batch_neutral;
roxieIP_1 := riskwise.shortcuts.staging_neutral_roxieIP;
outfile_name_1 := '~ScoringQA::out::PostBeneficiaryFraud_regression_test_baseline_' +  ut.GetDate;

// ****** Baseline Run Settings ******
// roxieIP_2 := riskwise.shortcuts.prod_batch_neutral;
// roxieIP_2 := riskwise.shortcuts.staging_neutral_roxieIP;
roxieIP_2 := RiskWise.Shortcuts.Dev196;
outfile_name_2 := '~ScoringQA::out::PostBeneficiaryFraud_regression_test_second_' +  ut.GetDate;

// ****** Settings For Both Runs ******
retry := 3;
timeout := 120;
threads := 30;
num_records := 10000;
infile_name := ut.foreign_prod + '~scoring_project::in::riskview_xml_generic_version4_20140528';

// ****** Settings For comparison output ******
eyeball := 20;


// ****** ACTIONS: No modification needed ******
run_1 := zz_Koubsky.bwr_PostBeneficiaryFraud(	roxieIP_1,
																							// Gateway, 
																							threads, 
																							timeout, 
																							retry, 
																							infile_name,
																							outfile_name_1, 
																							num_records
																							);
																					
run_2 := zz_Koubsky.bwr_PostBeneficiaryFraud(	roxieIP_2,
																							// Gateway, 
																							threads, 
																							timeout, 
																							retry, 
																							infile_name,
																							outfile_name_2, 
																							num_records
																							);		


ds_results_baseline := DATASET(outfile_name_1, Models.Layout_PostBeneficiaryFraud.Final_Output, CSV(HEADING(single), QUOTE('"')));
ds_results_second := DATASET(outfile_name_2, Models.Layout_PostBeneficiaryFraud.Final_Output, CSV(HEADING(single), QUOTE('"')));

// SEQUENTIAL(run_1, run_2);
run_1;
run_2;

// ****** ACTIONS: Generates comparisons ******
ashirey.Diff(ds_results_baseline, ds_results_second, ['acctno'], j2, 'PBF' );
OUTPUT(COUNT(j2) / 2, NAMED('macro_differences_count'));
OUTPUT(CHOOSEN(j2, eyeball * 2), NAMED('macro_differences'));
