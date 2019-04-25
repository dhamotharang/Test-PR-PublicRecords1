// EXPORT bwr_bs_quad_join := 'todo';

// #workunit('name','NonFCRA-Bocashell 4.1');
// #workunit('name','Nuestar-NonFCRA Bocashell 4.1');
// #workunit('name','Nuestar-FCRA Bocashell 4.1');

import risk_indicators, ut, ashirey, riskprocessing.layouts, scoring_qa, zz_Koubsky, Scoring_Project_Macros;

eyeball := 20;

input_lay := RECORD
	// riskprocessing.layouts.layout_internal_shell;
	zz_Koubsky.test_lay.lay;
END;

// /*
input_lay_full := RECORD
  String file_version;
	input_lay;
	// pii_lay;
END;

file_1 := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_20150312_1';
file_2 := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_20150313_1';
file_3 := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_prod_20150312_1';
file_4 := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_prod_20150313_1';

d_1 := dataset(file_1, input_lay, thor);
d_2 := dataset(file_2, input_lay, thor);
d_3 := dataset(file_3, input_lay, thor);
d_4 := dataset(file_4, input_lay, thor);

ds_1 := project(d_1, TRANSFORM(input_lay_full, SELF.file_version := 'cert_11'; SELF.time_ms := 0; SELF := LEFT; self := []));
ds_2 := project(d_2, TRANSFORM(input_lay_full, SELF.file_version := 'cert_12'; SELF.time_ms := 0; SELF := LEFT; self := []));
ds_3 := project(d_3, TRANSFORM(input_lay_full, SELF.file_version := 'prod_12'; SELF.time_ms := 0; SELF := LEFT; self := []));
ds_4 := project(d_4, TRANSFORM(input_lay_full, SELF.file_version := 'prod_13'; SELF.time_ms := 0; SELF := LEFT; self := []));

   
at_name := 'header_summary.ver_sources_recordcount';

ds_join_1 := join(ds_1, ds_2, 
						left.seq = right.seq 
						and left.#expand(at_name) <> right.#expand(at_name)
						and left.#expand(at_name) <> '',
						transform({dataset(input_lay_full) res}, self.res := left + right));

ds_join_2 := join(ds_3, ds_4, 
						left.seq = right.seq 
						and left.#expand(at_name) <> right.#expand(at_name),
						transform({dataset(input_lay_full) res}, self.res := left + right));

ds_join_3 := join(ds_join_1, ds_join_2, 
						left.res[1].seq = right.res[1].seq and 
						left.res[2].#expand(at_name) <> right.res[2].#expand(at_name),
						transform({dataset(input_lay_full) res}, self.res := left.res + right.res));

output(at_name);						
output(choosen(ds_join_1, eyeball), named('cert_results'));
output(count(ds_join_1), named('cert_results_count'));
output(choosen(ds_join_2, eyeball), named('prod_results'));
output(count(ds_join_2), named('prod_results_count'));
output(choosen(ds_join_3, eyeball), named('cert_prod_results'));
output(count(ds_join_3), named('cert_prod_results_count'));

// */ 
 
/*
// at_name := 'velocity_counters.phones_per_addr_multiple_use';
// at_name := 'velocity_counters.phones_per_addr_created_6months';
// at_name := 'velocity_counters.phones_per_addr_current';
// at_name := 'velocity_counters.phones_per_addr';
// at_name := 'address_verification.edamatchlevel';
// at_name := 'iid.chronomatchlevel';
// at_name := 'other_address_info.avg_lres';

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
output(choosen(j_1, 15), named('diff_detail'));
*/

/*
// at_name := 'address_verification__edamatchlevel';
at_name := 'phone_verification__recent_disconnects';

ashirey.flatten(ds_baseline, flatten_baseline);
ashirey.flatten(ds_new, flatten_second);
// scoring_qa.COMPARE_DSETS_MACRO( flatten_baseline, flatten_second, ['AccountNumber'], 0 );
// scoring_qa.CROSSTAB_MACRO( flatten_baseline, flatten_second, ['AccountNumber'], at_name);

ashirey.Diff(flatten_baseline, flatten_second, ['AccountNumber'], j2, 'BocaShell' );

// OUTPUT(COUNT(j2) / 2, NAMED('macro_differences_count'));
// OUTPUT(CHOOSEN(j2, eyeball * 2), NAMED('macro_differences'));
*/

