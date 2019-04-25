
EXPORT Runway_Macro_Cert_Report_Generation := FUNCTION

import ut,STD, Scoring_Project_Macros, Scoring_Project_DailyTracking, test_apaar;

 dt := ut.getdate;
 // dt := '20150428';
decimal19_2 thresh := 1.25;



ds_cur:=  test_apaar.Runway_Macro_Cert_Join_Code(dt);

// ds_curr := dataset('~' + 'Scoring_Project::out::runway_join_results_' + dt + '_1', Scoring_Project_Macros.Runway_Join_Layout, thor);

filenames_details :=  nothor(STD.File.LogicalFileList('Scoring_Project::out::runway_cert_join_results_*_1'));
filelist := sort(filenames_details, -modified);

// p_file_name := filelist[1].name;
p_file_name := filelist[1].name;
prev_date := p_file_name[length(p_file_name)-9.. length(p_file_name)-2];

cleaned_curr_date := dt;
cleaned_prev_date := prev_date;


// ds_pre := dataset('~'+ 'Scoring_Project::out::runway_cert_join_results_20160112_1', test_apaar.Runway_Join_Layout_Old_test, thor);
ds_pre := dataset('~'+ p_file_name, test_apaar.Runway_Join_Layout_Old_test, thor);

ds_join := JOIN(ds_cur, ds_pre, LEFT.seq = RIGHT.seq , transform(left));

clean_file := ds_join(seq <> 0);
ds_current := JOIN(ds_cur, clean_file, LEFT.seq = RIGHT.seq , transform(left));
ds_previous := JOIN(ds_pre, clean_file, LEFT.seq = RIGHT.seq , transform(left));
		
		
stat_set := Scoring_Project_Macros.Runway_Stats_Calculation_Simplified(ds_current, ds_previous);
 
//we are not setting any threshold as we want to populate all scores and want business to decide the threshold														
// filter_ds := stat_set(percent_change > thresh);	
filter_ds := stat_set;

//We are not sorting as per Nathan's suggestion
re_filter2:=SORT(filter_ds, -percent_change);

// re_filter2 := filter_ds;

MyRec := RECORD
INTEGER order;
STRING line;
END;

		max_diff := (STRING)SORT(filter_ds, -percent_change)[1].percent_change + '%';
		
		ds_no_diff := DATASET([{2, 'No differences exceeding the ' + thresh + '% threshold'}], MyRec);
		
		STRING filler := '                                                                                           ';

		fcra_cert_realtime := IF(COUNT(re_filter2) > 0,
																			PROJECT(re_filter2, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.score_name) + filler)[1..20] + filler[1..5] + (LEFT.previous_average + filler)[1..20] + (LEFT.current_average + filler)[1..20] + (LEFT.Average_Change + filler)[1..20] + (LEFT.percent_increase + '%'+ filler)[1..20] + (LEFT.percent_decrease + '%'+ filler)[1..20] + (LEFT.percent_change + '%'+ filler)[1..20] + LEFT.total_222_change)),
																			ds_no_diff);
					
		
																			
		line_heading := ('Score Name' + filler)[1..20] + filler[1..5] + ('Previous Average' + filler)[1..20]  + ('Current Average' + filler)[1..20] + ('Average Change' + filler)[1..20] + ('Percent Increase'+ filler)[1..20]  + ('Percent Decrease'+ filler)[1..20]  + ('Percent Change'+ filler)[1..20] + '222 Change';

		main_head := DATASET([{1,   'Runway Scores Tracking Report' + '\n'
													+ '*** This report is produced by Scoring QA ***' + '\n\n'
													}], MyRec); 		
				
	head_fcra_cert_realtime := DATASET([{1,    
														'Environment:  Cert - FCRA & NON-FCRA'	+ '\n'
													// + 'Archive date:  999999' + '\n'
													+ 'Previous run date:  ' + cleaned_prev_date + '\n'
													+ 'Current run date:  ' + cleaned_curr_date + '\n' 
													+ 'Previous record count:  ' + COUNT(ds_pre) + '\n'
													+ 'Current record count:  ' + COUNT(ds_cur) + '\n'
													+ 'Compared records:  ' + COUNT(clean_file) + '\n'
													+ '\n' 
													+ line_heading + '\n'
													+ '-----------------------------------------------------------------------------------------------------------------------------------------------------------'
													}], MyRec); 
													

	
		spacer := DATASET([{3,    
														'\n' 
													+ '\n' 
													+ '\n' 
													}], MyRec);
		
		spacer2 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 5; SELF := LEFT));
		spacer3 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 7; SELF := LEFT));

		output_fcra_cert_realtime := PROJECT(SORT(head_fcra_cert_realtime + fcra_cert_realtime, order), TRANSFORM(MyRec, SELF.order := 2; SELF := LEFT));
		
		// OUTPUT(output_cert_archive, NAMED('output_cert_archive'));

		output_append := main_head + output_fcra_cert_realtime + spacer ;
		output_full := SORT(output_append, order);
		// OUTPUT(output_full, NAMED('output_full'));

		MyRec Xform(myrec L,myrec R) := TRANSFORM
				SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
				self := l;
		END;

		XtabOut := ITERATE(output_full, Xform(LEFT, RIGHT));
  	// OUTPUT(XtabOut, NAMED('XtabOut'));

		final := FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.test_list, 'Runway Scores Tracking Report. MaxDiff: ' + max_diff, XtabOut[COUNT(XtabOut)].line):
									FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.test_list,'Runway Macro Scores Tracking Report CRON job failed','The failed workunit is:' + WORKUNIT + FAILMESSAGE));


return final;

end;

