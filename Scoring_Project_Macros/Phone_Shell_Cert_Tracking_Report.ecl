

EXPORT Phone_Shell_Tracking_Report := 'todo';

import RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking,ut,sghatti,Gateway, Scoring_Project_ISS,Phone_Shell,Risk_Indicators;
thresh := 0;
eyeball := 10;
input_layout := Record
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus - Raw_Input - Clean_Input - Clam Phone_Shell;
	Risk_Indicators.Layout_Boca_Shell - LnJ_datasets - ConsumerStatements - bk_chapters Boca_Shell;
END;

// slim_rec := RECORD
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
model :='COLLECTIONSCORE_V3'; //'PHONESCORE_V2';//
// model :='PHONESCORE_V2'; //'COLLECTIONSCORE_V3';//
ds_base := dataset('~ScoringQA::out::phone_shell_'+model+'_Cert_'+ b1, input_layout, thor);
ds_test := dataset('~ScoringQA::out::phone_shell_'+model+'_Cert_'+ a1, input_layout, thor);

ds_trans_base := project(ds_base, num_trans(left));
ds_trans_test := project(ds_test, num_trans(left));

mod_lay := record
	string hashtag;
	slim_rec;
end;

ds_mod_base := project(ds_trans_base, transform(mod_lay, self.hashtag := trim(left.acctno, left, right) + trim(left.gathered_phone, left, right); self := left));
ds_mod_test := project(ds_trans_test, transform(mod_lay, self.hashtag := trim(left.acctno, left, right) + trim(left.gathered_phone, left, right); self := left));

cert_ds_out := Scoring_Project_PIP.Compare_dsets_macro_email(ds_mod_base, ds_mod_test, ['hashtag'], thresh);

								
j_dropped := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, left only);								
j_new := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, right only);	
							

dropped := count(j_dropped);	
new := count(j_new);	

dropped_sources := table(j_dropped, {source_list, _count := count(group)}, source_list);
new_sources := table(j_new, {source_list, _count := count(group)}, source_list);

output(dropped_sources, named('dropped_sources'));
output(new_sources, named('new_sources'));



import ut;
import std, Scoring_Project, ashirey,Scoring_Project_Macros,  Scoring_Project_DailyTracking;

dt := ut.getdate;

nonfcra_ds_curr := ds_mod_test;


cleaned_nonfcra_curr_date := a1;
cleaned_nonfcra_prev_date := b1;

nonfcra_ds_prev := ds_mod_base;


		nonfcra_join1 := JOIN(nonfcra_ds_curr, nonfcra_ds_prev,  LEFT.hashtag=RIGHT.hashtag, transform(left));
		nonfcra_clean_file := nonfcra_join1(hashtag <> '');
		nonfcra_ds_curr_join := JOIN(nonfcra_ds_curr, nonfcra_clean_file, LEFT.hashtag=RIGHT.hashtag, transform(left));
		nonfcra_ds_prev_join := JOIN(nonfcra_ds_prev, nonfcra_clean_file, LEFT.hashtag=RIGHT.hashtag, transform(left));

// /* LAYOUT FLATTENING */ 
				 // ashirey.flatten(nonfcra_ds_curr_join, nonfcra_curr_output, ,true , ,);
         // ashirey.flatten(nonfcra_ds_prev_join, nonfcra_prev_output, ,true , ,);
         // nonfcra_curr_ds := Scoring_Project.BocaShell_Normalized_Code(nonfcra_curr_output, 'hashtag');
         // nonfcra_prev_ds := 	Scoring_Project.BocaShell_Normalized_Code(nonfcra_prev_output, 'hashtag');
         
         // nonfcra_layout := record
         // recordof(nonfcra_curr_ds);
         // Integer flag;
         // end;
         
         
         // nonfcra_jn := JOIN(nonfcra_curr_ds, nonfcra_prev_ds, left.accountnumber = right.accountnumber and
         														 // left.field_name = right.field_name,
         														// TRANSFORM(nonfcra_layout, 
         																			// self.flag := If(left.field_value <> right.field_value, 1, 0);
         																			// self := Left;
         																			// ));
         														
         // nonfcra_filter_join := nonfcra_jn(flag = 1, field_name <> 'proflic_build_date');	
         
         // nonfcra_recrd := record
         // nonfcra_filter_join.field_name;
         // Integer Difference_count := count(group);
         // decimal19_2  Difference_Percent :=  (count(group)/count(nonfcra_ds_curr_join))*100;
         // end;
         
         // nonfcra_result := table(nonfcra_filter_join, nonfcra_recrd, nonfcra_filter_join.field_name);



// re_filter1_nonfcra := nonfcra_result(field_name not in ['time_ms'], Difference_Percent > thresh);
// re_filter2_nonfcra := SORT(re_filter1_nonfcra, -Difference_Percent);




		MyRec := RECORD
			INTEGER order;
			STRING line;
		END;
max_diff := (STRING)cert_ds_out[1].diff_pct	 + '%';
		
		
		
		ds_no_diff := DATASET([{2, 'No differences exceeding the ' + thresh + '% threshold'}], MyRec);
		
		STRING filler := '        ';

		cert_realtime := IF(COUNT(cert_ds_out) > 0,
																			PROJECT(cert_ds_out, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field) + filler)[1..50] + (LEFT.diff_cnt	 + filler)[1..10] + (LEFT.diff_pct	 + '%'+filler)[1..10]+ (left.up_cnt + filler)[1..10]    + (left.up_pct + '%'+filler)[1..10] + (left.down_cnt + filler)[1..10]    + (left.down_pct + '%')[1..10]     )),
																			ds_no_diff);

																			
		line_heading := ('Field' + filler)[1..50] + ('Diff Cnt' + filler)[1..10] + ('Diff Pct' + filler)[1..10]+ ('Up Cnt' + filler)[1..10]+ ('Up Pct' + filler)[1..10]+('Down Cnt' + filler)[1..10] + ('Down Pct' + filler)[1..10];
		// max_diff := (STRING)SORT(re_filter1_nonfcra, -Difference_Percent)[1].Difference_Percent + '%';
		
		// ds_no_diff := DATASET([{2, 'No differences exceeding the ' + thresh + '% threshold'}], MyRec);
		
		// STRING filler := '                                                                                                                    ';

		// cert_realtime := IF(COUNT(re_filter2_nonfcra) > 0,
																			// PROJECT(re_filter2_nonfcra, TRANSFORM(MyRec, SELF.order := 2;
																			// SELF.line := (TRIM(LEFT.Field_Name) + filler)[1..75] + (LEFT.Difference_count + filler)[1..25] + LEFT.Difference_Percent + '%')),
																			// ds_no_diff);

																			
		// line_heading := ('Field Name' + filler)[1..75] + ('Difference Count' + filler)[1..25] + 'Difference Percent';

/////

filler2 := '            ';
		ds_no_diff2 := DATASET([{2, 'No dropped sources '}], MyRec);
		
		cert_realtime_dropped := IF(COUNT(dropped_sources) > 0,
																			PROJECT(dropped_sources, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.source_list	) + filler2)[1..50] + (LEFT._count + filler2)[1..10] )),
																			ds_no_diff2);

																			
		line_heading_sources := ('source list' + filler2)[1..50] + ('Count' + filler2)[1..10] ;

		cert_realtime_new := IF(COUNT(new_sources) > 0,
																			PROJECT(new_sources, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.source_list	) + filler2)[1..50] + (LEFT._count + filler2)[1..10] )),
																			ds_no_diff2);

																			
		main_head := DATASET([{1,   'Phone Shell' + '\n'
													+ '*** This report is produced by Scoring QA ***' + '\n\n'
													}], MyRec); 		
				
real dp_pct := round((dropped/COUNT(nonfcra_clean_file))*100,2)		;		
				
		head_cert_realtime_dropped := DATASET([{1,    
														'Environment:  CERT - NONFCRA'	+ '\n'
													+ 'Archive date:  999999' + '\n'
													+ 'Previous run date:  ' + cleaned_nonfcra_prev_date + '\n'
													+ 'Current run date:  ' + cleaned_nonfcra_curr_date + '\n' 
													+ 'Previous record count:  ' + COUNT(nonfcra_ds_prev) + '\n'
													+ 'Current record count:  ' + COUNT(nonfcra_ds_curr) + '\n'
													+ 'Compared records:  ' + COUNT(nonfcra_clean_file) + '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ 'Phones Dropped: 	' + dropped + '\n'  
													+ 'Percent Dropped: 	' + dp_pct + '\n'  
													+ '\n'
													+ line_heading_sources + '\n'
													+ '------------------------------------------------------------------------'
													}], MyRec); 

real new_pct := round((new/COUNT(nonfcra_clean_file))*100,2);

		head_cert_realtime_new := DATASET([{1,    
													'\n'
													+'Phones Gained: 	' + new + '\n'  
													+'Percent Gained: 	' + new_pct + '\n'  
													+ '\n'
													+ line_heading_sources + '\n'
													+ '------------------------------------------------------------------------'
													}], MyRec); 			
			
			
			
		head_cert_realtime := DATASET([{1,    												
													line_heading + '\n'
													+ '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec); 
													
		spacer := DATASET([{3,    
														'\n' 
													+ '\n' 
													+ '\n' 
													}], MyRec);
		
		spacer2 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 3; SELF := LEFT));
		spacer4 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 5; SELF := LEFT));

		output_cert_realtime_dropped := PROJECT(SORT(head_cert_realtime_dropped + cert_realtime_dropped, order), TRANSFORM(MyRec, SELF.order := 2; SELF := LEFT));
		output_cert_realtime_new := PROJECT(SORT(head_cert_realtime_new + cert_realtime_new, order), TRANSFORM(MyRec, SELF.order := 4; SELF := LEFT));
		// output_cert_realtime := PROJECT(SORT(head_cert_realtime + cert_realtime, order), TRANSFORM(MyRec, SELF.order := 6; SELF := LEFT));
		output_cert_realtime := PROJECT(SORT(head_cert_realtime + cert_realtime, order), TRANSFORM(MyRec, SELF.order := 6; SELF := LEFT));
	

		output_append := main_head + output_cert_realtime_dropped +spacer2+output_cert_realtime_new+spacer4+output_cert_realtime;
		output_full := SORT(output_append, order);

		MyRec Xform(myrec L,myrec R) := TRANSFORM
				SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
				self := l;
		END;

		XtabOut := ITERATE(output_full, Xform(LEFT, RIGHT));

		 final := FileServices.SendEmail('Benjamin.Karnatz@lexisnexisrisk.com;Matthew.Ludewig@lexisnexisrisk.com;Isabel.Ma@lexisnexisrisk.com', 'PhoneShell Cert Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line);
		 return final;

