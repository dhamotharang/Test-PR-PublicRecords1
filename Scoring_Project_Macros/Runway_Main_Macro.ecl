EXPORT Runway_Main_Macro ( bs_version, fcraroxie_IP, neutralroxie_IP, Thread, Timeouts, Retry, Input_file_name, Output_file_name, records_ToRun):= functionmacro

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
String my_file := Input_file_name;
String outfile_name :=  Output_file_name ;
bs_out_file := '~Scoring_Project::out::temp_bs_out_file';
fcra_bs_out_file := '~Scoring_Project::out::temp_fcra_bs_out_file';

//No longer needed but will keep in case these are run separately
nonfcra_runway_out_file := '~Scoring_Project::out::nonfcra_runway_file_out';
fcra_runway_out_file := '~Scoring_Project::out::fcra_runway_file_out';

//===========Start============

nonfcra_bs_file := Scoring_Project_Macros.BocaShell_50_nonFCRA_cert_MACRO( Version, neutralroxie_IP, neutralroxieIP, Threads, Timeout, Retry, my_file, bs_out_file, no_of_records);
// output(bs_file, named('bs_file'));

fcra_bs_file := Scoring_Project_Macros.BocaShell_50_FCRA_cert_MACRO( Version, roxieIP, neutralroxieIP, Threads, Timeout, Retry, my_file, fcra_bs_out_file, no_of_records);
// output(bs_file, named('bs_file'));

step1 := Parallel(nonfcra_bs_file, fcra_bs_file);

nonfcra_runway_file := Scoring_Project_Macros.Runway_NonFCRA_Macro( bs_version, neutralroxie_IP, Thread, Timeout, Retry, bs_out_file, nonfcra_runway_out_file, records_ToRun);
// output(nonfcra_runway_file, named('nonfcra_runway_file'));

fcra_runway_file := Scoring_Project_Macros.Runway_FCRA_Macro( bs_version, neutralroxie_IP, Thread, Timeout, Retry, fcra_bs_out_file, fcra_runway_out_file, records_ToRun);
// output(fcra_runway_file, named('fcra_runway_file'));

all_runway:= Scoring_Project_Macros.Runway_Join_Function(nonfcra_runway_file, fcra_runway_file);
step2:= output(all_runway, named('All_Runway_Results')); 

stat_set := zz_Koubsky.macro_get_stats(all_runway);
step3:= output(choosen(stat_set, all), named('Results_statistics'));

Final := SEQUENTIAL(step1, step2, step3);

RETURN Final;

EndMacro;