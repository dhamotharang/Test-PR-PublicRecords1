EXPORT Runway_Main_Macro_Auto ( bs_version, fcraroxie_IP, neutralroxie_IP, Thread, Timeouts, Retry, records_ToRun):= functionmacro
//EXPORT Runway_Main_Macro_Auto ( bs_version, fcraroxie_IP, neutralroxie_IP, Thread, Timeouts, Retry, Input_file_name, Output_file_name, records_ToRun):= functionmacro

IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT, zz_Koubsky;

// Test settings
// unsigned8 records_ToRun := 10;
// integer Retry := 3;
// integer Timeout := 120;
// integer Thread := 1;
// integer bs_version := 41;

// String neutralroxie_IP := RiskWise.shortcuts.staging_neutral_roxieIP; 
// String roxieIP := Riskwise.shortcuts.staging_fcra_roxieIP ;

// my_file := '~scoring_project::in::riskviewattributes_v3_batch_experian_attributes_20140710';

//**** RUNTIME SETTINGS ******
unsigned8 no_of_records := records_ToRun;
integer Retry := retry;
integer Timeout := Timeouts;
integer Threads := Thread;
integer Version := bs_version;

String neutralroxieIP := neutralroxie_IP ; 
String roxieIP := fcraroxie_IP ;

//=========Files===============
//String my_file := Input_file_name;
//String outfile_name :=  Output_file_name ;
bs_out_file := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_prod_' + ut.getdate + '_1';
fcra_bs_out_file := '~scoringqa::out::fcra::bocashell_41_historydate_999999_prod_' + ut.getdate + '_1';

//No longer needed but will keep in case these are run separately
nonfcra_runway_out_file := '~Scoring_Project::out::nonfcra_runway_file_out';
fcra_runway_out_file := '~Scoring_Project::out::fcra_runway_file_out';

//===========Start============

nonfcra_runway_file := Scoring_Project_Macros.Runway_NonFCRA_Macro( bs_version, neutralroxie_IP, Thread, Timeout, Retry, bs_out_file, nonfcra_runway_out_file, records_ToRun);
// output(nonfcra_runway_file, named('nonfcra_runway_file'));

fcra_runway_file := Scoring_Project_Macros.Runway_FCRA_Macro( bs_version, neutralroxie_IP, Thread, Timeout, Retry, fcra_bs_out_file, fcra_runway_out_file, records_ToRun);
// output(fcra_runway_file, named('fcra_runway_file'));

all_runway:= Scoring_Project_Macros.Runway_Join_Function(nonfcra_runway_file, fcra_runway_file);
// step1:= output(all_runway, named('All_Runway_Results'));
step1 := output(all_runway,,'~Scoringqa::out::All_Runway_Results_' + ut.getdate, CSV(heading(single), quote('"')), overwrite);

stat_set := zz_Koubsky.macro_get_stats(all_runway);
// step2:= output(stat_set, named('Results_statistics'));
step2 := output(stat_set,,'~Scoringqa::out::All_Runway_Stats_' + ut.getdate, CSV(heading(single), quote('"')), overwrite);

Final := SEQUENTIAL( step1, step2):
		FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.fail_list,'Auto Runway Cron job failed. ','The failed workunit is:' + WORKUNIT + FAILMESSAGE));

RETURN Final;

EndMacro;