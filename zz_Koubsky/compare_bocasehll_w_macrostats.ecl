// EXPORT compare_bocashell_40_50 := 'todo';

#workunit('name','Bocashell Compare nonFCRA');
// #workunit('name','Bocashell Compare FCRA');
// #workunit('name','NonFCRA-Bocashell 4.1 - May');
// #workunit('name','FCRA-Bocashell 4.1');

import risk_indicators, ut, ashirey;

eyeball := 100;

input_lay := RECORD
	unsigned8 time_ms := 0;
	STRING30 AccountNumber;
	risk_indicators.Layout_Boca_Shell;
	STRING200 errorcode;
END;
	
slim_rec := RECORD
	STRING30 																										AccountNumber;
	unsigned6 																									did;
	risk_indicators.Layout_Boca_Shell.Shell_Input								Shell_Input;
	risk_indicators.Layout_Boca_Shell.Phone_Verification				Phone_Verification;
	risk_indicators.Layout_Boca_Shell.Velocity_Counters					Velocity_Counters;
	string8 gong_ADL_dt_first_seen;
	string8 gong_ADL_dt_last_seen;
	// risk_indicators.Layout_Boca_Shell.BJL 											BJL;	
	// risk_indicators.Layout_Boca_Shell.Address_Verification 		Address_Verification;	
	// risk_indicators.Layout_Boca_Shell.fdattributesv2 					fdattributesv2;	
	// risk_indicators.Layout_Boca_Shell.SSN_Verification					SSN_Verification;
	// risk_indicators.Layout_Boca_Shell.iid											iid;
END;

slim_rec slim_trans(input_lay le) := TRANSFORM
	// SELF.gong_ADL_dt_last_seen := IF( le.gong_ADL_dt_last_seen > '20140630', '20140630', le.gong_ADL_dt_last_seen);
	// SELF.Phone_Verification.gong_did.gong_adl_dt_last_seen_full := IF( le.Phone_Verification.gong_did.gong_adl_dt_last_seen_full > '20140630', '20140630', le.Phone_Verification.gong_did.gong_adl_dt_last_seen_full);
	SELF := le
END;

// basefilename := '~scoringqa::out::bs_41_tracking_edina_nonfcra_no_edina_nuestar_baseline_20140714'; 
// testfilename := '~scoringqa::out::bs_41_tracking_edina_nonfcra_no_edina_nuestar_second_20140714'; 
basefilename := '~scoringqa::out::bs_41_tracking_edina_nonfcra_no_edina_nuestar_baseline_20140724'; 
testfilename := '~scoringqa::out::bs_41_tracking_edina_nonfcra_no_edina_nuestar_second_20140724'; 
// basefilename := '~scoringqa::out::bs_41_tracking_edina_fcra_no_edina_nuestar_baseline_20140724'; 
// testfilename := '~scoringqa::out::bs_41_tracking_edina_fcra_no_edina_nuestar_second_20140724'; 
// basefilename := '~scoringqa::out::tracking::bocashell50::cert_bs_50_fcra_no_edina_nuestar_baseline_20140714'; 
// testfilename := '~scoringqa::out::tracking::bocashell50::cert_bs_50_fcra_no_edina_nuestar_second_20140714'; 

// ds_baseline := dataset(basefilename, input_lay, csv(quote('"'), maxlength(32000), HEADING(1)));
ds_baseline := PROJECT(dataset(basefilename, input_lay, csv(quote('"'), maxlength(32000), HEADING(1))), slim_trans(LEFT));
// ds_baseline := PROJECT(dataset(basefilename, input_lay, csv(quote('"'), maxlength(32000), HEADING(1))), TRANSFORM(input_lay, SELF.time_ms := 0; SELF := LEFT));
// ds_new := dataset(testfilename, input_lay, csv(quote('"'), maxlength(32000), HEADING(1)));
ds_new := PROJECT(dataset(testfilename, input_lay, csv(quote('"'), maxlength(32000), HEADING(1))), slim_trans(LEFT));
// ds_new := PROJECT(dataset(testfilename, input_lay, csv(quote('"'), maxlength(32000), HEADING(1))), TRANSFORM(input_lay, SELF.time_ms := 0; SELF := LEFT));
   
output(choosen(ds_baseline, eyeball), NAMED('ds_baseline'));
output(choosen(ds_new, eyeball), NAMED('ds_new'));
output(COUNT(ds_baseline), NAMED('slim_baseline_count'));
output(COUNT(ds_new), NAMED('slim_new_count'));
   
/*
 cmpr := record, maxlength(50000)
			dataset(slim_rec) res;
		end;
 // blank := DATASET(1, TRANSFORM(slim_rec, SELF.AccountNumber := '-', SELF := []));
 
j1 := JOIN(ds_baseline, ds_new, 
			left.AccountNumber = right.AccountNumber
			AND LEFT.velocity_counters.phones_per_addr_multiple_use <> RIGHT.velocity_counters.phones_per_addr_multiple_use,
			// transform(input_lay, self := left) );
			transform(cmpr, self.res := left + right) );
			// transform(cmpr, self.res := left + right + blank) );
 
OUTPUT(COUNT(j1), NAMED('differences_count'));
OUTPUT(CHOOSEN(j1, eyeball), NAMED('differences'));
*/
ashirey.flatten(ds_baseline, flatten_baseline);
ashirey.flatten(ds_new, flatten_second);
ashirey.Diff(flatten_baseline, flatten_second, ['AccountNumber'], j2, 'BocaShell' );

OUTPUT(COUNT(j2) / 2, NAMED('macro_differences_count'));
OUTPUT(CHOOSEN(j2, eyeball * 2), NAMED('macro_differences'));


/*
macro_stats(ds, at_name) := FUNCTIONMACRO

	stats_layout := RECORD
		STRING name;
		INTEGER count_null;
		INTEGER count_0 ;
		INTEGER count_1 ;
		INTEGER count_2 ;
		INTEGER count_3 ;
		INTEGER count_4 ;
		INTEGER count_5 ;
		INTEGER count_6 ;
		INTEGER count_7 ;
		INTEGER count_8 ;
		INTEGER count_9 ;
		INTEGER count_10 ;
		INTEGER count_11 ;
		INTEGER count_12 ;
		INTEGER count_13 ;
		INTEGER count_14 ;
		INTEGER count_15 ;
		INTEGER count_16 ;
		INTEGER count_17 ;
		INTEGER count_18 ;
		INTEGER count_19 ;
		INTEGER count_20 ;
		INTEGER count_21 ;
		INTEGER count_22 ;
		INTEGER count_23 ;
		INTEGER count_24 ;
		INTEGER count_25 ;
		INTEGER count_26 ;
		INTEGER count_27 ;
		INTEGER count_28 ;
		INTEGER count_29 ;
		INTEGER count_30 ;
		INTEGER count_31 ;
		INTEGER count_32 ;
		INTEGER count_33 ;
		INTEGER count_34 ;
		INTEGER count_35 ;
		INTEGER count_36 ;
		INTEGER count_37 ;
		INTEGER count_38 ;
		INTEGER count_39 ;
		INTEGER count_40 ;
		INTEGER count_41 ;
		INTEGER count_42 ;
		INTEGER count_43 ;
		INTEGER count_44 ;
		INTEGER count_45 ;
		INTEGER count_46 ;
		INTEGER count_47 ;
		INTEGER count_48 ;
		INTEGER count_49 ;
		INTEGER count_50 ;
		INTEGER count_50plus ;

	END;

	stats_layout add_stats(ut.ds_oneRecord le) :=  TRANSFORM
		// SELF.name := at_name;
		// SELF.mean := table(ds_slim, {temp_mean := AVE(group, (real)ds.#expand(at_name))} )[1].temp_mean;
		// SELF.median := (REAL)medn.#expand(at_name);
		// SELF.std_dev := SQRT( VARIANCE(ds_slim, (REAL) #expand(at_name)));
		// SELF.miss_rate := COUNT( ds( (STRING) #expand(at_name) = '')) / full_count;
		// SELF.zero_rate := COUNT( ds( (STRING) #expand(at_name) = '0')) / full_count;
		// SELF.neg_one_rate := COUNT( ds( (STRING) #expand(at_name) = '-1')) / full_count;
		// SELF.hit_rate := 	(full_count -
											// COUNT( ds( (STRING) #expand(at_name) = '')) -
											// COUNT( ds( (STRING) #expand(at_name) = '0')) -
											// COUNT( ds( (STRING) #expand(at_name) = '-1')) )
											// / full_count;	
		SELF.name := at_name;
		SELF.count_null := COUNT( ds( (STRING) #expand(at_name) = ''));
		SELF.count_0 := COUNT( ds( (STRING) #expand(at_name) = '0'));
		SELF.count_1 := COUNT( ds( (STRING) #expand(at_name) = '1'));
		SELF.count_2 := COUNT( ds( (STRING) #expand(at_name) = '2'));
		SELF.count_3 := COUNT( ds( (STRING) #expand(at_name) = '3'));
		SELF.count_4 := COUNT( ds( (STRING) #expand(at_name) = '4'));
		SELF.count_5 := COUNT( ds( (STRING) #expand(at_name) = '5'));
		SELF.count_6 := COUNT( ds( (STRING) #expand(at_name) = '6'));
		SELF.count_7 := COUNT( ds( (STRING) #expand(at_name) = '7'));
		SELF.count_8 := COUNT( ds( (STRING) #expand(at_name) = '8'));
		SELF.count_9 := COUNT( ds( (STRING) #expand(at_name) = '9'));
		SELF.count_10 := COUNT( ds( (STRING) #expand(at_name) = '10'));
		SELF.count_11 := COUNT( ds( (STRING) #expand(at_name) = '11'));
		SELF.count_12 := COUNT( ds( (STRING) #expand(at_name) = '12'));
		SELF.count_13 := COUNT( ds( (STRING) #expand(at_name) = '13'));
		SELF.count_14 := COUNT( ds( (STRING) #expand(at_name) = '14'));
		SELF.count_15 := COUNT( ds( (STRING) #expand(at_name) = '15'));
		SELF.count_16 := COUNT( ds( (STRING) #expand(at_name) = '16'));
		SELF.count_17 := COUNT( ds( (STRING) #expand(at_name) = '17'));
		SELF.count_18 := COUNT( ds( (STRING) #expand(at_name) = '18'));
		SELF.count_19 := COUNT( ds( (STRING) #expand(at_name) = '19'));
		SELF.count_20 := COUNT( ds( (STRING) #expand(at_name) = '20'));
		SELF.count_21 := COUNT( ds( (STRING) #expand(at_name) = '21'));
		SELF.count_22 := COUNT( ds( (STRING) #expand(at_name) = '22'));
		SELF.count_23 := COUNT( ds( (STRING) #expand(at_name) = '23'));
		SELF.count_24 := COUNT( ds( (STRING) #expand(at_name) = '24'));
		SELF.count_25 := COUNT( ds( (STRING) #expand(at_name) = '25'));
		SELF.count_26 := COUNT( ds( (STRING) #expand(at_name) = '26'));
		SELF.count_27 := COUNT( ds( (STRING) #expand(at_name) = '27'));
		SELF.count_28 := COUNT( ds( (STRING) #expand(at_name) = '28'));
		SELF.count_29 := COUNT( ds( (STRING) #expand(at_name) = '29'));
		SELF.count_30 := COUNT( ds( (STRING) #expand(at_name) = '30'));
		SELF.count_31 := COUNT( ds( (STRING) #expand(at_name) = '31'));
		SELF.count_32 := COUNT( ds( (STRING) #expand(at_name) = '32'));
		SELF.count_33 := COUNT( ds( (STRING) #expand(at_name) = '33'));
		SELF.count_34 := COUNT( ds( (STRING) #expand(at_name) = '34'));
		SELF.count_35 := COUNT( ds( (STRING) #expand(at_name) = '35'));
		SELF.count_36 := COUNT( ds( (STRING) #expand(at_name) = '36'));
		SELF.count_37 := COUNT( ds( (STRING) #expand(at_name) = '37'));
		SELF.count_38 := COUNT( ds( (STRING) #expand(at_name) = '38'));
		SELF.count_39 := COUNT( ds( (STRING) #expand(at_name) = '39'));
		SELF.count_40 := COUNT( ds( (STRING) #expand(at_name) = '40'));
		SELF.count_41 := COUNT( ds( (STRING) #expand(at_name) = '41'));
		SELF.count_42 := COUNT( ds( (STRING) #expand(at_name) = '42'));
		SELF.count_43 := COUNT( ds( (STRING) #expand(at_name) = '43'));
		SELF.count_44 := COUNT( ds( (STRING) #expand(at_name) = '44'));
		SELF.count_45 := COUNT( ds( (STRING) #expand(at_name) = '45'));
		SELF.count_46 := COUNT( ds( (STRING) #expand(at_name) = '46'));
		SELF.count_47 := COUNT( ds( (STRING) #expand(at_name) = '47'));
		SELF.count_48 := COUNT( ds( (STRING) #expand(at_name) = '48'));
		SELF.count_49 := COUNT( ds( (STRING) #expand(at_name) = '49'));
		SELF.count_50 := COUNT( ds( (STRING) #expand(at_name) = '50'));
		SELF.count_50plus := COUNT( ds( (STRING) #expand(at_name) > '50'));
									
	END;

	dset := project(ut.ds_oneRecord, add_stats(left));

	return dset;
endmacro;

ds_base_stat :=
macro_stats(flatten_baseline, 'velocity_counters__phones_per_addr_multiple_use') +
macro_stats(flatten_baseline, 'velocity_counters__phones_per_addr_created_6months') +
macro_stats(flatten_baseline, 'velocity_counters__phones_per_addr_current') +
macro_stats(flatten_baseline, 'velocity_counters__phones_per_addr') +
macro_stats(flatten_baseline, 'velocity_counters__phones_per_adl_created_6months') +
macro_stats(flatten_baseline, 'velocity_counters__adls_per_phone_multiple_use');
OUTPUT(ds_base_stat , NAMED('ds_base_stat'));

ds_second_stat :=
macro_stats(flatten_second, 'velocity_counters__phones_per_addr_multiple_use') +
macro_stats(flatten_second, 'velocity_counters__phones_per_addr_created_6months') +
macro_stats(flatten_second, 'velocity_counters__phones_per_addr_current') +
macro_stats(flatten_second, 'velocity_counters__phones_per_addr') +
macro_stats(flatten_second, 'velocity_counters__phones_per_adl_created_6months') +
macro_stats(flatten_second, 'velocity_counters__adls_per_phone_multiple_use');
OUTPUT(ds_second_stat, NAMED('ds_second_stat'));
*/