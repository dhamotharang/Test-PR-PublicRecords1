EXPORT Phone_Shell_Cert_Tracking_Report := function;

import RiskWise, scoring_project_pip, Scoring_Project_Macros, Scoring_Project_DailyTracking, ut, std, ashirey, Gateway, Phone_Shell, Risk_Indicators;


//Options to change
thresh := 0.5;
eyeball := 10;
model :='COLLECTIONSCORE_V3'; //'PHONESCORE_V2';//	
a:= (String8)std.Date.Today();


//Getting the previous day from the input day above
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);

a1:= a +'_1';
b1:= b +'_1';


//reading in dataset
input_layout := Record
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus - Raw_Input - Clean_Input - Clam Phone_Shell;
	Risk_Indicators.Layout_Boca_Shell - LnJ_datasets - ConsumerStatements - bk_chapters Boca_Shell;
END;

ds_base := dataset('~ScoringQA::out::phone_shell_'+model+'_Cert_'+ b1, input_layout, thor);
ds_test := dataset('~ScoringQA::out::phone_shell_'+model+'_Cert_'+ a1, input_layout, thor);

// output(ds_base, named('ds_base'));


//slimming down dataset and creating hashtag
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

ds_trans_base := project(ds_base, num_trans(left));
ds_trans_test := project(ds_test, num_trans(left));

// output(ds_trans_base, named('ds_trans_base'));

mod_lay := record
	string hashtag;
	slim_rec;
end;

ds_mod_base := project(ds_trans_base, transform(mod_lay, self.hashtag := trim(left.acctno, left, right) + trim(left.gathered_phone, left, right); self := left));
ds_mod_test := project(ds_trans_test, transform(mod_lay, self.hashtag := trim(left.acctno, left, right) + trim(left.gathered_phone, left, right); self := left));

// output(ds_mod_base, named('ds_mod_base'));


//getting a count of the number of test cases in the sample
ds_mod_base_dedup := dedup(ds_mod_base, acctno);
ds_mod_test_dedup := dedup(ds_mod_test, acctno);

// output(count(ds_mod_base_dedup), named('ds_mod_base_dedup_count')); 
// output(count(ds_mod_test_dedup), named('ds_mod_test_dedup_count')); 

Matched_test_case_base := join(ds_mod_base_dedup, ds_mod_test_dedup, left.acctno = right.acctno, transform(mod_lay, Self := left));    //# of test cases with responses both days
Matched_test_case_test := join(ds_mod_base_dedup, ds_mod_test_dedup, left.acctno = right.acctno, transform(mod_lay, Self := right));   //# of test cases with responses both days

// output(count(Matched_test_case_base), named('Matched_test_case_base_count')); 
// output(count(Matched_test_case_test), named('Matched_test_case_test_count')); 


/////////*New Layout for dataset field compare */
NewLay := Record
	string hashtag;	
	input_layout - Boca_Shell;     //Removing Bocashell attributes as we only want to compare PhoneShell fields
End;

NewLay New_transPSbase(ds_base le) := TRANSFORM
	self.hashtag := trim(le.phone_shell.Input_Echo.acctno, left, right) + trim(le.Phone_Shell.Gathered_Phone, left, right);	
	self := le;
END;

NewLay New_transPStest(ds_test le) := TRANSFORM
	self.hashtag := trim(le.phone_shell.input_echo.acctno, left, right) + trim(le.Phone_Shell.Gathered_Phone, left, right);	
	self := le;
END;

ds_trans_PS_Result_base := project(ds_base, New_transPSbase(left));
ds_trans_PS_Result_test := project(ds_test, New_transPStest(left));

// output(choosen(ds_trans_PS_Result,5), named('ds_trans_PS_Result'));

ashirey.flatten(ds_trans_PS_Result_base, flatten_base_PhoneShell);
ashirey.flatten(ds_trans_PS_Result_test, flatten_test_PhoneShell);

// output(choosen(flatten_PhoneShell,5), named('flatten_PhoneShell'));

cert_ds_out := Scoring_Project_PIP.Compare_dsets_macro_email(flatten_base_PhoneShell, flatten_test_PhoneShell, ['hashtag'], thresh);

cert_ds_out_filter := cert_ds_out(field not in ['phone_shell__input_echo__in_processing_date']);


//calculating dropped and added sources
j_dropped := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, left only);								
j_new := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, right only);	
							
dropped := count(j_dropped);	
new := count(j_new);	

dropped_sources := table(j_dropped, {source_list, _count := count(group)}, source_list);
new_sources := table(j_new, {source_list, _count := count(group)}, source_list);

// output(dropped_sources, named('dropped_sources'));
// output(new_sources, named('new_sources'));



nonfcra_ds_curr := ds_mod_test;
nonfcra_ds_prev := ds_mod_base;

cleaned_nonfcra_curr_date := a1;
cleaned_nonfcra_prev_date := b1;

	nonfcra_join1 := JOIN(nonfcra_ds_curr, nonfcra_ds_prev,  LEFT.hashtag=RIGHT.hashtag, transform(left));
	nonfcra_clean_file := nonfcra_join1(hashtag <> '');


//designing emailed report
	MyRec := RECORD
		INTEGER order;
		STRING line;
	END;
max_diff := (STRING)cert_ds_out_filter[1].diff_pct	 + '%';
		
		
		
	ds_no_diff := DATASET([{2, 'No differences exceeding the ' + thresh + '% threshold'}], MyRec);
	
	STRING filler := '        ';

	cert_realtime := IF(COUNT(cert_ds_out_filter) > 0,
																		PROJECT(cert_ds_out_filter, TRANSFORM(MyRec, SELF.order := 2;
																		SELF.line := (TRIM(LEFT.Field[14..]) + filler)[1..75] + (LEFT.diff_cnt	 + filler)[1..10] + (LEFT.diff_pct	 + '%'+filler)[1..10]+ (left.up_cnt + filler)[1..10]    + (left.up_pct + '%'+filler)[1..10] + (left.down_cnt + filler)[1..10]    + (left.down_pct + '%')[1..10]     )),
																		ds_no_diff);

																		
	line_heading := ('Phone_Shell__ Field (Threshold: ' + thresh + '%)' + filler)[1..75] + ('Diff Cnt' + filler)[1..10] + ('Diff Pct' + filler)[1..10]+ ('Up Cnt' + filler)[1..10]+ ('Up Pct' + filler)[1..10]+('Down Cnt' + filler)[1..10] + ('Down Pct' + filler)[1..10];

filler2 := '                    ';
	ds_no_diff2 := DATASET([{2, 'No dropped sources '}], MyRec);
	ds_no_diff3 := DATASET([{2, 'No added sources '}], MyRec);
	
	cert_realtime_dropped := IF(COUNT(dropped_sources) > 0,
																		PROJECT(dropped_sources, TRANSFORM(MyRec, SELF.order := 2;
																		SELF.line := (TRIM(LEFT.source_list	) + filler2)[1..35] + (LEFT._count + filler2)[1..10] )),
																		ds_no_diff2);

																		
	line_heading_sources := ('source list' + filler2 + filler2)[1..35] + ('Count' + filler2)[1..10] ;

	cert_realtime_new := IF(COUNT(new_sources) > 0,
																		PROJECT(new_sources, TRANSFORM(MyRec, SELF.order := 2;
																		SELF.line := (TRIM(LEFT.source_list	) + filler2)[1..35] + (LEFT._count + filler2)[1..10] )),
																		ds_no_diff3);
	
	
	main_head := DATASET([{1,   'Phone Shell' + '\n'
												+ '*** This report is produced by Scoring QA ***' + '\n\n'
												}], MyRec); 		
			
real dp_pct := round((dropped/COUNT(nonfcra_clean_file))*100,2)		;		
				
	head_cert_realtime_dropped := DATASET([{1,    
													'Environment:  CERT - NONFCRA'	+ '\n'
												+ 'Archive date:  999999' + '\n'
												+ 'Previous run date:  ' + cleaned_nonfcra_prev_date + '\n'
												+ 'Current run date:  ' + cleaned_nonfcra_curr_date + '\n' 
												+ 'Previous phone count:  ' + COUNT(nonfcra_ds_prev) + '\n'
												+ 'Current phone count:  ' + COUNT(nonfcra_ds_curr) + '\n'
												+ 'Matched phone records:  ' + COUNT(nonfcra_clean_file) + '\n'
												+ 'Matched test case count:  ' + COUNT(Matched_test_case_base) + '\n'    //# of matched test cases with responses both days												
												+ '\n' 
												+ '\n' 
												+ 'Phones Dropped: 	' + dropped + '\n'  
												+ 'Percent Dropped: 	' + dp_pct + '\n'  
												+ '\n'
												+ line_heading_sources + '\n'
												+ '----------------------------------------'
												}], MyRec); 

real new_pct := round((new/COUNT(nonfcra_clean_file))*100,2);

	head_cert_realtime_new := DATASET([{1,    
												'Phones Gained: 	' + new + '\n'  
												+'Percent Gained: 	' + new_pct + '\n'  
												+ '\n'
												+ line_heading_sources + '\n'
												+ '----------------------------------------'
												}], MyRec); 			


Prev_Avg := ave(ds_mod_base, Phone_score);
Curr_Avg := ave(ds_mod_test, Phone_score);
Diff_Avg := Curr_Avg - Prev_Avg;
DiffPct_Avg := (Curr_Avg - Prev_Avg)/Prev_Avg*100;
line_heading_avg := ('Field' + filler)[1..42] + ('Previous Avg' + filler)[1..15] + ('Current Avg' + filler)[1..15]+ ('Diff Avg' + filler)[1..14] + 'Diff Pct';

j_base_matched := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, Transform(mod_lay, Self := left));								
j_test_matched := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, transform(mod_lay, Self := right));	
Prev_Avg_matched := ave(j_base_matched, Phone_score);
Curr_Avg_matched := ave(j_test_matched, Phone_score);
Diff_Avg_matched := Curr_Avg_matched - Prev_Avg_matched;
DiffPct_Avg_matched := (Diff_Avg_matched)/Prev_Avg_matched*100;

TopOneScore_matched_base := dedup(sort(j_base_matched, acctno, -phone_score), acctno);
TopOneScore_matched_test := dedup(sort(j_test_matched, acctno, -phone_score), acctno);

Prev_Avg_matched_TopOne := ave(TopOneScore_matched_base, Phone_score);
Curr_Avg_matched_TopOne := ave(TopOneScore_matched_test, Phone_score);
Diff_Avg_matched_TopOne := Curr_Avg_matched_TopOne - Prev_Avg_matched_TopOne;
DiffPct_Avg_matched_TopOne := (Diff_Avg_matched_TopOne)/Prev_Avg_matched_TopOne*100;

// output(count(TopOneScore_matched_base));
// output(TopOneScore_matched_base);
// output(count(TopOneScore_matched_test));
// output(TopOneScore_matched_test);

	head_cert_realtime_avg := DATASET([{1,    
												line_heading_avg + '\n'
												+ '----------------------------------------------------------------------------------------------' + '\n'
												+('Phone_model_score(unmatched)' + filler)[1..45] + ((string)Round(Prev_Avg, 2) + filler)[1..14] + ((string)Round(Curr_Avg, 2) + filler)[1..14]+ ((string)Round(Diff_Avg, 2) + filler)[1..14]+ (string)Round(DiffPct_Avg,1) + '\n'
												+('Phone_model_score(matched)' + filler)[1..45] + ((string)Round(Prev_Avg_matched, 2) + filler)[1..14] + ((string)Round(Curr_Avg_matched, 2) + filler)[1..14]+ ((string)Round(Diff_Avg_matched, 2) + filler)[1..14]+ (string)Round(DiffPct_Avg_matched,1) + '\n'
												+('Phone_model_score(matched, top 1 score)' + filler)[1..45] + ((string)Round(Prev_Avg_matched_TopOne, 2) + filler)[1..14] + ((string)Round(Curr_Avg_matched_TopOne, 2) + filler)[1..14]+ ((string)Round(Diff_Avg_matched_TopOne, 2) + filler)[1..14]+ (string)Round(DiffPct_Avg_matched_TopOne,1)
												}], MyRec); 	
	
	head_cert_realtime := DATASET([{1,    												
												line_heading + '\n'
												+ '-------------------------------------------------------------------------------------------------------------------------------------'
												}], MyRec); 
												
	spacer := DATASET([{3,    
													'\n' 
												+ '\n' 
												+ '\n' 
												}], MyRec);
	
	spacer2 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 3; SELF := LEFT));
	spacer4 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 5; SELF := LEFT));
	spacer6 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 7; SELF := LEFT));

	output_cert_realtime_dropped := PROJECT(SORT(head_cert_realtime_dropped + cert_realtime_dropped, order), TRANSFORM(MyRec, SELF.order := 2; SELF := LEFT));
	output_cert_realtime_new := PROJECT(SORT(head_cert_realtime_new + cert_realtime_new, order), TRANSFORM(MyRec, SELF.order := 4; SELF := LEFT));
	output_cert_realtime_avg := PROJECT(SORT(head_cert_realtime_avg, order), TRANSFORM(MyRec, SELF.order := 6; SELF := LEFT));
	output_cert_realtime := PROJECT(SORT(head_cert_realtime + cert_realtime, order), TRANSFORM(MyRec, SELF.order := 8; SELF := LEFT));

	output_append := main_head + output_cert_realtime_dropped +spacer2+output_cert_realtime_new+spacer4+output_cert_realtime_avg+spacer6+output_cert_realtime;
	output_full := SORT(output_append, order);

	MyRec Xform(myrec L,myrec R) := TRANSFORM
			SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
			self := l;
	END;

	XtabOut := ITERATE(output_full, Xform(LEFT, RIGHT));

// final := FileServices.SendEmail('Benjamin.Karnatz@lexisnexisrisk.com', 'PhoneShell Cert Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line);
final := FileServices.SendEmail('Benjamin.Karnatz@lexisnexisrisk.com;Matthew.Ludewig@lexisnexisrisk.com;Isabel.Ma@lexisnexisrisk.com;Blake.Huebner@lexisnexisrisk.com;Barbara.Gress@lexisnexisrisk.com;Brent.Sorenson@lexisnexisrisk.com;jim.corbin@lexisnexisrisk.com', 'PhoneShell Cert Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line);

return final;

END;