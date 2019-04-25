#workunit('name','Nuestar - Runway');

import risk_indicators, riskwise, Scoring_Project_Macros, models, zz_Koubsky;

eyeball := 5;


// ******** input files **************************************
input_lay := RECORD
	unsigned8 time_ms := 0;
	STRING30 AccountNumber;
	risk_indicators.Layout_Boca_Shell;
	STRING200 errorcode;
END;
	
basefilename := '~scoringqa::out::bs_41_tracking_edina_nonfcra_no_edina_nuestar_baseline_20140714'; 
testfilename := '~scoringqa::out::bs_41_tracking_edina_nonfcra_no_edina_nuestar_second_20140714'; 

ds_baseline := dataset(basefilename, input_lay, csv(quote('"'), maxlength(32000), HEADING(1)));
ds_new := dataset(testfilename, input_lay, csv(quote('"'), maxlength(32000), HEADING(1)));
   
output(choosen(ds_baseline, eyeball), NAMED('ds_baseline'));
output(choosen(ds_new, eyeball), NAMED('ds_new'));
output(COUNT(ds_baseline), NAMED('slim_baseline_count'));
output(COUNT(ds_new), NAMED('slim_new_count'));

Runway_lay := RECORD
  models.Layout_Runway;
	STRING errorcode;
END;

FPscores_lay := RECORD
	Unsigned seq := 0;
	Unsigned did := 0;
	string2 NAP;
	string2 NAS;
	string2 CVI_score;
	String3 FP1109_0_0_score := '';
	String3 FP3710_0_0_score := '';
END;

FPscores_lay FPscore_trans (Runway_lay le) := TRANSFORM
	SELF := le;
	SELF := [];
END;


// ******** create modified inputs **************************************

input_lay mod_trans1 (input_lay le, input_lay ri) := TRANSFORM
	SELF.velocity_counters.phones_per_addr_multiple_use := le.velocity_counters.phones_per_addr_multiple_use;
	SELF := ri;
END;

input_lay mod_trans2 (input_lay le, input_lay ri) := TRANSFORM
	SELF.velocity_counters.phones_per_addr := le.velocity_counters.phones_per_addr;
	SELF := ri;
END;

input_lay mod_trans3 (input_lay le, input_lay ri) := TRANSFORM
	SELF.velocity_counters.phones_per_addr_current := le.velocity_counters.phones_per_addr_current;
	SELF := ri;
END;

input_lay mod_trans4 (input_lay le, input_lay ri) := TRANSFORM
	SELF.velocity_counters.phones_per_addr_created_6months := le.velocity_counters.phones_per_addr_created_6months;
	SELF := ri;
END;

ds_phonemultuse_fix := JOIN(ds_baseline, ds_new, LEFT.AccountNumber = RIGHT.AccountNumber, mod_trans1(LEFT, RIGHT));
ds_phoneperaddr_fix := JOIN(ds_baseline, ds_phonemultuse_fix, LEFT.AccountNumber = RIGHT.AccountNumber, mod_trans2(LEFT, RIGHT));
ds_phoneperaddrcurr_fix := JOIN(ds_baseline, ds_phoneperaddr_fix, LEFT.AccountNumber = RIGHT.AccountNumber, mod_trans3(LEFT, RIGHT));
ds_phoneperaddr6mos_fix := JOIN(ds_baseline, ds_phoneperaddrcurr_fix, LEFT.AccountNumber = RIGHT.AccountNumber, mod_trans4(LEFT, RIGHT));

output(choosen(ds_phonemultuse_fix, eyeball), NAMED('ds_phonemultuse_fix'));
output(choosen(ds_phoneperaddr_fix, eyeball), NAMED('ds_phoneperaddr_fix'));
output(choosen(ds_phoneperaddrcurr_fix, eyeball), NAMED('ds_phoneperaddrcurr_fix'));
output(choosen(ds_phoneperaddr6mos_fix, eyeball), NAMED('ds_phoneperaddr6mos_fix'));


// ******** get current scores **************************************

Runway_lay get_runway(dataset(input_lay) inputset) := FUNCTION
		RETURN zz_Koubsky.macro_get_runway( 								41, // bs_version
																												RiskWise.shortcuts.staging_neutral_roxieIP, // neutralroxie_IP
																												RiskWise.shortcuts.staging_neutral_roxieIP, // neutralroxie_IP
																												3, // Thread
																												120, // Timeout
																												2, // Retry
																												// '~Scoring_Project::out::temp_bs_out_file', // bs_out_file
																												inputset, // bs_out_file
																												'~Scoring_Project::out::nonfcra_runway_file_out', // nonfcra_runway_out_file
																												25000 // records_ToRun
																												);
END;

ds1 := get_runway(ds_baseline);
runway_base := PROJECT(ds1, FPscore_trans(LEFT));
output(choosen(runway_base, eyeball), named('ds_runway_base'));

ds2 := get_runway(ds_new);
runway_full_Nuestar := PROJECT(ds2, FPscore_trans(LEFT));
output(choosen(runway_full_Nuestar, eyeball), named('ds_runway_full_Nuestar'));

ds3 := get_runway(ds_phonemultuse_fix);
runway_phonemultuse_fix := PROJECT(ds3, FPscore_trans(LEFT));
output(choosen(runway_phonemultuse_fix, eyeball), named('runway_phonemultuse_fix'));

ds4 := get_runway(ds_phoneperaddr_fix);
runway_phoneperaddr_fix := PROJECT(ds4, FPscore_trans(LEFT));
output(choosen(runway_phoneperaddr_fix, eyeball), named('runway_phoneperaddr_fix'));

ds5 := get_runway(ds_phoneperaddrcurr_fix);
runway_phoneperaddrcurr_fix := PROJECT(ds5, FPscore_trans(LEFT));
output(choosen(runway_phoneperaddrcurr_fix, eyeball), named('runway_phoneperaddrcurr_fix'));

ds6 := get_runway(ds_phoneperaddr6mos_fix);
runway_phoneperaddr6mos_fix := PROJECT(ds6, FPscore_trans(LEFT));
output(choosen(runway_phoneperaddr6mos_fix, eyeball), named('runway_phoneperaddr6mos_fix'));

// ******** get score stats **************************************
macro_get_stats(ds_name1, ds_name2) := FUNCTIONMACRO
	ds_stat_set :=
		zz_Koubsky.macro_runway_stats(ds_name1, ds_name2, 'NAP') +
		zz_Koubsky.macro_runway_stats(ds_name1, ds_name2, 'NAS') +
		zz_Koubsky.macro_runway_stats(ds_name1, ds_name2, 'CVI_score') +
		zz_Koubsky.macro_runway_stats(ds_name1, ds_name2, 'FP1109_0_0_score') +
		zz_Koubsky.macro_runway_stats(ds_name1, ds_name2, 'FP3710_0_0_score');
	RETURN ds_stat_set;
endmacro;

OUTPUT( macro_get_stats(runway_base, runway_full_Nuestar), NAMED('base_to_Nuestar_stats'));
OUTPUT( macro_get_stats(runway_base, runway_phonemultuse_fix), NAMED('base_to_phonemultuse_stats'));
OUTPUT( macro_get_stats(runway_base, runway_phoneperaddr_fix), NAMED('base_to_phoneperaddr_stats'));
OUTPUT( macro_get_stats(runway_base, runway_phoneperaddrcurr_fix), NAMED('base_to_honeperaddrcurr_stats'));
OUTPUT( macro_get_stats(runway_base, runway_phoneperaddr6mos_fix), NAMED('base_to_phoneperaddr6mos_stats'));
