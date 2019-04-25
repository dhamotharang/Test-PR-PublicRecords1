

EXPORT Phone_Shell_Tracking_Report := 'todo';

import RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking,ut,sghatti,Gateway, Scoring_Project_ISS,Phone_Shell,Risk_Indicators;
thresh := 0;
eyeball := 10;
input_layout := Record
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus - Raw_Input - Clean_Input - Clam Phone_Shell;
	Risk_Indicators.Layout_Boca_Shell - LnJ_datasets - ConsumerStatements -bk_chapters Boca_Shell;
	// Risk_Indicators.Layout_Boca_Shell  Boca_Shell;
END;

slim_rec := RECORD
  string50 acctno;
  string10 gathered_phone;
  integer phone_score;
  string200 source_list;
END;

slim_rec Num_trans(input_layout le) := TRANSFORM
	self.acctno := le.phone_shell.input_echo.acctno;
	self.gathered_phone := le.phone_shell.gathered_phone;
	self.phone_score := (integer)le.phone_shell.phone_model_score;
	self.source_list := le.phone_shell.sources.source_list;
	self := [];
END; 


   	a:= ut.GetDate;
	
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);

	a1:= a +'_1';
	b1:= b +'_1';
	// b1:= '20180817'+'_1';

model := 'COLLECTIONSCORE_V3';
// model := 'PHONESCORE_V2';
ds_base := dataset('~ScoringQA::out::phone_shell_'+model+'_Cert_'+ b1, input_layout, thor);
ds_test := dataset('~ScoringQA::out::phone_shell_'+model+'_Cert_'+ a1, input_layout, thor);





output(choosen(ds_base, 10));
output(choosen(ds_test, 10));



addhash := record
string hashtag;
input_layout;
end;

ds_mod_base_hash := project(ds_base, transform(addhash, self.hashtag := trim(left.phone_shell.input_echo.acctno, left, right) + trim(left.phone_shell.gathered_phone, left, right); self := left));
ds_mod_test_hash := project(ds_test, transform(addhash, self.hashtag := trim(left.phone_shell.input_echo.acctno, left, right) + trim(left.phone_shell.gathered_phone, left, right); self := left));



ashirey.flatten(ds_mod_base_hash,clean_ds_1_flat);
ashirey.flatten(ds_mod_test_hash,clean_ds_2_flat);



cert_ds_out := Scoring_Project_PIP.Compare_dsets_macro_email(clean_ds_1_flat, clean_ds_2_flat, ['hashtag'], thresh);
output(choosen(cert_ds_out, all), named('diff_full'));


ds_trans_base := project(ds_base, num_trans(left));
ds_trans_test := project(ds_test, num_trans(left));

mod_lay := record
	string hashtag;
	slim_rec;
end;

ds_mod_base := project(ds_trans_base, transform(mod_lay, self.hashtag := trim(left.acctno, left, right) + trim(left.gathered_phone, left, right); self := left));
ds_mod_test := project(ds_trans_test, transform(mod_lay, self.hashtag := trim(left.acctno, left, right) + trim(left.gathered_phone, left, right); self := left));
output(choosen(ds_mod_base, 10));
output(choosen(ds_mod_base, 10));


m1f := min(ds_mod_base,phone_score);
std1f := sqrt(VARIANCE(ds_mod_base,phone_score));
mx1f:= max(ds_mod_base,phone_score);
mean1f := ave(ds_mod_base,phone_score);

m2f := min(ds_mod_test,phone_score);
std2f := sqrt(VARIANCE(ds_mod_test,phone_score));
mx2f := max(ds_mod_test,phone_score);
mean2f := ave(ds_mod_test,phone_score);

output(m1f, named('left_min_full_ds'));
output(m2f, named('right_min_full_ds'));

output(std1f, named('left_std_full_ds'));
output(std2f, named('right_std_full_ds'));

output(mx1f, named('left_max_full_ds'));
output(mx2f, named('right_max_full_ds'));

output(mean1f, named('left_mean_full_ds'));
output(mean2f, named('right_mean_full_ds'));

// cert_ds_out := Scoring_Project_PIP.Compare_dsets_macro_email(ds_mod_base, ds_mod_test, ['hashtag'], thresh);

j1 := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, 
									transform({dataset(mod_lay) res}, self.res := left));
	output(choosen(j1, 10), named('left_ds_output_match'));
	c1 := count(j1);
	output(c1, named('left_ds_output_Match_count'));

j2 := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, 
									transform({dataset(mod_lay) res}, self.res := right));
	output(choosen(j2, 10), named('right_ds_output_Match'));
	c2 := count(j2);
	output(c2, named('right_ds_output_Match_count'));


j3 := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, left only);
	output(choosen(j3, 10), named('left_ds_output_ONLY'));
	c3 := count(j3);
	output(c3, named('left_ds_output_ONLY_count'));

j4 := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, right only);
	output(choosen(j4, 10), named('right_ds_output_ONLY'));
	c4 := count(j4);
	output(c4, named('right_ds_output_ONLY_count'));


// m1 := min(ds_mod_base,phone_score);
m1 := min(j1,res[1].phone_score);
std1 := sqrt(VARIANCE(j1,res[1].phone_score));
mx1:= max(j1,res[1].phone_score);
mean1 := ave(j1,res[1].phone_score);

m2 := min(j2,res[1].phone_score);
std2 := sqrt(VARIANCE(j2,res[1].phone_score));
mx2:= max(j2,res[1].phone_score);
mean2 := ave(j2,res[1].phone_score);




output(m1, named('left_min_Matched'));
output(m2, named('right_min_Matched'));

output(std1, named('left_std_Matched'));
output(std2, named('right_std_Matched'));

output(mx1, named('left_max_Matched'));
output(mx2, named('right_max_Matched'));

output(mean1, named('left_mean_Matched'));
output(mean2, named('right_mean_Matched'));
		
j_dropped := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, left only);								
j_new := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, right only);	
							

dropped := count(j_dropped);	
new := count(j_new);	

dropped_sources := table(j_dropped, {source_list, _count := count(group)}, source_list);
new_sources := table(j_new, {source_list, _count := count(group)}, source_list);

output(dropped_sources, named('dropped_sources'));
output(new_sources, named('new_sources'));		

	// model_results := MAP(Phone_Score_Model not in ['PHONESCORE_V2','COLLECTIONSCORE_V3'] => results,	// If no models called, just return the shell and attributes
											           // ModelVersion in ['V2'] and allowPremiumSource_A                 => Phone_Shell.PhoneScore_cp3_v2(results, Score_Threshold), 
											           // ModelVersion in ['V2'] and not allowPremiumSource_A             => Phone_Shell.PhoneScore_wf8_v2(results, Score_Threshold), 
                      // Basically, ModelVersion = V2 calls the old models (above). This is the ONLY way to call the old v2 models. 
                      // Anything else in ModelVersion (blank, V3, XYZ, etc) will call the new v3 models (below).
                      // allowPremiumSource_A                                            => Phone_Shell.PhoneScore_cp3_v3(results, Score_Threshold),
											                                                                              // Phone_Shell.PhoneScore_wf8_v3(results, Score_Threshold)
                     // ); 

EXPORT PhoneShell_Stats_Model := 'todo';