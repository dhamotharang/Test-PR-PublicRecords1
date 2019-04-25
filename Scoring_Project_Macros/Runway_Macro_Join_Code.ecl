EXPORT Runway_Macro_Join_Code(dt) := functionmacro

IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT,  Scoring_Project_Macros, ut;

// Test settings
unsigned8 records_ToRun := 50000;
integer Retry := 3;
integer Timeout := 120;
integer Thread := 1;
integer bs_version := 41;

String neutralroxie_IP := RiskWise.shortcuts.staging_neutral_roxieIP; 
String roxieIP := Riskwise.shortcuts.staging_fcra_roxieIP ;

// dt := ut.GetDate;
tag:='~foreign::' + '10.173.44.105' + '::';
nonfcra_bs_out_file_curr := tag + 'scoringqa::out::nonfcra::bocashell_41_historydate_999999_prod_' + dt + '_1';
fcra_bs_out_file_curr := tag + 'scoringqa::out::fcra::bocashell_41_historydate_999999_prod_' + dt + '_1';


nonfcra_runway_out_file_curr := '~Scoring_Project::out::nonfcra_runway_file_out_' + dt + '_1';
fcra_runway_out_file_curr := '~Scoring_Project::out::fcra_runway_file_out_' + dt + '_1';

//===========Start============

nonfcra_runway_file_curr := Scoring_Project_Macros.Runway_NonFCRA_Macro( bs_version, neutralroxie_IP, Thread, Timeout, Retry, nonfcra_bs_out_file_curr, nonfcra_runway_out_file_curr, records_ToRun);


fcra_runway_file_curr := Scoring_Project_Macros.Runway_FCRA_Macro( bs_version, neutralroxie_IP, Thread, Timeout, Retry, fcra_bs_out_file_curr, fcra_runway_out_file_curr, records_ToRun);

all_runway_curr:= Scoring_Project_Macros.Runway_Join_Function(nonfcra_runway_file_curr, fcra_runway_file_curr, dt);

return all_runway_curr;

endmacro;
	