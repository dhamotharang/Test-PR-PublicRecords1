// EXPORT BWR_Modeling_Collections := 'todo';


#Workunit('name','Core PhonesPlus Base');
// #Workunit('name','Core PhonesPlus Second');
// #Workunit('name','Core Test');

// #WORKUNIT('priority','high');

IMPORT Risk_Indicators, RiskWise, std, riskprocessing, zz_bkarnatz;


// NeutralRoxie :=riskwise.shortcuts.core_96_roxieIP;//old
Roxie :=riskwise.shortcuts.core_97_roxieIP;

//4 threads on a 50-way and 2 requests(workunits) at a time.
Threads := 4;
Records_1 := 0;        //0 records to run all

Name := 'GongNeustar_PhonesPlusV2_20181217b_Base';        //normal Production-like file
// Name := 'GongNeustar_PhonesPlusV2_20181219b_Second';         //Production + Gong + Neustar
// Name := 'Core_TEST';

Sequential(
					 // zz_bkarnatz.PhoneShell.Modeling.BocaShell_30_NonFCRA_Macro(Roxie, Threads, Records_1, Name),
					 // zz_bkarnatz.PhoneShell.Modeling.BocaShell_41_NonFCRA_Macro(Roxie, Threads, Records_1, Name),
					 // zz_bkarnatz.PhoneShell.Modeling.BocaShell_51_NonFCRA_Macro(Roxie, Threads, Records_1, Name),
					 // zz_bkarnatz.PhoneShell.Modeling.FPv3_Score_Macro(Roxie, Threads, Records_1, Name),
					 // zz_bkarnatz.PhoneShell.Modeling.BocaShell_52_FCRA_Macro(Roxie, Threads, Records_1, Name),
					 // zz_bkarnatz.PhoneShell.Modeling.CIID_Macro(Roxie, Threads, Records_1, Name)

					 // zz_bkarnatz.PhoneShell.Modeling.BIID_20_Macro(Roxie, Threads, Records_1, Name),					 
					 zz_bkarnatz.PhoneShell.Modeling.FPv202_attributes_Macro(Roxie, Threads, Records_1, Name)

					 // zz_bkarnatz.PhoneShell.Modeling.Bus_Shell_22_Macro(Roxie, Threads, Records_1, Name),
					 // zz_bkarnatz.PhoneShell.Modeling.SBA_Non_SBFE_Score_Macro(Roxie, Threads, Records_1, Name)
)
					 // : WHEN(CRON('5 5 * * *')),
 :SUCCESS(FileServices.SendEmail('Benjamin.Karnatz@lexisnexisrisk.com','PhonesPlus_FPV202_base_Completed','The Completed workunit is:' + workunit));
 
