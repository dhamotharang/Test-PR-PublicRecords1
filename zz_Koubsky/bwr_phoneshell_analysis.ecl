#workunit('name', 'phonescore_analysis');

eyeball := 100;

results_lay := RECORD
  string50 acctno;
  string10 gathered_phone;
  string3 phone_score;
  string200 source_list;
 END;

// ds_base := choosen(dataset('~scoringqa::out::phoneshell_with_phonescore_baseline_20150506_w20150506-092705_slimmed_results.csv', results_lay, thor), eyeball);
ds_base := choosen(dataset('~scoringqa::out::phoneshell_with_phonescore_baseline_20150506_w20150506-092705_slimmed_results.csv', results_lay, thor), all);
// ds_test := choosen(dataset('~scoringqa::out::phoneshell_with_phonescore_testrun1_20150506_w20150506-093409_slimmed_results.csv', results_lay, thor), eyeball);
ds_test := choosen(dataset('~scoringqa::out::phoneshell_with_phonescore_testrun1_20150506_w20150506-093409_slimmed_results.csv', results_lay, thor), all);

output(choosen(ds_base, eyeball), named('baseline'));
output(choosen(ds_test, eyeball), named('testrun'));

mod_lay := record
	string hashtag;
	results_lay;
end;

ds_mod_base := project(ds_base, transform(mod_lay, self.hashtag := trim(left.acctno, left, right) + trim(left.gathered_phone, left, right); self := left));
ds_mod_test := project(ds_test, transform(mod_lay, self.hashtag := trim(left.acctno, left, right) + trim(left.gathered_phone, left, right); self := left));

output(choosen(ds_mod_base, eyeball), named('mod_baseline'));
output(choosen(ds_mod_test, eyeball), named('mod_testrun'));

j_base := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag,
								transform(mod_lay, self := left));
								
j_test := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag,
								transform(mod_lay, self := right));
								
j_dropped := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, left only);								
j_new := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, right only);	
							
output(choosen(j_dropped, eyeball), named('dropped_phones'));
output(choosen(j_new, eyeball), named('new_phones'));

output(count(ds_mod_base), named('baseline_count'));
output(count(ds_mod_test), named('testrun_count'));
output(count(j_base), named('joined_baseline_count'));
output(count(j_test), named('joined_testrun_count'));	
output(count(j_dropped), named('dropped_phones_count'));	
output(count(j_new), named('new_phones_count'));	
						
scoring_qa.COMPARE_DSETS_MACRO(ds_mod_base, ds_mod_test, ['hashtag'], 0);
// Scoring_QA.CROSSTAB_MACRO(j_base, j_test, ['hashtag'], 'phone_score');

dropped_sources := table(j_dropped, {source_list, _count := count(group)}, source_list);
new_sources := table(j_new, {source_list, _count := count(group)}, source_list);

output(dropped_sources, named('dropped_sources'));
output(new_sources, named('new_sources'));



								
