// #workunit('name','NonFCRA-Bocashell 4.1');
#workunit('name','FCRA-Bocashell 4.1');

import risk_indicators, ut, ashirey, riskprocessing.layouts;

eyeball := 50;

input_lay := RECORD
	riskprocessing.layouts.layout_internal_shell;
	// unsigned8 time_ms := 0;
	// STRING30 AccountNumber;
	// risk_indicators.Layout_Boca_Shell;
	// STRING200 errorcode;
END;

/*	
slim_rec := RECORD
	STRING30 																										AccountNumber;
	unsigned6 																									did;
	risk_indicators.Layout_Boca_Shell.Shell_Input								Shell_Input;
	// risk_indicators.Layout_Boca_Shell.BJL 											BJL;	
	// risk_indicators.Layout_Boca_Shell.Address_Verification 		Address_Verification;	
	// risk_indicators.Layout_Boca_Shell.fdattributesv2 					fdattributesv2;	
	// risk_indicators.Layout_Boca_Shell.SSN_Verification					SSN_Verification;
	// risk_indicators.Layout_Boca_Shell.iid											iid;
END;
*/

// basefilename := '~scoringqa::out::bs_41_tracking_edina_nonfcra_no_edina_dave_nuestar_baseline_test_20150128'; 
// testfilename := '~scoringqa::out::bs_41_tracking_edina_nonfcra_no_edina_dave_neustar_test_20150129';
basefilename := '~scoringqa::out::bs_41_tracking_edina_fcra_no_edina_dave_nuestar_baseline_test_20150128'; 
testfilename := '~scoringqa::out::bs_41_tracking_edina_fcra_no_edina_dave_neustar_test_20150129';

ds_baseline := PROJECT(dataset(basefilename, input_lay, thor), TRANSFORM(input_lay, SELF.time_ms := 0; SELF := LEFT));
ds_new := PROJECT(dataset(testfilename, zz_Koubsky.temp_layout.bs_lay, thor), TRANSFORM(input_lay, SELF.time_ms := 0; SELF := LEFT));

   
output(choosen(ds_baseline, eyeball), NAMED('ds_baseline'));
output(choosen(ds_new, eyeball), NAMED('ds_new'));
output(COUNT(ds_baseline), NAMED('slim_baseline_count'));
output(COUNT(ds_new), NAMED('slim_new_count'));

/*
// at_name := 'velocity_counters.phones_per_addr_multiple_use';
// at_name := 'velocity_counters__phones_per_addr_created_6months';
// at_name := 'velocity_counters__phones_per_addr_current';
// at_name := 'velocity_counters__phones_per_addr';
// at_name := 'address_verification__edamatchlevel';
// at_name := 'iid__chronomatchlevel';
// at_name := 'velocity_counters__phones_per_adl';
// at_name := 'header_summary__phones_on_file';
// at_name := 'phone_verification__gong_did__gong_did_phone_ct';
// at_name := 'phone_verification__recent_disconnects';
// at_name := 'velocity_counters__phones_per_adl_created_6months';
// at_name := 'velocity_counters__adls_per_phone_multiple_use';

j := join(ds_baseline, ds_new, left.AccountNumber=right.AccountNumber,
					transform( {string AccountNumber}, self.AccountNumber := left.AccountNumber));

j_left := join(ds_baseline, ds_new, left.AccountNumber=right.AccountNumber 
					and left.#expand(at_name) <> right.#expand(at_name),
					transform(input_lay, self := left));

j_right := join(ds_baseline, ds_new, left.AccountNumber=right.AccountNumber 
					and left.#expand(at_name) <> right.#expand(at_name),
					transform(input_lay, self := right));
					
j_1 := join(j_left, j_right, left.AccountNumber=right.AccountNumber,
					transform( {dataset (input_lay) res}, self.res := left + right) );
					
					
j_30 := join(j_left, j_right, left.AccountNumber=right.AccountNumber,
					transform( {integer total}, self.total := (integer) right.#expand(at_name) - (integer) left.#expand(at_name)));
					
t_30 := table(j_30, 
		{	total;
			total_change := count(group)}, 
			total);

output(at_name);
output(count(j), named('joined_count'));
output(t_30, named('stats_total'));
output(choosen(j_1, 50), named('diff_detail'));
*/

ashirey.flatten(ds_baseline, flatten_baseline);
ashirey.flatten(ds_new, flatten_second);
ashirey.Diff(flatten_baseline, flatten_second, ['AccountNumber'], j2, 'BocaShell' );

OUTPUT(COUNT(j2) / 2, NAMED('macro_differences_count'));
// OUTPUT(CHOOSEN(j2, eyeball * 2), NAMED('macro_differences'));

