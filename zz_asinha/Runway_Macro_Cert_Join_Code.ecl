EXPORT Runway_Macro_Cert_Join_Code(dt) := functionmacro

IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT, zz_Koubsky, Scoring_Project_Macros, ut;

// Test settings
unsigned8 records_ToRun := 50000;
integer Retry := 3;
integer Timeout := 120;
integer Thread := 20;
integer bs_version := 41;

String neutralroxie_IP := RiskWise.shortcuts.staging_neutral_roxieIP; 
String roxieIP := Riskwise.shortcuts.staging_fcra_roxieIP ;

// dt := ut.GetDate;
// tag:=ut.foreign_prod_boca;

nonfcra_bs_out_cert_file_curr := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_' + dt + '_1';
fcra_bs_out_cert_file_curr := '~scoringqa::out::fcra::bocashell_41_historydate_999999_cert_' + dt + '_1';


nonfcra_runway_out_cert_file_curr := '~Scoring_Project::out::nonfcra_runway_file_cert_out_' + dt + '_1';
fcra_runway_out_cert_file_curr := '~Scoring_Project::out::fcra_runway_file_cert_out_' + dt + '_1';

//===========Start============

nonfcra_runway_file_cert_curr := test_apaar.Runway_Cert_NonFCRA_Macro( bs_version, neutralroxie_IP, Thread, Timeout, Retry, nonfcra_bs_out_cert_file_curr, nonfcra_runway_out_cert_file_curr, records_ToRun);


fcra_runway_file_cert_curr := test_apaar.Runway_Cert_FCRA_Macro( bs_version, neutralroxie_IP, Thread, Timeout, Retry, fcra_bs_out_cert_file_curr, fcra_runway_out_cert_file_curr, records_ToRun);

all_runway_curr_cert:= test_apaar.Runway_Cert_Join_Function(nonfcra_runway_file_cert_curr, fcra_runway_file_cert_curr, dt);

return all_runway_curr_cert;

endmacro;
	