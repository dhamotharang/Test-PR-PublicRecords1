import ut;
export Build_Reports (string version, boolean incr_update) := function
update_type := if(incr_update, 'Incremental Update', 'Full File Update');
in_file_input := Experian_Phones.Files.input;
new_base := Experian_Phones.Files.base;
prev_base := dataset('~thor_data400::base::experian_phones_father', Experian_Phones.Layouts.base, thor);

new_base_d1 := distribute(new_base, hash(Encrypted_Experian_PIN));
prev_base_d1 := distribute(prev_base, hash(Encrypted_Experian_PIN));

new_base_d2 := distribute(new_base (did >0), hash(did));
prev_base_d2 := distribute(prev_base(did >0), hash(did));



//files record count
input_cnt := count(in_file_input);
base_cnt := count(new_base );
prev_base_cnt := count(prev_base);

total_cur_phones := count(new_base(is_current));
total_prev_phones := count(prev_base(is_current));

//phones added
ph_added := join(new_base_d1 (is_current),
								prev_base_d1 (is_current),
								left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN and
								left.Phone_digits = right.Phone_digits and
								left.Phone_type = right.Phone_type and
								left.Phone_Source = right.Phone_Source,
								left only,
								local);

ph_added_cnt := count(dedup(sort(ph_added, Encrypted_Experian_PIN,Phone_digits,Phone_type,Phone_Source, local),Encrypted_Experian_PIN,Phone_digits,Phone_type,Phone_Source, local));
ph_added_pc := ((decimal15_2)ph_added_cnt/(decimal15_2)total_prev_phones) * 100.0;

//phones removed
ph_removed := join(prev_base_d1 (is_current),
								new_base_d1 (is_current),
								left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN and
								left.Phone_digits = right.Phone_digits and
								left.Phone_type = right.Phone_type and
								left.Phone_Source = right.Phone_Source,
								left only,
								local);

ph_removed_cnt := count(dedup(sort(ph_removed, Encrypted_Experian_PIN,Phone_digits,Phone_type,Phone_Source, local),Encrypted_Experian_PIN,Phone_digits,Phone_type,Phone_Source, local));
ph_removed_pc := ((decimal15_2)ph_removed_cnt/(decimal15_2)total_prev_phones) * 100.0;

//phones updated
ph_updated := join(new_base_d1 (is_current),
								prev_base_d1 (is_current),
								left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN and
								left.Phone_digits = right.Phone_digits and
								left.Phone_type = right.Phone_type and
								left.Phone_Source = right.Phone_Source and
								left.Phone_Last_Updt <> right.Phone_Last_Updt,
								local);

ph_updated_cnt := count(dedup(sort(ph_updated, Encrypted_Experian_PIN,Phone_digits,Phone_type,Phone_Source, local),Encrypted_Experian_PIN,Phone_digits,Phone_type,Phone_Source, local));
ph_updated_pc := ((decimal15_2)ph_updated_cnt/(decimal15_2)total_prev_phones) * 100.0;

total_cur_pins := count(dedup(sort(new_base_d1(is_current),Encrypted_Experian_PIN, local),Encrypted_Experian_PIN, local));
total_prev_pins := count(dedup(sort(prev_base_d1(is_current),Encrypted_Experian_PIN, local),Encrypted_Experian_PIN, local));

//pins added
pin_added_cnt := count(dedup(sort(ph_added, Encrypted_Experian_PIN, local), Encrypted_Experian_PIN,local));
pin_added_pc := ((decimal15_2)pin_added_cnt/(decimal15_2)total_prev_pins) * 100.0;

//pins removed
pin_removed_cnt := count(dedup(sort(ph_removed, Encrypted_Experian_PIN, local), Encrypted_Experian_PIN,local));
pin_removed_pc := ((decimal15_2)pin_removed_cnt/(decimal15_2)total_prev_pins) * 100.0;

//pins updated
pin_updated_cnt := count(dedup(sort(ph_updated, Encrypted_Experian_PIN, local), Encrypted_Experian_PIN,local));
pin_updated_pc := ((decimal15_2)pin_updated_cnt/(decimal15_2)total_prev_pins) * 100.0;

total_cur_dids := count(dedup(sort(new_base_d2(is_current),Encrypted_Experian_PIN, local),Encrypted_Experian_PIN, local));
total_prev_dids := count(dedup(sort(prev_base_d2(is_current),Encrypted_Experian_PIN, local),Encrypted_Experian_PIN, local));

//dids added
did_added_cnt := count(dedup(sort(ph_added (did >0), did, local), did,local));
did_added_pc := ((decimal15_2)did_added_cnt/(decimal15_2)total_prev_dids) * 100.0;

//dids removed
did_removed_cnt := count(dedup(sort(ph_removed(did >0), did, local), did,local));
did_removed_pc := ((decimal15_2)did_removed_cnt/(decimal15_2)total_prev_dids) * 100.0;

//dids updated
did_updated_cnt := count(dedup(sort(ph_updated(did >0), did, local), did,local));
did_updated_pc := ((decimal15_2)did_updated_cnt/(decimal15_2)total_prev_dids) * 100.0;

score_dist_cur := table(new_base(is_current), {
													score_bucket1 := map(score < 200 => ' Below 200',
																							score between 200 and 299=> '200 - 299',
																							score between 300 and 399=> '300 - 399',
																							score between 400 and 499=> '400 - 499',
																							score between 500 and 599=> '500 - 599',
																							score between 600 and 700=> '600 - 700',
																							 'Over 700'),
																							cnt1 := count(group)}, 
																							map(score < 200 => ' Below 200',
																							score between 200 and 299=> '200 - 299',
																							score between 300 and 399=> '300 - 399',
																							score between 400 and 499=> '400 - 499',
																							score between 500 and 599=> '500 - 599',
																							score between 600 and 700=> '600 - 700',
																							 'Over 700'), few);
score_dist_prev :=table(prev_base(is_current), {
													score_bucket2 := map(score < 200 => ' Below 200',
																							score between 200 and 299=> '200 - 299',
																							score between 300 and 399=> '300 - 399',
																							score between 400 and 499=> '400 - 499',
																							score between 500 and 599=> '500 - 599',
																							score between 600 and 700=> '600 - 700',
																							 'Over 700'),
																							cnt2 :=  count(group)}, 
																							map(score < 200 => ' Below 200',
																							score between 200 and 299=> '200 - 299',
																							score between 300 and 399=> '300 - 399',
																							score between 400 and 499=> '400 - 499',
																							score between 500 and 599=> '500 - 599',
																							score between 600 and 700=> '600 - 700',
																							 'Over 700'), few);




score_before_after := join(score_dist_prev, score_dist_cur,
													 left.score_bucket2 = right.score_bucket1,
													 transform({string Score, unsigned Before_, decimal15_2 Before_pc, unsigned After_, decimal15_2 After_pc, integer Diff, decimal15_2 Diff_pc},
																			self.score := if(left.score_bucket2 <> '', left.score_bucket2, right.score_bucket1),
																			self.Before_ := left.cnt2,
																			self.After_:= right.cnt1,
																			self.Diff := right.cnt1 - left.cnt2,
																			self.Before_pc :=  (((decimal15_2) left.cnt2 / (decimal15_2) count(prev_base(is_current))) * (decimal15_2)100.0) ,
																			self.After_pc :=  (((decimal15_2) right.cnt1 / (decimal15_2) count(new_base(is_current))) * (decimal15_2)100.0) ,
																			self.Diff_pc :=  (((decimal15_2) self.Diff / (decimal15_2) left.cnt2) * (decimal15_2)100.0) ),
														full outer);


score_changes := join(new_base_d1 (is_current),
								prev_base_d1 (is_current),
								left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN and
								left.Phone_digits = right.Phone_digits and
								left.Phone_pos = right.Phone_pos and
								left.Phone_type = right.Phone_type and
								left.Phone_Source = right.Phone_Source and
								left.did = right.did and
								left.score <> right.score,
								transform({integer diff},
													 self.diff := left.score - right.score),										 
								local);
								

score_no_changes := join(new_base_d1 (is_current),
								prev_base_d1 (is_current),
								left.Encrypted_Experian_PIN = right.Encrypted_Experian_PIN and
								left.Phone_digits = right.Phone_digits and
								left.Phone_pos = right.Phone_pos and
								left.Phone_type = right.Phone_type and
								left.Phone_Source = right.Phone_Source and
								left.did = right.did and
								left.score = right.score,
								transform({integer diff},
													 self.diff := 0),										 
								local);
								
score_changes_tbl := table((score_changes + score_no_changes), {
													string score_diff := map(
																							diff between -9 and -1 => 'Decreased   1 - 9 pts',
																							diff between -19 and -10=> 'Decreased  10 - 19 pts',
																							diff between -29 and -20=> 'Decreased  20 - 29 pts',
																							diff between -39 and -30=> 'Decreased  30 - 39 pts',
																							diff between -49 and -40=> 'Decreased  40 - 49 pts',
																							diff between -99 and -50=> 'Decreased  50 - 99 pts',
																							diff between -200 and -100=> 'Decreased 100 - 200 pts',
																							diff < -200 => 'Decreased    Over 200 pts',
																							diff between 1 and 9 => 'Increased   1 - 9 pts',
																							diff between 10 and 19=> 'Increased  10 - 19 pts',
																							diff between 20 and 29=> 'Increased  20 - 29 pts',
																							diff between 30 and 39=> 'Increased  30 - 39 pts',
																							diff between 40 and 49=> 'Increased  40 - 49 pts',
																							diff between 50 and 99=> 'Increased  50 - 99 pts',
																							diff between 100 and 200=> 'Increased 100 - 200 pts',
																							diff >200 => 'Increased    Over 200 pts',
																							' No Change'),
																							count_ :=  count(group)}, 
																							map(diff between -9 and -1 => 'Decreased   1 - 9 pts',
																							diff between -19 and -10=> 'Decreased  10 - 19 pts',
																							diff between -29 and -20=> 'Decreased  20 - 29 pts',
																							diff between -39 and -30=> 'Decreased  30 - 39 pts',
																							diff between -49 and -40=> 'Decreased  40 - 49 pts',
																							diff between -99 and -50=> 'Decreased  50 - 99 pts',
																							diff between -200 and -100=> 'Decreased 100 - 200 pts',
																							diff < -200 => 'Decreased    Over 200 pts',
																							diff between 1 and 9 => 'Increased   1 - 9 pts',
																							diff between 10 and 19=> 'Increased  10 - 19 pts',
																							diff between 20 and 29=> 'Increased  20 - 29 pts',
																							diff between 30 and 39=> 'Increased  30 - 39 pts',
																							diff between 40 and 49=> 'Increased  40 - 49 pts',
																							diff between 50 and 99=> 'Increased  50 - 99 pts',
																							diff between 100 and 200=> 'Increased 100 - 200 pts',
																							diff >200 => 'Increased    Over 200 pts',
																							'No Change'), few);

score_changes_total := dataset([{'TOTAL:', sum(score_changes_tbl,count_)}], {string score_diff, integer count_});


score_changes_final := project((score_changes_tbl + score_changes_total),transform({recordof(score_changes_tbl), decimal15_2 Change_pc},
																																									 self.Change_pc := ((decimal15_2)left.count_ / (decimal15_2) max(score_changes_total,count_)) * (decimal15_2)100,
																																									self := left));
																																			
wustats := parallel(
	output(input_cnt, named('update_input_file_count'));
	output(base_cnt, named('current_base_count'));
	output(prev_base_cnt, named('prev_base_count'));

	output(total_cur_phones, named('total_phones_current_count'));
	output(total_prev_phones, named('total_phones_pre_count'));
  output(ph_added_cnt + ' - ' + ph_added_pc, named('phones_added'));
  output(ph_removed_cnt + ' - ' + ph_removed_pc, named('phones_removed'));
  output(ph_updated_cnt + ' - ' + ph_updated_pc, named('phones_updated'));	
	
	output(total_cur_pins, named('total_pins_current_count'));
	output(total_prev_pins, named('total_pins_prev_count'));
  output(pin_added_cnt + ' - ' + pin_added_pc, named('pins_added'));
  output(pin_removed_cnt + ' - ' + pin_removed_pc, named('pins_removed'));
  output(pin_updated_cnt + ' - ' + pin_updated_pc, named('pins_updated'));

	output(total_cur_dids, named('total_dids_current_count'));
	output(total_prev_dids, named('total_dids_prev_count'));
  output(did_added_cnt + ' - ' + did_added_pc, named('dids_added'));
  output(did_removed_cnt + ' - ' + did_removed_pc, named('dids_removed'));
  output(did_updated_cnt + ' - ' + did_updated_pc, named('dids_updated')))
	;
	
email_body := 
	'View Workunit:                                        ' + thorlib.wuid() + '\n\n' +
	'Update Type: ' + update_type +'\n\n' +
	'Counts and Percentages' + '\n' +
	'Input File Count:                          ' + ut.intWithCommas(input_cnt) + '\t 100.00%\n\n' +	
	'Current Base File Count:        ' + ut.intWithCommas(base_cnt) + '\t 100.00%\n' +
	'Previous Base File Count:       ' + ut.intWithCommas(prev_base_cnt) + '\t 100.00%\n\n' +
	
	'BY PHONE\n' +
	'Current Base File Phone Count:    ' + ut.intWithCommas(total_cur_phones) + '\t 100.00%\n' +
	'Previous Base File Phone Count: ' + ut.intWithCommas(total_prev_phones) + '\t 100.00%\n' +
	'Phones Added:									' + ut.intWithCommas(ph_added_cnt) + '\t ' +(decimal15_2) ph_added_pc + '%\n' +
	'Phones Removed:								' + ut.intWithCommas(ph_removed_cnt) + '\t ' + (decimal15_2)ph_removed_pc + '%\n' +
	'Phones Updated:								' + ut.intWithCommas(ph_updated_cnt) + '\t ' + (decimal15_2)ph_updated_pc + '%\n\n' +

	'BY PIN\n' +
	'Current Base File PIN Count:      ' + ut.intWithCommas(total_cur_pins) + '\t 100.00%\n' +
	'Previous Base File PIN Count:   ' + ut.intWithCommas(total_prev_pins) + '\t 100.00%\n' +
	'PINs Added:									   ' + ut.intWithCommas(pin_added_cnt) + '\t ' + (decimal15_2)pin_added_pc + '%\n' +
	'PINs Removed:									 ' + ut.intWithCommas(pin_removed_cnt) + '\t ' + (decimal15_2)pin_removed_pc + '%\n' +
	'PINs Updated:									 ' + ut.intWithCommas(pin_updated_cnt) + '\t ' + (decimal15_2)pin_updated_pc + '%\n\n' +

	'BY DID\n' +
	'Current Base File DID Count:      ' + ut.intWithCommas(total_cur_dids) + '\t 100.00%\n' +
	'Previous Base File DID Count:   ' + ut.intWithCommas(total_prev_dids) + '\t 100.00%\n' +
	'DIDs Added:									   ' + ut.intWithCommas(did_added_cnt) + '\t ' + (decimal15_2)did_added_pc + '%\n' +
	'DIDs Removed:									 ' + ut.intWithCommas(did_removed_cnt) + '\t ' + (decimal15_2)did_removed_pc + '%\n' +
	'DIDs Updated:									 ' + ut.intWithCommas(did_updated_cnt) + '\t ' + (decimal15_2)did_updated_pc + '%\n\n'  +
	
	'SCORE DISTRIBUTIONS\n' +	
	'http://10.173.84.202:8010/WsWorkunits/WUResult?Wuid='+ thorlib.wuid()+'&Sequence=69\n\n' + 
	'SCORE CHANGES\n' +	
	'http://10.173.84.202:8010/WsWorkunits/WUResult?Wuid='+ thorlib.wuid()+'&Sequence=70'
	 ;

										
Phone_stats := 
	sequential(	wustats, 
	output(score_before_after, named('Before_After_Score_Distributions')),
	output(sort(score_changes_final, score_diff),all, named('Score_Changes')),
				FileServices.SendEmail(
			/* EMAIL RECIPIENTS */		'angela.herzberg@lexisnexis.com', 
			/* SUBJECT */				'Experian Phone Index Version ' + Version + ' - Update Stats',
			/* Email Body */			email_body)
			);

return Phone_stats;
end;

