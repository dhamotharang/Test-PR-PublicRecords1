
// #WORKUNIT('name', 'Phone_Shell_10');
#WORKUNIT('name', 'Phone_Shell_21');
// #WORKUNIT('name', 'Boca_Shell_41');
// #WORKUNIT('priority','high');

import riskwise, std, zz_bkarnatz;

// Roxie := RiskWise.Shortcuts.Dev156; // Dev156 Fusion Roxie
// Roxie := RiskWise.Shortcuts.prod_batch_analytics_roxie; // Production Roxie
Roxie := RiskWise.Shortcuts.Staging_Neutral_RoxieIP; // Staging/Cert Roxie
// Roxie := Riskwise.shortcuts.core_97_roxieIP; // Core Roxie

//2-3 threads on a 50-way and 2 requests(workunits) at a time.
Thread := 2; // Number of Parallel threads to SOAPCALL with
// RecstoRun := 5;   // Number of records to run through the service - set to 0 to run all
RecstoRun := 0;   // Number of records to run through the service - set to 0 to run all

// DRMOff := '0000000000000000000000000'; //orig Phone shell setting                   No Restrictions
DRM := '101000000000000000000000000'; //No Fares or Experian Business Reports    Restrictions
// DRM_new := '0000000000000101000000000000000000000000'; // based on product settings-amounts to Experian FCRA Header OFF and Inquiries OFF

// EQGateway := TRUE; // Equifax gateway model  Gateway
EQGatewayOff := FALSE; // no Equifax gateway    No Gateway

// PSVersion := 10;
PSVersion := 21;
// PSVersion := 20;

// BaseTest := 'Base_20181217b';
// BaseTest := 'Second_20181219a';
// BaseTest := 'Second_20181219b_Neustar_Exclusive';
// BaseTest := 'Second_20181219b_nov18_jan19_input';
// BaseTest := 'BSMatch';
// BaseTest := 'NeustarExclusive_Cert';
// BaseTest := 'nov18_jan19_input_Cert_second_RR';
BaseTest := 'daily_collect';
// BaseTest := 'combine_jul_sep19_3k';
// BaseTest := 'combine_jul_sep19_9k';

// ProjectName := 'PhonesPlusV2_Gong_Neustar';
// ProjectName := 'Timing';
// ProjectName := 'PhonesShellV2_';
ProjectName := 'PhonesmodelV21_';
// OptionsName1 := 'Gateway_NoRestrictions';
// OptionsName2 := 'Gateway_Restrictions';
// OptionsName3 := 'NoGateway_NoRestrictions';
OptionsName4 := 'NoGateway_Restrictions';
// BocaOptions1 := 'NoRestrictions';
// BocaOptions2 := 'Restrictions';


// Baseline(Current Production Version) : 20181217b
// Prod + Neustar : 20181219a
// Prod + Neustar + New Gong File : 20181219b


Sequential(
						// zz_bkarnatz.PhoneShell.Phone_Shell_Macro(ProjectName, OptionsName1, BaseTest, Roxie, Thread, RecstoRun, PSVersion, DRMOff, EQGateway));
						// zz_bkarnatz.PhoneShell.Phone_Shell_Macro(ProjectName, OptionsName2, BaseTest, Roxie, Thread, RecstoRun, PSVersion, DRM, EQGateway))
						
						// zz_bkarnatz.PhoneShell.Phone_Shell_Macro(ProjectName, OptionsName3, BaseTest, Roxie, Thread, RecstoRun, PSVersion, DRMOff, EQGatewayOff),
						zz_bkarnatz.PhoneShell.Phone_Shell_Macro(ProjectName, OptionsName4, BaseTest, Roxie, Thread, RecstoRun, PSVersion, DRM, EQGatewayOff))
						// zz_bkarnatz.PhoneShell.BocaShell_41_Macro(ProjectName, BocaOptions1, BaseTest, Roxie, Thread, RecstoRun, DRMOff),
						// zz_bkarnatz.PhoneShell.BocaShell_41_Macro(ProjectName, BocaOptions2, BaseTest, Roxie, Thread, RecstoRun, DRM))

					 // : WHEN(CRON('5 5 * * *')),
					 // : WHEN(CRON('11 5 * * *')),
 // : SUCCESS(FileServices.SendEmail('isabel.ma@lexisnexisrisk.com','PhonesShell_test_Completed','The Completed workunit is:' + workunit));
 // : SUCCESS(FileServices.SendEmail('isabel.ma@lexisnexisrisk.com','Bocashell_41_test_Completed','The Completed workunit is:' + workunit));
