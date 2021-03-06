// EXPORT BWR_Core_Testing_Products := 'todo';

#Workunit('name','****HIGH PRIORITY**** Ibehavior Testing Baseline');
// #Workunit('name','Core Timing Test');
// #Workunit('name','196 Test');

#WORKUNIT('priority','high');

import riskwise;

// NeutralRoxie :=riskwise.shortcuts.Dev194;
// NeutralRoxie :=riskwise.shortcuts.Dev196;
// NeutralRoxie :=riskwise.shortcuts.cert_OSS_neutral_roxieIP;
// NeutralRoxie :=riskwise.shortcuts.prod_batch_neutral;             //Prod
NeutralRoxie :=riskwise.shortcuts.core_roxieIP;										//Core Roxie
// NeutralRoxie := RiskWise.shortcuts.QA_neutral_roxieIP;            //QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'
// NeutralRoxie := RiskWise.shortcuts.staging_neutral_roxieIP;      // Staging/Cert

// FCRARoxie :=riskwise.shortcuts.Dev194;
// FCRARoxie :=riskwise.shortcuts.Dev196;
FCRARoxie :=riskwise.shortcuts.core_roxieIP;
// FCRARoxie :=riskwise.shortcuts.staging_fcra_roxieIP;
// FCRARoxie :=riskwise.shortcuts.prod_batch_fcra;
Threads_1 := 2;
Threads_2 := 3;
Records_1 := 25000;   //Most NonFCRA and Shells e.g. 25,000
Records_2 := 10000;   //Allows the 12 FP v3 scores to be run at a lower count bc they take so long.  e.g 10,000.
Records_3 := 50000;   //Allows FCRA Products to have higher size. e.g 50,000
Records_4 := 100000;   //Allows Heather's BS Products to have higher size. e.g 100,000
Name := 'core_refreshe_check';
// Name := 'Core_Timing_TEST';


// Sequential(
					 // Scoring_QA_Core_Testing.Core_Testing_Macros(NeutralRoxie, FCRARoxie, Threads_1, Records_1, Records_2, Records_3, Name),
					 // Scoring_QA_Core_Testing.Core_Testing_Errors(Name),
					 // Scoring_QA_Core_Testing.Modeling_Bocashell_FCRA_52(Records_4),
					 // Scoring_QA_Core_Testing.Modeling_Bocashell_nonFCRA_52(Records_4),
					 // Scoring_QA_Core_Testing.Modeling_Bocashell_FCRA_50(NeutralRoxie, FCRARoxie, Threads_2, Records_4, Name),
					 // Scoring_QA_Core_Testing.Modeling_BocaShell_NonFCRA_50(NeutralRoxie, Threads_2, Records_4, Name))	 
// :
// SUCCESS(FileServices.SendEmail('Benjamin.Karnatz@lexisnexis.com','BlackKnight_Second_Completed','The Completed workunit is:' + workunit));
// SUCCESS(FileServices.SendEmail('Benjamin.Karnatz@lexisnexis.com','Core_TEST_Completed','The Completed workunit is:' + workunit));


Sequential(Scoring_QA_Core_Testing.Core_Testing_Macros(NeutralRoxie, FCRARoxie, Threads_1, Records_1, Records_2, Records_3, Name),
					 Scoring_QA_Core_Testing.Core_Testing_Errors(Name),
					 Scoring_QA_Core_Testing.Modeling_Bocashell_FCRA_52(Records_4),
					 Scoring_QA_Core_Testing.Modeling_Bocashell_nonFCRA_52(Records_4));
					 // Scoring_QA_Core_Testing.Modeling_Bocashell_FCRA_50(NeutralRoxie, FCRARoxie, Threads_2, Records_4, Name),
					 // Scoring_QA_Core_Testing.Modeling_BocaShell_NonFCRA_50(NeutralRoxie, Threads_2, Records_4, Name))
					 
					 
					 // : WHEN(CRON('10 4 * * *')),
 // SUCCESS(FileServices.SendEmail('Bridgett.Braaten@lexisnexis.com; Matthew.Ludewig@lexisnexisrisk.com','Ibehavior_Base_Completed','The Completed workunit is:' + workunit));
 // SUCCESS(FileServices.SendEmail('Benjamin.Karnatz@lexisnexis.com','Core_Timing_Test_Completed','The Completed workunit is:' + workunit));
 
